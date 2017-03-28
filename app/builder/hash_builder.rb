class HashBuilder < Hash
  def self.build
    hash = HashBuilder.new
    yield hash if block_given?
    hash.to_h
  end

  def hash!(key)
    self[key] = HashBuilder.new unless has_key?(key)
    yield self[key] if block_given?
  end

  def array!(key)
    self[key] = Array.new unless has_key?(key)
    yield self[key] if block_given?

  def number!(key)
    self[key] = 0 unless has_key?(key)
    yield self[key] if block_given?
  end
end
