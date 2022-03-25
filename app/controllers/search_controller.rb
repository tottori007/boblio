class SearchController < ApplicationController
  require 'rexml/document'
  require "open-uri"

  def index
    @games = Game.joins("LEFT OUTER JOIN game_options ON games.game_id = game_options.game_id").search(params).order("release_year DESC").order("games.game_id DESC").page(params[:page])
    @keyword = params[:keyword]
    @playing_time = params[:playing_time]
    @player = params[:player]
    @best = params[:best]
    @miny = params[:miny].present? ? params[:miny] : Constants::RELEASE_YEAR_MIN
    @maxy = params[:maxy].present? ? params[:maxy] : Constants::RELEASE_YEAR_MAX
#    @game_image = get_image_url_all(@games)
  end

  def show
    @game = Game.find(params[:id])
#    @game_image = get_image_url(@game.bgg_id)
  end

  private
  def get_image_url_all(games)
    id = ""
    games.each_with_index do |game, i|
      id += game.game_id.to_s
      if i != games.length - 1
        id += ","
      end
    end

    palams = URI.encode_www_form(id: id)
    uri = URI.parse("https://api.geekdo.com/xmlapi2/thing?" + palams)
    response = Net::HTTP.get_response(uri)
    doc = REXML::Document.new(response.body)

    image = []
    doc.elements.each('items/item') do |element|
      image.push(element.elements["thumbnail"].text)
    end

    return image
  end

  def get_image_url(bgg_id)
    palams = URI.encode_www_form(id: bgg_id.to_s)
    uri = URI.parse("https://api.geekdo.com/xmlapi2/thing?" + palams)
    response = Net::HTTP.get_response(uri)
    doc = REXML::Document.new(response.body)
    if !doc.elements['//items/item/image'].nil?
      return doc.elements['//items/item/image'].text
    end
  end

end
