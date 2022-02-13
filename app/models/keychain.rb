class Keychain < ApplicationRecord
  def publish(token)
    require 'mini_magick'
    image = MiniMagick::Image.open("./app/assets/images/860x860.png")

    logger.debug("MESSAGE = #{message}")

    image.combine_options do |config|
      config.font "./app/assets/fonts/VL-PGothic-Regular.ttf"
      config.pointsize 64
      config.fill "#ff0000"
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
        :title => "れんしゅうそのいち",
        :price => 2000,
        :description => "API経由で作成",
        :products => [
          :itemId => 147,
          :exemplaryItemVariantId => 1952,
          :published => true,
          :resizeMode => "contain",
        ]
      }

      response = token.post(
        "https://suzuri.jp/api/v1/materials",
        {:body => record.to_json, :headers => {'Authorization' => "Bearer #{token.token}", 'Content-Type' => 'application/json'}}
      )

      logger.debug(response.status)
      logger.debug(response.body)
    else
      true
    end
  end
end
