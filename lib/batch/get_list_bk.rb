# bundle exec rails runner Batch::GetList.getList [filename]
# IN  file: tmp/bgglist/[filename]
# OUT file: tmp/bgglist/listYYYYMMDDHHMM.csv

class Batch::GetList
  require 'rexml/document'

  def self.getList
    puts '--- Batch::GetList.getList START ---'

    if ARGV[0]
      open_file_name = "tmp/bgglist/"+ARGV[0]
    else
      puts '--- Please specify a file name ---'
      return
    end

    id = ""
    page = ARGV[0].rpartition("page")
    File.open(open_file_name, "r") do |f|
      f.each_line { |line|
        id += line.chomp
        id += ","
      }
    end
    id = id.chop

    puts '--- Read '+open_file_name+' ---'

    palams = URI.encode_www_form(id: id)
    uri = URI.parse("https://api.geekdo.com/xmlapi2/thing?" + palams)
    response = Net::HTTP.get_response(uri)
    doc = REXML::Document.new(response.body)

    time_stamp = DateTime.now.strftime('%Y%m%d%H%M')
    file_name = "tmp/bgglist/list" + time_stamp + page[1] + page[2] + ".csv"

    File.open(file_name, "w") do |num|
      num.puts('name_en,release_year,player_min,player_max,player_best,playing_time,playing_time_min,playing_time_max,age_min,game_id,image_url,thumbnail_url')
      doc.elements.each('items/item') do |element|
        line = ""
        line += element.elements["name"].attributes["value"]
        line += ","
        line += element.elements["yearpublished"].attributes["value"]
        line += ","
        line += element.elements["minplayers"].attributes["value"]
        line += ","
        line += element.elements["maxplayers"].attributes["value"]
        line += ","
        line += get_bestplayer(element.elements["poll"])
        line += ","
        line += element.elements["playingtime"].attributes["value"]
        line += ","
        line += element.elements["minplaytime"].attributes["value"]
        line += ","
        line += element.elements["maxplaytime"].attributes["value"]
        line += ","
        line += element.elements["minage"].attributes["value"]
        line += ","
        line += element.attributes["id"]
        line += ","
        line += element.elements["image"].text
        line += ","
        line += element.elements["thumbnail"].text
        num.puts(line)
      end
    end

    puts '--- Create '+file_name+' ---'

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

    puts '--- Batch::GetList.getList END ---'
  end
end

private
def get_bestplayer(poll)

  best_player = ""
  best_score = 0
  poll.elements.each('results') do |element|
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