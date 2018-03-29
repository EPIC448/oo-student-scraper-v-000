class Student
 
  # this is template to create OBJECT such STUDENT () will haave a name, location... 
  #!!!!!! the Object is the thing that contain all the attribute in attr_accessor..... and it created by our Student class
  
  
  # it okay... your project might be different.... you Book project has scraper and this class in it... 
  # the concepts still apply....
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash) # from line 25 in student.rb
    student_hash.each do |key, value|
            #keys are all attr_accessor.. name , location etc
      self.send("#{key}=", value)

            # line 10 ... our hash keys used to call a attr_writer .... through attr_accessor
            # this is where we are using the collected hash as an object.  
            # self.name = student_hash[:name]  
            # self.location = stuent_hash[:location]
            # student.profile_url = student_hash[:profile_url]

    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      # we are using the hash to create a new instance od student. 
      Student.new(student_hash) #
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attr, value|
      self.send("#{attr}=", value)
    end
    self
  end

  def self.all
    @@all
  end
end

