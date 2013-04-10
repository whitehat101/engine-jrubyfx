# encoding: utf-8

#
# Responsible for loading sound media to be played using an id or key.
# Contains all sounds for use later.
# <p/>
# User: cdea
#
class JavaFXEngine::JFXGen::SoundManager
  java_import javafx.scene.media.AudioClip
  java_import java.util.concurrent.Executors

  #
  # Constructor to create a simple thread pool.
  #
  # @param numberOfThreads - number of threads to use media players in the map.
  #
  def initialize numberOfThreads = 2
    @soundPool       = Executors.newFixedThreadPool numberOfThreads
    @soundEffectsMap = {}
  end

  #
  # Load a sound into a map to later be played based on the id.
  #
  # @param id  - The identifier for a sound.
  # @param url - The url location of the media or audio resource. Usually in src/main/resources directory.
  #
  def loadSoundEffects id, url
    sound = AudioClip.new url.toExternalForm
    @soundEffectsMap[id.to_sym] = sound
  end

  #
  # Lookup a name resource to play sound based on the id.
  #
  # @param id identifier for a sound to be played.
  #
  def playSound id
    @soundPool.execute do
      @soundEffectsMap[id.to_sym].play
    end
  end

  #
  # Stop all threads and media players.
  #
  def shutdown
    @soundPool.shutdown
  end

end
