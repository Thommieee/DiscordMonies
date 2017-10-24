var BoardItem = require('./boarditem.js').BoardItem;
class Purchasable extends BoardItem {
  constructor(name, position, purchaseValue) {
    super(name, position);
    this.owner = null;
    this.purchaseValue = purchaseValue;
  }
}

exports.Purchasable = Purchasable
