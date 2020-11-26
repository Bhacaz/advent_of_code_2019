
range = (153517..630395)

def adjacent(password)
  index = (password.to_s.length) - 1

  find_double = false
  index.times do |i|
    tuple = password.to_s.chars[i..(i + 1)]
    if tuple[0] == tuple[1]
      find_double = true
      next
    end
  end

  find_double
end

def never_decrease(password)
  index = (password.to_s.length) - 1

  never_decrease = true
  index.times do |i|
    tuple = password.to_s.chars[i..(i + 1)]
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

puts passwords.size # 1729
