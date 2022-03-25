module SearchHelper
  def get_player(min, max, best)
    player = min == max ? min.to_s : "#{min.to_s} - #{max.to_s}"
    player += " (Best:#{best})" if best.present?
    return player
  end
  def get_name_jp(game)
    game.game_option.name_jp.present? ? game.game_option.name_jp : game.name_en
  end
end
