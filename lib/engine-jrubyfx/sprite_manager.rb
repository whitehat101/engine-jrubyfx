# encoding: utf-8
#
# Sprite manager is responsible for holding all sprite objects, and cleaning up
# sprite objects to be removed. All collections are used by the JavaFX
# application thread. During each cycle (animation frame) sprite management
# occurs. This assists the user of the API to not have to create lists to
# later be garbage collected. Should provide some performance gain.
# @author cdea
#
class JavaFXEngine::JFXGen::SpriteManager

  def initialize
    # All the sprite objects currently in play
    @game_actors          = []

    # A global single threaded list used to check collision against other
    # sprite objects.
    @check_collision_list = []

    # A global single threaded set used to cleanup or remove sprite objects
    # in play.
    @clean_up_sprites     = []
  end

  # private final static List<Sprite> @game_actors = new ArrayList<>();
  # private final static List<Sprite> @check_collision_list = new ArrayList<>();
  # private final static Set<Sprite> @clean_up_sprites = new HashSet<>();

  def getAllSprites
    @game_actors
  end

  #
  # VarArgs of sprite objects to be added to the game.
  # @param sprites
  #
  def addSprites *sprites
    @game_actors += sprites
  end

  #
  # VarArgs of sprite objects to be removed from the game.
  # @param sprites
  #
  def removeSprites *sprites
    @game_actors -= sprites
  end

  # Returns a set of sprite objects to be removed from the @game_actors.
  # @return @clean_up_sprites
  #
  def getSpritesToBeRemoved
    @clean_up_sprites
  end

  #
  # Adds sprite objects to be removed
  # @param sprites varargs of sprite objects.
  #
  def addSpritesToBeRemoved *sprites
    @clean_up_sprites += sprites
  end

  #
  # Returns a list of sprite objects to assist in collision checks.
  # This is a temporary and is a copy of all current sprite objects
  # (copy of @game_actors).
  # @return @check_collision_list
  #
  def getCollisionsToCheck
    @check_collision_list
  end

  #
  # Clears the list of sprite objects in the collision check collection
  # (@check_collision_list).
  #
  def resetCollisionsToCheck
    @check_collision_list.clear
    @check_collision_list += @game_actors
  end

  #
  # Removes sprite objects and nodes from all
  # temporary collections such as:
  # @clean_up_sprites.
  # The sprite to be removed will also be removed from the
  # list of all sprite objects called (@game_actors).
  #
  def cleanupSprites
    # remove from actors list
    @game_actors -= @clean_up_sprites

    # reset the clean up sprites
    @clean_up_sprites.clear
  end
end
