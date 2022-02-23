class Keychain < ApplicationRecord
  validates :message, length: {minimum:1, maximum: 15, too_short: "1文字以上%{count}%文字以下で入力してください", too_long: "最大%{count}文字までです"}
  validates :pattern, numericality: { only_integer:true }

  def publish(token)
    unless valid?
      return false
    end

    image = MiniMagick::Image.open("./app/assets/images/pattern#{pattern}.png")

    logger.debug("MESSAGE = #{message}")

    image.combine_options do |config|
      config.font "./app/assets/fonts/VL-PGothic-Regular.ttf"
      config.pointsize 72 
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
        :title => "#{Date.current.strftime('%Y年%m月%d日に作成')}",
        :price => 2000,
        :description => "なふだメーカーで作成した素材画像です",
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

      suzuri_response = JSON.parse(response.body)

      logger.debug(response.status)
      logger.debug(suzuri_response)

      suzuri_response
    else
      true
    end
  end
end
