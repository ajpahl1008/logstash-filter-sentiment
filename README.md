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

# Example Logstash Config
```
input {...}

filter {
  sentiment { }  # That's all folks!!!
}

output {...}

```

# Example output (running in debug)
Starting logstash (with plugin installed) in debug mode
```
bin/logstash -e 'input { stdin{} } filter { sentiment {} } output {stdout { codec => rubydebug }}'
```
Type in a string ex: "I am very Happy"
```
I am very Happy
{
            "message" => "I am very Happy",
          "sentiment" => :positive,
    "sentiment_score" => 0.4063,
         "@timestamp" => 2018-01-16T18:20:42.791Z,
               "host" => "mylaptop.local",
           "@version" => "1"
}
```
Type in a string ex: "I am so sad"
```
I am so sad
{
            "message" => "I am so sad",
          "sentiment" => :negative,
    "sentiment_score" => -0.33330000000000004,
         "@timestamp" => 2018-01-16T18:21:13.187Z,
               "host" => "mylaptop.local",
           "@version" => "1"
}
```
Type in a string ex: meh
```
meh
{
            "message" => "meh",
          "sentiment" => :neutral,
    "sentiment_score" => 0.0,
         "@timestamp" => 2018-01-16T18:21:34.473Z,
               "host" => "mylaptop.local",
           "@version" => "1"
}
```
