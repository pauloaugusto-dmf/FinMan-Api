require 'logging'

# Rails.logger = Logging.logger(STDOUT)

appender = Logging.appenders.file("#{Rails.root}/log/logging_#{Rails.env}.log")

appender.layout = Logging.layouts.pattern(
  pattern: '[%d] %-5l %c: %m\n',
  color_scheme: 'bright'
)

Logging.color_scheme('bright',
                     levels: {
                       info: :green,
                       warn: :yellow,
                       error: :red,
                       fatal: %i[white on_red]
                     },
                     date: :blue,
                     logger: :cyan,
                     message: :white)

Logging.logger.root.appenders = [appender]
