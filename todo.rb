#!/usr/bin/ruby

# @TODO Add support for unix style arguments e.g. -c <config files>-f <files>

# Function to print usage message
def print_usage()
  puts "Usage: todo [OPTION]"
  puts "-f <files>         List of files to parse"
  puts "-c <config file>   Path to config file"
  puts "-h                 Print this message"
end

# Function to parse command line input
def parse_input(input, files)
  @files_flag = false
  input.each do |argument|
    case argument
    when '-f'
      puts "files"
      @files_flag = true
    when '-c'
      puts "config"
      @files_flag = false
    else
      if @files_flag
        printf "File: %s", argument
        files.push(argument)
      end
    end
  end
end

# Get command line arguments
input_array = ARGV
input_length = input_array.length

# Print a usage message
if input_length == 0
  print_usage()
end

# Make array to hold file object that will be parsed
file_array = Array.new()

parse_input(input_array, file_array)

# Open file objects on specified files
for i in 0..file_array.length - 1
  file_array[i] = File.open(file_array[i])
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
      printf "%d: %s", @line_number, line
    end
    @line_number += 1
  end
end
