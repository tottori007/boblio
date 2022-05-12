# bundle exec rails runner Batch::DbCreate.new
# IN  -
# OUT -

class Batch::DbCreate

  def initialize
    puts '--- Batch::DbCreate START ---'
    exec
    puts '--- Batch::DbCreate END ---'
  end

  def exec
    system("rails db:drop")
    system("rails db:create")
    system("rails db:migrate")
    system("rails db:seed")
  end

end