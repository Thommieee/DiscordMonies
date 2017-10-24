var BoardItem = require('../containers/boarditem.js').BoardItem;
class Go extends BoardItem {
  constructor() {
    super("Go")
  }
  onPass(player) {
    player.modifyCash(200);
  }
}
