module Refinery
  module Footers
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Footers

      engine_name :refinery_footers

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "footers"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.footers_admin_footers_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Footers)
      end
    end
  end
end
