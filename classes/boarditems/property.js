var Purchasable = require('../containers/purchasable.js').Purchasable;
class Property extends Purchasable {
  constructor(name, position, purchaseValue, color, hcost, cost, costc, costh1, costh2, costh3, costh4, costh5) {
    super(purchaseValue)
  }
  onStep(player) {
    player.modifyCash(-100);
  }
}
exports.Property = Property;
