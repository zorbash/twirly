module Twirly
  module Serializers
    module User
      def as_json
        { user: {
            id:         id,
            username:   username,
            full_name:  full_name,
            bio:        bio,
            avatar_url: avatar_url,
          }
        }
      end

      def to_json
        as_json.to_json
      end
    end
  end
end
