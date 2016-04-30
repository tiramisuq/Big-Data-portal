require 'mongoid'
require 'json'
require 'pp'
require 'date'

#Encoding.default_external = 'UTF-8'
#Encoding.defalut_internal = 'UTF-8'

#Mongoid.load!('../data_models/mongoid.yml', :development)

class ImdbMovie	#name of collection: imdb_actor
	include Mongoid::Document
	store_in database: 'original'
	#store_in database: 'movieactor'
	field :title, type: String
	field :Year, type: Integer
	field :Directors, type: Array
	field :Stars, type: Array
	field :Role, type: Hash
	field :ProductionCo, type: Array
	field :Writers, type: Array
	field :Language, type: Array
	field :Country, type: Array
	field :Genre, type: Array
	field "Filming Locations".to_sym, type: Array
	field :Rating, type: Float
	field "Total Time".to_sym, type: Integer
	field :DESCRIPTION, type: String
	field :URL, type: String

	index :Title => 1
	index :Year => 1
	index :Rating => 1
end