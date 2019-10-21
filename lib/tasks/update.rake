namespace :update do

  desc "Update Prices"
  task prices: :environment do

    # podcast prices
    podcast_setup_price = 250
    podcast_episode_price = 12

    # video prices
    visual_setup_price = 250
    video_price = 432
    video_extra_format_price = 50

    # visual prices
    image_price = 100
    gif_5_price = 200
    gif_3_price = 175

    # distribution prices
    distribution_channel_price = 40


    # run update
    Product.where(product_type: "podcast-setup").take.update_attributes(price: podcast_setup_price)
    Product.where(name: "Podcast Episode").take.update_attributes(price: podcast_episode_price)

    Product.where(product_type: "visual-setup").take.update_attributes(price: visual_setup_price)

    Product.where(name: "Video").take.update_attributes(price: video_price)
    Product.where(name: "Extra Video Format").take.update_attributes(price: video_extra_format_price)

    Product.where(name: "Image").take.update_attributes(price: image_price)
    Product.where(name: "GIF - 5 seconds").take.update_attributes(price: gif_5_price)
    Product.where(name: "GIF - 3 seconds").take.update_attributes(price: gif_3_price)

    Product.where(product_type: "video-distribution").each do |distribution|
      distribution.update_attributes(price: distribution_channel_price)
    end
    Product.where(product_type: "visual-distribution").each do |distribution|
      distribution.update_attributes(price: distribution_channel_price)
    end

  end

end
