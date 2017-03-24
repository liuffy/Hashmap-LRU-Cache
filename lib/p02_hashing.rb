class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    binary_array = self.join(",").unpack("B*")
    binary_array[0].to_i ^ 5
  end
end

class String
  def hash
    binary_array = self.unpack("B*")
    binary_array[0].to_i ^ 5
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_array = self.keys.map{|key| [key,self[key]]} #convert hash to an array with tuples
    binary_array = hash_array.sort.join("").unpack("B*")
    binary_array[0].to_i ^ 5
  end
end
