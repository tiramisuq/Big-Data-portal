require 'mongoid'
require 'pp'
require_relative 'fused_actor'
require_relative 'fused_movie'

class Team
	include Mongoid::Document
	store_in database: "fused_movie_actor"
	#Mongoid.load!("../../config/mongoid.yml", :development)
	# FusedMovie.all.each {
	# 	|movie|
	# 	puts movie.genre
	# }
	@@dramaMovies = FusedMovie.all.where(genre: 'Drama')
	@@drama = Hash.new
	@@drama["writers"] = Hash.new
	@@drama["directors"] = Hash.new
	@@drama["actors"] = Hash.new
	@@drama["filming_locations"] = Hash.new

	@@actionMovies = FusedMovie.all.where(genre: 'Action')
	@@action = Hash.new
	@@action["writers"] = Hash.new
	@@action["directors"] = Hash.new
	@@action["actors"] = Hash.new
	@@action["filming_locations"] = Hash.new

	@@comedyMovies = FusedMovie.all.where(genre: 'Comedy')
	@@comedy = Hash.new
	@@comedy["writers"] = Hash.new
	@@comedy["directors"] = Hash.new
	@@comedy["actors"] = Hash.new
	@@comedy["filming_locations"] = Hash.new

	@@romanceMovies = FusedMovie.all.where(genre: 'Romance')
	@@romance = Hash.new
	@@romance["writers"] = Hash.new
	@@romance["directors"] = Hash.new
	@@romance["actors"] = Hash.new
	@@romance["filming_locations"] = Hash.new

	@@rehash = Hash.new

	def self.get_drama_team
		@@dramaMovies.each {
			|movie|
			#puts movie.genre
			if !movie.writers.empty?
				movie.writers.each {
					|writer|
					if (!@@drama["writers"].has_key?(writer))
						@@drama["writers"][writer] = 0
						#puts "add writer"
					end
					@@drama["writers"][writer] = @@drama["writers"][writer] + 1
				}
			end
			if !movie.directors.empty?
				movie.directors.each {
					|writer|
					if (!@@drama["directors"].has_key?(writer))
						@@drama["directors"][writer] = 0
						#puts "add writer"
					end
					@@drama["directors"][writer] = @@drama["directors"][writer] + 1
				}
			end
			if !movie.main_casts.empty?
				movie.main_casts.each {
					|writer|
					if (!@@drama["actors"].has_key?(writer))
						@@drama["actors"][writer] = 0
						#puts "add writer"
					end
					@@drama["actors"][writer] = @@drama["actors"][writer] + 1
				}
			end
			if !movie.filming_locations.empty?
				puts movie.filming_locations
				movie.filming_locations.each {
					|writer|
					if (!@@drama["filming_locations"].has_key?(writer))
						@@drama["filming_locations"][writer] = 0
						#puts "add writer"
					end
					@@drama["filming_locations"][writer] = @@drama["filming_locations"][writer] + 1
				}
			end
		}
		#puts @@drama["filming_locations"]
		@@rehash["Writer"] = @@drama["writers"].sort_by {|key, value| value}.reverse.first[0]
		@@rehash["Director"] = @@drama["directors"].sort_by {|key, value| value}.reverse.first[0]
		count = 0;
		@@rehash["Actors"] = Array.new
		@@drama["actors"].sort_by {|key, value| value}.reverse.each {
			|key, valuse|
			if (count == 5)
				break
			end
			count = count +1
			
			@@rehash["Actors"].push(key)
		}
		count = 0;
		# @@drama["filming_locations"].sort_by {|key, value| value}.reverse.each {
		# 	|key, value|
		# 	if (count == 2)
		# 		break
		# 	end
		# 	count = count +1
		# 	puts key
		# }
		# puts @@drama["directors"].sort_by {|key, value| value}
		# puts @@drama["actors"].sort_by {|key, value| value}
		# puts @@drama["filming_locations"].sort_by {|key, value| value}
		puts @@rehash
		return @@rehash
	end

	def self.get_action_team
		@@actionMovies.each {
			|movie|
			#puts movie.genre
			if !movie.writers.empty?
				movie.writers.each {
					|writer|
					if (!@@action["writers"].has_key?(writer))
						@@action["writers"][writer] = 0
						#puts "add writer"
					end
					@@action["writers"][writer] = @@action["writers"][writer] + 1
				}
			end
			if !movie.directors.empty?
				movie.directors.each {
					|writer|
					if (!@@action["directors"].has_key?(writer))
						@@action["directors"][writer] = 0
						#puts "add writer"
					end
					@@action["directors"][writer] = @@action["directors"][writer] + 1
				}
			end
			if !movie.main_casts.empty?
				movie.main_casts.each {
					|writer|
					if (!@@action["actors"].has_key?(writer))
						@@action["actors"][writer] = 0
						#puts "add writer"
					end
					@@action["actors"][writer] = @@action["actors"][writer] + 1
				}
			end
			if !movie.filming_locations.empty?
				puts movie.filming_locations
				movie.filming_locations.each {
					|writer|
					if (!@@action["filming_locations"].has_key?(writer))
						@@action["filming_locations"][writer] = 0
						#puts "add writer"
					end
					@@action["filming_locations"][writer] = @@action["filming_locations"][writer] + 1
				}
			end
		}
		#puts @@drama["filming_locations"]
		@@rehash["Writer"] = @@action["writers"].sort_by {|key, value| value}.reverse.first[0]
		@@rehash["Director"] = @@action["directors"].sort_by {|key, value| value}.reverse.first[0]
		count = 0;
		@@rehash["Actors"] = Array.new
		@@action["actors"].sort_by {|key, value| value}.reverse.each {
			|key, valuse|
			if (count == 5)
				break
			end
			count = count +1
			
			@@rehash["Actors"].push(key)
		}
		count = 0;
		# @@drama["filming_locations"].sort_by {|key, value| value}.reverse.each {
		# 	|key, value|
		# 	if (count == 2)
		# 		break
		# 	end
		# 	count = count +1
		# 	puts key
		# }
		# puts @@drama["directors"].sort_by {|key, value| value}
		# puts @@drama["actors"].sort_by {|key, value| value}
		# puts @@drama["filming_locations"].sort_by {|key, value| value}
		puts @@rehash
		return @@rehash
	end
	def self.get_comedy_team
		@@comedyMovies.each {
			|movie|
			#puts movie.genre
			if !movie.writers.empty?
				movie.writers.each {
					|writer|
					if (!@@comedy["writers"].has_key?(writer))
						@@comedy["writers"][writer] = 0
						#puts "add writer"
					end
					@@comedy["writers"][writer] = @@comedy["writers"][writer] + 1
				}
			end
			if !movie.directors.empty?
				movie.directors.each {
					|writer|
					if (!@@comedy["directors"].has_key?(writer))
						@@comedy["directors"][writer] = 0
						#puts "add writer"
					end
					@@comedy["directors"][writer] = @@comedy["directors"][writer] + 1
				}
			end
			if !movie.main_casts.empty?
				movie.main_casts.each {
					|writer|
					if (!@@comedy["actors"].has_key?(writer))
						@@comedy["actors"][writer] = 0
						#puts "add writer"
					end
					@@comedy["actors"][writer] = @@comedy["actors"][writer] + 1
				}
			end
			if !movie.filming_locations.empty?
				puts movie.filming_locations
				movie.filming_locations.each {
					|writer|
					if (!@@comedy["filming_locations"].has_key?(writer))
						@@comedy["filming_locations"][writer] = 0
						#puts "add writer"
					end
					@@comedy["filming_locations"][writer] = @@comedy["filming_locations"][writer] + 1
				}
			end
		}
		#puts @@drama["filming_locations"]
		@@rehash["Writer"] = @@comedy["writers"].sort_by {|key, value| value}.reverse.first[0]
		@@rehash["Director"] = @@comedy["directors"].sort_by {|key, value| value}.reverse.first[0]
		count = 0;
		@@rehash["Actors"] = Array.new
		@@comedy["actors"].sort_by {|key, value| value}.reverse.each {
			|key, valuse|
			if (count == 5)
				break
			end
			count = count +1
			
			@@rehash["Actors"].push(key)
		}
		count = 0;
		# @@drama["filming_locations"].sort_by {|key, value| value}.reverse.each {
		# 	|key, value|
		# 	if (count == 2)
		# 		break
		# 	end
		# 	count = count +1
		# 	puts key
		# }
		# puts @@drama["directors"].sort_by {|key, value| value}
		# puts @@drama["actors"].sort_by {|key, value| value}
		# puts @@drama["filming_locations"].sort_by {|key, value| value}
		puts @@rehash
		return @@rehash
	end
	def self.get_romance_team
		@@romanceMovies.each {
			|movie|
			#puts movie.genre
			if !movie.writers.empty?
				movie.writers.each {
					|writer|
					if (!@@romance["writers"].has_key?(writer))
						@@romance["writers"][writer] = 0
						#puts "add writer"
					end
					@@romance["writers"][writer] = @@romance["writers"][writer] + 1
				}
			end
			if !movie.directors.empty?
				movie.directors.each {
					|writer|
					if (!@@romance["directors"].has_key?(writer))
						@@romance["directors"][writer] = 0
						#puts "add writer"
					end
					@@romance["directors"][writer] = @@romance["directors"][writer] + 1
				}
			end
			if !movie.main_casts.empty?
				movie.main_casts.each {
					|writer|
					if (!@@romance["actors"].has_key?(writer))
						@@romance["actors"][writer] = 0
						#puts "add writer"
					end
					@@romance["actors"][writer] = @@romance["actors"][writer] + 1
				}
			end
			if !movie.filming_locations.empty?
				puts movie.filming_locations
				movie.filming_locations.each {
					|writer|
					if (!@@romance["filming_locations"].has_key?(writer))
						@@romance["filming_locations"][writer] = 0
						#puts "add writer"
					end
					@@romance["filming_locations"][writer] = @@romance["filming_locations"][writer] + 1
				}
			end
		}
		#puts @@drama["filming_locations"]
		@@rehash["Writer"] = @@romance["writers"].sort_by {|key, value| value}.reverse.first[0]
		@@rehash["Director"] = @@romance["directors"].sort_by {|key, value| value}.reverse.first[0]
		count = 0;
		@@rehash["Actors"] = Array.new
		@@romance["actors"].sort_by {|key, value| value}.reverse.each {
			|key, valuse|
			if (count == 5)
				break
			end
			count = count +1
			
			@@rehash["Actors"].push(key)
		}
		count = 0;
		# @@drama["filming_locations"].sort_by {|key, value| value}.reverse.each {
		# 	|key, value|
		# 	if (count == 2)
		# 		break
		# 	end
		# 	count = count +1
		# 	puts key
		# }
		# puts @@drama["directors"].sort_by {|key, value| value}
		# puts @@drama["actors"].sort_by {|key, value| value}
		# puts @@drama["filming_locations"].sort_by {|key, value| value}
		puts @@rehash
		return @@rehash
	end
	def self.build_team(genre)
		if (genre == 'romance')
			return get_romance_team
		end
		if (genre == 'action')
			return get_action_team
		end
		if (genre == 'comedy')
			return get_comedy_team
		end
		if (genre == 'drama')
			return get_drama_team
		end
	end
end
		

#Team.get_romance_team
Team.build_team('romance')