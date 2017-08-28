local class = require('class')
local constants = require('constants')

local MS_PER_S    =               constants.MS_PER_S
local MS_PER_MIN  = MS_PER_S    * constants.S_PER_MIN
local MS_PER_HOUR = MS_PER_MIN  * constants.MIN_PER_HOUR
local MS_PER_DAY  = MS_PER_HOUR * constants.HOUR_PER_DAY
local MS_PER_WEEK = MS_PER_DAY  * constants.DAY_PER_WEEK

local DAY_PER_WEEK = constants.DAY_PER_WEEK
local HOUR_PER_DAY = constants.HOUR_PER_DAY
local MIN_PER_HOUR = constants.MIN_PER_HOUR
local S_PER_MIN    = constants.S_PER_MIN

local insert, concat = table.insert, table.concat
local modf, fmod = math.modf, math.fmod
local isInstance = class.isInstance

local from = {
	weeks = MS_PER_WEEK,
	days = MS_PER_DAY,
	hours = MS_PER_HOUR,
	minutes = MS_PER_MIN,
	seconds = MS_PER_S,
	milliseconds = 1,
}

local Time = class('Time')

local function check(self, other)
	if not isInstance(self, Time) or not isInstance(other, Time) then
		return error('Cannot perform operation with non-Time object', 2)
	end
end

function Time:__init(value)
	self._value = tonumber(value) or 0
end

function Time:__tostring()
	local tbl = self:toTable()
	local ret = {}
	if tbl.weeks ~= 0 then insert(ret, tbl.weeks .. ' weeks') end
	if tbl.days ~= 0 then insert(ret, tbl.days .. ' days') end
	if tbl.hours ~= 0 then insert(ret, tbl.hours .. ' hours') end
	if tbl.minutes ~= 0 then insert(ret, tbl.minutes .. ' minutes') end
	if tbl.seconds ~= 0 then insert(ret, tbl.seconds .. ' seconds') end
	if tbl.milliseconds ~= 0 then insert(ret, tbl.milliseconds .. ' milliseconds') end
	return 'Time: ' .. concat(ret, ', ')
end

function Time:__eq(other) check(self, other)
	return self._value == other._value
end

function Time:__lt(other) check(self, other)
	return self._value < other._value
end

function Time:__le(other) check(self, other)
	return self._value <= other._value
end

function Time:__add(other) check(self, other)
	return Time(self._value + other._value)
end

function Time:__sub(other) check(self, other)
	return Time(self._value - other._value)
end

function Time:__mul(other)
	if not isInstance(self, Time) then
		self, other = other, self
	end
	other = tonumber(other)
	if other then
		return Time(self._value * other)
	else
		return error('Cannot perform operation with non-numeric object')
	end
end

function Time:__div(other)
	if not isInstance(self, Time) then
		return error('Division with Time is not commutative')
	end
	other = tonumber(other)
	if other then
		return Time(self._value / other)
	else
		return error('Cannot perform operation with non-numeric object')
	end
end

--[[
@static fromWeeks
@param t: number
@ret Time
]]
function Time.fromWeeks(t)
	return Time(t * MS_PER_WEEK)
end

--[[
@static fromDays
@param t: number
@ret Time
]]
function Time.fromDays(t)
	return Time(t * MS_PER_DAY)
end

--[[
@static fromHours
@param t: number
@ret Time
]]
function Time.fromHours(t)
	return Time(t * MS_PER_HOUR)
end

--[[
@static fromMinutes
@param t: number
@ret Time
]]
function Time.fromMinutes(t)
	return Time(t * MS_PER_MIN)
end

--[[
@static fromSeconds
@param t: number
@ret Time
]]
function Time.fromSeconds(t)
	return Time(t * MS_PER_S)
end

--[[
@static fromMilliseconds
@param t: number
@ret Time
]]
function Time.fromMilliseconds(t)
	return Time(t)
end

--[[
@static fromTable
@param t: table
@ret Time
]]
function Time.fromTable(t)
	local n = 0
	for k, v in pairs(from) do
		local m = tonumber(t[k])
		if m then
			n = n + m * v
		end
	end
	return Time(n)
end

--[[
@method toWeeks
@ret number
]]
function Time:toWeeks()
	return self:toMilliseconds() / MS_PER_WEEK
end

--[[
@method toDays
@ret number
]]
function Time:toDays()
	return self:toMilliseconds() / MS_PER_DAY
end

--[[
@method toHours
@ret number
]]
function Time:toHours()
	return self:toMilliseconds() / MS_PER_HOUR
end

--[[
@method toMilliseconds
@ret number
]]
function Time:toMinutes()
	return self:toMilliseconds() / MS_PER_MIN
end

--[[
@method toSeconds
@ret number
]]
function Time:toSeconds()
	return self:toMilliseconds() / MS_PER_S
end

--[[
@method toMilliseconds
@ret number
]]
function Time:toMilliseconds()
	return self._value
end

--[[
@method toTable
@ret table
]]
function Time:toTable()
	local v = self._value
	return {
		weeks = modf(v / MS_PER_WEEK),
		days = modf(fmod(v / MS_PER_DAY, DAY_PER_WEEK)),
		hours = modf(fmod(v / MS_PER_HOUR, HOUR_PER_DAY)),
		minutes = modf(fmod(v / MS_PER_MIN, MIN_PER_HOUR)),
		seconds = modf(fmod(v / MS_PER_S, S_PER_MIN)),
		milliseconds = modf(fmod(v, MS_PER_S)),
	}
end

return Time
