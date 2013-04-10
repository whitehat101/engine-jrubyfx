require "engine-jrubyfx/version"

# load Java's javafx namespace
def javafx() Java::Javafx end

# just what we need from jrubyFX
require "jrubyfx/fxml_application"

# load engine
require "engine-jrubyfx/game_world"
require "engine-jrubyfx/sprite"
require "engine-jrubyfx/sound_manager"
require "engine-jrubyfx/sprite_manager"
require "engine-jrubyfx/application"
include JavaFXEngine::JFXGen
