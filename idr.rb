
class Idr

  def id_for path
    Base64.urlsafe_encode64 path
  end

  def path_for id
    Base64.urlsafe_decode64 id
  end

end
