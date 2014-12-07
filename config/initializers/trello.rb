Trello.configure do |config|
  config.developer_public_key = Twirly::SETTINGS[:trello_key]
  config.member_token         = Twirly::SETTINGS[:trello_secret]
end
