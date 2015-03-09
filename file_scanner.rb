require 'open-uri'

puts "\nWELCOME TO THE DIRECTORY SCANNER\n"

def scan
  puts "Please type in the name of the Directory you'd like to scan.\n"
  print ">. "

  @dirname = gets.chomp

  if @dirname.empty?
    @dirname = "hardware"
    puts "No Input Found Defaulting to Hardware Directory"
  end
  phrase
end

def phrase
  items = ["Palmchip", "Verilog", "mbus"]
  #File.open("inputs.txt", "r").readlines.each do |items|
    items.each do |phrase|
      File.open("#{phrase}_results.csv", "w")
      total_matches = 0

        total_directories = Dir.glob("#{@dirname}/**/*.*").each do |fname|
        file_read_contents = File.open(fname).read
        if file_read_contents.match(phrase)
          lines.puts "#{fname}\t\t\t FOUND MATCH FOR PHRASE [ #{phrase} ]"
          total_matches+=1
        end
      end
    
    puts "\n=============================================================================="
    puts "\n                               SCAN RESULTS                                   "
    puts "\n=============================================================================="
    puts "\nScanned a Total of #{total_directories.length} files within #{@dirname} directory and sub-directories."
    puts "Found #{total_matches} Incidents of #{phrase} within #{@dirname} Directory from a Total of #{total_directories.length} Files"
    puts ""
    puts "Printing Results to #{phrase}_Results.csv"
  end
end

scan
