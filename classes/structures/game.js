class Game {
  constructor(id) {
    this.id = id;
    this.players = [];
    this.players[1] = "Aren"
    this.players[12341234] = "ded"
    this.Properties = [];
    this.Chest = [];
    this.Chance = [];
    this.Board = [];
  }
  getPlayer(userResolve) {
    if (parseInt(userResolve)) {
      return this.players[parseInt(userResolve)]
    } else {
      this.players.forEach(function(elem, index) {
        if (elem == userResolve) {
          return index
        }
      })
    }
  }
}
exports.Game = Game
