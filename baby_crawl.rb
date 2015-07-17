require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'anemone'

url = 'http://www.poetryfoundation.org/'

Anemone.crawl(url) do |anemone|
  count = 0
  anemone.focus_crawl do |page|
    page.links.select {|link| link.to_s.include? 'poetryfoundation'}
  end
  anemone.on_every_page do |page|
    if page.doc && page.doc.css('#poem div.poem') && page.doc.css('#poem div.poem').css('div')
      poem = page.doc.css('#poem div.poem').css('div')
      poem.each do |line|
        if line.text.include? 'tree'
          puts line.text
          count += 1
          puts count
        end
      end
    end
  end
end



# page = Nokogiri::HTML(open(url))
# $links = []

# def process_links (page)
#   raw_links = page.css('a')
#   raw_links.each do |link|
#     if link['href'][0] == "/"
#       link = 'http://www.poetryfoundation.org' + link['href']
#       $links << link
#     end
#   end
# end

# process_links page
# puts $links

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
