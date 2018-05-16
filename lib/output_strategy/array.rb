class OutputStrategy::Array
  class Array < ::Array
    # expect +puts+, +path+ and +close+ methods
    alias_method :puts, :push

    def path; end
    def close; end
  end

  def create(filename)
    Array.new
  end
end
