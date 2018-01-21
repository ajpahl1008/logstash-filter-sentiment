# logstash-filter-sentiment (beta)
A basic sentiment analysis filter for Logstash Pipelines based on 7compass' sentiment library for ruby.  You can checkout their code here: https://github.com/7compass/sentimental

# Prerequisites
git, ruby

# Download & Compile
```
# git clone http://github.com/ajpahl1008/logstash-filter-sentiment.github
# cd logstash-filter-sentimental
# gem clean; gem build logstash-filter-sentiment.gemspec
```
This will create logstash-filter-sentiment-6.1.1.gem

# Installation
```
cd ${LOGSTASH_DIR}
bin/logstash-plugin install ${PATH_TO_GEM}
```

# Example #1 Default Logstash Config
In this example, the sentiment defaults to the message field in the event.
```
input {...}

filter {
  sentiment { }
}

output {...}

```

# Example #2 Specify a field for analysis
In this example, the sentiment is targeted on the title field.
```
input {...}

filter {
  sentiment { target_field => "title" }
}

output {...}

```

# Example output (running in debug)
Starting logstash (with plugin installed) in debug mode
```
bin/logstash -e 'input { stdin{codec => json_lines} } filter { sentiment { target_field => "title"} } output {stdout { codec => rubydebug }}'
```
Manually enter a JSON Doc: {"title":"I'm very happy with this"} (Hit enter)
```
{
           "@version" => "1",
          "sentiment" => :positive,
              "title" => "I'm very happy with this",
    "sentiment_score" => 0.4063,
               "host" => "mylaptop.local",
         "@timestamp" => 2018-01-21T19:20:31.459Z
}

```
Manually enter a JSON Doc: {"title":"I am so sad"} (Hit enter)
```
{"title":"I am so sad"}
{
           "@version" => "1",
          "sentiment" => :negative,
              "title" => "I am so sad",
    "sentiment_score" => -0.33330000000000004,
               "host" => "mylaptop.local",
         "@timestamp" => 2018-01-21T19:21:55.242Z
}

```
Manually enter a JSON Doc: {"title":"meh"} (Hit enter)
```
{
           "@version" => "1",
          "sentiment" => :neutral,
              "title" => "meh",
    "sentiment_score" => 0.0,
               "host" => "mylaptop.local",
         "@timestamp" => 2018-01-21T19:23:17.753Z
}
```
Try entering a blank doc: { } (Hit enter)
```
logstash-filter-sentiment: WARNING: target_field 'title' does not exist in event
{
      "@version" => "1",
          "host" => "mylaptop.local",
    "@timestamp" => 2018-01-21T19:24:40.230Z
}
```
