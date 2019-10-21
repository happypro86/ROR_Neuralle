# Some Refinery stuff

# # Added by Refinery CMS Pages extension
# Refinery::Pages::Engine.load_seed
#
# # Added by Refinery CMS Blog engine
# Refinery::Blog::Engine.load_seed
#
# # Custom seed pages
# unless signup_page = Refinery::Page.find_by(:link_url => '/signup')
#   Refinery::Page.create!(
#     :title          => 'Signup',
#     :view_template  => 'signup',
#     :show_in_menu   => false
#   ).tap do |page|
#     Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
#       page.parts.create(
#         title: default_page_part[:title],
#         slug: default_page_part[:slug],
#         :body => nil,
#         :position => index
#       )
#     end
#   end
# end
#
# # Added by Refinery CMS Footers extension
# Refinery::Footers::Engine.load_seed
#
# # Added by Refinery CMS ServiceOptions extension
# Refinery::ServiceOptions::Engine.load_seed
#
# # Added by Refinery CMS Podcasts extension
# Refinery::Podcasts::Engine.load_seed


# # Orders seeds
#
BriefRequest.destroy_all
Order.destroy_all
Package.destroy_all
Product.destroy_all
OrderItem.destroy_all
#
#
# # Packages
#
# Package.create(
#   name: "small-business",
#   title: "Small Business",
#   position: 1,
#   price: 2924.00,
#   description: "Get started with a bi-monthly podcast and content to support its growth",
#   features: "2 x 60 min podcasts | 4 x 60 sec video"
# )
# Package.create(
#   name: "growing-business",
#   title: "Growing Business",
#   position: 2,
#   price: 7040.00,
#   description: "Level Up as your business grows, with a recurring weekly podcast",
#   features: "4 x 60 min podcasts | 12 x 60 sec video | 12 Social Media Distributions"
# )
# Package.create(
#   name: "enterprise",
#   title: "Enterprise",
#   position: 3,
#   price: 10922.00,
#   description: "Smash your content out of the park with multiple podcasts and content to reach your audience",
#   features: "7 x 60min podcasts | 18 x 60 sec video | 18 Social Media Distributions"
# )
# Package.create(
#   name: "customise",
#   title: "Customise",
#   description: "Prefer to Customise?"
# )


# # Podcast

Product.create(
  name: "Brief Setup",
  price: 250.00,
  product_type: "podcast-setup"
)
Product.create(
  name: "Podcast Episode",
  position: 1,
  price: 11.00,
  product_type: "podcast"
)
Product.create(
  name: "Podcast Host",
  price: 0.00,
  product_type: "podcast-host"
)
# Product.create(
#   name: "Podcast Episode - 45 mins",
#   position: 2,
#   price: 459.00,
#   product_type: "podcast"
# )
# Product.create(
#   name: "Podcast Episode - 30 mins",
#   position: 3,
#   price: 306.00,
#   product_type: "podcast"
# )
# Product.create(
#   name: "Podcast Episode - 15 mins",
#   position: 4,
#   price: 153.00,
#   product_type: "podcast"
# )
# Product.create(
#   name: "Podcast Trailer - 1 min",
#   position: 5,
#   price: 77.00,
#   product_type: "podcast"
# )
# Product.create(
#   name: "Video Recording of the Podcast (per min)",
#   position: 6,
#   price: 4.00,
#   product_type: "podcast",
#   pricing_per_min: true
# )


# Video

Product.create(
  name: "Brief Setup",
  price: 250.00,
  product_type: "visual-setup"
)

Product.create(
  name: "Video",
  position: 1,
  price: 360.00,
  product_type: "video"
)
Product.create(
  name: "Extra Video Format",
  price: 50.00,
  product_type: "extra-video-format"
)
Product.create(
  name: "Videographer Hire",
  price: 0.00,
  product_type: "videographer-hire"
)


# Visual

Product.create(
  name: "Image",
  position: 1,
  price: 100.00,
  product_type: "image"
)
Product.create(
  name: "GIF - 5 seconds",
  position: 2,
  price: 200.00,
  product_type: "image"
)
Product.create(
  name: "GIF - 3 seconds",
  position: 3,
  price: 175.00,
  product_type: "image"
)


channels = %w(Instagram YouTube Facebook Twitter LinkedIn Snapchat)

# # Distribution

channels.each_with_index do |channel, i|
  Product.create(
    name: channel,
    position: i + 1,
    price: 40.00,
    product_type: "video-distribution"
  )
end

channels.each_with_index do |channel, i|
  Product.create(
    name: channel,
    position: i + 1,
    price: 40.00,
    product_type: "visual-distribution"
  )
end
