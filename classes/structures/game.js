var Board = require('./board.js').Board;
var next = require('array-next');
class Game {
  constructor(id) {
    this.id = id;
    this.players = [];
    this.Board = null;
    this.Started = false;
    this.currentPlayer = null;
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
    }
  }
}
exports.Game = Game
