require 'mongoid'
require 'mongo'
require 'pp'
require 'date'
require_relative './algorithms/jaccard_array'
require_relative './algorithms/jaccard_n_grams'
require_relative './algorithms/monge_elkan'

class FusedActor
  include Mongoid::Document
  store_in database: "fused_movie_actor"
  field :name, type: String
  field :birthday, type: Date
  field :gender, type: String
  field :place_of_birth, type: String
  field :nationality, type: String
  field :known_credits, type: Integer
  field :adult_actor, type: Boolean
  field :years_active, type: String
  field :alias, type: Array
  field :biography, type: String
  field :known_for, type: Array
  field :match_id, type: Integer
  field :db_name, type: String

  index match_id: 1
  index name: 1

  @@current_match_id = 0

  # @@client = Mongo::Client.new(['127.0.0.1:27018'], :database => 'movieactor', :monitoring => false)

  def self.current_match_id
    @@current_match_id
  end

  def self.current_match_id= (mid)
    @@current_match_id = mid
  end


  def similarity other
    # initialize the weight of each field, the sum is 1
    n_w, b_w, g_w, pob_w, kf_w = 0.5, 0.12, 0.12, 0.14, 0.12
    # similarity of name
    if !self.name.nil? && !other.name.nil?
      if self.name.split(' ').length < other.name.split(' ').length
        name_sim = MongeElkan.jaro_winkler_sim(self.name, other.name)
      else
        name_sim = MongeElkan.jaro_winkler_sim(other.name, self.name)
      end
      # puts name_sim
    else
      name_sim = 0 # if some name is missing, they must be different
    end
    # similarity of birthday
    if !self.birthday.nil? && !other.birthday.nil?
      birthday_sim = (self.birthday == other.birthday ? 1.0 : 0)
    else
      b_w = b_w / 10 # lower the weight of birthday
      birthday_sim = 0
    end
    # similarity of gender
    if !self.gender.nil? && !other.gender.nil?
      gender_sim = (self.gender == other.gender ? 1.0 : 0)
    else
      g_w = g_w / 10 # lower the weight of birthday
      gender_sim = 0
    end
    # similarity of place_of_birth
    if !self.place_of_birth.nil? && !other.place_of_birth.nil?
      place_of_birth_sim = JaccardNGrams.trigrams_sim(self.place_of_birth, other.place_of_birth)
    else
      pob_w = pob_w / 10 # lower the weight of birthday
      place_of_birth_sim = 0
    end
    # similarity of known_for
    if !self.known_for.nil? && !other.known_for.nil?
      known_for_sim = JaccardArray.sim(self.known_for, other.known_for)
    else
      kf_w = kf_w / 10 # lower the weight of birthday
      known_for_sim = 0
    end
    # normalize the weights
    total_w = n_w + b_w + g_w + pob_w + kf_w
    n_w /= total_w
    b_w /= total_w
    g_w /= total_w
    pob_w /= total_w
    kf_w /= total_w
    # adjust the similarity of name if all other attributes are nil
    if n_w > 0.9
      name_sim = MongeElkan.exact self.name, other.name
    end
    #
    # compute the total similarity
    n_w * name_sim + b_w * birthday_sim + g_w * gender_sim + pob_w * place_of_birth_sim + kf_w * known_for_sim
  end

  def match? other, threshold = 0.85
    # similarity of name
    if !self.name.nil? && !other.name.nil?
      if self.name.split(' ').length < other.name.split(' ').length
        name_sim = MongeElkan.jaro_winkler_sim(self.name, other.name)
      else
        name_sim = MongeElkan.jaro_winkler_sim(other.name, self.name)
      end
    else
      name_sim = 0 # if some name is missing, they must be different
    end
    # the name similarity is too low, they have very high Pr to be different
    if name_sim < threshold
      return false
    end
    # similarity of birthday
    if !self.birthday.nil? && !other.birthday.nil?
      birthday_sim = (self.birthday == other.birthday ? 1.0 : 0)
    else
      birthday_sim = nil
    end
    # if both name and birthday similarity is very high, then they match
    if name_sim >= (1 + threshold) / 2 && birthday_sim == 1.0
      true
    else
      similarity(other) >= threshold
    end
  end

  def self.group_by_first_char array
    groups = Hash.new
    array.each do |elem|
      name_a = elem.name.split(' ')
      first_name = name_a[0]
      last_name = name_a[-1]
      if first_name.nil? # do not assign group if no name!
        next
      end
      keys = Array.new(2, '')
      first_name.length.times do |i|
        if first_name.slice(i) =~ /[A-Za-z]/
          keys[0] = first_name.slice(i).downcase
          break
        end
      end
      last_name.length.times do |i|
        if last_name.slice(i) =~ /[A-Za-z]/
          keys[1] = last_name.slice(i).downcase
          break
        end
      end
      keys.sort!
      key = keys[0] + keys[1]
      groups[key] ||= []
      groups[key] << elem
    end
    return groups
  end
end

#a1 = FusedActor.where(name: "Scarlett Johansson").first
#a2 = FusedActor.first
#a3 = FusedActor.where(name: "Scarlett Johansson").first
#a3.name = "George Bush"



#a3.gender = nil
#a3.birthday = nil

#puts a1.match?(a2)
#puts a1.match?(a3)

# ids = ImdbQuery.query_actordb_by_year 1980
# p ids
# as = FusedActor.read_imdb_by_ids ids
# as.each do |a|
#   puts a.name
# end
