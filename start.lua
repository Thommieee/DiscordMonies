local discordia = require('discordia')
local client = discordia.Client()
local Commands = {};
local data = require("./data.lua")
local helpembed;
local cmdapi = require('./cmdapi.lua')
local prefix = data.prefix;
local embeds = require('./embeds.lua')
local Logger = discordia.Logger
local Games = {};
local Players = {};
local Timer = require("Timer");

function loadCommands()
    helpembed = embeds.create("Help", 3066993)
    for i,v in pairs(Commands) do
        local fielddesc = "";
        for k,p in pairs(v['CommandList']) do
            if p['DMs'] then
                fielddesc = fielddesc.."**"..p['Name'].." ("..prefix..p['Usage'][1]..")**\n"
            else
                fielddesc = fielddesc..p['Name'].." ("..prefix..p['Usage'][1]..")\n"
            end
        end
        embeds.field(helpembed, v['Name'], fielddesc, true)
    end
end

client:on('ready', function()
client:setGame("Monopoly")
loadCommands();
end)

local boarddata = require('./boards/board.lua')

function getCurrentPlayer(gameid)
    for i,v in pairs(Games[gameid].players) do
        if v.isReady == true then
            return v
        end
    end
end

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
local ran = false;
for _,cmds in pairs(Commands) do
    for _,cmd in pairs(cmds['CommandList']) do
        local msg = message.content
        if string.sub(msg,1,string.len(prefix)) == prefix or message.guild == nil then
            if message.guild ~= nil then msg = string.sub(msg,string.len(prefix)+1) end
            for _,usg in pairs(cmd['Usage']) do
                if string.sub(msg,1,string.len(usg)) == usg then
                    ran = true;
                    local runit = true
                    if cmd['DMs'] and message.guild ~= nil then runit = false end
                    local data = {actions = actions, startts=startts, version=version, cmds = Commands, prefix = prefix, pingtime = pingtime}
                    if runit then 
                        local status, err = pcall(function() cmd['func'](string.sub(msg,string.len(usg)+2), message, client, data) end)
                        if not status then local emb = embeds.create("<:blobexplosion:348476151473373205> An error has occurred", 15158332); emb['description'] = err; message.channel:send({embed=emb})
                    end
                end
            end
        end
    end
end
        end
        if ran == false and message.guild == nil then
            if Players[message.author.id] then
                announce(Players[message.author.id].Game, message.author.username..": "..message.content)
            end     
        end
end)

client:run('Bot MzUxMzYwODI4MDQ3MzYwMDAx.DIRdyA.pT1CtRN8yoa4OK8vuwpJxd3uDWU')

table.insert(Commands, {Name="Builtin", CommandList={{Name="Help",Usage={"help","man"},Description="Gives help",func=function(args, message)
if args ~= "" then
    for _,pack in pairs(Commands) do
        for _,cmd in pairs(pack.CommandList) do
            if cmd['Name']:lower() == args:lower() then
                local emb = embeds.create("Command Help", 10181046)
                embeds.field(emb, "Name", cmd['Name'], false)
                local alstr = "";
                for _,usg in pairs(cmd.Usage) do alstr = alstr..prefix..usg..", " end
                embeds.field(emb, "Syntax", string.sub(alstr,1,string.len(alstr)-2), false)
                embeds.field(emb, "Description", cmd.Description, false)
                local permstr = "";
                if cmd.perms then
                    for _,perm in pairs(cmd.perms) do permstr = permstr..perm..", " end
                    embeds.field(emb, "Permissions", string.sub(permstr,1,string.len(permstr)-2), false)
                end
                message.channel:send({embed=emb})
            end
        end
    end
else 
    message.channel:send({embed=helpembed})
end
end},
{Name="Make",Usage={"make"},Description="Makes a game",func=function(id, message)
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
end
end},
{Name="Info",DMs=true,Usage={"info"},Description="Allows you to view information on a property",func=function(id,message)
for i,v in pairs(Games[Players[message.author.id].Game].Properties) do
    if v.name == id then
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
end},
{Name="Stats",DMs=true,Usage={"stats"},Description="View your cash and game ID",func=function(id, message)
if Players[message.author.id] then
    local playerdata = Players[message.author.id]
    local embed = embeds.create("Game Details", 1146986)
    embeds.field(embed, "Game ID", playerdata.Game, true)
    embeds.field(embed, "Cash", "$"..playerdata.Cash, true)
    message.channel:send({embed=embed})
else
    message:reply("You're not in a game...")
end                
end},
{Name="Add Money",DMs=true,Usage={"add"},Description="Adds money to your balance",func=function(amount, message)
if tonumber(amount) then
    Players[message.author.id].Cash = Players[message.author.id].Cash + tonumber(amount)
    announce(Players[message.author.id].Game, message.author.username.." has added $"..amount.." to his account.")
end
end},
{Name="Remove Money",DMs=true,Usage={"rem"},Description="Removes money from your balance",func=function(amount, message)
if tonumber(amount) then
    Players[message.author.id].Cash = Players[message.author.id].Cash - tonumber(amount)
    announce(Players[message.author.id].Game, message.author.username.." has removed $"..amount.." from his account")
end
end},
{Name="Chat",DMs=true,Usage={"chat"},Description="Allows you to talk to your fellow players",func=function(msg, message)
if Players[message.author.id] then
    announce("**"..Players[message.author.id].Game, message.author.username.."**: "..msg)
end
end},
{Name="Roll",DMs=true,Usage={"roll"},Description="Rolls the dice",func=function(msg, message)
if Players[message.author.id] and Players[message.author.id].isReady == true then
    if Players[message.author.id].isInJail == nil then Players[message.author.id].isInJail = false end
    local roll1 = math.random(1,6)
    local roll2 = math.random(1,6)
    local embed
    local roll = roll1 + roll2
    local footertext = tostring(roll1.." + "..roll2.." = "..roll)
    
    if roll1 == roll2 then 
        Players[message.author.id].isInJail = false
        embed = embeds.create(Players[message.author.id].Username.." rolled a "..roll..". Doubles!")
    else
        embed = embeds.create(Players[message.author.id].Username.." rolled a "..roll..".")
    end
    embed.footer = {text=footertext}
    local Game = Games[Players[message.author.id].Game]
    local Properties = Game.Properties
    local oldprop = Properties[Game.Board[Players[message.author.id].Position].id];
    local newprop;
    if Players[message.author.id].isInJail == false then
        move(message.author.id, roll, roll1, roll2)
        newprop = Properties[Game.Board[Players[message.author.id].Position].id];
        embed.description = "And they landed on: "..tostring(Games[Players[message.author.id].Game].Board[Players[message.author.id].Position].name)
        if Game.Board[Players[message.author.id].Position] and Game.Board[Players[message.author.id].Position].type == "gotojail" then
            print("JAIL TIME MY MAN")
            Players[message.author.id].isInJail = true
            for i,v in pairs(Game.Board) do
                if v.type == "jail" then
                    Players[message.author.id].Position = i
                    announce(Players[message.author.id].Game, message.author.username.." has moved to: "..v.name)
                end
            end
        end
    else
        embed.description = "But they're in Jail. And they're staying there."
        move(message.author.id,0,0,0) --// Trigger the move function so the turn order continues
    end
    local owner = "Bank"
    if newprop and newprop.owner then 
        owner = Players[newprop.owner].Username
    end
    --if owner == nil then owner = "Nobody" end
    embeds.field(embed, "Owner", owner)
    
    embeds.field(embed, "Current balance", "$"..Players[message.author.id].Cash)
    
    if (newprop and newprop.owner) and Players[message.author.id].isInJail == false then
        embeds.field(embed, "Amount Owing", newprop.cost)
        embeds.field(embed, "Next steps", "Remove the amount owing from your balance using the `rem` command. Control then passes onto the next player.");
    elseif (newprop and newprop.price) then
        embeds.field(embed, "Price", newprop.price)
        embeds.field(embed, "Next steps", "To purchase this property, use `getp`. Otherwise, state that you are putting this property up for auction and start a bid through chat!");
    end
    
    embeds.field(embed, "Next Player", "The next player is "..getCurrentPlayer(Players[message.author.id].Game).Username)
    
    announce(Players[message.author.id].Game, {embed=embed})
else
    message:reply("You're not in a game, or it's not your turn.")
end                
end},
{Name="End",Usage={"end"},Description="Ends the game",func=function(msg,message)
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
end},
{Name="Get Property",DMs=true,Usage={"getp"},Description="Allows you to get a property",func=function(msg,message)
local Board = Games[Players[message.author.id].Game].Board
local Properties = Games[Players[message.author.id].Game].Properties
--		print(string.sub(message.content,6))
if msg == "" then
    --	print("test")
    --	print(Board[Players[message.author.id].Position])
    if Board[Players[message.author.id].Position].id then
        Players[message.author.id].Cash = Players[message.author.id].Cash - Properties[Board[Players[message.author.id].Position].id].price
        Games[Players[message.author.id].Game].Properties[Games[Players[message.author.id].Game].Board[Players[message.author.id].Position].id].owner = message.author.id
        announce(Players[message.author.id].Game, message.author.username.." has bought "..Board[Players[message.author.id].Position].name.." for "..Board[Players[message.author.id].Position].price)
    end
else
    for i,v in pairs(Properties) do
        if v.name == msg and v.owner == nil then
            v.owner = message.author.id
            announce(Players[message.author.id].Game, message.author.username.." has claimed "..v.name)
        end
    end
end
end},
{Name="Move",DMs=true,Usage={"move"},Description="Moves the board",func=function(msg,message)
local Board = Games[Players[message.author.id].Game].Board
for i,v in pairs(Board) do
    if v.name == msg then
        if i < Players[message.author.id].Position then
            Players[message.author.id].Cash = Players[message.author.id].Cash + 200        
            announce(Players[message.author.id].Game, message.author.username.." has acquired $200 from passing Go")
        end
        Players[message.author.id].Position = i
        announce(Players[message.author.id].Game, message.author.username.." has moved to: "..v.name)
    end
end
end},
{Name="ToJail",DMs=true,Usage={"jail"},Description="Jails you",func=function(msg,message)
Players[message.author.id].isInJail = true;
local Board = Games[Players[message.author.id].Game].Board
for i,v in pairs(Board) do
    if v.type == "jail" then
        Players[message.author.id].Position = i
        announce(Players[message.author.id].Game, message.author.username.." has been jailed")
    end
end
end},
{Name="Start",Usage={"start"},Description="Starts the game",func=function(msg,message)
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
end},
{Name="Join Game",Usage={"join"},Description="Joins a game",func=function(msg,message)
if msg ~= "" then
    if not Players[message.author.id] then
        if Games[msg] and Games[msg].started == false then
            local playerdata = {};
            playerdata.Player = message.author
            playerdata.ID = message.author.id
            playerdata.Username = message.author.username
            playerdata.Cash = 1500
            playerdata.Game = i
            playerdata.Order = #Games[msg].order+1
            playerdata.Leader = false
            Players[message.author.id] = playerdata
            Games[msg].players[message.author.id] = playerdata
            Games[msg].order[#Games[msg].order+1] = message.author.id
            message:reply("Added you to the game")
        else
            message:reply("That game doesn't exist or has already started.")
        end
    else
        message:reply("You're already in a game")
    end
else
    message:reply("Matchmaking...")
    local gamefound = false;
    for i,v in pairs(Games) do
        if v.started == false and #v.players < 4 and gamefound == false then
            gamefound = true
            message.channel:send("Found game ID: "..i.."! Joining...")
            local playerdata = {};
            playerdata.Player = message.author
            playerdata.ID = message.author.id
            playerdata.Username = message.author.username
            playerdata.Cash = 1500
            playerdata.Game = i
            playerdata.Order = #Games[i].order+1
            playerdata.Leader = false
            Players[message.author.id] = playerdata
            Games[i].players[message.author.id] = playerdata
            Games[i].order[#Games[i].order+1] = message.author.id
            message:reply("Added you to the game")
        end
    end
end               
end},
{Name="Load Board",DMs=true,Usage={"load"},Description="Loads a board",func=function(msg,message)
if Players[message.author.id] and Games[Players[message.author.id].Game].started == false then
    local boards = {["botarena"]="./boards/victorsboard.lua",["default"]="./boards/board.lua",["dutch"]="./boards/dutch.lua"}
    if boards[msg] then
        announce(Players[message.author.id].Game, "Loading board: "..msg)
        local game = Games[Players[message.author.id].Game]
        local bdata = require(boards[msg])
        game.Board = bdata.Board
        game.Sets = bdata.Sets
        game.Properties = bdata.Properties
        game.Chance = bdata.Chance
        game.Chest = bdata.Chest
    end
end	               
end},
{Name="Break Jail",DMs=true,Usage={"breakjail","bjail"},Description="Pays the $50 bail for Jail",func=function(msg,message)
if Players[message.author.id] and Players[message.author.id].isInJail == true then
    Players[message.author.id].Cash = Players[message.author.id].Cash - 50
    Players[message.author.id].isInJail = false;
    announce(Games[Players[message.author.id].Game], message.author.username.." bailed out of Jail and paid $50")
end
end},
{Name="Chance",DMs=true,Usage={"chance"},Description="Opens a random chance card",func=function(msg,message)
announce(Players[message.author.id].Game, Games[Players[message.author.id].Game].Chance[ math.random( 0, #Games[Players[message.author.id].Game].Chance - 1 ) ])
end},
{Name="Chest",DMs=true,Usage={"chest"},Description="Opens a random community chest",func=function(msg,message)
announce(Players[message.author.id].Game, Games[Players[message.author.id].Game].Chest[ math.random( 0, #Games[Players[message.author.id].Game].Chest - 1 ) ])
end},
}})
