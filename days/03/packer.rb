#!/usr/bin/env ruby

def find_duplicate(a, b)
	a.each_char do | as |
		b.each_char do | bs |
			return as if as == bs
		end
	end
end

def find_duplicates(a, b, c)
	a.each_char do | as |
		b.each_char do | bs |
			c.each_char do | cs |
				return as if as == bs and bs == cs and as == cs
			end
		end
	end
end

def ord(s)
	# is uppercase
	if s.upcase == s then
		return s.ord - 'A'.ord + 27
	else
		return s.ord - 'a'.ord + 1
	end
end

star_one = 0
star_two = 0
i = 0
group = Array.new

File.open('example').each do | line |
	compartment_size = line.length / 2
	a = line[0...compartment_size]
	b = line[compartment_size..-1]
	dupe = find_duplicate(a, b)
	star_one += ord(dupe)
	group << line
	i += 1
	if i % 3 == 0 then
		dupe = find_duplicates(group[0], group[1], group[2])
		star_two += ord(dupe)
		group = Array.new
	end
end

puts star_one
puts star_two
