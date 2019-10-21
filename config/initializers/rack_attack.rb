# Block suspicious requests for '*.php'.
# After 1 blocked requests in 1 minute, block all requests from that IP for 120 minutes.
Rack::Attack.blocklist('fail2ban pentesters') do |req|
  # `filter` returns truthy value if request fails, or if it's from a previously banned IP
  # so the request is blocked
  Rack::Attack::Fail2Ban.filter("pentesters-#{req.ip}", maxretry: 1, findtime: 1.minutes, bantime: 120.minutes) do
    # The count for the IP is incremented if the return value is truthy
    (req.path =~ /\S+\.php/).present?
  end
end if Rails.env.production?

# class Rack::Attack
#   Rack::Attack.blocklist('bad-robots') do |req|
#     req.ip if /\S+\.php/.match?(req.path)
#   end
# end
