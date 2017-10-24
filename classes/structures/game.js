var Board = require('./board.js').Board;
class Game {
  constructor(id) {
    this.id = id;
    this.players = [];
    this.Board = null;
  }
  getPlayer(userResolve) {
    if (parseInt(userResolve)) {
      return this.players[parseInt(userResolve)]
    } else {
      this.players.forEach(function(elem, index) {
        if (elem == userResolve) {
          return this.players[index]
        }
      })
    }
  }

  loadBoard(boardid) {
    var board = new Board(boardid);
    if (board) { this.Board=board }
  }
}
exports.Game = Game
