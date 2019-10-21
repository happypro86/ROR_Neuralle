class BitpayService
  PEM_FILE = "#{Rails.root}/config/bitpaykey.pem"
  API_URL = 'https://bitpay.com'

  def initialize
    @client = BitPay::SDK::Client.new(
      pem: File.read(PEM_FILE),
      api_uri: API_URL
    )
  end

  def create_invoice(order, url)
    @client.create_invoice(
      price: order.total_price.to_i,
      currency: "AUD",
      facade: 'pos',
      params: {
        redirectURL: url
      }
    )
  end
end
