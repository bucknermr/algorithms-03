require_relative "heap"

class Array
  def heap_sort!
    length.times do |idx|
      BinaryMinHeap.heapify_up(self, idx, idx + 1) { |a, b| -1 * (a <=> b) }
    end

    (length - 1).downto(1) do |len|
      self[0], self[len] = self[len], self[0]
      BinaryMinHeap.heapify_down(self, 0, len) { |a, b| -1 * (a <=> b) }
    end
    
    self
  end
end
