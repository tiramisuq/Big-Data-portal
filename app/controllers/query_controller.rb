require_relative '../models/build_team'
require_relative '../models/portal_preparation'
class QueryController < ApplicationController
  def buildTeam
  	@genre = params[:genre]
  	@team = Team.build_team(@genre)
  end
  def queryActor
  	@actorname = params[:actorname]
  	@actor = FusedActor.where(name: @actorname)
  end
  def queryMovie
  	@moviename = params[:moviename]
  	@movie = FusedMovie.where(title: @moviename)
  end
  def opendb
  end
  def originalMovie
    @source = params[:source]
    @name = params[:name]
    #@movie = Array.new
    if (@source == 'imdb')
      @movie = ImdbMovie.where(title: @name)
    end
    if (@source == 'tmdb')
      @movie = TmdbMovie.where(title: @name)
    end
    if (@source == 'wiki') 
      @movie = WikiFilm.where(title: @name)
    end
    if (@source == 'all')
      @wiki = WikiFilm.where(title: @name)
      #@movie.push(@wiki.flatten!)
      @imdb = ImdbMovie.where(title: @name)
      #@movie.push(@imdb.flatten!)
      @tmdb = TmdbMovie.where(title: @name)
      #@movie.push(@tmdb.flatten!)
    end
  end
  def originalActor
    @source = params[:source]
    @name = params[:name]
    #@actor = Array.new
    if (@source == 'imdb') 
      @actor = ImdbActor.where(name: @name)
    end
    if (@source == 'tmdb') 
      @actor = TmdbActor.where(name: @name)
    end
    if (@source == 'wiki') 
      @actor = WikiActor.where(name: @name)
    end
    if (@source == 'all')
      @wiki = WikiActor.where(name: @name)
      #@movie.push(@wiki.flatten!)
      @imdb = ImdbActor.where(name: @name)
      #@movie.push(@imdb.flatten!)
      @tmdb = TmdbActor.where(name: @name)
      #@movie.push(@tmdb.flatten!)
    end
  end
  def popularfind
    @year = params[:year]
    @genre = params[:genre]
    @movies = PortalPreparation.popular_movie(genre: 'all', year: 'all', limits: 5)
  end

end
