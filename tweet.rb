require File.expand_path('../boot', __FILE__)

tweets = open("tweets.txt").read.encode('UTF-8').split("\n").delete_if {|tweet| tweet.strip.empty? }
sleep_time = 1800

loop do
  tweet = tweets.pop
  puts "#{tweet}\nnext tweet is #{Time.now + sleep_time}"
  Twitter.update tweet
  sleep(sleep_time)
  tweets.unshift(tweet)
end
