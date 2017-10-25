var Board = require('./board.js').Board;
var next = require('array-next');

class Game {
  constructor(id) {
    this.id = id;
    this.players = [];
    this.Board = null;
    this.Started = false;
    this.currentPlayer = null;
    this.Board = new Board("default");
  }
  getPlayer(userResolve) {
    var returnValue = null;
    if (parseInt(userResolve)) {
      returnValue = this.players[parseInt(userResolve)]
    } else {
      this.players.forEach(function(elem, index) {
        if (elem == userResolve) {
          returnValue = this.players[index]
        }
      })
    }
    return returnValue
  }

  loadBoard(boardid) {
    var board = new Board(boardid);
    if (board) { this.Board=board }
  }

  advanceTurn() {
    if (this.Started == true) {
      this.currentPlayer = next(this.players, this.currentPlayer)
      this.currentPlayer.needsToRoll=true;
    }
  }

  movePlayer(plr, steps) {
    var current = this.Board.Fields[plr.Position];
    for (var i=1;i<=steps;i++) {
      var newPos = next(this.Board.Fields, current);
      console.log(current.name)
      current = newPos;
      if (newPos['onPass']) {
        newPos.onPass(plr)
      }
      if (i==steps) {
        if (newPos['onStep']) {newPos.onStep(plr)}
        plr.Position = this.Board.Fields.indexOf(newPos);
      }
    }
  }
}
exports.Game = Game
