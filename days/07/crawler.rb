#!/usr/bin/env ruby

class Directory
	def initialize(name)
		@my_name = name
		@file_size = 0
		@dirs = Array.new
	end

	def add_file(name, size)
		@file_size += size.to_i
	end

	def add_dir(name)
		@dirs << name
	end

	def get_size(fs)
		ret = @file_size
		@dirs.each do |name|
			ret += fs["#{@my_name}/#{name}"].get_size(fs)
		end
		return ret
	end

	def to_s()
		"#{@my_name} #{@file_size} #{@dirs.length} Dirs"
	end
end

fs = Hash.new
full_path = Array.new
cur_dir = nil

File.open('input').each do | line |
	line = line.strip
	if line[0] == '$' then
		command = line[2, 2]
		if command == 'cd' then
			fs[full_path.join('/')] = cur_dir unless cur_dir.nil?
			cur_dir = nil
			destination = line[5..-1]
			if destination == '..' then
				full_path.pop
			else
				full_path << destination
			end
		else
			cur_dir = Directory.new(full_path.join('/'))
		end
	else
		st, name = line.split(' ')
		if st == 'dir' then
			cur_dir.add_dir(name)
		else
			cur_dir.add_file(name, st)
		end
	end
end
fs[full_path.join('/')] = cur_dir unless cur_dir.nil?

total_size = 0
fs.each_pair do |key, value|
	size = value.get_size(fs)
	total_size += size if size < 100000
end

puts total_size

base_dir_size = fs['/'].get_size(fs)
total_disk_size = 70000000
size_needed = 30000000
free_space = total_disk_size - base_dir_size
target_size = size_needed - free_space

smallest_dir = nil
smallest_dir_size = 10000000000
fs.each_pair do |key, value|
	size = value.get_size(fs)
	if size > target_size and size < smallest_dir_size then
		puts "#{value.get_size(fs)} - #{value}"
		smallest_dir = value
		smallest_dir_size = size
	end
end

puts smallest_dir_size
