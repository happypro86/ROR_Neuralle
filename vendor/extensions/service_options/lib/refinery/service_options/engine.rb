module Refinery
  module ServiceOptions
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::ServiceOptions

      engine_name :refinery_service_options

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "service_options"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.service_options_admin_service_options_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::ServiceOptions)
      end
    end
  end
end
