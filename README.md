# logstash-filter-sentiment
Sentiment Filter for Logstash Pipelines

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
