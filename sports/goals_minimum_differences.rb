def valid_data?(value)
  !value.to_i.zero?
end

def goal_difference(for_goals, against_goals)
  return nil if for_goals - against_goals < 0
  return for_goals - against_goals
end
Record = Struct.new(:team, :for_goals, :against_goals)
records = []
data = File.readlines('./soccer.dat')

# Populating records with cleaned data
data.each do |line|
  splitted_line = line.split(' ')
  next if !valid_data?(splitted_line[0])

  dash_position = splitted_line.find_index('-')
  records.push(Record.new(splitted_line[1], splitted_line[dash_position-1].to_f, splitted_line[dash_position+1].to_f))
end

# Identifying the minimum goal difference
result = records.reduce {|prev, current|
  previous_difference = goal_difference(prev.for_goals, prev.against_goals)
  current_difference = goal_difference(current.for_goals, current.against_goals)
  if previous_difference.nil?
    current
  elsif current_difference.nil?
    prev
  else
    (current_difference < previous_difference) ? current : prev
  end
}

puts result.to_s