exports.DMOnly = true
exports.GameCommand = true
exports.runCommand = function(user, args, msgo, DiscordMonies) {
  if (args[1]) {
    msgo.reply(args[1])
  }
}
