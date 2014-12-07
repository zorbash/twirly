FactoryGirl.define do
  factory :trello_label, class: Trello::Label do
    skip_create

    name { "some label - #{short_id}" }
    color { %w(red green purple).sample }

    trait :published do
      name 'published'
      color 'green'
    end

    initialize_with do
      label = Trello::Label.new
      attributes.each_pair { |k, v| card.attributes[k] = v }
      label
    end
  end
end
