module CB
  module Render
    module Rails
      class Engine < ::Rails::Engine
        initializer "cb-render.assets.precompile" do |app|
          config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
          config.assets.precompile += ["../vendor/assets/javascripts/cb_render.js"]
        end
        initializer "cb-render.view_helpers" do
          ActionView::Base.send :include, ContentHelper
        end
      end
    end
  end
end