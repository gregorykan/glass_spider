require 'nokogiri'
require 'open-uri'
require 'anemone'

url = 'http://www.poetryfoundation.org/'

Anemone.crawl(url) do |anemone|
  anemone.focus_crawl do |page|
    page.links.select {|link| link.to_s.include?('poetryfoundation')}
  end
  anemone.on_every_page do |page|
    if page.doc && page.doc.css('#poem div.poem') && page.doc.css('#poem div.poem').css('div') && !page.url.to_s.include?('poetrymagazine')
      count = 0
      poem = page.doc.css('#poem div.poem').css('div')
      limit = poem.length
      random = Random.new.rand(0..limit)
      poem.each do |line|
        if line.text.length < 100 && count == random
          puts line.text
        end
        count +=1
      end
    end
  end
end

