var Go = require('../boarditems/go.js').Go;
var Property = require('../boarditems/property.js').Property;
var Station = require('../boarditems/station.js').Station;
var Utility = require('../boarditems/utility.js').Utility;

class Board {
  constructor(boardid) {
    if (require("fs").existsSync('../../boards/'+boardid+'.json')) {
      var boardData = require('../../boards/'+boardid+'.json');
      this.Chance = boardData.Chance
      this.Chest = boardData.Chest
      var fieldData = [];
      boardData.Fields.forEach(function(item) {
        if (item.Type == "Go") {
          var boardField = new Go();
          fieldData[0] = boardField;
        } else if (item.Type == "Property") {
          var boardField = new Property();
        }
      })
    }
  }
}

exports.Board = Board;
