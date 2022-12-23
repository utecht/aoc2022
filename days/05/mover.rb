#!/usr/bin/env ruby

example = Array.new
example << "NZ".reverse.chars
example << "DCM".reverse.chars
example << "P".reverse.chars

input = Array.new
input << "JZGVTDBN".reverse.chars
input << "FPWDMRS".reverse.chars
input << "ZSRCV".reverse.chars
input << "GHPZJTR".reverse.chars
input << "FQZDNJCT".reverse.chars
input << "MFSGWPVN".reverse.chars
input << "QPBVCG".reverse.chars
input << "NPBZ".reverse.chars
input << "JPW".reverse.chars

def move(stacks, num, from, to)
	stack = ''
	num.times do
		stack << stacks[from - 1].pop
	end
	stack.reverse.each_char do |c|
		stacks[to - 1] << c
	end
end

File.open('example').each do | line |
	values = line.split(' ')
	num = values[1].to_i
	from = values[3].to_i
	to = values[5].to_i
	puts "#{num} #{from}->#{to}"
	move(example, num, from, to)
	puts example.inspect
end

str = ''
example.each do |s|
	str << s.pop
end
puts str

File.open('input').each do | line |
	values = line.split(' ')
	num = values[1].to_i
	from = values[3].to_i
	to = values[5].to_i
	move(input, num, from, to)
end

str = ''
input.each do |s|
	str << s.pop
end
puts str
