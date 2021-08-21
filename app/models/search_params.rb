# frozen_string_literal: true

class SearchParams < HashWithIndifferentAccess
  def initialize(hash)
    hash.each do |key, value|
      if value.present?
        self[key] = value
      end
    end
    freeze
  end

  def if(key)
    if self[key]
      yield(self[key])
    end
  end

  def any?(*keys)
    keys.flatten.find do |key|
      key?(key)
    end
  end
end
