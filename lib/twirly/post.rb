module Twirly
  class Post < SimpleDelegator
    include Twirly::Serializers::Post

    define_method(:alias_attribute, &Trello::Card.method(:alias_attribute).to_proc)

    alias :card :__getobj__

    alias_attribute :title, :name
    alias_attribute :updated_at, :last_activity_date
    alias_attribute :created_at, :due
    alias_attribute :published_at, :due
    alias_attribute :card_id, :short_id

    def category; card.list.name end

    def tags
      labels.map(&:name).reject { |label| label == 'published' }
    end

    def existing_front_matter
      @existing_front_matter ||= card.desc.scan(/(---.*---)/mi).flatten.first
    end

    def processed_front_matter
      @processed_front_matter =
      begin
        matter = YAML::load(existing_front_matter || '{}')
        matter[:title] = title
        matter[:slug] = slug
        matter[:category] = category
        matter[:date] = short_published_at
        matter[:tags] = tags.join(', ')
        matter[:authors] = authors.map(&:username).join(', ')
        matter[:attachments] = attachments.map(&:url).join(', ') if card.attachments.any?
        matter
      end
    end

    def body
      @body ||= Liquid::Template.parse(card.desc.sub(/---.*---/mi, '').strip).render
    end

    def published_at
      due || updated_at
    end

    def short_published_at
      published_at.strftime('%Y-%m-%d')
    end

    def published?
      card.labels.any? { |label| label.name == 'published' }
    end

    def slug
      "#{short_published_at}-#{title.parameterize}-#{card_id}"
    end

    def authors
      members.map { |member| Twirly::User.new(member) }
    end

    def front_matter
      "#{processed_front_matter.to_yaml}\n---"
    end

    def to_md
      "#{front_matter}\n\n#{body}"
    end

    class << self
      def published
        Twirly.board.cards.map { |card|
          post = Post.new(card)
          if post.published? then post else nil end
        }.compact.sort { |p1, p2| p2.published_at <=> p1.published_at }
      end

      def find(id)
        Post.new(Twirly.board.cards.find { |card| card.short_id == id })
      end
    end
  end
end
