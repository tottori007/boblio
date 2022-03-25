module Constants
  APP_VERSION = "1.0.0"

  #seed csv
  CSV_PATH = "db/csv/"
  CSV_FILE_GAMES = "games.csv"
  CSV_FILE_GAME_OPTIONS = "game_options.csv"

  #search/index
  SEARCH_TEXT = "Filters"

  PLAYING_TIME_TEXT = "プレイ時間"
  PLAYING_TIME = {
    "30分以内": 1,
    "30~60分": 2,
    "60分以上": 3 
  }.freeze
  PLAYING_TIME_COND = {
    "1": Float::MIN..30,
    "2": 30..60,
    "3": 60..Float::INFINITY
  }.freeze

  PLAYER_TEXT = "プレイ人数"
  PLAYER = {
    "1人": 1,
    "2人": 2,
    "3人": 3,
    "4人": 4,
    "5人": 5,
    "6人以上": 6 
  }.freeze
  PLAYER_COND = {
    "1": 1,
    "2": 2,
    "3": 3,
    "4": 4,
    "5": 5,
    "6": 6
  }.freeze

  RELEASE_YEAR_MIN = 1800
  RELEASE_YEAR_MAX = Date.today.year

end