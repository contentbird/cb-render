require 'redcarpet'
require 'pygments.rb'

module ContentHelper
  def default_options
    {display_label: true}
  end

  def display_content_property name, data, options={}
    self.send("display_#{data['type']}_property", name, data, options)
  end

  def display_image_property name, data, options={}
    options  = default_options.merge(options)
    content_tag :figure, class: options[:wrapper_class] do
      image_tag data['value'], alt: data['title']
    end
  end

  def display_text_property name, data, options={}
    options  = default_options.merge(options)
    content_tag :p, class: options[:wrapper_class] do
      if options[:display_label]
        "#{data['title']}: #{data['value']}"
      else
        data['value']
      end
    end
  end

  def display_memo_property name, data, options={}
    options  = default_options.merge(options)
    content_tag :p do
      if options[:display_label]
        raw("#{data['title']}: #{simple_format(data['value'])}")
      else
        simple_format(data['value'])
      end
    end
  end

  def display_markdown_property name, data, options={}
    markdown data['value'], options
  end

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer:language)
    end
  end

  class HTMLwithoutPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      "\n<pre><code class=\"#{language}\" data-language=\"#{language}\">#{code}</code></pre>\n"
    end
  end

  def markdown text, options={}
    markdown_options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }

    if options[:color_code]
      renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)
    else
      renderer = HTMLwithoutPygments.new(hard_wrap: true, filter_html: true)
    end

    html = Redcarpet::Markdown.new(renderer, markdown_options).render(text)
    html.html_safe
  end
end