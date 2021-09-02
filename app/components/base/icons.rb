# frozen_string_literal: true

module Base
  module Icons
    def icon(name, options = {}, &block)
      options[:class] = [options[:class], "bi bi-#{name}"].compact.join(' ')
      icon = tag.i('', **options)

      unless block
        return icon
      end

      icon + '&nbsp;'.html_safe + yield
    end
  end
end
