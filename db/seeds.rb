# frozen_string_literal: true

module DevRandomModule
  def random
    order('RANDOM()').first
  end
end
