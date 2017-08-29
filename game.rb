require 'pry'
require_relative 'computer'
require_relative 'game'
require_relative 'player'
require_relative 'deck'
require_relative 'rules'

class Game
  include Rules
  def initialize
    @deck = Deck.new
    @deck.shuffle
  end

  def play
    @player = Player.new('Player', 100)
    @dealer = Computer.new('Dealer')

    # while @player.has_money? && play_again?
    #? does the whole play method have to be in this while loop^
    2.times do
      deal(@player)
      deal(@dealer)
    end

    display!

    while hand_value(@player.hand) < 21 && @player.make_move!
      deal(@player)
      display!
    end

    puts "Dealer's Turn"
    while hand_value(@dealer.hand) < 21 && @dealer.dealer_move
      puts "waiting for dealer to hit or stand..."
      deal(@dealer)
      display!
    end

    case
    when player_won? || hand_value(@dealer.hand) > 21
      puts "You Won!!!!"
      play_again?
    when dealer_won? || hand_value(@player.hand) > 21
      puts "The Dealer won!!!"
      play_again?
    when hand_value(@player.hand) == hand_value(@dealer.hand)
      puts "It's a tie!"
      play_again?
    end
  end

  def player_won?
    hand_value(@player.hand) <= 21 && (hand_value(@player.hand) > hand_value(@dealer.hand))
  end

  def dealer_won?
    hand_value(@dealer.hand) <= 21 && (hand_value(@dealer.hand) > hand_value(@player.hand))
  end

  def deal(player)
    player.hand << @deck.draw
  end

  def display!
    system("clear")
    puts "Player Hand #{hand_value(@player.hand)} and player money #{@player.money}"
    puts @player.hand


    puts "Dealer Hand #{hand_value(@dealer.hand)}"
    puts @dealer.hand.last.to_s
  end


  def play_again?
    puts "Do you want to play again?"
    # loop until you get a good answer and return
    while true
      print "Please enter (y)es or (n)o: "
      answer = gets.chomp.downcase
      if answer[0] == "y"
        return true
# to call the play method here?
      elsif answer[0] == "n"
        return false
      end
      puts "That is not a valid answer!"
    end
  end
end
