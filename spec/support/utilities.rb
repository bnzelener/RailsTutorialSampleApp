def full_title(page_title)
	base_title = "My Sample App, Bitches!"
	if page_title.empty?
		base_title
	else
	"#{base_title} | #{page_title}"
	end
end