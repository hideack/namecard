class ImageController < ApplicationController
  def index
    filepath = Rails.root.join('tmp', 'storage', "#{params[:name]}.png")
    stat = File::stat(filepath)
    send_file(filepath, :filename => 'suzuri-keychain.png', :length => stat.size)
  end
end
