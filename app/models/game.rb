class Game < ApplicationRecord
  self.primary_key = :game_id
  has_one :game_option

  scope :search, -> (search_params) do
    return if search_params.blank?
      name_like(search_params[:keyword])
      .play_time(search_params[:playing_time])
      .player(search_params[:player], search_params[:best])
      .player_best(search_params[:player], search_params[:best])
      .year(search_params[:miny], search_params[:maxy])
  end

  scope :name_like, -> (keyword) { where(["name_jp like? OR name_en like?", "%#{keyword}%", "%#{keyword}%"]) if keyword.present? }
  scope :play_time, -> (playing_time) { where(playing_time: Constants::PLAYING_TIME_COND[playing_time.to_sym]) if playing_time.present? }
  scope :player, -> (player, best) { where(["player_min <= #{player} AND #{player} <= player_max"] ) if player.present? && best.to_i.zero? }
  scope :player_best, -> (player, best) { where(player_best: player) if player.present? && !best.to_i.zero? }
  scope :year, -> (miny, maxy) { where(release_year: miny..maxy) if miny.present? & maxy.present? }

end