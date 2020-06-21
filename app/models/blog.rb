class Blog < ApplicationRecord

  def self.crawl_and_create(tag)
    url = 'https://medium.com/tag/' + tag
    unparsed_html = HTTParty.get(url)
    parsed_doc = Nokogiri::HTML(unparsed_html)
    cards = parsed_doc.css('.postArticle')
    cards.each do |card|
      article_body_url = card.css('.postArticle-readMore a').attr('href').value
      parsed_article_body_doc = Nokogiri::HTML(HTTParty.get(article_body_url.split('?')[0]))
      data_hash = {
        author: card.css('.postMetaInline a')[1].text,
        title: card.css('.section-inner h3').text,
        details: card.css('time').text + ', ' + card.css('.readingTime').attr('title').value,
        body: parsed_article_body_doc.css('p').text,
        other_tags: parsed_article_body_doc.css('.n .p ul li').map{|t| t.text}.join(', '),
        search_tag: tag
      }
      Blog.create(data_hash)
    end
  end
end
