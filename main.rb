require 'benchmark'

day = ARGV[0].rjust(2, '0')
part = ARGV[1]

require_relative 'base_part'
require_relative "day#{day}/part#{part}"

result = nil
allocated = 0
measure = Benchmark.measure do
  allocated = GC.stat(:total_allocated_objects)
  result = Part.run
  allocated = GC.stat[:total_allocated_objects] - allocated
end

duration = (measure.real * 1000).round(2)

puts <<~result
-------- Day: #{day}, Part: #{part} --------
| Duration\t| #{duration} ms\t|
| Allocated\t| #{allocated}\t\t|
| Result\t| #{result}\t|
---------------------------------
result
