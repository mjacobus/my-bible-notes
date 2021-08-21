# frozen_string_literal: true

class Home::DashboardComponent < PageComponent
  def render?
    current_user
  end
end
