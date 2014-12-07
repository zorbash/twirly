module Twirly
  class Compiler
    def pull
      Twirly::Post.published.each do |post|
        output_path = File.join Twirly.source_dir, "#{post.slug}.html.md.erb"
        puts "Creating #{output_path}"

        File.open(output_path, 'w') { |out| out << post.to_md }
      end
    end
  end
end
