FactoryGirl.define do
  factory :post, class: Twirly::Post do
    skip_create

    initialize_with do
      Twirly::Post.new(FactoryGirl.create(:trello_card, :with_attachments))
    end
  end
end
