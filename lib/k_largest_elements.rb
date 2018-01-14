require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new { |a, b| -1 * (a <=> b) }
  array.each do |el|
    heap.push(el)
  end
  results = []
  k.times { results << heap.extract }
  results
end
