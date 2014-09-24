module ApplicationHelper
	def categorize_string(o)
		return o.map{|c| c.name}.join(' | ')
	end

end
