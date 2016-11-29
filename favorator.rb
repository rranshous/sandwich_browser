require_relative 'meta_writer'

class Favorator

  def love_on id
    meta_writer = MetaWriter.new id
    meta_writer.add({ favorite: 1 })
  end

end
