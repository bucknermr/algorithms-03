class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc || Proc.new { |a, b| a <=> b }
    @store = []
  end

  def count
    store.length
  end

  def extract
    store[0], store[-1] = store[-1], store[0]
    result = store.pop
    BinaryMinHeap.heapify_down(store, 0, &prc)
    result
  end

  def peek
    store[0]
  end

  def push(val)
    store.push(val)
    BinaryMinHeap.heapify_up(store, count - 1, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    children = []
    if parent_index == 0
      children << 1 if len > 1
      children << 2 if len > 2
    else
      idx = (parent_index * 2) + 1
      children << idx if len > idx
      children << idx + 1 if len > idx + 1
    end

    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    i, j = self.child_indices(len, parent_idx)

    while i
      swap_idx = nil

      if prc.call(array[parent_idx], array[i]) == 1
        swap_idx = j && prc.call(array[i], array[j]) == 1 ? j : i
      elsif j && prc.call(array[parent_idx], array[j]) == 1
        swap_idx = j
      end

      return array unless swap_idx

      array[parent_idx], array[swap_idx] = array[swap_idx], array[parent_idx]
      parent_idx = swap_idx
      i, j = self.child_indices(len, parent_idx)
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0
    prc ||= Proc.new { |a, b| a <=> b }

    while child_idx > 0
      parent_idx = self.parent_index(child_idx)

      break unless prc.call(array[parent_idx], array[child_idx]) == 1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]

      child_idx = parent_idx
    end

    array
  end
end
