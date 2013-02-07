require 'bundler/setup'
Bundler.require(:default) if defined?(Bundler)

Dotenv.load

Twitter.configure do |config|
	config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
	config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
	config.oauth_token = ENV['TWITTER_ACCESS_TOKEN']
	config.oauth_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
end

tweets = open("tweets.txt").read.encode('UTF-8','Shift_JIS').split("\n").delete_if { |tweet| tweet.strip.empty? }

loop do
	tweet = tweets.pop
	sleep_time = 60*60
	puts "tweet #{tweet} (#{Time.now}) next (#{Time.now + sleep_time})"
	client = Twitter::Client.new
	client.update tweet
	sleep(sleep_time)
	tweets.unshift(tweet)
end
