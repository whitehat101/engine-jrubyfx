# encoding: utf-8
#
# The Sprite class represents a image or node to be displayed.
# In a 2D game a sprite will contain a velocity for the image to
# move across the scene area. The game loop will call the update()
# and collide() method at every interval of a key frame. A list of
# animations can be used during different situations in the game
# such as rocket thrusters, walking, jumping, etc.
#
# @author cdea
#

module JavaFXEngine::JFXGen::Sprite
  # Current display node
  attr_accessor :node

  # velocity vector
  attr_accessor :vX, :vY

  # dead?
  attr_accessor :isDead

  # collision shape
  attr_accessor :collisionBounds

  # Updates this sprite object's velocity, or animations.
  def update() end

  # Did this sprite collide into the other sprite?
  #
  # @param other - The other sprite.
  # @return boolean - Whether this or the other sprite collided, otherwise false.
  def collide other

    if collisionBounds.nil? or other.collisionBounds.nil?
      return false
    end

    # determine its size
    sphereA    = collisionBounds
    sphereB    = other.collisionBounds
    centerA    = sphereA.local_to_scene sphereA.get_center_x, sphereA.get_center_y
    centerB    = sphereB.local_to_scene sphereB.get_center_x, sphereB.get_center_y
    dx         = centerB.get_x - centerA.get_x
    dy         = centerB.get_y - centerA.get_y
    distance   = Math.sqrt dx*dx + dy*dy
    minDist    = sphereB.get_radius + sphereA.get_radius

    distance < minDist
  end

  def handleDeath gameWorld
    gameWorld.getSpriteManager.addSpritesToBeRemoved self
  end

end
