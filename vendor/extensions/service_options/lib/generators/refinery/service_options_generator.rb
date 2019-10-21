module Refinery
  class ServiceOptionsGenerator < Rails::Generators::Base

    def rake_db
      rake "refinery_service_options:install:migrations"
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

# Added by Refinery CMS ServiceOptions extension
Refinery::ServiceOptions::Engine.load_seed
        EOH
      end
    end
  end
end
