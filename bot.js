const Discord = require("discord.js");
const client = new Discord.Client();
var DiscordMonies = require('./classes/classloader.js');

client.on('ready', () => {
  console.log('Did a thingy')
});

client.on('message', msg => {

});

client.login('MzUxMzYwODI4MDQ3MzYwMDAx.DIRdyA.pT1CtRN8yoa4OK8vuwpJxd3uDWU');
