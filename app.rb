
require 'sinatra'
require_relative 'image_index'

IMAGE_DIR='./data'

# create index of images
image_index = ImageIndex.new IMAGE_DIR
image_index.populate

get '/image/random' do
  random_image_id = image_index.random_id
  redirect "/image/#{random_image_id}"
end

get '/image/:id' do |id|
  image_path = image_index.path_for id
  send_file image_path
end
