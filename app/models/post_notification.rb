class PostNotification < ApplicationRecord
    belongs_to :post
    belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
    belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  
    enum action: { comment: 1, favorite: 2 }
  end
  