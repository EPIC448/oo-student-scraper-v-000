require 'open-uri'

class Scraper
  # this is our scraper OBJECT class..
  
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        # student and card are RUBY representation of certain HTML element on the page
        # |Student| and |Card| are call node
        # line 13 to 15 are children of students... FYI
        student_profile_link = "#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        # line 17 is all hash beacause we be specific about what we want and it cant mainpulated.
        # name: etc is independent of attr-accesors.  It a key of hash
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
        # this are hashes...but we set them up to be return as an array.... thus array of hasah
      end
    end
    students  #we call student
  end

  def self.scrape_profile_page(profile_slug)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_slug))
    links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    # student[:twitter] = profile_page.css(".social-icon-container").children.css("a")[0].attribute("href").value
    # # if profile_page.css(".social-icon-container").children.css("a")[0]
    # student[:linkedin] = profile_page.css(".social-icon-container").children.css("a")[1].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[1]
    # student[:github] = profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[2]
    # student[:blog] = profile_page.css(".social-icon-container").children.css("a")[3].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[3]
    student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

    student
  end

end
