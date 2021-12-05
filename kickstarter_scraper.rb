# require libraries/modules here
require 'nokogiri'
require 'pry'
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard-blurb").text
# location: project.css("ul.project-meta").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  #now set up empty projects hash that we fill up with scraped data:
  projects = {}
  #then Iterate through the projects w loop
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard-blurb").text,
      :location => project.css("ul.project-meta").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i,

    }
  end

  #thenthen return the projects hash taht we filled above
  projects
end
