#!/usr/bin/env ruby

def all_smaller(nums, target)
	nums.each do |n|
		return false if n >= target
	end
	return true
end

def is_visible(row, col)
	height = @forest[row][col]
	left = @forest[row][0...col]
	right = @forest[row][col+1..-1]
	above = Array.new
	(0...row).each do |r|
		above << @forest[r][col]
	end
	below = Array.new
	(row+1..@forest.first.length-1).each do |r|
		below << @forest[r][col]
	end
	return (all_smaller(left, height) or
			all_smaller(right, height) or
			all_smaller(above, height) or
			all_smaller(below, height))
end

def count_scenic(trees, height)
	count = 0
	trees.each do |t|
		if t < height then
			count += 1
		else
			return count + 1
		end
	end
	return count
end

def scenic_score(row, col)
	height = @forest[row][col]
	left = @forest[row][0...col]
	right = @forest[row][col+1..-1]
	above = Array.new
	(0...row).each do |r|
		above << @forest[r][col]
	end
	below = Array.new
	(row+1..@forest.first.length-1).each do |r|
		below << @forest[r][col]
	end
	left.reverse!
	above.reverse!
	# puts "#{row}/#{col} #{count_scenic(left, height)} #{count_scenic(right, height)} #{count_scenic(above, height)} #{count_scenic(below, height)}"
	return count_scenic(left, height) * count_scenic(above, height) * count_scenic(right, height) * count_scenic(below, height)
end

@forest = Array.new

File.open('input').each do | line |
	row = Array.new
	line.strip.each_char do |c|
		row << c.to_i
	end
	@forest << row
end

visible_count = 0
best_scenic_score = 0
@forest.each_index do |row|
	@forest[row].each_index do |col|
		visible_count += 1 if is_visible(row, col)
		ss = scenic_score(row, col)
		best_scenic_score = ss if ss > best_scenic_score
	end
end

puts scenic_score(2, 1)

puts visible_count
puts best_scenic_score