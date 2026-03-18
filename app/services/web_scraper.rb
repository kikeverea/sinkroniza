require "net/http"
require "nokogiri"
require "uri"

class WebScraper
  def self.scrape(page_url)
    page = URI.open(page_url)
    html = page.read
    doc  = Nokogiri::HTML(html)

    # noinspection RubyRedundantSafeNavigation
    href =
      doc.at_css('link[rel="icon"]')&.[]("href") ||
      doc.at_css('link[rel="shortcut icon"]')&.[]("href") ||
      doc.at_css('link[rel="apple-touch-icon"]')&.[]("href") ||
      "/favicon.ico"

    {
      favicon: URI.join(page_url, href).to_s
    }
  end

  def self.result(favicon:)

  end
end