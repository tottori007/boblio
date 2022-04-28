# bundle exec rails runner Batch::GetList.getPalam [filename] [param]
# IN  file: tmp/bgglist/[filename]
# IN  param:
#   exp -> description
#   ejp -> description(日本語訳)
#   des -> designer
#   pub -> publisher
#   art -> artist
#   cat -> category
#   mec -> mechanic
#   fam -> famiry
# OUT file: tmp/bgglist/[param]YYYYMMDDHHMM.csv

BGG_URL_BASE = "https://api.geekdo.com/xmlapi2/thing?"
IN_FILE_PATH = "tmp/bgglist/"
OUT_FILE_PATH = "tmp/bgglist/"
PAGE_ROW_COUNT = 100

class Batch::GetParam
  require 'rexml/document'

  def self.getParam
    puts '--- Batch::GetParam.getParam START ---'

    if ARGV[0]
      open_file_name = ::IN_FILE_PATH + ARGV[0]
    else
      return '--- Please specify a file name ---'
    end

    param = 
      case ARGV[1]
      when "exp"; "description"
      when "ejp"; "description"
      when "des"; "link[@type='boardgamedesigner']"
      when "pub"; "link[@type='boardgamepublisher']"
      when "art"; "link[@type='boardgameartist']"
      when "cat"; "link[@type='boardgamecategory']"
      when "mec"; "link[@type='boardgamemechanic']"
      when "fam"; "link[@type='boardgamefamiry']"
      else nil
      end

    if param.nil?
      puts '--- Please specify the param  ---'
      return
    end

    id = []
    page = 0
    row_count = 0

    File.open(open_file_name, "r") do |f|
      id[page] = ""
      f.each_line do |line|
        id[page] += line.chomp
        id[page] += ","
        row_count += 1
        if row_count % ::PAGE_ROW_COUNT  == 0
          id[page] = id[page].chop
          page += 1
          id[page] = ""
        end
      end
      id[page] = id[page].chop
    end

    puts '--- Read ' + open_file_name + ' ---'
    puts '--- Total  page:'+page.to_s.next+'  row:'+row_count.to_s + ' ---'

    row_data = []
    row_count = 0
    id.each.with_index(1) do |p_id, n|
      palams = URI.encode_www_form(id: p_id)
      uri = URI.parse(::BGG_URL_BASE + palams)
      response = Net::HTTP.get_response(uri)
      doc = REXML::Document.new(response.body)

      puts '--- Request '+uri.to_s+' ---'

      doc.elements.each('items/item') do |element|
        line = ""
        game_id = element.attributes["id"]
        case ARGV[1]
        when "exp"
          description = element.elements[param].text
          line += '"'+description+'"'
          row_data[row_count] = line
          row_count += 1
        when "ejp"
          description = element.elements[param].text
          description_jp = get_translate_jp(replace_title_jp(game_id, description))
          line += '"'+description_jp+'"'
          row_data[row_count] = line
          row_count += 1
        when "pub"
          line += game_id
          line += ","
          line += element.elements[param].attributes["id"]
          line += ","
          line += element.elements[param].attributes["value"]
          row_data[row_count] = line
          row_count += 1
        else
          element.elements.each(param) do |p|
            line = ""
            line += game_id
            line += ","
            line += p['id']
            line += ","
            line += p['value']
            row_data[row_count] = line
            row_count += 1
          end
        end
      end
    end

    time_stamp = DateTime.now.strftime('%Y%m%d%H%M')
    file_name = ::OUT_FILE_PATH + ARGV[1] + time_stamp + ".csv"

    File.open(file_name, "w") do |num|
      row_data.each do |r|
        num.puts(r)
      end
    end

    puts '--- Create '+file_name+' ---'

    puts '--- Batch::GetParam.getParam END ---'

  end
end

private
def replace_title_jp(game_id, text_en)
  game = Game.find_by(game_id: game_id)
  game_o = GameOption.find_by(game_id: game_id)
  name_en = game.name_en if game.present?
  name_jp = game_o.name_jp if game_o.present?
  text_en = text_en.gsub(game.name_en, game_o.name_jp) if name_en.present? && name_jp.present?
  return text_en
end

#  https://script.google.com/macros/library/d/1Y8_5yaEhQF-1956MpOPkWvV156PV2PZ9BuM2wT8LRguZy5772S80c99f/1
#  text="Hello"&source=en&target=ja
def get_translate_jp(text_en)
  text = CGI.unescapeHTML text_en
  palams = URI.encode_www_form(text: text)
  uri = URI.parse("https://script.google.com/macros/s/AKfycbzemKuGZ0jb3fzt_tLO5i1ofj5oMESXpkxURfWWTCsa1nDcvotCEPZPvhlKPwmQgjObbA/exec?" + palams +"&source=en&target=ja")
  response_redirect = Net::HTTP.get_response(uri)
  if response_redirect.code == "302"
    redirect_url = URI.parse(response_redirect['location'])
  else
    puts '--- Request Error : '+response_redirect.msg+' '+response_redirect.code+' ---'
    return text_en
  end
  response = Net::HTTP.get_response(redirect_url)

  puts '--- Request https://script.google.com/macros/text='+text_en.slice(0..50)+'... ---'

  if response.code == "200"
    res_text = JSON.parse(response.body)['text']
    return res_text.gsub(/\R/, "<br>").gsub("＆","&")
  else
    puts '--- Request Error : '+response.msg+' '+response.code+' ---'
    return text_en
  end
end
