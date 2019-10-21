# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "ServiceOptions" do
    describe "Admin" do
      describe "service_options", type: :feature do
        refinery_login

        describe "service_options list" do
          before do
            FactoryGirl.create(:service_option, :title => "UniqueTitleOne")
            FactoryGirl.create(:service_option, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.service_options_admin_service_options_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.service_options_admin_service_options_path

            click_link "Add New Service Option"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              expect { click_button "Save" }.to change(Refinery::ServiceOptions::ServiceOption, :count).from(0).to(1)

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
            end
          end

          context "invalid data" do
            it "should fail" do
              expect { click_button "Save" }.not_to change(Refinery::ServiceOptions::ServiceOption, :count)

              expect(page).to have_content("Title can't be blank")
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:service_option, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.service_options_admin_service_options_path

              click_link "Add New Service Option"

              fill_in "Title", :with => "UniqueTitle"
              expect { click_button "Save" }.not_to change(Refinery::ServiceOptions::ServiceOption, :count)

              expect(page).to have_content("There were problems")
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:service_option, :title => "A title") }

          it "should succeed" do
            visit refinery.service_options_admin_service_options_path

            within ".actions" do
              click_link "Edit this service option"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            expect(page).to have_content("'A different title' was successfully updated.")
            expect(page).not_to have_content("A title")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:service_option, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.service_options_admin_service_options_path

            click_link "Remove this service option forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::ServiceOptions::ServiceOption.count).to eq(0)
          end
        end

      end
    end
  end
end
