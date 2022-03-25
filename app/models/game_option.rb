class GameOption < ApplicationRecord
  belongs_to :game, dependent: :destroy, primary_key: :game_id
end
