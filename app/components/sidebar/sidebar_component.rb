# frozen_string_literal: true

# Icons: https://icons.getbootstrap.com/

class Sidebar::SidebarComponent < ApplicationComponent
  def render?
    current_user
  end

  def menu_entries
    [
      home_link,
      timeline_section,
      admin_section,
      profile,
      logout
    ].compact
  end

  private

  def home_link
    entry(t('app.links.home'), root_path, icon: 'house-door')
  end

  def profile
    entry(t('app.links.profile'), profile_path, icon: 'person-badge')
  end

  def timeline_section
    unless current_user.pending_profile_changes?
      entry(t('app.links.timelines'), '#', icon: 'clock-history').tap do |section|
        section.append_child(timelines_path)
      end
    end
  end

  def admin_section
    if current_user.master?
      entry('Admin', '#', icon: 'pencil').tap do |section|
        section.append_child(users)
        section.append_child(admin_users)
      end
    end
  end

  def timelines_path
    entry(Db::Timeline.model_name.human, urls.timelines_path(current_user), icon: 'clock-history')
  end

  def users
    entry(Db::User.model_name.human, users_path, icon: 'people')
  end

  def admin_users
    entry(Db::User.model_name.human, admin_db_users_path, icon: 'people')
  end

  def logout
    entry(t('app.links.logout'), '/logout', icon: 'door-open')
  end

  def entry(text, url, **args)
    Sidebar::MenuEntry.new(text, url, **args)
  end
end
