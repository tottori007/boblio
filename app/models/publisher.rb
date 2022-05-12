class Publisher < ApplicationRecord
  belongs_to :game
  belongs_to :m_publisher, foreign_key: 'publisher_id'
end
