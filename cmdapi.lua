local discordia = require('discordia')

local cmdapi = {};

cmdapi.getUser=function(arg,plrtable)
	local userfound = nil;
	if string.sub(arg,1,2) == "<@" then --// Check if the user is mentioning someone
		local id = string.sub(arg,3,string.len(arg)-1)
		if string.sub(id,1,1) == "!" then id=string.sub(id,2) end
		for i,v in pairs(plrtable) do
			if v.Player.id == id then
				userfound = v
			end
		end
	else
		for i,v in pairs(plrtable) do
			if v.Username == arg then
				userfound = v
			end
		end
	end
	return userfound
end

cmdapi.checkPermissions=function(member, channel, permissions)
local allowed = true;
	if type(permissions) == "table" then
		for _,v in pairs(permissions) do
			if not member:hasPermission(channel, v) then
				allowed = false
			end
		end
	elseif type(permissions) == "string" then
		if not member:hasPermission(channel, v) then
			allowed = false
		end
	else
		allowed = true
	end
return allowed;
end

return cmdapi
