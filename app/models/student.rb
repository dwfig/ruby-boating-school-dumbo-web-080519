class Student
  # *  initialize with `first_name`
  attr_reader :first_name

  @@all = []

  def initialize(first_name)
    @first_name = first_name
    @@all << self
  end

  def self.all
    @@all
  end

  def boating_tests
    BoatingTest.all.select do |test|
      test.student == self
    end
  end

  def instructors
    self.boating_tests.map do |test|
      test.instructor
    end.uniq
  end

  def self.find_student(first_name)
    # output the student (Object) with that name
    self.all.find do |student|
        student.first_name == first_name
    end
  end

  def add_boating_test(test_name, test_status, instructor)
    # initialize new boating test
    BoatingTest.new(self, test_name, test_status, instructor)
  end

  def grade_percentage
    # return the percentage of tests that the student has passed as a Float
    tests = self.boating_tests
    passed_tests = self.boating_tests.select do |test|
      test.test_status == "passed"
    end
    num_tests = tests.count.to_f
    num_passed_tests = passed_tests.count.to_f
    grade_decimal = num_passed_tests / num_tests
    grade_percentage = grade_decimal * 100
  end

  def reduce_gp
    passed_tests = self.boating_tests.reduce(0) do |accumulator, test|
      test.test_status == "passed" ? accumulator += 1 : accumulator
      # if test.test_status == "passed"
      #   accumulator += 1
      # end
      # accumulator
    end
  end

  def ternary_version
    numtests = self.boating_tests.count
    numtests{|test| test.test_status =="passed"}.to_f/numtests*100
  end

end
