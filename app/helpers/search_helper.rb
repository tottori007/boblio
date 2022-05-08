module SearchHelper
  require "cgi/escape"

  def get_player(min, max, best)
    player = min == max ? min.to_s : "#{min.to_s} - #{max.to_s}"
    player += " (Best:#{best})" if best.present?
    return player
  end
  def get_name_jp(game)
    game_opt = game.game_option
    return game.name_en if game_opt.nil?
    game_opt.name_jp.present? ? game_opt.name_jp : game.name_en
  end
  def get_translate_jp(text_en)
    text = CGI.unescapeHTML text_en
    palams = URI.encode_www_form(text: text)
    uri = URI.parse("https://script.google.com/macros/s/AKfycbzemKuGZ0jb3fzt_tLO5i1ofj5oMESXpkxURfWWTCsa1nDcvotCEPZPvhlKPwmQgjObbA/exec?" + palams +"&source=en&target=ja")
    redirect_url = URI.parse(Net::HTTP.get_response(uri)['location'])
    response = Net::HTTP.get_response(redirect_url)

    if response.code == "200"
      res_text = JSON.parse(response.body)['text']
      return res_text.gsub(/\R/, "<br>").gsub(/\s/, " ").gsub("＆","&")
      #return res_text.gsub(/\R/, "<br>").gsub(/\s/, "&nbsp;").gsub("＆","&")
    else
      return text_en
    end
  end
end
