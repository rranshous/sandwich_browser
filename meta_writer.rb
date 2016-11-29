require 'json'
require_relative 'idr'

class MetaWriter

  def initialize image_id
    @image_path = Idr.new.path_for image_id
  end

  def add data
    json = data.to_json
    File.open(meta_path, 'a') do |fh|
      fh.write "\n#{json}"
    end
  end

  private

  def meta_path
    "#{@image_path}.meta"
  end

end
