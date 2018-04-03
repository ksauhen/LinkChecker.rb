class ReportGenerator

  def show_verified_link(links)
    links.each_key {|k| puts k}
  end

  def show_broken_links(links)
    puts links.select {|k,v| v.to_i >= 400}
  end

end