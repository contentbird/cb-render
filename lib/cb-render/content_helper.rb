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
    image_url = options[:summary] ? thumbnail_url(data['value']) : data['value']
    content_tag :figure, class: "cb-type-image cb-prop-#{name} #{options[:wrapper_class]}" do
      image_tag image_url, alt: data['title']
    end
  end

  def display_image_gallery_property name, data, options={}
    if options[:summary]
      display_first_gallery_image name, data, options
    else
      options  = default_options.merge(options)
      if data['value'].present?
        content_tag :div, class: "row cb-type-img_gal cb-prop-#{name}" do
          content_tag :ul, class: "_images" do
            data['value'].each do |image|
              concat(content_tag(:li, nil, class: "image-container _imageContainer", data: {image: image['url'], legend: image['legend']}) do
                content_tag :figure do
                  content_tag :div, class: 'image-content', style: "background-image: url(#{thumbnail_url(image['url'])}); padding-bottom: 30px" do
                    if image['legend'].present?
                      content_tag :figcaption do
                        image['legend']
                      end
                    end
                  end
                end
              end)
            end
          end
        end
      end
    end
  end

  def display_first_gallery_image name, data, options={}
    image_data = {'value' => data['value'].first['url'], 'title' => data['value'].first['legend']}
    display_image_property(name, image_data, options)
  end

  def display_text_property name, data, options={}
    options  = default_options.merge(options)
    content_tag :p, class: "cb-type-text cb-prop-#{name} #{options[:wrapper_class]}" do
      if options[:display_label]
        "#{data['title']}: #{data['value']}"
      else
        data['value']
      end
    end
  end

  def display_memo_property name, data, options={}
    options  = default_options.merge(options)
    content_tag :p, class: "cb-type-memo cb-prop-#{name}" do
      if options[:display_label]
        raw("#{data['title']}: #{simple_format(data['value'])}")
      else
        simple_format(data['value'])
      end
    end
  end

  def display_email_property name, data, options={}
    options  = default_options.merge(options)
    content_tag :p, class: "cb-type-email cb-prop-#{name} #{options[:wrapper_class]}" do
      if options[:display_label]
        raw("#{data['title']}: <a href=\"mailto:#{data['value']}\">#{data['value']}</a>")
      else
        data['value']
      end
    end
  end

  def display_tel_property name, data, options={}
    options  = default_options.merge(options)
    content_tag :p, class: "cb-type-tel cb-prop-#{name}" do
      if options[:display_label]
        "#{data['title']}: #{data['value']}"
      else
        data['value']
      end
    end
  end

  def display_url_property name, data, options={}
    options  = default_options.merge(options)
    content_tag :p, class: "cb-type-url cb-prop-#{name}" do
      if options[:display_label]
        raw("#{data['title']}: <a href=\"#{data['value']}\" target=\"_blank\">#{data['value']}</a>")
      else
        data['value']
      end
    end
  end

  def display_markdown_property name, data, options={}
    content_tag :div, class: "cb-type-markdown cb-prop-#{name}" do
      markdown data['value'], options
    end
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

  def thumbnail_url url
    return nil if url.nil?
    url.gsub(/(?<path>.*)\.([a-z|A-Z]*)$/, '\k<path>_thumb.jpg')
  end
end