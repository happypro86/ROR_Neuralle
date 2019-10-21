module Refinery
  module Footers
    module Admin
      class FootersController < ::Refinery::AdminController

        crudify :'refinery/footers/footer'

        private

        # Only allow a trusted parameter "white list" through.
        def footer_params
          params.require(:footer).permit(:title, :link, :icon, :placement, :text)
        end
      end
    end
  end
end
