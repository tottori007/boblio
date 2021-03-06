# bundle exec rails runner Batch::GetList.getList [filename]
# IN  file: tmp/bgglist/[filename]
# OUT file: tmp/bgglist/listYYYYMMDDHHMM.csv

BGG_URL_BASE = "https://api.geekdo.com/xmlapi2/thing?"
IN_FILE_PATH = "tmp/bgglist/"
OUT_FILE_PATH = "tmp/bgglist/"
OUT_FINE_NAME = "list" # listYYYYMMDDHHMM.csv
PAGE_ROW_COUNT = 100

class Batch::GetList
  require 'rexml/document'

  def self.getList
    puts '--- Batch::GetList.getList START ---'

    if ARGV[0]
      open_file_name = ::IN_FILE_PATH + ARGV[0]
    else
      puts '--- Please specify a file name ---'
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
        line += element.attributes["id"]
        line += ","
        line += '"'+element.elements["name"].attributes["value"]+'"'
        line += ","
        line += element.elements["yearpublished"].attributes["value"]
        line += ","
        line += element.elements["minplayers"].attributes["value"]
        line += ","
        line += element.elements["maxplayers"].attributes["value"]
        line += ","
        line += get_bestplayer(element.elements["poll[@title='User Suggested Number of Players']"])
        line += ","
        line += element.elements["playingtime"].attributes["value"]
        line += ","
        line += element.elements["minplaytime"].attributes["value"]
        line += ","
        line += element.elements["maxplaytime"].attributes["value"]
        line += ","
        line += element.elements["minage"].attributes["value"]
        line += ","
        line += element.elements["image"].text if element.elements["image"].present?
        line += ","
        line += element.elements["thumbnail"].text if element.elements["thumbnail"].present?
        row_data[row_count] = line
        row_count += 1
      end
    end

    time_stamp = DateTime.now.strftime('%Y%m%d%H%M')
    file_name = ::OUT_FILE_PATH + ::OUT_FINE_NAME + time_stamp + ".csv"

    File.open(file_name, "w") do |num|
      num.puts('game_id,name_en,release_year,player_min,player_max,player_best,playing_time,playing_time_min,playing_time_max,age_min,image_url,thumbnail_url')
      row_data.each do |r|
        num.puts(r)
      end
    end

    puts '--- Create '+file_name+' ---'

=begin
    file_name_desc = "tmp/bgglist/desc" + time_stamp + page[1] + page[2] + ".csv"

    File.open(file_name_desc, "w") do |num|
      num.puts('description')
      doc.elements.each('items/item') do |element|
        line = ""
        line += element.elements["description"].text
#        line += get_translate_jp(element.elements["description"].text)
        num.puts(line)
      end
    end

    puts '--- Create '+file_name_desc+' ---'
=end
    puts '--- Batch::GetList.getList END ---'

  end
end

private
# Best*2 + Reco - NotReco ????????????????????????????????????
def get_bestplayer(poll)

  return "" if poll.nil?

  best_player = ""
  best_score = 0
  poll.elements.each('results') do |element|
    return best_player if element.elements["result"].nil?
    score = 0
    score += element.elements["result[@value='Best']"].attributes["numvotes"].to_i * 2
    score += element.elements["result[@value='Recommended']"].attributes["numvotes"].to_i
    score -= element.elements["result[@value='Not Recommended']"].attributes["numvotes"].to_i
    if best_score < score
      best_player = element.attributes["numplayers"]
      best_score = score
    end
  end
  return best_player

end
def get_translate_jp(text_en)
  palams = URI.encode_www_form(text: text_en)
  uri = URI.parse("https://script.google.com/macros/s/AKfycbzemKuGZ0jb3fzt_tLO5i1ofj5oMESXpkxURfWWTCsa1nDcvotCEPZPvhlKPwmQgjObbA/exec?" + palams +"&source=en&target=ja")
  response = Net::HTTP.get_response(uri)

  if response.code == 200
    return response.body
  end

#  https://script.google.com/macros/s/AKfycbzemKuGZ0jb3fzt_tLO5i1ofj5oMESXpkxURfWWTCsa1nDcvotCEPZPvhlKPwmQgjObbA/exec
#  https://script.google.com/macros/library/d/1Y8_5yaEhQF-1956MpOPkWvV156PV2PZ9BuM2wT8LRguZy5772S80c99f/1
#  text="Hello"&source=en&target=ja

end