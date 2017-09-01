local discordia = require('discordia')
local client = discordia.Client()
local embeds = require('./embeds.lua')
local Logger = discordia.Logger
local Games = {};
local Players = {};
local Timer = require("Timer");

client:on('ready', function()
    
end)

local boarddata = require('./boards/board.lua')

function move(playerid, moves, m1, m2)
local Board = Games[Players[playerid].Game].Board
local gameid = Players[playerid].Game
if Players[playerid].Position + moves > #Board then
local total = Players[playerid].Position + moves
--print(Players[playerid].Position)
Players[playerid].Position = total-#Board
--print(Players[playerid].Position)
announce(Players[playerid].Game, Players[playerid].Username.." has passed Go and has received $200")
Players[playerid].Cash = Players[playerid].Cash + 200
else
Players[playerid].Position = Players[playerid].Position + moves
end
if m1 ~= m2 then
Players[playerid].isReady = false
--print(Players[playerid])
--print(Players[playerid].Order)
--print(Players[playerid].Game)
--print(Games[gameid])
--print(Games[gameid].order)
--print(#Games[gameid].order)
if Players[playerid].Order == #Games[gameid].order then

for i,v in pairs(Games[gameid].players) do
if Players[i].Order == 1 then
Players[i].isReady = true
Timer.setTimeout(50, function() Players[i].Player:send("It is your turn.") end)
end
end

else

for i,v in pairs(Games[gameid].players) do
if Players[i].Order == Players[playerid].Order + 1 then
Players[i].isReady = true
Timer.setTimeout(50, function() Players[i].Player:send("It is your turn.") end)
end
end

end
end

end

function announce(gameid, message)

for i,v in pairs(Games[gameid].players) do
Players[i].Player:send(message)
end
end

client:on('messageCreate', function(message)
	local commandran = false
	if string.sub(message.content,1,8) == "mb:make " then
		commandran = true
		local id = string.sub(message.content,9)
		if id ~= "" then
			if not Players[message.author.id] then
				if not Games[id] then
					local playerdata = {};
					playerdata.Player = message.author
					playerdata.ID = message.author.id
					playerdata.Username = message.author.username
					playerdata.Cash = 1500
					playerdata.Game = id
					playerdata.Order = 1
					playerdata.Leader = true
					playerdata.Position = 0
					Players[message.author.id] = playerdata
					local gamedata = {};
					gamedata.players = {}
					gamedata.order = {};
					gamedata.Board = boarddata.Board
					gamedata.Sets = boarddata.Sets
					gamedata.Properties = boarddata.Properties
					gamedata.Chest = boarddata.Chest
					gamedata.Chance = boarddata.Chance
					gamedata.order[1] = message.author.id
					gamedata.players[message.author.id] = playerdata
					gamedata.ID = id
					gamedata.started = false;
					Games[id] = gamedata
					message:reply("Game created.")
				else
					message:reply("That ID is already being used")
				end
			else
				message:reply("You're already in a game.")
			end
		else
			message:reply("I require a game ID")
		end
	elseif string.sub(message.content,1,8) == "mb:join " then
		commandran = true
		local id = string.sub(message.content,9)
		if id ~= "" then
			if not Players[message.author.id] then
				if Games[id] and Games[id].started == false then
					local playerdata = {};
					playerdata.Player = message.author
					playerdata.ID = message.author.id
					playerdata.Username = message.author.username
					playerdata.Cash = 1500
					playerdata.Game = id
					playerdata.Order = #Games[id].order+1
					playerdata.Leader = false
					Players[message.author.id] = playerdata
					Games[id].players[message.author.id] = playerdata
					Games[id].order[#Games[id].order+1] = message.author.id
					message:reply("Added you to the game")
				else
					message:reply("That game doesn't exist or has already started.")
				end
			else
				message:reply("You're already in a game")
			end
		else
			message:reply("I require a game ID")
		end
	end
	if commandran == false then
	if message.guild == nil then
	if message.content == "stats" then
		if Players[message.author.id] then
			local playerdata = Players[message.author.id]
			local embed = embeds.create("Game Details", 1146986)
			embeds.field(embed, "Game ID", playerdata.Game, true)
			embeds.field(embed, "Cash", "$"..playerdata.Cash, true)
			message.channel:send({embed=embed})
		else
			message:reply("You're not in a game...")
		end
	elseif string.sub(message.content,1,5) == "load " then
		if Players[message.author.id] and Games[Players[message.author.id].Game].started == false then
		local boards = {["botarena"]="./boards/victorsboard.lua",["default"]="./boards/board.lua",["dutch"]="./boards/dutch.lua"}
		if boards[string.sub(message.content,6)] then
			announce(Players[message.author.id].Game, "Loading board: "..string.sub(message.content,6))
			local game = Games[Players[message.author.id].Game]
			local bdata = require(boards[string.sub(message.content,6)])
			game.Board = bdata.Board
			game.Sets = bdata.Sets
			game.Properties = bdata.Properties
			game.Chance = bdata.Chance
			game.Chest = bdata.Chest
		end
		end
	elseif message.content == "chest" then
		announce(Players[message.author.id].Game, Games[Players[message.author.id].Game].Chest[ math.random( 0, #Games[Players[message.author.id].Game].Chest - 1 ) ])
	elseif message.content == "chance" then
		announce(Players[message.author.id].Game, Games[Players[message.author.id].Game].Chance[ math.random( 0, #Games[Players[message.author.id].Game].Chance - 1 ) ])		
	elseif message.content == "start" then
		if Players[message.author.id] then
			if Players[message.author.id].Leader == true then
				Games[Players[message.author.id].Game].started = true;
				for i,v in pairs(Games[Players[message.author.id].Game].players) do
					Players[i].Position = 1
				end
				Players[message.author.id].isReady = true
				announce(Players[message.author.id].Game, "The game has started.")
				Players[message.author.id].Player:send("It is your turn.")
			else
				message:reply("You're not the game's leader.")
			end
		else
			message:reply("You're not in a game...")
		end
	elseif string.sub(message.content, 1, 5) == "chat " then
		if Players[message.author.id] then
		announce(Players[message.author.id].Game, message.author.username.." ("..message.author.id.."): "..string.sub(message.content, 6))
		end
	elseif string.sub(message.content, 1, 5) == "info " then
		for i,v in pairs(Games[Players[message.author.id].Game].Properties) do
			if v.name == string.sub(message.content, 6) then
				local owner;
				if v.owner then
					owner = Players[v.owner].Username
				else
					owner = "Nobody"
				end
				local embed = embeds.create("Property Info")
				embed.description = "Information for card: "..v.name
				embeds.field(embed, "Owned by", owner)
				embeds.field(embed, "Price", v.price)
				embeds.field(embed, "Rent", v.cost)
				message.channel:send({embed=embed})
			end
		end
	elseif string.sub(message.content, 1,4) == "add " then
		if tonumber(string.sub(message.content, 5)) then
			Players[message.author.id].Cash = Players[message.author.id].Cash + tonumber(string.sub(message.content, 5))
			announce(Players[message.author.id].Game, message.author.username.." has taken $"..string.sub(message.content, 5))
		end
	elseif string.sub(message.content,1, 5) == "move " then
		local Board = Games[Players[message.author.id].Game].Board
		for i,v in pairs(Board) do
			if v.name == string.sub(message.content,6) then
				Players[message.author.id].Position = i
				announce(Players[message.author.id].Game, message.author.username.." has moved to: "..v.name)
			end
		end
	elseif string.sub(message.content,1,4) == "getp" then
		local Board = Games[Players[message.author.id].Game].Board
		local Properties = Games[Players[message.author.id].Game].Properties
--		print(string.sub(message.content,6))
		if string.sub(message.content,6) == "" then
		--	print("test")
		--	print(Board[Players[message.author.id].Position])
			if Board[Players[message.author.id].Position].id then
				Players[message.author.id].Cash = Players[message.author.id].Cash - Properties[Board[Players[message.author.id].Position].id].price
				Games[Players[message.author.id].Game].Properties[Games[Players[message.author.id].Game].Board[Players[message.author.id].Position].id].owner = message.author.id
				announce(Players[message.author.id].Game, message.author.username.." has bought "..Board[Players[message.author.id].Position].name)
			end
		else
		for i,v in pairs(Properties) do
			if v.name == string.sub(message.content,6) and v.owner == nil then
				v.owner = message.author.id
				announce(Players[message.author.id].Game, message.author.username.." has claimed "..v.name)
			end
		end
		end
	elseif string.sub(message.content, 1,4) == "rem " then
                if tonumber(string.sub(message.content, 5)) then
                        Players[message.author.id].Cash = Players[message.author.id].Cash - tonumber(string.sub(message.content, 5))
			announce(Players[message.author.id].Game, message.author.username.." has removed $"..string.sub(message.content, 5))
                end
	elseif message.content == "end" then
                if Players[message.author.id] then
                        if Players[message.author.id].Leader == true then
				local id = Players[message.author.id].Game
                                for i,v in pairs(Games[id].players) do
					Players[i]=nil;
				end
				Games[id]=nil;
                        else
                                message:reply("You're not the game's leader.")
                        end
                else
                        message:reply("You're not in a game...")
                end
        elseif message.content == "roll" then
		if Players[message.author.id] and Players[message.author.id].isReady == true then
			local roll1 = math.random(1,6)
			local roll2 = math.random(1,6)
			local roll = roll1 + roll2
			local footertext = tostring(roll1.." + "..roll2.." = "..roll)
			local embed = embeds.create(Players[message.author.id].Username.." rolled a "..roll.."...")
			embed.footer = {text=footertext}
			move(message.author.id, roll, roll1, roll2)
			embed.description = "...which means they landed on: "..Games[Players[message.author.id].Game].Board[Players[message.author.id].Position].name
			local prop = Games[Players[message.author.id].Game].Properties[Games[Players[message.author.id].Game].Board[Players[message.author.id].Position].id]
			local owner = "";
			if prop and prop.owner then
				owner = Players[prop.owner].Username
			else
				owner = "Nobody"
			end
			--local owner = Players[Properties[Board[Players[message.author.id].Position].id].owner].username or "Nobody"
			embeds.field(embed, "Owner", owner)
			announce(Players[message.author.id].Game, {embed=embed})
		else
			message:reply("You're not in a game, or it's not your turn.")
		end
	else
		if Players[message.author.id] then
                announce(Players[message.author.id].Game, message.author.username.." ("..message.author.id.."): "..message.content)
                end
	end
	end
	end
end)

client:run('Bot MzUxMzYwODI4MDQ3MzYwMDAx.DIRdyA.pT1CtRN8yoa4OK8vuwpJxd3uDWU')

