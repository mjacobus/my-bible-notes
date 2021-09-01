# frozen_string_literal: true

class Scriptures::IndexPageComponent < PageComponent
  include MenuAwareComponent
  has :scriptures
  paginate :scriptures
  has :owner
  menu_type :item_options

  private

  def menu_items(menu)
    []
  end

  def delete_warning
    t('app.messages.confirm_delete')
  end
end
