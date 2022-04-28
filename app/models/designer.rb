class Designer < ApplicationRecord
  belongs_to :game
  belongs_to :m_designer, foreign_key: 'designer_id'
end
