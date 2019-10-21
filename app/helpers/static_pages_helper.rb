module StaticPagesHelper

  def about_companies_logos
    ["development_ready_logo.png", "go_markets_logo.png", "uncommon_logo.png", "infinity_logo.png", "coinjar_logo.svg", "bgs_logo.png", "lwc_logo.png"]
  end

  def image_id(image)
    image[0...-4].gsub("_", "-")
  end

end
