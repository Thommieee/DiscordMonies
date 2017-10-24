const Discord = require("discord.js");
const client = new Discord.Client();
var DiscordMonies = require('./classes/classloader.js');
var board = new DiscordMonies.Board('default');
var Games = {};
client.on('ready', () => {
  console.log('Did a thingy')

});

client.on('message', msg => {

});

client.login(require('./data.json').token);
