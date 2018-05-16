require 'ext/string'

class WordCruncher
  attr_accessor :sequences, :words, :s_length

  def initialize(sequences, words, s_length=4)
    @sequences = sequences
    @words = words
    @s_length = s_length
  end

  def process(dict)
    # store data in hash with sequence as key and words having such sequence as its value
    # eg. data = { "arro" => ["arrows", "carrots"] }
    data = Hash.new { |h,k| h[k] = Array.new }
    dict.each do |word|
      word.chomp!
      # skip shorter words
      next if word.length < @s_length

      word.each_cons(@s_length) do |s|
        data[s] << word
      end
    end
    write_data data
  end

  private
  def write_data(data)
    data.each do |k, v|
      if v.size == 1
        @sequences.puts k
        @words.puts v.first
      end
    end
  end
end
