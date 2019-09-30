require 'rest-client'
require 'json'
require 'pry'
require 'pry'
def get_character_movies_from_api(character_name)
  #make the web request
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  results = response_hash["results"].select do |info|
  info["name"].downcase == character_name 
  end
  films = results[0]["films"]
end

  
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.


def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  film_hashes = films.map do |film_url|
    response_string = RestClient.get(film_url)
    response_hash = JSON.parse(response_string)
    response_hash
  end
  # binding.pry
  film_hashes.each do |film| 
   puts  film["title"]
   puts "**********************************\n\n"
   character_hash = film["characters"].map do |character|
      response_string = RestClient.get(character)
    response_hash = JSON.parse(response_string)
    response_hash
    end
    # print film["characters"]
    character_hash.each do |character|
      puts character["name"]
      puts "*****************\n"

    end
  end
  # binding.pry

end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
