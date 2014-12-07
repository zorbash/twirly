FactoryGirl.define do
  factory :trello_member, class: Trello::Member do
    skip_create

    id { SecureRandom.hex }
    username { Faker::Internet.user_name }
    email { Faker::Internet.free_email }
    bio { Faker::Lorem.sentence }

    initialize_with do
      member = Trello::Member.new
      attributes.each_pair { |k, v| member.attributes[k] = v }
      member
    end
  end
end
