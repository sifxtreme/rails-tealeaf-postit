module ApplicationHelper
	def categorize_string(o)
		return o.map{|c| c.name}.join(' | ')
	end


	def display_datetime(dt)
		return dt.strftime("%m/%d/%Y %l:%M%P %Z")
	end

end
