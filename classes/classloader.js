exports.Structures = {
  BoardItem:require('./containers/boarditem.js').BoardItem,
  Purchasable:require('./containers/purchasable.js').Purchasable,
};
exports.BoardItems = {
  Property:require('./boarditems/property.js').Property,
  Go:require('./boarditems/go.js').Go,
  Station:require('./boarditems/station.js').Station,
  Utiity:require('./boarditems/utility.js').Utility,
};
exports.Board = require('./structures/board.js').Board;
exports.Game = require('./structures/game.js').Game;
exports.Player = require('./structures/player.js').Player;
