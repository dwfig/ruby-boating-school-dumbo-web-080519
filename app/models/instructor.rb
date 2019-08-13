class Instructor

  @@all = []

  attr_reader :name

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  def boating_tests
    BoatingTest.all.select do |test|
      test.instructor == self
    end
  end

  def students
    self.boating_tests.map do |test|
      test.student
    end.uniq
  end

  # def pass_student(student, test_name)
  #   passed_test = BoatingTest.all.find do |test|
  #     test.student == student && test.test_name == test_name
  #   end
  #   # passed_test.status = "passed"
  #   if passed_test == nil
  #     passed_test = BoatingTest.new(student,test_name, "passed", self)
  #   else
  #     passed_test.test_status = "passed"
  #   end
  #   passed_test
  #   # If there is a `BoatingTest` whose name and student match the values passed in, this method should update the status of that BoatingTest to 'passed'. If there is no matching test, this method should create a test with the student, that boat test name, and the status 'passed'. Either way, it should return the `BoatingTest` instance.
  # end
  #
  # def fail_student(student, test_name)
  #   failed_test = BoatingTest.all.find do |test|
  #     test.student == student && test.test_name == test_name
  #   end
  #   # failed_test.status = "passed"
  #   if failed_test == nil
  #     failed_test = BoatingTest.new(student,test_name, "failed", self)
  #   else
  #     failed_test.test_status = "failed"
  #   end
  #   failed_test
  #   # ` should take in a student instance and test name. Like `#pass_student`, it should try to find a matching `BoatingTest` and update its status to 'failed'. If it cannot find an existing `BoatingTest`, it should create one with the name, the matching student, and the status 'failed'.
  # end

  def status_change(new_status, student, test_name)
    test_to_change = self.boating_tests.find do |test|
      test.student == student && test.test_name == test_name
    end
    if test_to_change == nil
      test_to_change = BoatingTest.new(student, test_name, new_status, self)
    else
      test_to_change.test_status = new_status
    end
    test_to_change
  end

  def pass_student(student, test_name)
    status_change("passed", student, test_name)
  end

  def fail_student(student, test_name)
    status_change("failed", student, test_name)
  end

end
