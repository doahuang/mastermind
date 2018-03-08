class Code
  attr_reader :pegs
  def initialize(pegs)
    @pegs = pegs
  end
  def self.colors
    { "r" => :red, "g" => :green, "b" => :blue,
      "y" => :yellow, "o" => :orange, "p" => :purple }
  end
  def colors
    self.class.colors.map{ |k, v| "#{k}: #{v}" }.join("  ")
  end
  def self.random
    pegs = colors.keys.sample(4)
    self.new(pegs)
  end
  def self.parse(color)
    pegs = color.downcase.chars
    pegs.select!{ |peg| colors[peg] }
    self.new(pegs)
  end
  def ==(other_code)
    self.class == other_code.class && pegs == other_code.pegs
  end
  def color_count
    count = Hash.new(0)
    pegs.each{ |color| count[color] += 1 }
    count
  end
  def show_matches(other_code)
    [exact_matches(other_code), near_matches(other_code)]
  end
  private
  def exact_matches(other_code)
    pegs.each_index.reduce(0) do |sum, i|
      pegs[i] == other_code.pegs[i] ? sum + 1 : sum
    end
  end
  def near_matches(other_code)
    sum = 0
    other_code.color_count.each do |color, count|
      next unless color_count.key?(color)
      sum += [count, color_count[color]].min
    end
    sum - exact_matches(other_code)
  end
end