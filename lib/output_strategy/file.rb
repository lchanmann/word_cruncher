class OutputStrategy::File
  def create(filename)
    File.new filename, "w"
  end
end
