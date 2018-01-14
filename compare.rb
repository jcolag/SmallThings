listA = [ 1, 2, 12, 3, 0, 10, 11, 4, 5, 6, 7, 8, 9 ]
listB = [ 1, 2, 6, 12, 3, 0, 10, 11, 4, 5, 7, 8, 9 ]

def compare(first, second)
  offset = 0
  lastoff = 0
  k = 1
  first.each do |i|
    j = second.index(i) + 1
    offset -= 1 if j < k + offset
    offset += 1 if j > k + offset
    mark = ""
    mark = "*" if lastoff != offset
    print k.to_s + ":" + j.to_s + " (" + offset.to_s + mark + ")\n"
    lastoff = offset
    k += 1
  end
end

compare(listA, listB)
print "---\n"
compare(listB, listA)

