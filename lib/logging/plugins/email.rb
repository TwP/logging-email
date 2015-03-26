
module Logging
  module Plugins
    module Email
      extend self

      VERSION = '1.0.0'.freeze

      def initialize_email
        require File.expand_path('../../appenders/email', __FILE__)
      end
    end
  end
end
