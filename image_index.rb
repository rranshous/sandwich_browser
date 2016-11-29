require 'base64'

class ImageIndex

  def initialize image_dir
    @image_dir = File.absolute_path image_dir
    @all_file_paths = []
  end

  def populate
    puts "populating"
    search_string = File.join(@image_dir, '**', '*')
    all_files = Dir.glob(search_string)
    image_files = all_files.select{ |fn| fn.end_with?('jpg') }
    @all_file_paths = image_files
    puts "found images: #{@all_file_paths.length}"
  end

  def random_id
    file_path = @all_file_paths.sample
    encode_as_id file_path
  end

  def path_for id
    decode_to_path id
  end

  private

  def encode_as_id s
    Base64.urlsafe_encode64 s
  end

  def decode_to_path s
    Base64.urlsafe_decode64 s
  end

end
