class PasteFromGoogleDocsScrubber < Rails::Html::TargetScrubber
  def initialize
    super
    self.attributes = %w(dir style id)
  end
end
