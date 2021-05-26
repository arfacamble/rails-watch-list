require 'open-uri'
require 'json'
require 'faker'

puts "---------------------"
puts "destroying everything"
Bookmark.destroy_all
# Movie.destroy_all
List.destroy_all

# puts "-----------------------"
# puts "creating films from api"

# number_of_pages = JSON.parse(open('http://tmdb.lewagon.com/movie/top_rated').read)['total_pages']
# page = 1
# number_of_pages.times do
#   puts "Page #{page} of films loading"
#   url = "http://tmdb.lewagon.com/movie/top_rated?page=#{page}"
#   films = JSON.parse(URI.open(url).read)['results']
#   films.each do |f|
#     og_title = f['original_title']
#     eng_title = f['title']
#     overview = f['overview']
#     rating = f['vote_average']
#     poster_url = "https://image.tmdb.org/t/p/w500#{f['backdrop_path']}"
#     title = (og_title == eng_title ? eng_title : "#{og_title} (#{eng_title})")
#     Movie.create(title: title, overview: overview, poster_url: poster_url, rating:rating)
#   end
#   page += 1
# end

puts "--------------"
puts "creating lists"

rand(8..12).times do
  List.create!(name: Faker::Creature::Animal.name)
end

puts "--------------------------------"
puts "creating bookmarks for each list"

List.all.each do |list|
  num_in_list = rand(10..15)
  films_in_list = Movie.all.sample(num_in_list)
  films_in_list.each do |film|
    comment = "#{Faker::Movies::HitchhikersGuideToTheGalaxy.character} says this film is #{Faker::ElectricalComponents.electromechanical}"
    bookmark = Bookmark.new(comment: comment)
    bookmark.movie = film
    bookmark.list = list
    bookmark.save!
  end
end
