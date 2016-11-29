require 'base64'

class ImageIndex

  def initialize image_dir
    @image_dir = File.absolute_path image_dir
    @all_file_paths = []
    @idr = Idr.new
  end

  def populate
    puts "populating"
    search_string = File.join(@image_dir, '**', '*')
    all_files = Dir.glob(search_string)
    image_files = all_files.select{ |fn| fn.end_with?('jpg') }
    @all_file_paths = image_files
    puts "found images: #{@all_file_paths.length}"
  end

  def all_ids
    @all_file_paths.map{ |p| @idr.id_for p }
  end

  def random_id
    file_path = @all_file_paths.sample
    @idr.id_for file_path
  end

  def path_for id
    @idr.path_for id
  end

end
