# encoding: utf-8
require 'spec_helper'
#require "logstash/filters/sentiment"

describe LogStash::Filters::Sentiment do
  describe "Set to Hello World" do
    let(:config) do <<-CONFIG
      filter {
        sentiment {
          message => "Hello World"
        }
      }
    CONFIG
    end

    sample("message" => "some text") do
      expect(subject.get("message")).to eq('Hello World')
    end
  end
end
