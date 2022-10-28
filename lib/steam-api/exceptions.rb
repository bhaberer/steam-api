# frozen_string_literal: true

module Steam
  # Error returning the requested object from the Steam API
  class SteamError < StandardError
    def initialize(error = 'The API request has failed')
      super(error)
    end
  end

  # Error returning the requested object from the Steam API
  class UnavailableError < StandardError
    def initialize(error = 'The server is temporarily unable to service \
                            your request. Please try again later.')
      super(error)
    end
  end

  # Error returning the requested object from the Steam API
  class JSONError < StandardError
    def initialize(error = 'The API returned an unexpected JSON response')
      super(error)
    end
  end
end
