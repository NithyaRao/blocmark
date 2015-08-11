class Topic < ActiveRecord::Base
  belongs_to :user
   has_many :bookmarks, dependent: :destroy
   has_many :likes, dependent: :destroy
end
