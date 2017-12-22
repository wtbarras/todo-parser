#!/usr/bin/ruby

# @TODO Add support for unix style arguments e.g. -c <config files>-f <files>

# Get command line arguments
input_array = ARGV
input_length = input_array.length
# Make array to hold file object that will be parsed
file_array = Array.new(input_length)

# Open file objects on specified files
for i in 0..input_length-1
  file_array[i] = File.open(input_array[i])
end

# Print out file contents
file_array.each do |file|
  puts file.path
  @line_number = 1
  file.readlines.each do |line|
    if line.include? "@TODO"
      printf "%d: %s\n", @line_number, line
    end
    @line_number += 1
  end
end
