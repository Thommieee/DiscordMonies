class Player {
  constructor(user, game) {
    this.Player = user;
    this.ID = user.id
    this.Username = user.username;
    this.Cash = 1500;
    this.Game = game;
    this.Position = game.players.length;
    if (this.Position == 0) {
      this.Leader = true
    } else {
      this.Leader = false
    }
  }
  modifyCash(cash) {
    this.Cash = this.Cash + cash
  }
}
exports.Player = Player
