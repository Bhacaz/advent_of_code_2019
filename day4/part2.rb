
range = (153517..630395)

def adjacent(password)
  pass_s = password.to_s.chars

  find_double = false
  (pass_s.size - 1).times do |i|
    tuple = pass_s[i..(i + 1)]
    if tuple[0] == tuple[1] && pass_s.count(tuple[0]) == 2
      find_double = true
      next
    end
  end

  find_double
end

def never_decrease(password)
  pass_s = password.to_s.chars

  never_decrease = true
  (pass_s.size - 1).times do |i|
    tuple = pass_s[i..(i + 1)]
    if tuple[0].to_i > tuple[1].to_i
      never_decrease = false
      next
    end
  end

  never_decrease
end

passwords = range.select do |password|
  adjacent(password) && never_decrease(password)
end

puts passwords.size # 1172

