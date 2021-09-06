# frozen_string_literal: true

class NameBasedColor
  def initialize(name)
    @name = name
  end

  def to_s
    @to_s ||= begin
      hex = rgb_values.map { |value| value.to_s(16) }.join
      "##{hex}"
    end
  end

  def rgb_values
    @rgb_values ||= begin
      values = [[], [], []]

      @name.chars.each_with_index do |char, index|
        values[index % 3].push(char.ord)
      end

      values.map(&:sum).map { |v| v % 255 }
    end
  end
end
