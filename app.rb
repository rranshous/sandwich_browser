require 'sinatra'
require 'sinatra/advanced_routes'

require_relative 'image_index'
require_relative 'pager'
require_relative 'idr'
require_relative 'favorator'

IMAGE_DIR = ENV['IMAGE_DIR'] || './data'

# create index of images
image_index = ImageIndex.new IMAGE_DIR
image_index.populate

# return list of routes
get '/' do
  content_type :text
  out = ""
  Sinatra::Application.each_route do |route|
    out += "#{route.verb} #{route.path}\n"
  end
  etag Base64.urlsafe_encode64(out), :weak
  return out
end

# show lots of thumbnails
get '/gallery' do
  page =       (params[:page]      || 0  ).to_i
  @page_size = (params[:page_size] || 100).to_i

  image_pager = Pager.new image_index.all_ids
  @image_ids, @next_page_num, @prev_page_num = \
    image_pager.data_for_page page, @page_size

  erb :"gallery.html"
end

post '/image/:id/favorite' do |id|
  favorator = Favorator.new
  favorator.love_on id
  halt 200
end

# push to random image url
get '/image/random' do
  random_image_id = image_index.random_id
  redirect "/image/#{random_image_id}", 302
end

# return data for an image by it's id
get '/image/:id' do |id|
  etag id
  image_path = image_index.path_for id
  send_file image_path
end
