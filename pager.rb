

class Pager

  def initialize all_data
    @data = all_data
  end

  def data_for_page page_num, page_size
    page_num, page_size = page_num.to_i, page_size.to_i
    offset = page_size * page_num
    start = offset
    stop = offset + page_size - 1
    next_page_num = page_num + 1
    prev_page_num = [page_num - 1].max
    data_set = (@data[start..stop] || [])
    [data_set, next_page_num, prev_page_num]
  end

end
