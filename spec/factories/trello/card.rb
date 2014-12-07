FactoryGirl.define do
  sequence :short_id
end

FactoryGirl.define do
  factory :trello_card, class: Trello::Card do
    skip_create

    id { SecureRandom.hex }
    short_id
    name { "some card - #{short_id}" }
    desc  "---\ntags: pathway to [_], wesser\n---\n\n{% youtube 6TncafSqfyo %}"
    due { Time.now }
    closed false
    url "https://trello.com/c/NrYMTajk/6-the-mushrooms-yard-of-my-head"
    short_url "https://trello.com/c/NrYMTajk"
    board_id "53779c553c97bc8a506f83df"
    member_ids ["51597b21213b313631005042"]
    list_id "53779c553c97bc8a506f83e0"
    pos nil
    last_activity_date { Time.now }
    card_labels []
    labels []
    cover_image_id nil

    association :attachments, factory: :trello_attachment

    trait :published do
      due { (DateTime.now - 1).to_time }

      card_labels do
        [ { name: 'published' } ]
      end

      labels do
        [ { name: 'published' } ]
      end
    end

    trait :unpublished do
      due nil
    end

    trait :with_attachments do
      after(:create) do |card|
        card.stub(:attachments).and_return create_list(:trello_attachment, 5)
      end
    end

    initialize_with do
      card = Trello::Card.new
      attributes.each_pair { |k, v| card.attributes[k] = v }
      card
    end
  end
end
