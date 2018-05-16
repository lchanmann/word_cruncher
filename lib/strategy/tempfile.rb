require 'tempfile'

class Strategy::Tempfile
  def create(filename)
    Tempfile.new filename
  end
end
