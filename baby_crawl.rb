require 'nokogiri'
require 'open-uri'

url = 'http://www.poetryfoundation.org/'
page = Nokogiri::HTML(open(url))

def process_links (page)
  links = []
  raw_links = page.css('a')
  raw_links.each do |link|
    if link['href'][0] == "/"
      link = 'http://www.poetryfoundation.org' + link['href']
      links << link
    end
  end
  return links
end

puts process_links(page)

# url = 'http://www.poetryfoundation.org/poem/250560'
# poem = page.css('#poem div.poem').css('div')
# poem.shift
# search_term = "the"
# collection = []

# poem.each do |line|
#   if line.text.include? search_term
#     collection << line.text
#     puts line.text
#   end
# end
