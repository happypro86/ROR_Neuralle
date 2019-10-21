class BriefRequest < ActiveRecord::Base
  require 'file_size_validator'
  mount_uploader :brief_file, BriefFileUploader

  belongs_to :order

  validates :brief_file, file_size: { maximum: 50.megabytes }

  def completed?
    name.present? &&
    email.present? &&
    phone_number.present? &&
    country.present? &&
    brief_description.present? &&
    design_style.present?
  end

  def any_field?
    name.present? ||
    company.present? ||
    email.present? ||
    phone_number.present? ||
    country.present? ||
    industry.present? ||
    brief_description.present? ||
    design_style.present? ||
    further_notes.present?
  end
end
