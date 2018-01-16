# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "sentimental"

# This example filter will replace the contents of the default
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an example.
class LogStash::Filters::Sentiment < LogStash::Filters::Base

  config_name "sentiment"
  # Replace the message with this value.
  # config :message, :validate => :string, :default => "HelloWorld!"

  public
  def register
    # Add instance variables
  end # def register

  public
  def filter(event)

    @logger.debug? && @logger.debug("Conducting Sentiment Analysis on Event String: #{event.get("message")}")

    analyzer = Sentimental.new
    analyzer.load_defaults
    sentiment = analyzer.sentiment event.get("message")
    score = analyzer.score event.get("message")
    @logger.debug? && @logger.debug(puts sentiment, score)

    event.set("sentiment", sentiment)
    event.set("sentiment_score", score)

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Sentiment
