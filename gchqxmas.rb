#!/bin/ruby
# Encoding: utf-8
require 'net/http'
require 'uri'

Choices = %w( A B C D E F )
def append(input, suffix, depth)
  if depth < 1
    url = input + suffix
    uri = URI.parse(url)
    result = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.get(uri.to_s)
    end
    puts "Failed " unless result.is_a?(Net::HTTPSuccess)
    puts "Success! " unless result.body.include?("Sorry - you did not get all the questions correct.")
    return
  end
  Choices.each_index do |i|
    puts i
    url = input
    append(url + Choices[i], suffix, depth - 1)
  end
end
append("https://s3-eu-west-1.amazonaws.com/puzzleinabucket/", ".html", 6)

