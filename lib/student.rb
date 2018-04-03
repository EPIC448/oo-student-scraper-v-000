class Student
 
  # this is template to create OBJECT such STUDENT () will haave a name, location... 
  #!!!!!! the Object is the thing that contain all the attribute in attr_accessor..... and it created by our Student class
  
  
  # it okay... your project might be different.... you Book project has scraper and this class in it... 
  # the concepts still apply....
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash) # from line 37 in student.rb
    student_hash.each do |key, value|
            #keys are all attr_accessor.. name , location etc
      self.send("#{key}=", value)

            # line 17 ... our hash keys used to a attr_writer .... through attr_accessor. with the help of .send
            # this is where we are using the collected hash as an object.  
            # self.name = student_hash[:name]  
            # self.location = stuent_hash[:location]
            # student.profile_url = student_hash[:profile_url]
            # example.. https://stackoverflow.com/questions/3337285/what-does-send-do-in-ruby
    end
    @@all << self
  end


  def self.all
    @@all # call it from line 27 student.rb
  end


  def self.create_from_collection(students_array) # it comes in as an array
    students_array.each do |student_hash|

       # student_hash just a representation what is provided as student_array
       # is looped over. i.e {:name=>"Alex Patriquin", :location=>"New York, NY"}
       # we are using the hash to create a new instance of student. 
      
       Student.new(student_hash) # then we call the instance of the class Student with result from line 30
    end
  end



  def add_student_attributes(attributes_hash) # used in command line 29. attribute_hash is passed in
    #attr  in this case is a KEY =  :twitter and VALUE = "https://twitter.com/empireofryan"
    attributes_hash.each do |attr, value| 
      self.send("#{attr}=", value)
    end
    self
  end

  
end

