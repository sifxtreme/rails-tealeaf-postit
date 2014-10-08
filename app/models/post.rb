class Post < ActiveRecord::Base
	belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
	has_many :comments
	has_many :post_categories
	has_many :categories, through: :post_categories
	has_many :votes, as: :voteable

	before_save :generate_slug

	validates :title, presence: true, length: {minimum: 5}
	validates :url, presence: true

	def total_votes
		up_votes - down_votes
	end

	def up_votes
		self.votes.where(vote: true).size
	end

	def down_votes
		self.votes.where(vote: false).size
	end

	def generate_slug
		orig_slug = to_slug(self.title)
		post = Post.find_by slug: orig_slug
		the_slug = orig_slug
		count = 2
		while post && post != self
			the_slug = orig_slug + "-" + count.to_s
			post = Post.find_by slug: the_slug
			count = count+1
		end
		self.slug = the_slug.downcase
	end

	def to_slug(name)
		str = name.strip
		str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
		str.gsub! /-+/, '-'
		return str
	end

	def to_param
		self.slug
	end

end
 