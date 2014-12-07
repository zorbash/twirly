FactoryGirl.define do
  factory :trello_board, class: Trello::Board do
    skip_create

    id { SecureRandom.hex }
    short_id
    name { "some board - #{short_id}" }
    description 'this board is so great'
    closed false
    url "https://trello.com/b/NrYMTajk/foo-bar"
    short_url "https://trello.com/b/NrYMTajk"
    organization_id "53779c553c97bc8a506f83df"

    initialize_with do
      board = Trello::Board.new
      attributes.each_pair { |k, v| board.attributes[k] = v }
      board
    end
  end
end
