require 'open-uri'
require 'nokogiri'
require 'net/https'
require_relative 'page'
require_relative 'report_generator'



class LinkChecker

  #@url = 'http://getbootstrap.com/'


  def find_links_on_page(url)
    doc = Nokogiri::HTML(open(url))
    links = doc.css('a')
    href = links.map {|link| link.attribute('href').to_s}
    href.map do|h|
      if /\A#/.match(h)
        h = url + h
        elsif /\A\//.match(h)
          h = $main_page_url + h
        else h = h
      end
    end
  end

  def get_response_code(links)
    responce = Hash.new
  links.each do|link|
    uri = URI(link)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'

    http.start do |h|
      res = h.request Net::HTTP::Get.new(uri.request_uri)
      responce[uri] = res.code
    end
  end
  responce
  end




end


Page.new.read_config
lc = LinkChecker.new()
all_links = lc.find_links_on_page($url)
all_resp = lc.get_response_code(all_links)
report = ReportGenerator.new()

report.show_verified_link(all_resp)
report.show_broken_links(all_resp)


