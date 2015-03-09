require 'open-uri'

puts "\nWELCOME TO THE DIRECTORY SCANNER\n"

def scan
  puts "Please type in the name of the Directory you'd like to scan.\n"
  print ">. "

  dirname = gets.chomp

  if dirname.empty?
    dirname = "hardware"
    puts "No Input Found Defaulting to Hardware Directory"
  end

  puts "What Phrase would you like to scan for? (NOTE: Phrase is Case Sensitive)"
  print ">. "

  phrase = gets.chomp
  results = File.open("#{phrase}_results.csv", "w")
  total_matches = 0

  total_directories = Dir.glob("#{dirname}/**/*.*").each do |fname|
    file_read_contents = File.open(fname).read
      if file_read_contents.match(phrase)
        results.puts "#{fname}\t\t\t FOUND MATCH FOR PHRASE [ #{phrase} ]"
	  total_matches+=1
      end
  end

  puts "\n=============================================================================="
  puts "\n                               SCAN RESULTS                                   "
  puts "\n=============================================================================="
  puts "\nScanned a Total of #{total_directories.length} files within #{dirname} directory and sub-directories."
  puts "Crunching Numbers ... <insert robot noises> ... "
  puts "Found #{total_matches} Incidents of #{phrase} within #{dirname} Directory from a Total of #{total_directories.length} Files"
  puts ""
  puts "Printing Results to #{phrase}_Results.csv"

  puts "\nWould you like to scan another term or phrase?"
  puts "Please Type Yes or No"
  input = gets.chomp.capitalize
  if (input == "Yes")
    scan
  else (input == "No")
    puts "Thank you for using the Document Scanner. Have a wonderful day and day."
  end
end

scan
