var Purchasable = require('../containers/purchasable.js').Purchasable;
class Utility extends Purchasable {
  constructor(name, position, purchaseValue) {
    super(name, position, purchaseValue)
  }
  onStep(player) {
    player.modifyCash(-100);
  }
}
exports.Utility = Utility;
