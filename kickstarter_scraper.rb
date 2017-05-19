require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  project_hash = {
    projects: {}
  }


  projects = kickstarter.css("li.project.grid_4")

  projects.each do |project|
    hash = {}
    info_hash = {
      image_link: project.css(".project-thumbnail a img").attribute("src").value,
      description: project.css("p.bbcard_blurb").text.strip,
      location: project.css("span.location-name").text,
      percent_funded: project.css(".first.funded strong").text.gsub("%", "").to_i
    }
    title = project.css("h2.bbcard_name strong a").text
    hash[title] = info_hash
    project_hash[:projects].merge!(hash)
  end

  project_hash[:projects]
end
