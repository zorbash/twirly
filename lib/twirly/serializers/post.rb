module Twirly
  module Serializers
    module Post
      def as_json
        { post: {
            card_id:       card_id,
            title:         title,
            category:      category,
            tags:          tags,
            updated_at:    updated_at,
            published_at:  published_at
          }
        }
      end

      def to_json
        as_json.to_json
      end
    end
  end
end
