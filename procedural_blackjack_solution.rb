# Interactive Blackjack command line game

# Methods

def calculate_total(cards)
  vals = cards.map { |e| e[1] }
  total = 0
  vals.each do |val| 
    if val == "A"
      total += 11
    elsif val.to_i == 0
      total += 10
    else
      total += val.to_i
    end
  end

  # Correct for aces
  vals.select{ |e| e == "A"}.count.times do
    total -= 10 if total > 21
  end

  return total
end

# Main

# Start Game

puts "Welcome to Blackjack!"

suits = ["H", "D", "S", "C"]
cards = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

deck = suits.product(cards)
deck.shuffle!

# Deal Cards

mycards = []
dealercards = []

mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards << deck.pop

dealertotal = calculate_total(dealercards)

mytotal = calculate_total(mycards)

# Show Cards

puts "Dealer has #{dealercards.first} and #{dealercards[1]}, for a total of #{dealertotal}"
puts "You have #{mycards.first} and #{mycards[1]}, for a total of #{mytotal}"
puts ""

# Player turn

if mytotal == 21
  puts "You hit blackjack! Congratulations, you won!"
  exit
end

while mytotal < 21
  puts "What would you like to do? 1) hit 2) stay"
  hit_or_stay = gets.chomp

  if !["1", "2"].include?(hit_or_stay)
    next
  end

  if hit_or_stay == "2"
    puts "You chose to stay."
    break
  end

  # hit
  new_card = deck.pop
  puts "Dealing card to player: #{new_card}"
  mycards << new_card
  mytotal = calculate_total(mycards)
  puts "Your total is now: #{mytotal}"

  if mytotal == 21
    puts "Congratulations, you hit blackjack! You win!"
    exit
  elsif mytotal > 21
    puts "You went bust! You lose!"
    exit
  end

end

# Dealer turn

if dealertotal == 21
  puts "The Dealer hit blackjack. Sorry, you lose!"
  exit
end

while dealertotal < 17
  new_card = deck.pop
  puts "Dealing card to Dealer: #{new_card}"
  dealercards << new_card
  dealertotal = calculate_total(dealercards)
  puts "Dealer's total is now: #{dealertotal}"

  if dealertotal == 21
    puts "The Dealer hit blackjack. Sorry, you lose!"
    exit
  elsif dealertotal > 21
    puts "Dealer went bust. You win!"
    exit
  end
end

# Compare Hands

puts "Dealer cards:"
dealercards.each do |card|
  puts "=> #{card}"
end

puts ""

puts "Your cards:"
mycards.each do |card|
  puts "=> #{card}"
end

puts ""

if mytotal > dealertotal
  puts "You had a higher card total. You win!"
elsif dealertotal > mytotal
  puts "Dealer had a higher card total. You lose!"
else
  puts "You have the same total as the dealer. It's a tie!"
end
  
exit









