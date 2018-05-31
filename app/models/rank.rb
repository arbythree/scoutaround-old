class Rank < Achievable
  def next_rank
    Rank.find_by(ordinal: self.ordinal + 1)
  end
end
