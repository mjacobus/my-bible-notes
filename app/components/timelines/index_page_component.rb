# frozen_string_literal: true

class Timelines::IndexPageComponent < PageComponent
  has :timelines
  paginate :timelines
end
