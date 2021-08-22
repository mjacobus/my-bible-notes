# frozen_string_literal: true

class TestFactories
  class Db::UserFactory < TestFactories::Factory
    def attributes(overrides = {})
      {
        name: "User-#{seq}",
        username: "user-#{seq}",
        avatar: 'https://lh3.googleusercontent.com/-QTW2nlN4-NU/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucnAmijxFSFomGTNwgC-PRjxi5qPVg/s10-c/x.jpg'
      }.merge(overrides)
    end
  end
end
