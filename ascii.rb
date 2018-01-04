#!/bin/ruby
numbers = STDIN.read.split(", ").each do |ch|
  puts ch + ' => ' + ch.to_i.chr
end

