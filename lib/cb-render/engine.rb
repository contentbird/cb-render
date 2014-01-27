module CB
  module Render
    module Rails
      class Engine < ::Rails::Engine
        initializer "cb-render.assets.precompile" do |app|
          config.assets.paths << '../vendor/assets/fonts'
          config.assets.precompile += ["../vendor/assets/javascripts/cb_render.js"]
          config.assets.precompile += %w( .svg .eot .woff .ttf )
          #app.config.assets.precompile << %r(bootstrap/glyphicons-halflings-regular\.(?:eot|svg|ttf|woff)$)
        end
        initializer "cb-render.view_helpers" do
          ActionView::Base.send :include, ContentHelper
        end
      end
    end
  end
end