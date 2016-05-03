require 'mongoid'
require 'json'
require 'pp'
require 'date'

#Encoding.default_external = 'UTF-8'
#Encoding.defalut_internal = 'UTF-8'

#Mongoid.load!('../data_models/mongoid.yml', :development)

class ImdbActor	#name of collection: imdb_actor
	include Mongoid::Document
	#store_in database: 'movieactor'
	store_in database: 'original'
	field :name, type: String
	field :birthday, type: String
	field :jobs, type: Array
	field :gender, type: String
	field :place_of_birth, type: String
	field :nationality, type: String
	field :known_for, type: Array
	field :url, type: String
	field :description, type: String

	index :Name => 1
	index :Birthday => 1
end