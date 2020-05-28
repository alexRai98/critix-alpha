
def load_file(path)
  JSON.parse(File.read(path))
end
companies = load_file("db/companies.json")
platforms = load_file("db/platforms.json")
genres = load_file("db/genres.json")
games = load_file("db/games.json")
​

companies.each do |company|
  Company.find_or_create_by!(company)
end

platforms.each do |platform|
  Platform.find_or_create_by!(platform)
end

genres["genres"].each do |genre|
  Genre.find_or_create_by!(name: genre)
end
​