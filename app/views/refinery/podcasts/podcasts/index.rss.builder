require 'uri' # used for URI.encode
xml.instruct!

xml.rss 'xmlns:itunes' => 'http://www.itunes.com/dtds/podcast-1.0.dtd', :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    # Points to your website (e.g. http://yoursite.com/)
    base_url = request.protocol + request.host_with_port

    # NOTE: Fill in everything with your own data down to the categories.
    xml.title Refinery::Podcasts.title

    # Points to your website (e.g. http://yoursite.com/)
    xml.link base_url

    # Points to your podcast feed (e.g. http://yoursite.com/podcasts.rss)
    xml.tag!('atom:link', :href => refinery.podcasts_podcasts_url(format: :rss), :rel => 'self', :type => 'application/rss+xml')

    # Accepted values are those in the ISO 639-1 Alpha-2 list (two-letter language codes, some with possible modifiers, such as 'en-us').
    xml.language Refinery::Podcasts.language

    xml.copyright "© #{Time.now.year} #{Refinery::Core.site_name}"
    xml.tag!('itunes:subtitle', Refinery::Podcasts.subtitle)

    # The content of this tag is shown in the Artist column in iTunes.
    xml.tag!('itunes:author', strip_tags(Refinery::Podcasts.author).gsub(/\&?amp;/, ''))

    # This tag should be used to indicate whether or not your podcast contains
    # explicit material. The three values for this tag are "yes", "no", and "clean".
    xml.tag!('itunes:explicit', Refinery::Podcasts.explicit_content)

    # The contents of this tag are shown in a separate window that appears when the
    # "circled i" in the Description column is clicked. It also appears on the iTunes
    # page for your podcast. This field can be up to 4000 characters.
    xml.tag!('itunes:summary', Refinery::Podcasts.description)
    xml.description Refinery::Podcasts.description

    # This tag contains information that will be used to contact the owner of the podcast
    # for communication specifically about their podcast. It will not be publicly displayed.
    xml.tag!('itunes:owner') do |owner|
      xml.tag!('itunes:name', Refinery::Podcasts.owner_name)
      xml.tag!('itunes:email', Refinery::Podcasts.owner_email)
    end

    # upload an image to your resources tab and link it in here
    # iTunes prefers square .jpg or .png images that are between
    # 1400 x 1400 pixels and 3000 x 3000 pixels
    xml.tag!('itunes:image', :href => Refinery::Podcasts.image_url)

    # select from the list of categories here:
    # https://help.apple.com/itc/podcasts_connect/?lang=en#/itc9267a2f12
    # xml.tag!('itunes:category', :text => Refinery::Podcasts.category) do |node|
    #   xml.tag!('itunes:category', :text => Refinery::Podcasts.subcategory)
    # end

    Refinery::Setting.find_or_set(:categories, "Business/Investing").split(',').each do |category|
      category = category.split('/')
      Hash[*category].each do |category, subcategory|
        xml.tag!('itunes:category', text: category.strip.squeeze(" ")) do |node|
          xml.tag!('itunes:category', text: subcategory.strip.squeeze(" "))
        end
      end
    end

    @podcasts.each do |item|
      unless item.podcast_file_tmp || item.title == "test"
        # item_url = request.protocol + request.host_with_port + item.file.url
        # item_url = item.podcast_file.url
        # item_size = item.podcast_file.file.size
        # item_type = item.podcast_file.file.content_type
        item_url_with_prefix = ENV['PODTRAC_FREFIX'] + item.file_url
        item_url = item.file_url
        item_size = "1040384"
        item_type = "audio/mpeg"

        summary = Nokogiri::HTML(item.summary)
        summary = summary.css('*').remove_attr('style').first.to_s
        summary = summary.gsub("\r\n", '').gsub("\n", '')
        summary = Sanitize.fragment(summary,
          :elements   => ['p', 'ul', 'li', 'a']
        )

        summary = summary.gsub('</ul>', "</ul>\r\n")
                         .gsub('<li><p>', '<li>')
                         .gsub('</p></li>', '</li>')
                         .gsub('<a>', "<a href='#'>")

        xml.item do
          xml.title item.title
          xml.description do
            xml.cdata! sanitize(item.summary)
          end
          xml.tag!('itunes:author', item.author)
          xml.tag!('itunes:subtitle', item.subtitle)
          xml.tag!('description') {
           xml.cdata!(summary)
          }
          xml.enclosure :url => item_url_with_prefix, :length => item_size, :type => item_type
          xml.guid item_url
          xml.tag!('pubDate', item.published_at.to_time.rfc2822)
          xml.tag!('itunes:duration', item.duration)
          xml.tag!('itunes:keywords', item.keywords)
          xml.tag!('itunes:explicit', Refinery::Podcasts.explicit_content)
          if item.image.present?
            xml.tag!('itunes:image', href: "http://" + request.host_with_port + item.image.url)
          end
        end
      end
    end
  end
end
