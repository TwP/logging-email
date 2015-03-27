## Logging Email Appender
by Tim Pease [![](https://secure.travis-ci.org/TwP/logging-email.png)](https://travis-ci.org/TwP/logging-email)

* [Homepage](http://rubygems.org/gems/logging-email)
* [Github Project](https://github.com/TwP/logging-email)

### Description

The Logging email appender provides a way to send log messages via email from
a Ruby application. This is useful if you wish to be notified of exceptions or
fatal errors as they arise.

The email appender was originally part of the Logging framework proper, but with
the release of Logging 2.0.0, it has been extracted into its own gem.

### Installation

The Logging framework uses the [little-plugger](https://github.com/twp/little-plugger)
gem based plugin system. All that needs to be done to start using the email
appender is to install the gem.

```
gem install logging-email
```

The plugin system will automatically detect and load the plugin when the Logging
framework is first initialized.

### Examples

The example below configures an email appender and gives it the name "gmail".
This name will be used later to add the appender to our logger.

The appender itself is configured to send email via the Google's Gmail servers.
This requires a user name and password; we load these from environment
variables. The Gmail SMTP servers also require `STARTTLS` to be enabled so that
TLS or SSL encryption can be used for communication.

The email appender is configured to buffer log messages. The log messages will
be sent in a single email when either 20 log messages have been buffered or one
minute has passed since the first log message was buffered. This helps reduce
the overall volume of email. The caveat here is that if there is a fatal error
and the application crashes, these log message **will not** be sent out via
email; they will be lost.

```ruby
require 'logging'
Logging.init      # initialize the framework and load plugins

Logger.appenders.email 'gmail',
    :from       => "server@example.com",
    :to         => "developers@example.com",
    :subject    => "Application Error [#{%x(uname -n).strip}]",
    :address    => "smtp.gmail.com",
    :port       => 443,
    :domain     => "gmail.com",
    :user_name  => ENV["GMAIL_USER"],
    :password   => ENV["GMAIL_PASS"],
    :authentication => :plain,
    :enable_starttls_auto => true,
    :auto_flushing => 20,      # send an email after 20 messages have been buffered
    :flush_period  => 60,      # send an email after one minute
    :level         => :error   # only process log events that are "error" or "fatal"

logger = Logging.logger['example_logger']
logger.level = :info

logger.add_appenders \
    Logging.appenders['gmail'],             # lookup the gmail email appender
    Logging.appenders.file('example.log')

logger.debug "this debug message will not be output by the logger"
logger.info "just some friendly advice"
logger.error exception                      # this `exception` will be emailed
```

### Development

The `logging-email` source code relies on the Mr Bones project for default rake
tasks. You will need to install the Mr Bones gem if you want to build or test
the `logging-email` gem. Conveniently there is a bootstrap script that you can
run to setup your development environment.

```
script/bootstrap
```

This will install the Mr Bones gem and the required Ruby gems for development.
After this is done you can rake `rake -T` to see the available rake tasks.

### License

The MIT License

Copyright (c) 2015 Tim Pease

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
