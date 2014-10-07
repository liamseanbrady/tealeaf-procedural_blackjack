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

# METHODS

def deal_card(card_deck, cards_array)
  random_suit = card_deck.sample
  random_cards = random_suit.values.first
  random_card = random_cards.sample
  random_card_index = random_cards.index(random_card)
  random_cards.delete_at(random_card_index)
  suit_name = random_suit.keys.first
  cards_array.push({suit: suit_name, value: random_card})
end

def deal_first_two_cards(card_deck, cards_array)
  2.times do
    deal_card(card_deck, cards_array)
  end
end

def get_players_total(players_cards, player_name)
  ace_count = 0
  players_total = 0
  players_cards.each do |card|
    if card[:value] == "Ace"
      ace_count += 1
    elsif card[:value] == "Jack" || card[:value] == "King" || card[:value] == "Queen"
      players_total += 10
    else
      players_total += card[:value]
    end
  end
  if ace_count == 0
    return players_total
  elsif players_total < 11 && ace_count == 1
    return players_total + 11
  else
    return players_total + ace_count
  end
end

def get_dealers_total(dealers_cards)
  ace_count = 0
  dealers_total = 0
  dealers_cards.each do |card|
    if card[:value] == "Ace"
      dealers_total += 11
    elsif card[:value] == "Jack" || card[:value] == "King" || card[:value] == "Queen"
      dealers_total += 10
    else
      dealers_total += card[:value]
    end
  end
    return dealers_total
end

def dealers_first_card(dealers_cards)
  if dealers_cards.first[:value] == "Ace"
    return 11
  else
    return dealers_cards.first[:value]
  end
end

def display_header_for(name)
    puts " "
    puts "-  -  -  -  -  #{name}'s Hand  -  -  -  -  -"
end

def display_dealers_first_card(dealers_cards)
  puts "#{dealers_cards.first[:value]} of #{dealers_cards.first[:suit]}"
  puts "This card is hidden"
end

def display_hand_for(cards)
  cards.each{ |card| puts "#{card[:value]} of #{card[:suit]}" }
end

def display_total_for(total, name)
  puts " "
  puts "#{name}'s total: #{total}"
  puts " "
end

def display_current_hand_for(name, cards, total)
  display_header_for(name)
  display_hand_for(cards)
  display_total_for(total, name)
end

def display_press_key_with_msg(msg)
  puts "Press any key to #{msg}..."
  gets.chomp
end

def display_bust_msg_for(name)
  puts "#{name} went bust!"
  puts ""
end

def display_result(player_name, msg)
  puts ""
  puts "-  -  -  -  -  -  Result  -  -  -  -  -  -"
  puts ""
  puts "********** #{player_name} #{msg} **********"
  puts ""
end



# MAIN


# Ask the player for their name
  puts "Please enter your name to play:"

# Store the player's name
  player_name = gets.chomp

begin
  # VARS

  # Create data structure for deck of cards (52) (this is the previous data structure that was used for the basic implementation)
  # card_deck = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, [1, 11],
  #               1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, [1, 11],
  #               1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, [1, 11],
  #               1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, [1, 11]]

 # Create data structure for 2 decks of cards (52 cards in each) - Runs in constant time, I think.
  card_deck = [ {"Hearts" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]},
                {"Clubs" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]},
                {"Diamonds" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]},
                {"Spades" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]},
                {"Hearts" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]},
                {"Clubs" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]},
                {"Diamonds" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]},
                {"Spades" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]}, ]

  # Create data structure for 2 decks of cards (52 cards in each) - PROGRAMMTICALLLY CREATED. Runs in theta N time. Less efficient, but can add numerous decks easily if required.
  # cards = [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]
  # suits = ["Hearts", "Clubs", "Diamonds", "Spades"]
  # card_deck = []
  # 2.times do
  #   suits.each do |suit|
  #     card_deck.push({suit => cards})
  #   end
  # end

  player_won = false
  player_lost = false

  # Clear the player's screen for a new game
  system "clear"

  # Welcome players to the game
  puts "****** Welcome to Blackjack, #{player_name} ******"  

  # Deal two cards to the player (pick two random cards)
  players_cards = []
  deal_first_two_cards(card_deck, players_cards)
  # Calculate the sum of the player's two cards
  players_total = get_players_total(players_cards, player_name)
  # Deal two cards to the dealer
  dealers_cards = []
  deal_first_two_cards(card_deck, dealers_cards)
  # Calculate the sum of the dealer's two cards
  dealers_total = get_dealers_total(dealers_cards)

  # Display initial state for Dealer and Player
  display_header_for("Dealer")
  display_dealers_first_card(dealers_cards)

  display_current_hand_for(player_name, players_cards, players_total)

  # Deal with early wins and losses
  if players_total == 21
    player_won = true
    puts "#{player_name} got Blackjack!"
  end

  if !player_won
    begin
    # Ask the Player to either HIT or STAY
      puts "Would you like to Hit or Stay? (h/s)"
      player_decision = gets.chomp
      # If the Player chooses hit
      if player_decision.downcase == "h"
      # Pick a random card for the Player and add it to their score
        deal_card(card_deck, players_cards)
        players_total = get_players_total(players_cards, player_name)
        # display Player's new score
        display_current_hand_for(player_name, players_cards, players_total)
      #  If the sum of the Player's cards are more than 21 then the player loses
        if players_total > 21
          # end game and player loses
          display_bust_msg_for(player_name)
          player_lost = true
          break
        end
      end
    end until player_decision.downcase != "h"
  end

  # Ask the Player to perform an action to see the Dealer's hidden card
  display_press_key_with_msg("reveal the Dealer's hidden card")

  # If the dealer got Blackjack, AND the Player didn't get Blackjack, then tell the Player now that the Dealer got Blackjack
  if dealers_total == 21 && !player_won
    player_lost = true
    puts "The Dealer got Blackjack!"
  end

  # If the player has not already won or lost and the Dealer's total is less than 17
  if !player_won && !player_lost && dealers_total < 17
    # Display the Dealer's cards so the player knows what the Dealer's second card was
    display_current_hand_for("Dealer", dealers_cards, dealers_total)
    # Until the sum of the dealer's cards is 17 or more
    begin
      # Ask the player to perform an action to continue the loop.
      display_press_key_with_msg("allow the Dealer to take a card")
      # The dealer must Hit
      deal_card(card_deck, dealers_cards)
      dealers_total = get_dealers_total(dealers_cards)
      # display Dealer's new score
      display_current_hand_for("Dealer", dealers_cards, dealers_total)
      # If the sum of the dealer's cards is now above 21, then the player wins
      if dealers_total > 21
        display_bust_msg_for("The Dealer")
        player_won = true
      elsif dealers_cards.count == 2 && dealers_total == 21
        player_lost = true
      end
    end until dealers_total >= 17
  else
    display_current_hand_for("Dealer", dealers_cards, dealers_total)
  end

  # Ask the Player to perform an action to see the result
  display_press_key_with_msg("see the result")

  # Compare the sum of the player's cards to the sum of the dealer's cards. The highest value wins. Display who the winner is.
  result =
  if !player_won && !player_lost
    if players_total == dealers_total
      "tied with the Dealer"
    elsif players_total > dealers_total
      "won because his/her card total was higher"
    else
      "lost because his/her card total was lower"
    end
  elsif player_won
    if players_total == 21
      "got Blackjack!"
    else
      "won! Dealer went bust!"
    end
  elsif player_lost
    if players_total > 21
      "went bust and lost!"
    else
      "lost. Dealer got Blackjack!"
    end
  end

  display_result(player_name, result)

  # Ask player if the want to play again
  puts "Would you like to play again, #{player_name}? (y/n)"

  # Store the player's answer
  play_again = gets.chomp

end until play_again.downcase == "n"

# Clear the console to make the goodbye message obvious
system "clear"

# Goodbye message
puts "****** Thanks for playing procedural blackjack, #{player_name} ******"
puts " "




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
        # Array is better choice. In the procedural game, I'll hedge my bets with array as it fits the purpose and no more, which is better than a complicated hash (which isn't really any more useful).
        # Eventually changed to using an array with nested hashes, as this was required for the 'bonus' of adding suits into the program.

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

# 7. When deleting the 'random_card' from the array it's deleting all instances of cards of the same value.
    # Get the index of the random card somehow, and do delete_at for that specific index, instead of delete for that value.
    # Best way to do this? Is there a method I can use? Is there a sample with index method or similar?
    # I want to:
      # Get a random card from the array using sample
      # I want to get the index of this card at the same time. Might as well just delete the first one at the value.
      # How to do this?
        # Check the docs for a good array method. We can use the .index method to get the first item that matches the parameter given.

# 8. Need to deal with Aces. Determine whether they should be 1 or 11 based upon the current sum of the players cards.
    # First thing I notice here is that the players total should always be the sum of the players_cards array. We should be += it with each once we 
    # get in the loop. We should be adding that card to the players_cards array, then doing each on it and adding them together into players_total 
    # every time round the loop.
    # Ace is always counted as 11 for the dealer

# 9. Make players_cards and dealers_cards more efficient and semantic by storing each card as a hash with two keys - suit, and value.
    # This should be fairly easy to do. Let's make a mock version of the deal_first_two_cards method using a hash instead of an array to store the cards.
    # Next, let's look at how this would impact the rest of the code.
# def deal_first_two_cards(card_deck, cards_array)
#   begin
#     random_suit = card_deck.sample
#     suit_name = random_suit.keys.first
#     random_cards = random_suit.values.first
#     random_card = random_cards.sample
#     random_card_index = random_cards.index(random_card)
#     card_deck.delete_at(random_card_index)
#     cards_array.push({suit: #{suit_name}, value: #{random_card}})
#   end until cards_array.count == 2
# end

# def get_players_total(players_cards, player_name)
#   ace_count = 0
#   players_total = 0
#   players_cards.each do |card|
#     if card[value] == [1, 11]
#       ace_count += 1
#     else
#       players_total += card[value]
#     end
#   end
#   if ace_count == 0
#     return players_total
#   elsif players_total < 11 && ace_count == 1
#     puts "#{player_name} has an ace"
#     return players_total + 11
#   else
#     puts "#{player_name} has #{ace_count} ace(s)"
#     return players_total + ace_count
#   end
# end

# def get_dealers_total(dealers_cards)
#   ace_count = 0
#   dealers_total = 0
#   dealers_cards.each do |card|
#     if card[value] == [1, 11]
#       dealers_total += 11
#     else
#       dealers_total += card[value]
#     end
#   end
#     return dealers_total
# end

# def dealers_first_card(dealers_cards)
#   if dealers_cards.first[value] == [1, 11]
#     return 11
#   else
#     return dealers_cards.first[value]
#   end
# end

# 10. Currently, if the player scores 21 (no matter how many cards they have), the player automatically wins.
    # We need to check if they have 21 with 2 cards and only then say that the player has autmatically won.

# 11. How would adding another deck work?
    # Can just add another 'deck' model inside the card_deck array.

# 12. Possible redundant code in the check for the winner. Let's paste code here to analyze.
  #   result =
  #   if !player_won && !player_lost
  #     if players_total == dealers_total
  #       "tied with the Dealer"
  #     elsif players_total > dealers_total
  #       "won because his/her card total was higher"
  #     else
  #       "lost because his/her card total was lower"
  #     end                                                         <= If the player has not won or lost, then simply compare players total to dealer's total and either one wins or they tie.
  #   elsif player_won
  #     if players_total == 21          X
  #       if players_cards.count == 2   Ident this line to be only one layer of nesting in the elsif parent.
  #         "got Blackjack!"
  #       else                          X
  #         "won!"                      X
  #       end                           X
  #     else                            
  #       "won! Dealer went bust!"      
  #     end                                                         <= If the player has won, means player got blackjack, or dealer went bust
  #   elsif player_lost
  #     if dealers_cards.count == 2     X
  #       if !dealers_total == 21
  #         "went bust and lost!"
  #       else
  #         "lost. Dealer got Blackjack!"
  #       end
  #     end                             X
  #   end

  #   display_result(player_name, result)

# 13. How do we clean up the logic and loop for the Player's turn?
    # Let's analyze the code below to see what we can do. On analysis, the loop is actually reasonably efficient.
  #  if !player_won
  #   begin
  #   # Ask the Player to either HIT or STAY
  #     puts "Would you like to Hit or Stay? (h/s)"
  #     player_decision = gets.chomp
  #     # If the Player chooses hit
  #     if player_decision.downcase == "h"
  #     # Pick a random card for the Player and add it to their score
  #       deal_card(card_deck, players_cards)
  #       players_total = get_players_total(players_cards, player_name)
  #       # display Player's new score
  #       display_current_hand_for(player_name, players_cards, players_total)
  #     #  If the sum of the Player's cards are more than 21 then the player loses
  #       if players_total > 21
  #         # end game and player loses
  #         display_bust_msg_for(player_name)
  #         player_lost = true
  #         break
  #       end
  #     end
  #   end until player_decision.downcase != "h"
  # end

# 14. Can we create the card_deck programmatically? Let's the solution out and see if it works.
  #  Let's have a look at the code and see what we can do to re-create it programmatically:
     # Create data structure for 2 decks of cards (52 cards in each)
    # card_deck = [ {"Hearts" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]},
    #               {"Clubs" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]},
    #               {"Diamonds" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]},
    #               {"Spades" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]},
    #               {"Hearts" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]},
    #               {"Clubs" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]},
    #               {"Diamonds" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]},
    #               {"Spades" => [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]}, ]
  # This didn't work. The card_deck array was exactly the same but seemed to processed differently. Interesting in itself? Memory allocation different for this?


# cards = [1, 2, 3, 4, 5, 6, 7, 8, 9, "Jack", "Queen", "King", "Ace"]
# suits = ["Hearts", "Clubs", "Diamonds", "Spades"]
# card_deck = []
# 2.times do
#   suits.each do |suit|
#     card_deck.push({suit => cards})
#   end
# end

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

  # EXTRA - If the dealer already has 17, don't hit at all - go straight to comparing.

  # => The dealer must keep hitting until she has at least 17.
  # => If the dealer busts, then the player wins. 
  # => If the dealer hits 21, then the dealer wins. 
  # => If the dealer stays, then we compare the sums of the two hands between the player and dealer
  # => The higher value in the comparison wins. EXTRA - We shouldn't need to check for less than 21 here. Game should have ended before if that were the case.


# Improving Game Play

  # Here is an example of what the Game Play should look like:

 #  -  -  -  -  -  Dealer's Hand  -  -  -  -  -
 #                  5 of Clubs
 #              This card is hidden

 #  -  -  -  -  -  Liam's Hand  -  -  -  -  -
 #                  5 of Clubs
 #                  2 of Hearts

 #  Liam's Total = 7

 #  Would you like to Hit or Stay? ( h / s )

 #  -  -  -  -  -  Liam's Hand  -  -  -  -  -
 #                5 of Clubs
 #                2 of Hearts
 #                8 of Diamonds

 #  Liam's Total = 15

 #  Would you like to Hit or Stay? ( h / s )

 # -  -  -  -  -  Liam's Hand  -  -  -  -  -
 #                5 of Clubs
 #                2 of Hearts
 #                8 of Diamonds
 #                Jack of Clubs

 #  Liam went bust!

 #  ****** Thanks for playing procedural blackjack, Liam ******








