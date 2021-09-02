# frozen_string_literal: true

class BaseFormPageComponent < PageComponent
  include Base::FormComponent

  def url
    if record.id
      return urls.to(record)
    end

    index_path
  end

  def form_key
    @form_key ||= record.class.to_s.underscore.tr('db/', '')
  end

  private

  def select_input(form, name, collection)
    form.input name, collection: collection, include_blank: true
  end

  def index_link_name
    t("app.links.#{form_key.pluralize}")
  end

  def index_path
    urls.send("#{form_key.pluralize}_path", current_user)
  end
end
