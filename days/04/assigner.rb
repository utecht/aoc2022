#!/usr/bin/env ruby

def schedule_overlap(a_start, a_end, b_start, b_end)
	if a_start.to_i >= b_start.to_i then
		if a_end.to_i <= b_end.to_i then
			return true
		end
	end
	return false
end

def elf_overlap(a, b)
	a_start, a_end = a.split('-')
	b_start, b_end = b.split('-')
	return true if schedule_overlap(a_start, a_end, b_start, b_end)
	return true if schedule_overlap(b_start, b_end, a_start, a_end)
	return false
end

def any_overlap(a, b)
	a_start, a_end = a.split('-')
	b_start, b_end = b.split('-')
	elfa = (a_start.to_i..a_end.to_i).to_a
	elfb = (b_start.to_i..b_end.to_i).to_a
	return false if (elfa & elfb).empty?
	return true
end

star_one = 0
star_two = 0

File.open('example').each do | line |
	elfa, elfb = line.split(',')
	star_one += 1 if elf_overlap(elfa, elfb)
	star_two += 1 if any_overlap(elfa, elfb)
end

puts star_one
puts star_two
