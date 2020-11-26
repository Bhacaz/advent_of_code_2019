
INPUT = File.open('input.txt', 'r').read.split("\n").map { |row| row.chars }

LENGTH = INPUT.size - 1
WIDE = INPUT.first.size - 1

COUNT = []
MAX = [0]

def cross_product(a, b)
  result = []
  result[0] = a[1] * b[2] - a[2] * b[1]
  result[1] = a[2] * b[0] - a[0] * b[2]
  result[2] = a[0] * b[1] - a[1] * b[0]
  result
end

def count_asteroid(px, py)
  found = []

  (0..WIDE).each do |x|
    (0..LENGTH).each do |y|

      if INPUT[y][x] == '.'
        COUNT[y] ||= []
        COUNT[y][x] = '.'
      elsif [x, y] != [px, py]
        same_lines = found.select { |f| cross_product([f[0] - px, f[1] - py, 0], [x - px, y - py, 0]) == [0, 0, 0] }
        different_direction = same_lines.select do |f|
          Math.atan2((f[1] - py), f[0] - px) == Math.atan2((y - py), x - px)
        end.empty?

        if found.empty? || same_lines.empty? || different_direction
          found << [x, y]
        end
      end
    end
  end

  #COUNT[py] ||= []
  #COUNT[py][px] = found.size

  if found.size > MAX[0]
    MAX[0] = found.size
  end
end

INPUT.each_with_index do |row, y|
  row.each_with_index do |element, x|
    next if element == '.'

    count_asteroid(x, y)
  end
end

p MAX # 340 ([28, 29])

