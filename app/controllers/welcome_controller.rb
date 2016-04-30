class WelcomeController < ApplicationController
	# @@client = Mongo::Client.new(['127.0.0.1:27018'], :database => 'fused_movie_actor', :monitoring => false)
  def homepage
  	# new thread for reading db
  	# @@client = Mongo::Client.new(['127.0.0.1:27018'], :database => 'movieactor', :monitoring => false)
  end
  def helloworld
  	@hello = "Hello World"
  end
  def opendb
  end
end
