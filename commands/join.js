exports.runCommand = function(user, args, msgo, DiscordMonies) {
  if (DiscordMonies.Players[user.id]) {
    msgo.reply("You're already in a game.")
  } else {
    if (args[1]) {
      if (DiscordMonies.Games[args[1]] && DiscordMonies.Games[args[1]].Started == false) {
        var Player = new DiscordMonies.Player(user, DiscordMonies.Games[args[1]]);
        DiscordMonies.Players[Player.ID] = Player
        DiscordMonies.Games[args[1]].players[DiscordMonies.Games[args[1]].players.length] = Player
        Player.Game.announce("**" + Player.user.username + "** has joined the game!")
      }
    } else {
      var found = false;
      for (let key in DiscordMonies.Games) {
        let elem = DiscordMonies.Games[key];
        if (found == false && elem.Started == false && elem.players.length < 4) {
          found = true;
          var Player = new DiscordMonies.Player(user, elem);
          DiscordMonies.Players[Player.ID] = Player
          elem.players[elem.players.length] = Player
          Player.Game.announce("**" + user.username + "** has joined the game!")
        }
      }
    }
  }
}
