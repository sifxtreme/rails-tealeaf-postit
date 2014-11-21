module Sluggable
	extend ActiveSupport::Concern

	included do
		before_save :generate_slug
		class_attribute :slug_column
	end

	def generate_slug
		orig_slug = to_slug(self.send(self.class.slug_column.to_sym))
		obj = self.class.find_by slug: orig_slug
		the_slug = orig_slug
		count = 2
		while obj && post != self
			the_slug = orig_slug + "-" + count.to_s
			obj = self.class.find_by slug: the_slug
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

	module ClassMethods
		def sluggable_column(column_name)
			self.slug_column = column_name
		end
	end

end