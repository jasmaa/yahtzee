require 'set'

def mode(l)
  l.reduce({}) { |acc, x|
    if acc.has_key? x then
      acc[x] += 1
    else
      acc[x] = 1
    end
    acc
  }.sort_by{ |k, v| -v }.first.first
end

def simulate_yahtzee(n_dice = 5, tries = 3)
  dice = (1..n_dice).map { |x| rand 1..6 }
  for i in 1..tries do
    if dice.to_set.size == 1 then
      return true
    end
    most_common = mode dice
    dice = dice.map { |x| x == most_common ? x : (rand 1..6) }
  end
  false
end

n = 1000000
n_wins = 0.0
for i in 0...n do
  if simulate_yahtzee then
    n_wins += 1
  end
  if (i+1) % (n/10) == 0 then
    print "(i=#{i}) Percentage: #{n_wins / (i+1)}\n"
  end
end