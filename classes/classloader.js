var fs = require('fs');
var containerdir = fs.readdirSync('./classes/containers/');
var itemsdir = fs.readdirSync('./classes/boarditems/');
var structuredir = fs.readdirSync('./classes/structures/');
var containerobj = {};
var itemobj = {};
containerdir.forEach(function(filename) {
  var data = require('./containers/'+filename);
  Object.keys(data).forEach(function(thing) {
    containerobj[thing] = data[thing]
  })
});
exports.Containers = containerobj
itemsdir.forEach(function(filename) {
  var data = require('./boarditems/'+filename);
  Object.keys(data).forEach(function(thing) {
    itemobj[thing] = data[thing]
  })
});

exports.BoardItems = itemobj

structuredir.forEach(function(filename) {
  var data = require('./structures/'+filename);
  Object.keys(data).forEach(function(thing) {
    exports[thing] = data[thing]
  })
});
