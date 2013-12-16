mongoose = require('mongoose');
config = require('../config');

countrySchema = new mongoose.Schema {
	name : {type : String}
	dreams : {type : Number}
}
module.exports = mongoose.model('Country', countrySchema)