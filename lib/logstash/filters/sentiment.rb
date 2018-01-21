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
  config :target_field, :validate => :string, :default => "message"

  public
  def register
    # Add instance variables
  end # def register

  public
  def filter(event)

    if !event.get(target_field).nil?
       @logger.debug? && @logger.debug("Conducting Sentiment Analysis on Field: #{target_field}")

       analyzer = Sentimental.new
       analyzer.load_defaults
       sentiment = analyzer.sentiment event.get(target_field)
       score = analyzer.score event.get(target_field)
       @logger.debug? && @logger.debug(puts sentiment, score)

       event.set("sentiment", sentiment)
       event.set("sentiment_score", score)
    else
      puts "logstash-filter-sentiment: WARNING: target_field '#{target_field}' does not exist in event"
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Sentiment
