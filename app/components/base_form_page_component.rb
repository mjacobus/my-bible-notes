# frozen_string_literal: true

class BaseFormPageComponent < PageComponent
  has :owner
  has :current_user

  def submit_button(form)
    form.submit(class: 'btn btn-primary mt-3 float-right')
  end

  def input_wrapper(&block)
    tag.div(class: 'form-wrapper my-3', &block)
  end

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

  def setup
    with_owner_breadcrumb
    breadcrumb.add(index_link_name, index_path)

    if record.id?
      breadcrumb.add(record.to_s, urls.to(record))
      breadcrumb.add(t('app.links.edit'))
      return
    end

    breadcrumb.add(t('app.links.new'))
  end

  def index_link_name
    t("app.links.#{form_key.pluralize.to_s}")
  end

  def index_path
    urls.send("#{form_key.pluralize}_path", current_user)
  end

  def self.record(name)
    has name

    define_method :record do
      send(name)
    end
  end
end
