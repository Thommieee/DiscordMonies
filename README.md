Discord Monies
-----
Monopoly for Discord  

Directory Structure
------
* /boards - Contains all boards  
* /classes - Contains all classes
  * /classes/boarditems - Contains all items that can appear on the board  
  * /classes/containers - Contains classes that are used as containers for other classes  
  * /classes/structures - Classes used by the game  
* /commands - Contains all commands  

Issue Reporting
-----
When reporting an issue, make sure to give accurate information about the issue, and reproduction steps.

Installation
-----
1. Clone the repository using `git clone https://github.com/aren-cllc/DiscordMonies.git`
2. Create a file called `data.json`, and put `{"token":"yourtokenhere"}` into that file, replacing `yourtokenhere` with your bot's token.
3. Install discord.js with `npm install --save discord.js`
4. Run `bot.js` with `node bot.js`
