#!/usr/bin/ruby

# @TODO Add support for unix style arguments e.g. -c <config files>-f <files>

def print_usage()
  puts "Usage: todo [OPTION]"
  puts "-f <files>         List of files to parse"
  puts "-c <config file>   Path to config file"
  puts "-h                 Print this message"
end


# Get command line arguments
input_array = ARGV
input_length = input_array.length

# Print a usage message
if input_length == 0
  print_usage()
end

# Make array to hold file object that will be parsed
# This won't be the same as input_length once more arguments are added
file_array = Array.new(input_length)

# Open file objects on specified files
for i in 0..input_length-1
  file_array[i] = File.open(input_array[i])
end

# Go through each file that was specified
file_array.each do |file|
  # Print file name
  puts file.path
  @line_number = 1
  # Go through each line in the file
  file.readlines.each do |line|
    # Check if the line includes the target text
    if line.include? "@TODO"
      # Strip comment and todo off front of line
      line = line[line.index("@TODO") + 6, line.length - 1]
      # Print line number and message
      printf "%d: %s\n", @line_number, line
    end
    @line_number += 1
  end
end
