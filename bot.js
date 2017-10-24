const Discord = require("discord.js");
const client = new Discord.Client();
var DiscordMonies = require('./classes/classloader.js');
var board = new DiscordMonies.Board('default');
client.on('ready', () => {
  console.log('Did a thingy')

});

client.on('message', msg => {
  if (msg.content.startsWith("mb:test")) {
    console.log(board.getInfo(msg.content.substr(8), "name"))
  }
});

client.login(require('./data.json').token);
