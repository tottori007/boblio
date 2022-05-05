# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"

puts "----- SEED:games START -----"
file_name_games = Constants::CSV_PATH + Constants::CSV_FILE_GAMES
CSV.foreach(file_name_games, headers: true) do |row|
  Game.create!(
    game_id: row['game_id'],
    name_en: row['name_en'],
    release_year: row['release_year'],
    player_min: row['player_min'],
    player_max: row['player_max'],
    player_best: row['player_best'],
    playing_time: row['playing_time'],
    playing_time_min: row['playing_time_min'],
    playing_time_max: row['playing_time_max'],
    age_min: row['age_min'],
    image_url: row['image_url'],
    thumbnail_url: row['thumbnail_url']
  )
end
puts "----- SEED:games END -----"

puts "----- SEED:game_options START -----"
file_name_game_options = Constants::CSV_PATH + Constants::CSV_FILE_GAME_OPTIONS
CSV.foreach(file_name_game_options, headers: true) do |row|
  GameOption.create!(
    game_id: row['game_id'],
    name_jp: row['name_jp'],
    expansion: row['expansion'],
    play_limit: row['play_limit'],
    description_en: row['description_en'],
    description_jp: row['description_jp']
  )
end
puts "----- SEED:game_options END -----"

puts "----- SEED:m_designers START -----"
file_name_m_designers = Constants::CSV_PATH + Constants::CSV_FILE_M_DESIGNERS
CSV.foreach(file_name_m_designers, headers: true) do |row|
  MDesigner.create!(
    designer_id: row['designer_id'],
    name: row['name'],
    name_jp: row['name_jp']
  )
end
puts "----- SEED:m_designers END -----"

puts "----- SEED:designers START -----"
file_name_designers = Constants::CSV_PATH + Constants::CSV_FILE_DESIGNERS
CSV.foreach(file_name_designers, headers: true) do |row|
  Designer.create!(
    game_id: row['game_id'],
    designer_id: row['designer_id']
  )
end
puts "----- SEED:designers END -----"

=begin
Game.create(name_jp: 'Boonlake', name_en: 'Boonlake', playing_time: '160', bgg_id: '343905',)
Game.create(name_jp: 'Ark Nova', name_en: 'Ark Nova', playing_time: '150', bgg_id: '342942',)
=end