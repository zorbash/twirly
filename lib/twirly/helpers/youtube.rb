module Twirly
  module Helpers
    # Exposes a tag for liquid templates with the
    # following syntax
    #
    # {% youtube width height value %}
    class Youtube < Liquid::Tag
      def initialize(name, variables, tokens)
        super
        _parse_variables(variables)
      end

      def render(context)
        <<-VIDEO.strip_heredoc.strip
        <div class="embed-video-container">
          <iframe width="#{@width}" height="#{@height}"
                  src="http://www.youtube.com/embed/#{@id}">
          </iframe>
        </div>
        VIDEO
      end

      def _parse_variables(variables)
        parsed_variables = variables.split(' ')
        if parsed_variables.size == 3
          @width  = parsed_variables[0]
          @height = parsed_variables[1]
          @id     = parsed_variables[2]
        else
          @id     = parsed_variables.first
          @width  = 320
          @height = 280
        end
      end
    end
  end
end
