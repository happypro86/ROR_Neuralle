module Refinery
  module Footers
    class Footer < Refinery::Core::BaseModel
      self.table_name = 'refinery_footers'


      validates :title, :presence => true, :uniqueness => true

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

      scope :left, -> { where(:placement => 'left') }
      scope :right, -> { where(:placement => 'right') }

      scope :asc, -> { order('position ASC') }
      scope :desc, -> { order('position DESC') }

    end
  end
end
