require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
Twitter.configure do |config|
  config.consumer_key = '6V3etTdl8tpOKI2jI4tY5L7Zm'
  config.consumer_secret = 'UwSMkXWVyk8AfoH8Mn9JV3REAYsNqcROU1SxBL5SR07UvPOWpb'
#  config.oauth_token = 'terminal_21'
#  config.oauth_token_secret = '81910378'
end

search_term = URI::encode('#cccamp')

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    tweets = Twitter.search("#{search_term}").results

    if tweets
      tweets.map! do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_mentions', comments: tweets)
    end
#  rescue Twitter::Error
  rescue Twitter::Error => e
    puts "Twitter Error: #{e}"
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end
