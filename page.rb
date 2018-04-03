require 'yaml'

class Page

  def read_config
    config = YAML.load_file("config.yml")
    $main_page_url = config["main_page_url"]
    $url = config["url"]
    $exclude_links = config["exclude_links"]
  end

end