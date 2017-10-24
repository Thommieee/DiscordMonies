exports.runCommand = function(user, args, msgo, DiscordMonies) {
  if (args[1]) {
    if (DiscordMonies.Players[user.id]) {
      msgo.reply("You're already in a game.")
    } else {
      var Game = new DiscordMonies.Game(args[1]);
      DiscordMonies.Games[args[1]] = Game
      var Player = new DiscordMonies.Player(user, Game);
      DiscordMonies.Players[Player.ID] = Player
      msgo.reply("Created game: "+args[1])
    }
  }
}
