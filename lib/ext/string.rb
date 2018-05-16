class String
  def each_cons(n)
    return enum_for(:each_cons, n) unless block_given?

    (0..self.length-n).each do |start_index|
      yield self[start_index, n]
    end
  end
end
