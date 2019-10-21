class StaticPagesController < ApplicationController

  def media
    # Neuralle account
    @instagram = InstagramApi.user(8022410616).recent_media({count: 4}).data

    # Tony test account
    # @instagram = InstagramApi.user(8503516048).recent_media({count: 4}).data
  end

  def about_us
  end

  def service_agreement
  end

  def podcast
    @podcasts = Refinery::Podcasts::Podcast.order('published_at DESC')
  end

  def mailchimp_list
    gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    gibbon.timeout = 30
    gibbon.open_timeout = 30

    lists = gibbon.lists.retrieve
    data = lists["lists"].map do |item|
      { id: item["id"],
        web_id: ["web_id"],
        name: item["name"],
        subscribe_url_long: item["subscribe_url_long"]
      }
    end

    render json: data
  end

end
