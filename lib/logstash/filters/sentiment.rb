require "logstash/filters/base"
require "logstash/namespace"
require "sentimental"

class LogStash::Filters::Sentiment < LogStash::Filters::Base

  config_name "sentiment"
  config :target_field, :validate => :string, :default => "message"

  public
  def register

  end

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


    filter_matched(event)
  end
end
