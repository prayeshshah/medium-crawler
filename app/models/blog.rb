class Blog < ApplicationRecord

  def self.crawl_and_create(tag)
    url = 'https://medium.com/tag/' + tag
    unparsed_html = HTTParty.get(url)
    parsed_doc = Nokogiri::HTML(unparsed_html)
    (0..2).to_a.each do |x|
      article_body_url = parsed_doc.css('.postArticle')[x].css('.postArticle-readMore').css('a').first['href']
      parsed_article_body_doc = Nokogiri::HTML(HTTParty.get(article_body_url.split('?')[0]))
      # responses_url = parsed_article_body_doc.at_css('a:contains("See responses")')
      # crawl_responses(responses_url['href']) if responses_url
      data_hash = {
        author: parsed_doc.css('.postArticle')[x].css('.ds-link')[0].text,
        title: parsed_doc.css('.postArticle')[x].css('.section-inner').css('h3').text,
        details: parsed_doc.css('.postArticle')[x].css('time').text + ', ' + parsed_doc.css('.postArticle')[x].css('.readingTime')[0].attributes["title"].value,
        body: parsed_article_body_doc.css('p').text,
        other_tags: parsed_article_body_doc.css('.n .p').css('ul li').map{|t| t.text}.join(', '),
        search_tag: tag
      }
      Blog.create(data_hash)
    end
  end
end
