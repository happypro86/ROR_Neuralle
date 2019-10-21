require 'spec_helper'

module Refinery
  module ServiceOptions
    describe ServiceOption do
      describe "validations", type: :model do
        subject do
          FactoryGirl.create(:service_option,
          :title => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:title) { should == "Refinery CMS" }
      end
    end
  end
end
