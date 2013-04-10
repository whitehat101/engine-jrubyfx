# JavaFXEngine::JFXGen

A port of https://github.com/carldea/JFXGen to jRuby

The 0.1.x series aims for full compatability with carldea's java classes.

## Installation

Add this line to your application's Gemfile:

    gem 'engine-jrubyfx'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install engine-jrubyfx

## Usage

````
require 'engine-jrubyfx'

# Launch our application!
Engine.start do |primaryStage|
  # ...
end
````

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
