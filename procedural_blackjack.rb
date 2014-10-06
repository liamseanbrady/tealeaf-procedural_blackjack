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
    random_suit = card_deck.sample
    suit_name = random_suit.keys[0]
    random_cards = random_suit.values[0]
    random_card = random_cards.sample
    random_card_index = random_cards.index(random_card)
    card_deck.delete_at(random_card_index)
    cards_array.push([random_card, suit_name])
  end until cards_array.count == 2
end

def get_players_total(players_cards, player_name)
  ace_count = 0
  players_total = 0
  players_cards.each do |card_val|
    if card_val[0] == [1, 11]
      ace_count += 1
    else
      players_total += card_val[0]
    end
  end
  if ace_count == 0
    return players_total
  elsif players_total < 11 && ace_count == 1
    puts "#{player_name} has an ace"
    return players_total + 11
  else
    puts "#{player_name} has #{ace_count} ace(s)"
    return players_total + ace_count
  end
end

def get_dealers_total(dealers_cards)
  ace_count = 0
  dealers_total = 0
  dealers_cards.each do |card_val|
    if card_val[0] == [1, 11]
      dealers_total += 11
    else
      dealers_total += card_val[0]
    end
  end
    return dealers_total
end

def dealers_first_card(dealers_cards)
  if dealers_cards[0][0] == [1, 11]
    return 11
  else
    return dealers_cards[0][0]
  end
end


# Ask the player for their name
  puts "Please enter your name to play:"

# Store the player's name
  player_name = gets.chomp

# Welcome players to the game
  puts "****** Welcome to Blackjack, #{player_name} ******"

begin
  # VARS

  # Create data structure for deck of cards (52)
  # card_deck = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, [1, 11],
  #               1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, [1, 11],
  #               1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, [1, 11],
  #               1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, [1, 11]]

  card_deck = [ {"hearts" => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, [1, 11]]},
                {"clubs" => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, [1, 11]]},
                {"diamonds" => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, [1, 11]]},
                {"spades" => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, [1, 11]]} ]


  player_already_won = false
  player_already_lost = false
  dealer_already_lost = false

  # Welcome players to the game
  puts "- - - - - - - -  Starting Game...  - - - - - - - -"

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

  # Deal with early wins and losses

  if players_total == 21
    player_already_won = true
    puts "#{player_name} got blackjack!"
  end

  if players_total > 21
    player_already_lost = true
  end

  if dealers_total > 21
    player_already_won = true
  end


  puts "=> Dealer's first card: - #{dealers_first_card(dealers_cards)} of #{dealers_cards[0][1]} -"
  puts "=> #{player_name}'s' hand: #{players_cards}  Card total: #{players_total}"

  if !player_already_won && !player_already_lost
    begin
    # Ask the player to either HIT or STAY
      puts "Would you like to hit or stay? (hit/stay)"
      player_decision = gets.chomp
      # If the player chooses hit
      if player_decision.downcase == "hit"
      # confirm with player that they chose 'hit' - might not need this, so commented it out for now.
      # puts "#{player_name} chose hit - hero!"
      # Pick a random card for the player and add it to their score
        random_suit = card_deck.sample
        suit_name = random_suit.keys[0]
        random_cards = random_suit.values[0]
        random_card = random_cards.sample
        random_card_index = random_cards.index(random_card)
        card_deck.delete_at(random_card_index)
        players_cards.push([random_card, suit_name])
        players_total = get_players_total(players_cards, player_name)
        # display player's new score
        puts "=> #{player_name}'s' card: - #{random_card} of #{suit_name} - "
        puts "=> #{player_name}'s' hand: #{players_cards}  Card total: #{players_total}"
      #  If the sum of the player's cards are more than 21 then the player loses
        if players_total > 21
          # end game and player loses
          puts "#{player_name} went bust!"
          player_already_lost = true
          break
      #  Else If the sum of the player's cards is 21, then the player wins
        elsif players_total == 21
          # end game and player wins
          puts "#{player_name} got blackjack"
          player_already_won = true
          break
      #  Else If the sum is less than 21, recurse
        elsif players_total < 21
          # recurse
        end
      # Else
      else
      #  save the total value of the player's cards - we're doing this by incrementing each time
      puts "#{player_name} chose stay"
      end
    end until player_decision.downcase != "hit"
  end

  # If the player has not already won or lost
  if !player_already_won && !player_already_lost && dealers_total < 17
    # Until the sum of the dealer's cards is 17 or more
    begin
    #   The dealer must HIT
      puts "=> Dealer's hand: #{dealers_cards}"
      random_suit = card_deck.sample
      suit_name = random_suit.keys[0]
      random_cards = random_suit.values[0]
      random_card = random_cards.sample
      random_card_index = random_cards.index(random_card)
      card_deck.delete_at(random_card_index)
      dealers_cards.push([random_card, suit_name])
      dealers_total = get_dealers_total(dealers_cards)
      puts "=> Dealer's card is: #{random_card} of #{suit_name}"
      puts "=> Dealer's current total is: #{dealers_total}"
    #   If the sum of the dealer's cards is now above 21, then the player wins
      if dealers_total > 21
        puts "Dealer is bust"
        player_already_won = true
    #   Else if the sum of the dealer's cards is 21 exactly, then the dealer wins
      elsif dealers_total == 21
        puts "Dealer got blackjack!"
        player_already_lost = true
      end
    end until dealers_total >= 17
  else
    puts "=> Dealer's hand: #{dealers_cards}"
    puts "Dealer's total is: #{dealers_total}"
  end

  # Compare the sum of the player's cards to the sum of the dealer's cards. The highest value wins. Display who the winner is.
  if !player_already_won && !player_already_lost
    if players_total == dealers_total
      puts "Tie"
    elsif players_total > dealers_total
      puts "#{player_name} wins"
    else
      puts "Dealer wins"
    end
  elsif player_already_won && player_already_lost
    puts "Nobody wins"
  elsif player_already_won
    puts "#{player_name} wins"
  elsif player_already_lost
    puts "#{player_name} loses"
  end

  # Ask player if the want to play again
  puts "Would you like to play again, #{player_name}? (y/n)"

  # Store the player's answer
  play_again = gets.chomp

end until play_again.downcase == "n"

# Goodbye message
puts "****** Thanks for playing procedural blackjack, #{player_name} ******"






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

# 7. When deleting the 'random_card' from the array it's deleting all instances of cards of the same value.
    # Get the index of the random card somehow, and do delete_at for that specific index, instead of delete for that value.
    # Best way to do this? Is there a method I can use? Is there a sample with index method or similar?
    # I want to:
      # Get a random card from the array using sample
      # I want to get the index of this card at the same time. Might as well just delete the first one at the value.
      # How to do this?
        # Check the docs for a good array method. We can use the .index method to get the first item that matches the parameter given.

# 7. Need to deal with Aces. Determine whether they should be 1 or 11 based upon the current sum of the players cards.
    # First thing I notice here is that the players total should always be the sum of the players_cards array. We should be += it with each once we 
    # get in the loop. We should be adding that card to the players_cards array, then doing each on it and adding them together into players_total 
    # every time round the loop.
    # Ace is always counted as 11 for the dealer


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





