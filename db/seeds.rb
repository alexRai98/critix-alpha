
def load_file(path)
  JSON.parse(File.read(path))
end
companies = load_file("db/companies.json")
platforms = load_file("db/platforms.json")
genres = load_file("db/genres.json")
games = load_file("db/games.json")
companies.each do |company|
  Company.find_or_create_by!(company)
end

platforms.each do |platform|
  Platform.find_or_create_by!(platform)
end

genres["genres"].each do |genre|
  Genre.find_or_create_by!(name: genre)
end


def create_genres_relationships(new_game, genres)
  return if genres == nil
  begin
    genres.each { |genre| new_game.genres << Genre.find_by(name: genre) }
  rescue
    p "Genre relationship not created for #{new_game}"
  end
end

def create_platforms_relationships(new_game, platforms)
  return if platforms == nil
  begin
    platforms.each { |platform| new_game.platforms << Platform.find_by(name: platform["name"]) }
  rescue
    p "Platform relationship not created for #{new_game}"
  end
end

def create_involved_companies_relationships(new_game, involved_companies)
  return if involved_companies == nil
  begin
    involved_companies.each do |involved_company|
      company = Company.find_by(name: involved_company["name"])
      InvolvedCompany.create( company: company, 
                              game: new_game, 
                              developer: involved_company["developer"],
                              publisher: involved_company["publisher"] )
    end
  rescue
    p "Involved company relationship not created for #{new_game}"
  end
end

def create_game_relationships(new_game, game)
  create_genres_relationships(new_game, game["genres"])
  create_platforms_relationships(new_game, game["platforms"])
  create_involved_companies_relationships(new_game, game["involved_companies"])
end

puts "Loading main games and relations"
main_games = games.select { |game| game["parent"] == nil }
main_games.each do |game|
  new_game = Game.new(game.slice("name", "summary", "release_date", "category", "rating"))
  if new_game.save
    create_game_relationships(new_game, game)
  else
    p "#{new_game} not created"
  end
end

puts "Loading expansion games and relations"
expansion_games = games.select{ |game| game["parent"] != nil }
expansion_games.each do |game|
  game_data = game.slice("name", "summary", "release_date", "category", "rating")
  game_data["parent"] = Game.find_by(name: game["parent"])
  new_game = Game.new(game_data)

  if new_game.save
    create_game_relationships(new_game, game)
  else
    p "#{new_game} not created"
  end
end

puts "End seeding data"