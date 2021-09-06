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
      bible_section,
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

  def bible_section
    unless current_user.pending_profile_changes?
      entry(t('app.links.bible'), '#', icon: 'book').tap do |section|
        section.append_child(scriptures_path)
        section.append_child(scripture_tags)
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
    entry(t('app.links.timelines'), urls.timelines_path(current_user), icon: 'clock-history')
  end

  def scriptures_path
    entry(t('app.links.my_scriptures'), urls.scriptures_path(current_user), icon: 'book')
  end

  def scripture_tags
    entry(t('app.links.tags'), urls.scripture_tags_path(current_user), icon: 'tag')
  end

  def users
    entry(t('app.links.users'), users_path, icon: 'people')
  end

  def admin_users
    entry(t('app.links.users'), admin_db_users_path, icon: 'people')
  end

  def logout
    entry(t('app.links.logout'), '/logout', icon: 'door-open')
  end

  def entry(text, url, **args)
    Sidebar::MenuEntry.new(text, url, **args)
  end
end
