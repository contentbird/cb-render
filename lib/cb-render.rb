require 'cb-render/content_helper'
module CB
  module Render
    class FrameworkNotFound < StandardError; end

    # Inspired by Kaminari
    def self.load!

      if rails?
        require 'sass-rails'
        register_rails_engine
      end

      if !(rails?)
        raise CB::Render::FrameworkNotFound, "cb-render requires Rails > 4 which is not loaded"
      end

      stylesheets = File.expand_path(File.join("..", 'vendor', 'assets', 'stylesheets'))
      ::Sass.load_paths << stylesheets
    end

    private

    def self.asset_pipeline?
      defined?(::Sprockets)
    end

    def self.rails?
      defined?(::Rails)
    end

    def self.register_rails_engine
      require 'cb-render/engine'
    end
  end
end

CB::Render.load!
