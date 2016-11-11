class OpenFile
  attr_accessor :file

  def initialize(file)
    @file = file
    file_to_line
  end

  # Manipulates file to a point where it can be iterated
  # over and parsed.
  def file_to_line
    open_file
    break_lines
    strip_lines
    join_lines
    p @file
    @file
  end

  # Opens file and sets value to a single string.
  def open_file
    @file = File.read(file)
  end

  # Breaks a single html string passed in into
  # individual lines based on line breaks ("\n").
  def break_lines
    @file = @file.split("\n")
  end

  # Takes each line in array and strips it of its
  # leading white spaces from tabs.
  def strip_lines
    @file.each { |line| line.strip!}
  end

  #Joins file back into one string without new line
  # breaks.
  def join_lines
    @file = @file.join
  end

end
# OpenFile.new('lib/simple_test.html')
