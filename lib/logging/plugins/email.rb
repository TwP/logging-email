module Logging
  module Plugins
    module Email
      extend self

      VERSION = '0.0.1'.freeze

      # This method will be called by the Logging framework when it first
      # initializes. Here we require the email appender code.
      def initialize_email
        require File.expand_path('../../appenders/email', __FILE__)
      end
    end
  end
end
