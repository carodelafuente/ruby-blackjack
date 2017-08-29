module Rules
  def hand_value(hand)
    aces = 0

    total = hand.reduce(0) do |acc, card|
      if ["Jack", "Queen", "King"].include?(card.rank)
        acc + 10
      elsif card.rank == "Ace"
        aces += 1
        acc
      else
        acc + card.rank.to_i
      end
    end

    aces.times do
      if total > 10
        total += 1
      else
        total += 11
      end
    end

    total
  end
end
