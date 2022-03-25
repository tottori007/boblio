# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"

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

file_name_game_options = Constants::CSV_PATH + Constants::CSV_FILE_GAME_OPTIONS
CSV.foreach(file_name_game_options, headers: true) do |row|
  GameOption.create!(
    game_id: row['game_id'],
    name_jp: row['name_jp'],
    description_en: row['description_en'],
    description_jp: row['description_jp']
  )
end

=begin
Game.create(name_jp: 'Boonlake', name_en: 'Boonlake', playing_time: '160', bgg_id: '343905',)
Game.create(name_jp: 'Ark Nova', name_en: 'Ark Nova', playing_time: '150', bgg_id: '342942',)
Game.create(name_jp: 'Terraforming Mars: Ares Expedition', name_en: 'Terraforming Mars: Ares Expedition', playing_time: '60', bgg_id: '328871',)
Game.create(name_jp: 'The Crew: Mission Deep Sea', name_en: 'The Crew: Mission Deep Sea', playing_time: '20', bgg_id: '324856',)
Game.create(name_jp: 'MicroMacro: Crime City', name_en: 'MicroMacro: Crime City', playing_time: '45', bgg_id: '318977',)
Game.create(name_jp: 'CloudAge', name_en: 'CloudAge', playing_time: '100', bgg_id: '316858',)
Game.create(name_jp: 'Hallertau', name_en: 'Hallertau', playing_time: '140', bgg_id: '300322',)
Game.create(name_jp: 'Cascadia', name_en: 'Cascadia', playing_time: '45', bgg_id: '295947',)
Game.create(name_jp: 'My City', name_en: 'My City', playing_time: '30', bgg_id: '295486',)
Game.create(name_jp: 'Gloomhaven: Jaws of the Lion', name_en: 'Gloomhaven: Jaws of the Lion', playing_time: '120', bgg_id: '291457',)
Game.create(name_jp: 'Tapestry', name_en: 'Tapestry', playing_time: '120', bgg_id: '286096',)
Game.create(name_jp: 'Maracaibo', name_en: 'Maracaibo', playing_time: '120', bgg_id: '276025',)
Game.create(name_jp: 'The Taverns of Tiefenthal', name_en: 'The Taverns of Tiefenthal', playing_time: '60', bgg_id: '269207',)
Game.create(name_jp: 'Similo', name_en: 'Similo', playing_time: '15', bgg_id: '268620',)
Game.create(name_jp: 'Similo', name_en: 'Similo', playing_time: '15', bgg_id: '268620',)
Game.create(name_jp: 'Wingspan', name_en: 'Wingspan', playing_time: '70', bgg_id: '266192',)
Game.create(name_jp: 'トワイライトインペリウム 第4版', name_en: 'Twilight Imperium: Fourth Edition', playing_time: '480', bgg_id: '233078',)
Game.create(name_jp: 'ブラス:バーミンガム', name_en: 'Brass: Birmingham', playing_time: '120', bgg_id: '224517',)
Game.create(name_jp: 'Gaia Project', name_en: 'Gaia Project', playing_time: '150', bgg_id: '220308',)
Game.create(name_jp: 'The Quest for El Dorado', name_en: 'The Quest for El Dorado', playing_time: '60', bgg_id: '217372',)
Game.create(name_jp: 'The Kings Will', name_en: 'The Kings Will', playing_time: '90', bgg_id: '213149',)
Game.create(name_jp: 'Jump Drive', name_en: 'Jump Drive', playing_time: '30', bgg_id: '205597',)
Game.create(name_jp: 'Everdell', name_en: 'Everdell', playing_time: '80', bgg_id: '199792',)
Game.create(name_jp: 'Great Western Trail', name_en: 'Great Western Trail', playing_time: '150', bgg_id: '193738',)
Game.create(name_jp: 'Star Realms: Colony Wars', name_en: 'Star Realms: Colony Wars', playing_time: '20', bgg_id: '182631',)
Game.create(name_jp: 'A Feast for Odin', name_en: 'A Feast for Odin', playing_time: '120', bgg_id: '177736',)
Game.create(name_jp: 'グルームヘイヴン', name_en: 'Gloomhaven', playing_time: '120', bgg_id: '174430',)
Game.create(name_jp: 'The Game', name_en: 'The Game', playing_time: '20', bgg_id: '173090',)
Game.create(name_jp: 'テラフォーミング・マーズ', name_en: 'Terraforming Mars', playing_time: '120', bgg_id: '167791',)
Game.create(name_jp: 'Terraforming Mars', name_en: 'Terraforming Mars', playing_time: '120', bgg_id: '167791',)
Game.create(name_jp: 'Patchwork', name_en: 'Patchwork', playing_time: '30', bgg_id: '163412',)
Game.create(name_jp: 'Deus', name_en: 'Deus', playing_time: '90', bgg_id: '162082',)
Game.create(name_jp: 'パンデミックレガシー:シーズン1', name_en: 'Pandemic Legacy: Season 1', playing_time: '60', bgg_id: '161936',)
Game.create(name_jp: 'Imperial Settlers', name_en: 'Imperial Settlers', playing_time: '90', bgg_id: '154203',)
Game.create(name_jp: 'Rococo', name_en: 'Rococo', playing_time: '120', bgg_id: '144344',)
Game.create(name_jp: 'La Boca', name_en: 'La Boca', playing_time: '40', bgg_id: '136280',)
Game.create(name_jp: 'Suburbia', name_en: 'Suburbia', playing_time: '90', bgg_id: '123260',)
Game.create(name_jp: 'Robinson Crusoe: Adventures on the Cursed Island', name_en: 'Robinson Crusoe: Adventures on the Cursed Island', playing_time: '120', bgg_id: '121921',)
Game.create(name_jp: 'Terra Mystica', name_en: 'Terra Mystica', playing_time: '150', bgg_id: '120677',)
Game.create(name_jp: 'The City', name_en: 'The City', playing_time: '30', bgg_id: '103649',)
Game.create(name_jp: 'Innovation', name_en: 'Innovation', playing_time: '60', bgg_id: '63888',)
Game.create(name_jp: 'Sorry! Sliders', name_en: 'Sorry! Sliders', playing_time: '30', bgg_id: '37196',)
Game.create(name_jp: 'Times Up! Title Recall!', name_en: 'Times Up! Title Recall!', playing_time: '60', bgg_id: '36553',)
Game.create(name_jp: 'Race for the Galaxy', name_en: 'Race for the Galaxy', playing_time: '60', bgg_id: '28143',)
Game.create(name_jp: 'Escalation!', name_en: 'Escalation!', playing_time: '15', bgg_id: '26884',)
Game.create(name_jp: 'Jungle Speed', name_en: 'Jungle Speed', playing_time: '10', bgg_id: '8098',)
Game.create(name_jp: 'Crazy Race', name_en: 'Crazy Race', playing_time: '45', bgg_id: '4855',)
Game.create(name_jp: 'The London Game', name_en: 'The London Game', playing_time: '30', bgg_id: '2866',)
Game.create(name_jp: 'Power Grid', name_en: 'Power Grid', playing_time: '120', bgg_id: '2651',)
Game.create(name_jp: 'Vampire', name_en: 'Vampire', playing_time: '30', bgg_id: '497',)
Game.create(name_jp: 'Magic: The Gathering', name_en: 'Magic: The Gathering', playing_time: '20', bgg_id: '463',)
Game.create(name_jp: 'Tichu', name_en: 'Tichu', playing_time: '60', bgg_id: '215',)
Game.create(name_jp: 'Crude: The Oil Game', name_en: 'Crude: The Oil Game', playing_time: '90', bgg_id: '147',)
Game.create(name_jp: 'RoboRally', name_en: 'RoboRally', playing_time: '120', bgg_id: '18',)
=end