# Adding complexity:
  # Use 'the book' to recommend moves to the player. 'The book' is a guide provided by casinos
  # to allow you to make decisions about the best move to make

# Problem scope:
  # Create a simple blackjack game between the 'player' and the computer.

# Rules of the game:
  # => Blackjack is a card game where you calculate the sum of the values of your cards and 
  #    try to hit 21, aka "blackjack". 
  # => Both the player and dealer are dealt two cards to start the game. 
  # => All face cards are worth whatever numerical value they show. 
  # => Suit cards are worth 10. 
  # => Aces can be worth either 11 or 1. Example: if you have a Jack and an Ace, 
  #    then you have hit "blackjack", as it adds up to 21. If ace as 11 means bust, then it becomes 1.
  # => If your hand is less than 11, it is considered soft, in terms of getting an ace. When a hand is
  #    soft, if an ace were added, it would be 11, if the hand is hard then an added ace would be 1.

  # => After being dealt the initial 2 cards, the player goes first and can choose to either "hit" or "stay".
  # => Hitting means deal another card. 
  # => If the player's cards sum up to be greater than 21, the player has "busted" and lost. 
  # => If the sum is 21, then the player wins.
  # => If the sum is less than 21, then the player can choose to "hit" or "stay" again.
  # => If the player "hits", then repeat above
  # => If the player stays, then the player's total value is saved.

  # => It is now the dealer's turn.
  # => The dealer must keep hitting until she has at least 17.
  # => If the dealer busts, then the player wins. 
  # => If the dealer hits 21, then the dealer wins. 
  # => If the dealer stays, then we compare the sums of the two hands between the player and dealer
  # => The higher value in the comparison wins.


# Pseudo-code:

require "pry"

# METHODS

def deal_first_two_cards(card_deck, cards_array)
  begin
    random_card = card_deck.sample
    card_deck.delete(random_card)
    cards_array.push(random_card)
  end until cards_array.count == 2
end

# VARS

# Create data structure for deck of cards (52)
card_deck = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 1,
              1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 1,
              1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 1,
              1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 1]

player_already_won = false
player_already_lost = false

# Welcome players to the game
puts "Welcome to Blackjack"

# Deal two cards to the player (pick two random cards)
players_cards = []
deal_first_two_cards(card_deck, players_cards)
# Calculate the sum of the player's two cards
players_total = 0
players_cards.each{ |card_val| players_total += card_val}
# Deal two cards to the dealer
dealers_cards = []
deal_first_two_cards(card_deck, dealers_cards)
# Calculate the sum of the dealer's two cards
dealers_total = 0
dealers_cards.each{ |card_val| dealers_total += card_val}

if players_total == 21 || dealers_total == 21
  # end the game
end

puts "Dealer's hand: #{dealers_total}"
puts "Your hand: #{players_total}"

begin
# Ask the player to either HIT or STAY
  puts "Would you like to hit or stay? (hit/stay)"
  player_decision = gets.chomp
  # If the player chooses hit
  if player_decision.downcase == "hit"
  # Pick a random card for the player and add it to their score
    random_card = card_deck.sample
    card_deck.delete(random_card)
    players_total += random_card
    # display player's new score
    puts "Card total: #{players_total}"
  #  If the sum of the player's cards are more than 21 then the player loses
    if players_total > 21
      # end game and player loses
      puts "#{players_total} - You went bust"
      player_already_lost = true
      break
  #  Else If the sum of the player's cards is 21, then the player wins
    elsif players_total == 21
      # end game and player wins
      puts "#{players_total} - You won!"
      player_already_won = true
      break
  #  Else If the sum is less than 21, recurse
    elsif players_total < 21
      # recurse
    end
  # Else
  else
  #  save the total value of the player's cards - we're doing this by incrementing each time
  puts "You chose stay - coward!"
  players_total
  end
end until player_decision.downcase != "hit"

# If the player has not already won or lost
if !player_already_won || !player_already_lost && dealers_total < 17
  # Until the sum of the dealer's cards is 17 or more
  begin
  #   The dealer must HIT
    random_card = card_deck.sample
    card_deck.delete(random_card)
    dealers_total += random_card
    puts "Dealer's current hand: #{dealers_total}"
  #   If the sum of the dealer's cards is now above 21, then the player wins
    if dealers_total > 21
      puts "Dealer is bust. Player wins"
  #   Else if the sum of the dealer's cards is 21 exactly, then the dealer wins
    elsif dealers_total == 21
      puts "Player lost"
    end
  end until dealers_total >= 17
end

# Compare the sum of the player's cards to the sum of the dealer's cards. The highest value wins. Display who the winner is.
if players_total == dealers_total
  puts "Tie"
elsif players_total > dealers_total
  puts "Player wins"
else
  puts "Dealer wins"
end

# Goodbye message
puts "Thanks for playing procedural blackjack"






# Problem solving:


 # 1. Questions for card deck data structure:
      # What does the deck of cards consist of?
        # 4 suits
          # Hearts, Spades, Diamonds, Clubs
          # Every suit has Ace - 9 normal face cards. (total = 40)
          # Every suit has King, Queen, Jack (each with value of 10) (total = 12)
      # Hash or array?
        # Specific keys would sort of indicate hash.
        # Possibly a hash for suits, and each suit being modelled by an array?
        # Can't really define King, Queen, etc, in array.
        # Mapping names (1 of clubs, etc) to values (Ace to 1 or 11, etc) makes a hash more viable - it would seem.
        # Although, 2d array with index 0 containing name and index 1 containing value, kind of makes sense.
        # Thinking of more complex parts, it might be difficult to map Ace to 1 and 11. Not true actually, value of Ace could be array with 2 items (1, 11)
        # Are the suits really relevant here? Struggling to find answer as to why they would be. Just need 4 sets of (1-9, and 3 sets of 10s).
        # Array is better choice. In the procedural game, I'll hedge my bets with array as it fits the purpose and no more, which is better
        # than a complicated hash (which isn't really any more useful).

# 2. How to deal with Aces?
    # We might have a problem with the aces, how to identify them as aces?
    # Should we just count them as 1s just now and try a simple implementation?
    # That's probably not a bad idea, and if it is, them it will be a good lesson.

# 3. How to model player's/comp's cards?
    # Should these be an array? Probably.
    # Going to need to add at some point, so would be easy to do each, and just save to a players_total array.
    # Cool.

# 4. Need to remove cards from array once they've been taken. 
    # Same card value could be used more than it should be available to be used, if it isn't removed. Need to model reality.
    # Best way to do this? Make each loop multi-line. Get index of sample card by value and remove it? Suit doesn't matter or whether it's a King, etc.
    # What matters is that that value can't be used again.

# 4. Best way to structure loop for asking player to hit or stay
    # if hit
        # add up new score
        # repeat above
    # else
      # break

# 5. Problem with variable scope when making player's decisions
    # I want they player's total to be incremented inside the method, then be available with the same value at the main scope.
    # We'll put it back inside the main scope inside a loop for the time being. Can be refactored later if need be.

# 6. Currently, the game does not end if the player's score is above 21 or equal to 21
    # See extra conditions below


# Extra conditions

  # => After being dealt the initial 2 cards, the player goes first and can choose to either "hit" or "stay".

  # EXTRA - If the player's score is equal to 21 or the dealer's score is equal to 21, we have a winner - end the game.

  # => If the player's cards sum up to be greater than 21, the player has "busted" and lost. 
  # => If the sum is 21, then the player wins.
  # => If the sum is less than 21, then the player can choose to "hit" or "stay" again.
  # => If the player "hits", then repeat above
  # => If the player stays, then the player's total value is saved.

  # EXTRA - Check if player has already won

  # => It is now the dealer's turn.
  # => The dealer must keep hitting until she has at least 17.
  # => If the dealer busts, then the player wins. 
  # => If the dealer hits 21, then the dealer wins. 
  # => If the dealer stays, then we compare the sums of the two hands between the player and dealer
  # => The higher value in the comparison wins. EXTRA - We shouldn't need to check for less than 21 here. Game should have ended before if that were the case.





