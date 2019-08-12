def search()
  print "Type in a song or artist: "
  title = gets.chomp
  puts ""

  if (title == "_skip") #puts a blank line in "output.txt" if ever needed
    output = File.open('output.txt', 'a')
    output.puts ""
    output.close
    search()
  else
    #searches the Spotify library with the given input and outputs the first 20 relevant songs
    song = RSpotify::Track.search(title)

    puts "Here are the 20 most relevant results:"
    puts ""

    for i in 0..19
      if (song[i] != nil) #when there isn't more than 20 songs
        puts "#{i+1}. " + song[i].name + "  -  " + song[i].artists[0].name
      end
    end

    puts ""
    print "Make a selection (0 to search again): "
    num = gets.chomp.to_i
    puts ""
    if (num == 0)
      search()
    else
      song = song[num-1] #arrays start at 0
      return song
    end
  end
end

def getKey(song)
  key = song.key
  #integers map to standard pitch class
  #there's probably a better way to do this but i dont have time to figure that out lol
  if (key == 0)
    key = "C"
  elsif (key == 1)
    key = "C# / Db"
  elsif (key == 2)
   key = "D"
  elsif (key == 3)
    key = "D# / Eb"
  elsif (key == 4)
    key = "E"
  elsif (key == 5)
    key = "F"
  elsif (key == 6)
   key = "F# / Gb"
  elsif (key == 7)
    key = "G"
  elsif (key == 8)
    key = "G# / Ab"
  elsif (key == 9)
    key = "A"
  elsif (key == 10)
    key = "A# / Bb"
  elsif (key == 11)
    key = "B"
   end

  #checks if the song is major or minor
  mode = song.mode
  if (mode == 0)
    key = key.gsub("#", "#m") #replaces # with #m if needed
    key = "#{key}m"
  end
  return key
end
