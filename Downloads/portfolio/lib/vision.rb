require "base64"
require "json"
require "net/https"

module Vision
  class << self
    def get_image_data(image_file)
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}"

      dir_tree = image_file.key.scan(/.{1,#{2}}/)
      base64_image = Base64.encode64(open("#{Rails.root}/public/uploads/#{dir_tree[0]}/#{dir_tree[1]}/#{image_file.key}").read)

      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: "LABEL_DETECTION"
            }
          ]
        }]
      }.to_json

      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request["Content-Type"] = "application/json"
      response = https.request(request, params)
      response_body = JSON.parse(response.body)

      if (error = response_body["responses"][0]["error"]).present?
        raise error["message"]
      else
        response_body["responses"][0]["labelAnnotations"].pluck("description").take(3)
      end
    end
  end
end
