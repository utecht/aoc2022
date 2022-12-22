#!/usr/bin/env ruby

class Elf
	attr_accessor :food

	def initialize
		@food = 0
	end

	def add_food(new_food)
		@food += new_food
	end
end

elves = Array.new
elf = Elf.new

File.open('input').each do | line |
	if line.strip.empty? then
		elves << elf
		elf = Elf.new
	else
		elf.add_food line.to_i
	end
end

elves.sort! { |a, b|
	b.food <=> a.food
}

puts elves.first.food
puts elves[0].food + elves[1].food + elves[2].food