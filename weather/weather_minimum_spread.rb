def valid_data?(value)
  Integer(value) rescue false
end

Record = Struct.new(:date, :max, :min)
records = []
data = File.readlines('./w_data.dat')

# Populating records with cleaned data
data.each do |line|
  date, max_temp, min_temp = line.split(' ')
  if valid_data?(date)
    records.push(Record.new(date, max_temp.to_f, min_temp.to_f))
  end
end

# Identifying the minimum spread record
result = records.reduce {|prev, current|
  (current.max - current.min) < (prev.max - prev.min) ? current : prev
}

puts result.date
























