require_relative 'rules'

class Computer
  include Rules
  attr_reader :name, :hand
  def initialize(name)
    @name = name
    @hand = []
  end

  def dealer_move
    print "Waiting for #{@name} to hit or stand...\n"
    sleep rand(1..2)
    if hand_value(@hand) < 17
      return true
    elsif hand_value(@hand) > 17
      return false
    end
  end

end
