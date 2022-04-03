class TShirt < ApplicationRecord
  validates :message, length: {minimum:1, maximum: 15, too_short: "1文字以上%{count}%文字以下で入力してください", too_long: "最大%{count}文字までです"}
  validates :pattern, numericality: { only_integer:true }

  def publish(token)
    unless valid?
      return false
    end

    image = MiniMagick::Image.open("./app/assets/images/tshirts-front.png")

    message.gsub!(/\s/, "\n")
    logger.debug("MESSAGE = #{message}")

    image.combine_options do |config|
      config.font "./app/assets/fonts/aachen_bold.ttf"
      config.pointsize 512
      config.fill "#585c63"
      config.gravity "center"
      config.annotate "0,0", message
    end

    temp_name = "#{SecureRandom.hex}"
    temp_file = "./storage/#{temp_name}.png"
    temp_url  = "https://suzuri-namecard.herokuapp.com/image/#{temp_name}"
    image.write temp_file

    logger.debug(temp_file)
    logger.debug(temp_url)

    if Rails.env == 'production'
      record = {
        :texture => temp_url,
        :title => message
        :price => 2000,
        :description => "#{Date.current.strftime('%Y年%m月%d日に作成')}",
        :products => [
          :itemId => 1,
          :exemplaryItemVariantId => 151,
          :published => true,
          :resizeMode => "contain",
        ]
      }

      response = token.post(
        "https://suzuri.jp/api/v1/materials",
        {:body => record.to_json, :headers => {'Authorization' => "Bearer #{token.token}", 'Content-Type' => 'application/json'}}
      )

      suzuri_response = JSON.parse(response.body, {symbolize_names: true})

      logger.debug(response.status)
      logger.debug(suzuri_response)

      suzuri_response
    else
      true
    end
  end
end
