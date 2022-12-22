#!/usr/bin/env ruby

def score_throw(you)
	if you == 'X' then
		return 1
	end
	if you == 'Y' then
		return 2
	end
	if you == 'Z' then
		return 3
	end
	return 0
end

# X rock | lose
# Y paper | draw
# Z scissor | win

def score(opponent, you)
	throw_points = score_throw(you)
	win_points = 0
	# rock
	if opponent == 'A' then
		win_points = 3 if you == 'X'
		win_points = 6 if you == 'Y'
	end
	# paper
	if opponent == 'B' then
		win_points = 3 if you == 'Y'
		win_points = 6 if you == 'Z'
	end
	# scissors
	if opponent == 'C' then
		win_points = 3 if you == 'Z'
		win_points = 6 if you == 'X'
	end
	return throw_points + win_points
end

def pick_correct(opponent, you)
	# rock
	if opponent == 'A' then
		return 'Z' if you == 'X'
		return 'X' if you == 'Y'
		return 'Y' if you == 'Z'
	end
	# paper
	if opponent == 'B' then
		return 'X' if you == 'X'
		return 'Y' if you == 'Y'
		return 'Z' if you == 'Z'
	end
	# scissors
	if opponent == 'C' then
		return 'Y' if you == 'X'
		return 'Z' if you == 'Y'
		return 'X' if you == 'Z'
	end
end

total = 0
second_total = 0
File.open('input').each do | line |
	opponent, you = line.split
	total += score(opponent, you)
	new_you = pick_correct(opponent, you)
	second_total += score(opponent, new_you)
end

puts total
puts second_total

