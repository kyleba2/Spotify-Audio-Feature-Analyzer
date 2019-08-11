require 'rspotify'
require_relative 'methods'
RSpotify.authenticate("client_id","client_secret") #insert your own key from "https://developer.spotify.com/dashboard/applications"

def init()
  system 'clear'
  print "Clear output.txt? (y/n): "
end


def run()
  input = gets.chomp
  if (input == "y")
    output = File.open('output.txt', 'w')
    #Creates header
    output.write("Song\tArtist\tKey\tMode\tLength\tTempo\tAcousticness\tDanceability\tEnergy\tLoudness\tValence\tPopularity")
    output.puts ""
    output.close
  end


  song = search()

  if (song != nil)
    #for clarity
    print "You are searching: "
    print song.name
    print " by #{song.artists[0].name}"
    puts""

    key =  getKey(song.audio_features)
    length = song.duration_ms / 1000

    #store results in .txt for easy copypasting to spreadsheet program
    output = File.open('output.txt', 'a')
    output.puts "#{song.name}\t#{song.artists[0].name}\t#{key}\t#{song.audio_features.mode}\t#{length}\t#{song.audio_features.tempo}\t#{song.audio_features.acousticness}\t#{song.audio_features.danceability}\t#{song.audio_features.energy}\t#{song.audio_features.loudness}\t#{song.audio_features.valence}\t#{song.popularity}"
    output.close

    #puts to console for clarity
    puts "Key: #{key}"
    puts "Length: #{length}"
    puts "Tempo: #{song.audio_features.tempo}"
    puts "Acousticness: #{song.audio_features.acousticness}"
    puts "Danceability: #{song.audio_features.danceability}"
    puts "Energy: #{song.audio_features.energy}"
    puts "Loudness: #{song.audio_features.loudness}"
    puts "Valence: #{song.audio_features.valence}"
    puts "Popularity: #{song.popularity}"
    puts "Output saved to \"output.txt\""
    puts ""
    puts "Done! :)" #be polite
  else
    puts "Out of bounds. Try again."
  end

 #prompt to search again
  print "Search again? (y/n): "
  input = gets.chomp
  if (input == "y")
    puts ""
    run()
  else
    system 'clear'
    puts "Terminating program... Type \"ruby main.rb\" to run again."
  end

end

init()
run()
