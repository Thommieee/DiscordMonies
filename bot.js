const Discord = require("discord.js");
const client = new Discord.Client();
var DiscordMonies = require('./classes/classloader.js');
var prefix = require('./data.json').prefix

global.logType = {
  debug: 0,
  info: 1,
  warning: 2,
  critical: 3,
  good: 4
}

global.log = function(logMessage, type = logType.debug) {
  if (logMessage == null) {
      return;
  }

  //Log a message to the console
  if (type == logType.debug) {
      if (process.argv.indexOf("--debug") == -1) {
          return;
      }
  }

  var logFormatting;
  var logString;
  
  var lines = logMessage.split("\n");

  for (i = 0; i < lines.length; i++) {
      switch (type) {
          case logType.debug:
              if (i == 0) {
                  logString = "[ ] ";
              } else if (i == lines.length - 1) {
                  logString = " └─ ";
              } else {
                  logString = " ├─ ";
              }
              logString += lines[i];
              logFormatting = "\x1b[1m\x1b[34m";
              break;
          case logType.info:
              if (i == 0) {
                  logString = "[i] ";
              } else if (i == lines.length - 1) {
                  logString = " └─ ";
              } else {
                  logString = " ├─ ";
              }
              logString += lines[i];
              logFormatting = "\x1b[1m\x1b[37m";
              break;
          case logType.warning:
              if (i == 0) {
                  logString = "[!] ";
              } else if (i == lines.length - 1) {
                  logString = " └─ ";
              } else {
                  logString = " ├─ ";
              }
              logString += lines[i];
              logFormatting = "\x1b[1m\x1b[33m";
              break;
          case logType.critical:
              if (i == 0) {
                  logString = "[X] ";
              } else if (i == lines.length - 1) {
                  logString = " └─ ";
              } else {
                  logString = " ├─ ";
              }
              logString += lines[i];
              logFormatting = "\x1b[1m\x1b[31m";
              break;
          case logType.good:
              if (i == 0) {
                  logString = "[>] ";
              } else if (i == lines.length - 1) {
                  logString = " └─ ";
              } else {
                  logString = " ├─ ";
              }
              logString += lines[i];
              logFormatting = "\x1b[1m\x1b[32m";
              break;
      }

      var logOutput = logFormatting + logString + "\x1b[0m";
      
      console.log("[" + new Date().toLocaleTimeString("us", {
          hour12: false
      }) + "] " + logOutput);
  }
}


client.on('ready', () => {
  console.log('Did a thingy')
});

client.on('message', msg => {
  if (msg.content.startsWith(prefix)) {
    var args = msg.content.substr(3).split(" ");
    if (require("fs").existsSync('commands/'+args[0]+'.js')) {
      try {
        require('./commands/'+args[0]+'.js').runCommand(msg.author, args, msg, DiscordMonies)
      } catch(err) {
        var embed = new Discord.RichEmbed;
        embed.setColor("#FF0000");
        embed.addField("Details", err.message);

        if (err.name == "UserInputError") {
          embed.setTitle("<:userexception:348796878709850114> User Input Error");
          embed.setDescription("Discord Monies didn't understand what you were trying to say.");
        } else if (err.name == "CommandError") {
          embed.setTitle("<:userexception:348796878709850114> Command Error");
          embed.setDescription("Discord Monies couldn't complete that command.");
        } else {
          log("Uncaught Exception:", logType.critical);
          log(err.stack, logType.critical);

          embed.setTitle("<:exception:346458871893590017> Internal Error");
          embed.setFooter("This error has been logged, and we'll look into it.");
          embed.setDescription("Discord Monies has run into a problem trying to process that command.");
        }
        
        msg.channel.send("", {embed: embed});
        msg.channel.stopTyping(true);
      }
    }
  }
});

client.login(require('./data.json').token);
