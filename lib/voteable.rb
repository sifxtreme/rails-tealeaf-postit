# module Voteable
# 	extend ActiveSupport::Concern

# 	included do
# 		has_many :votes, as: :voteable
# 	end

# 	def total_votes
# 		up_votes - down_votes
# 	end

# 	def up_votes
# 		self.votes.where(vote: true).size
# 	end

# 	def down_votes
# 		self.votes.where(vote: false).size
# 	end

# 	module ClassMethods
# 		def my_class_method
# 			return "WHOA"
# 		end
# 	end
# end