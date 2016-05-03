# require_relative '../models/build_team'
require_relative '../models/portal_preparation'
require 'json'

class QueryController < ApplicationController
  def buildTeam
    team_builder = BuildTeam.new
  	@genre = params[:genre]
  	@team = team_builder.build_team(@genre)
  end
  def queryActor
  	@actorname = params[:actorname]
    actorname_re = Regexp.new(@actorname, true)
  	@actor = FusedActor.where(name: actorname_re)
  end
  def queryMovie
  	@moviename = params[:moviename]
    moviename_re = Regexp.new(@moviename, true)
  	@movie = FusedMovie.where(title: moviename_re)
  end
  def opendb
  end
  def originalMovie
    @source = params[:source]
    @name = params[:name]
    name_re = Regexp.new("^#{@name}$", true)
    #@movie = Array.new
    if (@source.downcase == 'imdb')
      @movie = ImdbMovie.where(title: name_re)
    end
    if (@source.downcase == 'tmdb')
      @movie = TmdbMovie.where(title: name_re)
    end
    if (@source.downcase == 'wiki')
      @movie = WikiFilm.where(title: name_re)
    end
    if (@source.downcase == 'all')
      @wiki = WikiFilm.where(title: name_re)
      #@movie.push(@wiki.flatten!)
      @imdb = ImdbMovie.where(title: name_re)
      #@movie.push(@imdb.flatten!)
      @tmdb = TmdbMovie.where(title: name_re)
      #@movie.push(@tmdb.flatten!)
    end
  end
  def originalActor
    @source = params[:source]
    @name = params[:name]
    name_re = Regexp.new("#{@name}", true)
    #@actor = Array.new
    if (@source == 'imdb') 
      @imdb = ImdbActor.where(name: name_re)
    end
    if (@source == 'tmdb') 
      @tmdb = TmdbActor.where(name: name_re)
    end
    if (@source == 'wiki')
      @wiki = WikiActor.where(name: name_re)
    end
    if (@source == 'all')
      @wiki = WikiActor.where(name: name_re)
      #@movie.push(@wiki.flatten!)
      @imdb = ImdbActor.where(name: name_re)
      #@movie.push(@imdb.flatten!)
      @tmdb = TmdbActor.where(name: name_re)
      #@movie.push(@tmdb.flatten!)
    end
  end
  def popularfind
    @year = params[:year]
    @genre = params[:genre]
    @movies = PortalPreparation.popular_movie(genre: @genre, year: @year, limits: 10)
  end

end
