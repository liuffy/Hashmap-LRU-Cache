require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
   bucket(key).include?(key)
  end

# set, insert a new link with the key and value into the correct bucket.
# You can use your LinkedList#append method.) If the key already exists,
# you will need to update the existing link.
  def set(key, val)
    resize! if @count == num_buckets

    if include?(key)
      bucket(key).update(key,val)
    else 
      bucket(key).append(key, val)
      @count += 1
    end 
  end

#To get, check whether the linked list contains the key you're looking up
  def get(key)
    bucket(key).each{ |link| return link.val if link.key == key }
  end

#To delete, remove the link corresponding to that key from the linked list
  def delete(key)
    bucket(key).each do |link|
      if link.key == key
        link.remove
        @count -= 1
        return link.val
      end 
    end 
  end

  def each
    @store.each do |bucket|
      bucket.each do |link|
        yield [link.key, link.val]
      end 
    end 
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0 
    @store = Array.new(num_buckets * 2) {LinkedList.new}

    old_store.each do |bucket|
      bucket.each{ |link| set(link.key, link.val)}
    end 
  end

  def bucket(key)
    @store[key.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `key`
  end
end
