# Inherit from JRubyFX::Application to create our Application
module JavaFXEngine::JFXGen
  class Engine < JRubyFX::Application

    def self.start &block
      @@block = block
      self.launch
    end

    def start primaryStage
      @@block.call primaryStage
      primaryStage.show
    end

  end
end
