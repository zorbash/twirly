FactoryGirl.define do
  factory :user, class: Twirly::User do
    skip_create

    initialize_with do
      Twirly::User.new(FactoryGirl.create(:trello_member))
    end
  end
end
