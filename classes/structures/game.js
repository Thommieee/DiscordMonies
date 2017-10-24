var Board = require('./board.js').Board;
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
}
exports.Game = Game
