const Discord = require("discord.js");
const client = new Discord.Client();
var DiscordMonies = require('./classes/classloader.js');
var prefix = require('./data.json').prefix

client.on('ready', () => {
  console.log('Did a thingy')
});

client.on('message', msg => {
  if (msg.content.startsWith(prefix)) {
    var args = msg.content.substr(3).split(" ");
    console.log(require("fs").existsSync('commands/'+args[0]+'.js'))
    if (require("fs").existsSync('commands/'+args[0]+'.js')) {
      try {
        require('./commands/'+args[0]+'.js').runCommand(msg.author, args, msg, DiscordMonies)
      }
      catch(err) {
        msg.reply(err.stack);
      }
    }
  }
});

client.login(require('./data.json').token);
