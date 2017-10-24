exports.runCommand = function(user, args, msgo, DiscordMonies) {
  if (args[1]) {
    if (DiscordMonies.Players[user.id]) {
      var plr = DiscordMonies.Players[user.id]
      if (plr.Leader == true && plr.Game.Started == false) {
        plr.Game.loadBoard(args[1])
        msgo.reply("Attempted to load board: " + args[1])
      } else {
        msgo.reply("You're not this game's leader or the game has already started")
      }
    } else {
      msgo.reply("You're not in a game")
    }
  }
}
