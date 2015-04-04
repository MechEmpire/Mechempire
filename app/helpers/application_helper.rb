module ApplicationHelper
  def markdown(text)
    options = {   
        :autolink => true, 
        :space_after_headers => true,
        :fenced_code_blocks => true,
        :no_intra_emphasis => true,
        :hard_wrap => true,
        :strikethrough =>true,
        :tables => true
      }
      # Redcarpet::Markdown.new(renderer, extensions = {})
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,options)
    markdown.render(h(text)).html_safe
  end

  # class HTMLwithCodeRay < Redcarpet::Render::HTML
  #   def block_code(code, language)
  #     CodeRay.scan(code, language).div(:tab_width=>2)
  #   end
  # end
end
