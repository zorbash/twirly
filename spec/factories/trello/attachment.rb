FactoryGirl.define do
  factory :trello_attachment, class: Trello::Attachment do
    skip_create

    name { Faker::Lorem.word << '.png' }
    id { SecureRandom.hex }
    url 'https://trello-attachments.s3.amazonws.com/koko.png'
    bytes { Random.new.rand(100..100_100) }
    date { Time.now.to_s }
    is_upload true

    initialize_with do
      attachment = Trello::Attachment.new attributes.stringify_keys
      attachment
    end
  end
end
