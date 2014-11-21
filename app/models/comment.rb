class Comment < ActiveRecord::Base
	include VoteableAsifOct

	belongs_to :user
	belongs_to :post

	validates :body, presence: true, length: {minimum: 5}

end
