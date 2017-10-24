exports.runCommand = function(user, args, msgo, DiscordMonies) {
  if (DiscordMonies.Players[user.id]) {
    var plr = DiscordMonies.Players[user.id]
    if (plr.Leader == true && plr.Game.Started == false) {
      plr.Game.Started = true;
      plr.Game.advanceTurn();
    }
  }
}
