require_relative "../lib/scraper.rb"
require_relative "../lib/student.rb"
require 'nokogiri'
require 'colorize'
require 'pry'
 
#Note: to run CLI or run an methods in it you say.. you say...  ruby ./bin/run

class CommandLineInteface
  BASE_PATH = "./fixtures/student-site/"  #this is the preset website.

  def call
    make_students
    add_attributes_to_students
    display_students   #line 34 in command_line_interface
  end

  def make_students
    students_array = Scraper.scrape_index_page(BASE_PATH + 'index.html')
              # BASE_PATH is link HTML
              # class method on line 20 is located in student.rb... we created that
    Student.create_from_collection(students_array)   #line 28 in student.rb
  end

  def add_attributes_to_students
    Student.all.each do |student|
      attributes = Scraper.scrape_profile_page(BASE_PATH + student.profile_url) #scraper.rb line #27
       # then we pass in "attributes" in as a argument.
      student.add_student_attributes(attributes) #in student.rb line #48
    end
  end


  def display_students  
    # combines it all together for display in 
     # break this down.
    Student.all.each do |student| #line 26 on command_line_interface
      puts "#{student.name.upcase}".colorize(:blue)
      puts "  location:".colorize(:light_blue) + " #{student.location}"
      puts "  profile quote:".colorize(:light_blue) + " #{student.profile_quote}"
      puts "  bio:".colorize(:light_blue) + " #{student.bio}"
      puts "  twitter:".colorize(:light_blue) + " #{student.twitter}"
      puts "  linkedin:".colorize(:light_blue) + " #{student.linkedin}"
      puts "  github:".colorize(:light_blue) + " #{student.github}"
      puts "  blog:".colorize(:light_blue) + " #{student.blog}"
      puts "----------------------".colorize(:green)
    end
  end

end
