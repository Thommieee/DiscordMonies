class Player {
  constructor(user) {
    this.Player = user;
    this.Username = user.username;
    this.Cash = 1500;
    this.Game = null;
    this.Leader = false;
    this.Position = 0;
  }
  modifyCash(cash) {
    this.Cash = this.Cash + cash
  }
}
exports.Player = Player
