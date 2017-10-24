const Discord = require("discord.js");
const client = new Discord.Client();
var DiscordMonies = require('./classes/classloader.js');

client.on('ready', () => {
  console.log('Did a thingy')
});

client.on('message', msg => {
  if (msg.content == "mb:test") {
    var board = new DiscordMonies.Board('default');
  }
});

client.login(require('./data.json').token);
