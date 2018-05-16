require 'tempfile'

class OutputStrategy::Tempfile
  def create(filename)
    Tempfile.new(filename)
  end
end
