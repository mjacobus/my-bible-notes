# frozen_string_literal: true

class Db::User < ApplicationRecord
  has_many :timelines, dependent: :destroy
  has_many :scriptures, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  def username=(value)
    super(value.to_s.parameterize)
  end

  def pending_profile_changes?
    username.blank?
  end

  def permissions
    @permissions ||= begin
      begin
        default_permissions_config.merge(JSON.parse(permissions_config.to_s))
      rescue JSON::ParserError
        default_permissions_config
      end
    end
  end

  def grant_controller_access(controller, action: '*')
    permissions['controllers'].push("#{controller}##{action}")
    self.permissions_config = permissions.to_json
  end

  # that is for active admin form
  def controller_accesses=(items)
    permissions['controllers'] = []
    Array.wrap(items).compact.reject { |i| i == '#' }.each do |item|
      parts = item.split('#')
      grant_controller_access(parts[0], action: parts[1])
    end
  end

  # that is for active admin form
  def controller_accesses
    permissions['controllers']
  end

  def is?(other_user)
    other_user.is_a?(self.class) && other_user.id == id
  end

  private

  def default_permissions_config
    { controllers: [] }.stringify_keys
  end

  def update_permissions
    self.permissions_config = permissions.to_json
  end
end
