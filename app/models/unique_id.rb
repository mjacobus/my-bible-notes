# frozen_string_literal: true

class UniqueId
  def initialize(value = nil)
    @value = (value || SecureRandom.uuid).dup
    freeze
  end

  def to_s
    @value
  end

  def ==(other)
    other.to_s == to_s
  end
end
