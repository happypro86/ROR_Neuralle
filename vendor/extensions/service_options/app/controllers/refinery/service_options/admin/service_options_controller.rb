module Refinery
  module ServiceOptions
    module Admin
      class ServiceOptionsController < ::Refinery::AdminController

        crudify :'refinery/service_options/service_option'

        private

        # Only allow a trusted parameter "white list" through.
        def service_option_params
          params.require(:service_option).permit(:title, :description)
        end
      end
    end
  end
end
