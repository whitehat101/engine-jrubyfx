# encoding: utf-8

#
# This application demonstrates a JavaFX 2.x Game Loop.
# Shown below are the methods which comprise of the fundamentals to a
# simple game loop in JavaFX:
# <pre>
#  <b>init()</b> - Initialize the game world.
#  <b>beginGameLoop()</b> - Creates a JavaFX Timeline object containing the game life cycle.
#  <b>updateSprites()</b> - Updates the sprite objects each period (per frame)
#  <b>checkCollisions()</b> - Method will determine objects that collide with each other.
#  <b>cleanupSprites()</b> - Any sprite objects needing to be removed from play.
# </pre>
#
# @author cdea
#


module JavaFXEngine::JFXGen::GameWorld
  java_import javafx.animation.TimelineBuilder
  java_import javafx.animation.Animation
  java_import javafx.animation.KeyFrame
  java_import javafx.util.Duration

  #
  # Constructor that is called by the derived class. This will
  # set the frames per second, title, and setup the game loop.
  #
  # @param fps   - Frames per second.
  # @param title - Title of the application window.
  #

  def initialize fps, title
    # The sprite and sound managers.
    @spriteManager = SpriteManager.new
    @soundManager  =  SoundManager.new 3

    # Number of frames per second.
    @framesPerSecond = fps

    # Title in the application window.
    @windowTitle = title

    # create and set timeline for the game loop
    buildAndSetGameLoop
  end

  #
  # Builds and sets the game loop ready to be started.
  #
  # protected final void
  def buildAndSetGameLoop
    oneStep     = proc do
      # update actors
      updateSprites

      # check for collision
      checkCollisions

      # removed dead things
      cleanupSprites
    end
    oneFrameAmt = Duration.millis( 1000.0 / getFramesPerSecond )
    oneFrame    = KeyFrame.new oneFrameAmt, oneStep

    # sets the game world's game loop (Timeline)
    infinite_loop = TimelineBuilder.create
      .cycleCount(Animation::INDEFINITE)
      .keyFrames(oneFrame)
      .build

    setGameLoop infinite_loop
  end

  #
  # Initialize the game world by update the JavaFX Stage.
  #
  # @param primaryStage The main window containing the JavaFX Scene.
  #
  # public abstract void
  def init(primaryStage) end

  #
  # Kicks off (plays) the Timeline objects containing one key frame
  # that simply runs indefinitely with each frame invoking a method
  # to update sprite objects, check for collisions, and cleanup sprite
  # objects.
  #
  def beginGameLoop
    @gameLoop.play
  end

  #
  # Updates each game sprite in the game world. This method will
  # loop through each sprite and passing it to the handleUpdate()
  # method. The derived class should override handleUpdate() method.
  #
  def updateSprites
    @spriteManager.getAllSprites.each { |sprite| handleUpdate sprite }
  end

  #
  # Updates the sprite object's information to position on the game surface.
  #
  # @param sprite - The sprite to update.
  #
  def handleUpdate(sprite) end

  #
  # Checks each game sprite in the game world to determine a collision
  # occurred. The method will loop through each sprite and
  # passing it to the handleCollision()
  # method. The derived class should override handleCollision() method.
  #
  def checkCollisions
    # check other sprite's collisions
    @spriteManager.resetCollisionsToCheck

    # check each sprite against other sprite objects.
    @spriteManager.getCollisionsToCheck.each do |spriteA|
      @spriteManager.getAllSprites.each do |spriteB|
        # The break helps optimize the collisions
        #  The break statement means one object only hits another
        # object as opposed to one hitting many objects.
        # To be more accurate comment out the break statement.
        break if handleCollision spriteA, spriteB
      end
    end
  end

  #
  # When two objects collide this method can handle the passed in sprite
  # objects. By default it returns false, meaning the objects do not
  # collide.
  #
  # @param spriteA - called from checkCollision() method to be compared.
  # @param spriteB - called from checkCollision() method to be compared.
  # @return boolean True if the objects collided, otherwise false.
  #
  def handleCollision spriteA, spriteB
    false
  end

  #
  # Sprites to be cleaned up.
  #
  def cleanupSprites
    @spriteManager.cleanupSprites
  end

  #
  # Returns the frames per second.
  #
  # @return int The frames per second.
  #
  def getFramesPerSecond
    @framesPerSecond
  end

  #
  # Returns the game's window title.
  #
  # @return String The game's window title.
  #
  def getWindowTitle
    @windowTitle
  end

  #
  # The game loop (Timeline) which is used to update, check collisions, and
  # cleanup sprite objects at every interval (fps).
  #
  # @return Timeline An animation running indefinitely representing the game
  #         loop.
  #
  def getGameLoop
    @gameLoop
  end

  #
  # The sets the current game loop for this game world.
  #
  # @param gameLoop Timeline object of an animation running indefinitely
  #                 representing the game loop.
  #
  def setGameLoop gameLoop
    @gameLoop = gameLoop
  end

  #
  # Returns the sprite manager containing the sprite objects to
  # manipulate in the game.
  #
  # @return SpriteManager The sprite manager.
  #
  def getSpriteManager
    @spriteManager
  end

  #
  # Returns the JavaFX Scene. This is called the game surface to
  # allow the developer to add JavaFX Node objects onto the Scene.
  #
  # @return Scene The JavaFX scene graph.
  #
  def getGameSurface
    @gameSurface
  end

  #
  # Sets the JavaFX Scene. This is called the game surface to
  # allow the developer to add JavaFX Node objects onto the Scene.
  #
  # @param gameSurface The main game surface (JavaFX Scene).
  #
  def setGameSurface gameSurface
    @gameSurface = gameSurface
  end
  private :setGameSurface

  #
  # All JavaFX nodes which are rendered onto the game surface(Scene) is
  # a JavaFX Group object.
  #
  # @return Group The root containing many child nodes to be displayed into
  #         the Scene area.
  #
  def getSceneNodes
    @sceneNodes
  end

  #
  # Sets the JavaFX Group that will hold all JavaFX nodes which are rendered
  # onto the game surface(Scene) is a JavaFX Group object.
  #
  # @param sceneNodes The root container having many children nodes
  #                   to be displayed into the Scene area.
  #
  def setSceneNodes sceneNodes
    @sceneNodes = sceneNodes
  end

  def getSoundManager
    @soundManager
  end

  #
  # Stop threads and stop media from playing.
  #
  def shutdown
    @gameLoop.stop
    @soundManager.shutdown
  end
end
