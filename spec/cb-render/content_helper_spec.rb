require 'spec_helper'
require File.dirname(__FILE__) + '/../../lib/cb-render/content_helper'
require 'active_support/core_ext/string'
require 'action_view'

include ActionView::Helpers
include ActionView::Context

describe ContentHelper do
  include ContentHelper

  describe '#markdown' do
    it 'renders markdown with code embedded with or without code coloring, depending on the option passed' do
      text = "this **is**\n >multiline\n\n```ruby\ndef test\n  puts 'test'\nend\n```\n classy!"

      with_code_coloring = markdown(text, color_code: true)
      with_code_coloring.should eq "<p>this <strong>is</strong></p>\n\n<blockquote>\n<p>multiline</p>\n</blockquote>\n<div class=\"highlight\"><pre><span class=\"k\">def</span> <span class=\"nf\">test</span>\n  <span class=\"nb\">puts</span> <span class=\"s1\">&#39;test&#39;</span>\n<span class=\"k\">end</span>\n</pre></div>\n<p>classy!</p>\n"

      without_code_coloring = markdown(text)
      without_code_coloring.should eq "<p>this <strong>is</strong></p>\n\n<blockquote>\n<p>multiline</p>\n</blockquote>\n\n<pre><code class=\"ruby\" data-language=\"ruby\">def test\n  puts 'test'\nend\n</code></pre>\n\n<p>classy!</p>\n"
    end
  end

  describe '#display_content_property' do
    it 'renders text properties with their label and no transformation' do
      rendered = display_content_property('text_prop', {'title' => 'Text property', 'value' => 'this is text', 'type' => 'text'})
      rendered.should eq '<p class="cb-type-text cb-prop-text_prop ">Text property: this is text</p>'
    end

    it 'renders memo properties using simpleformat' do
      rendered = display_content_property('text_prop', {'title' => 'Memo property', 'value' => "this is\n multiline\ntext", 'type' => 'memo'})
      rendered.should eq "<p class=\"cb-type-memo cb-prop-text_prop\">Memo property: <p>this is\n<br /> multiline\n<br />text</p></p>"
    end

    it 'renders image properties displaying the image' do
      rendered = display_content_property('image_prop', {'title' => 'Image property', 'value' => "http://img.us/test.jpg", 'type' => 'image'})
      rendered.should eq '<figure class="cb-type-image cb-prop-image_prop "><img alt="Image property" src="http://img.us/test.jpg" /></figure>'
    end

    it 'renders markdown with code embedded with or without code coloring, depending on the option passed' do
      prop = {'title' => 'Markdown property', 'value' => "this **is**\n >multiline\n\n```ruby\ndef test\n  puts 'test'\nend\n```\n classy!", 'type' => 'markdown'}

      with_code_coloring = display_content_property('mark_prop', prop, color_code: true)
      with_code_coloring.should eq "<div class=\"cb-type-markdown cb-prop-mark_prop\"><p>this <strong>is</strong></p>\n\n<blockquote>\n<p>multiline</p>\n</blockquote>\n<div class=\"highlight\"><pre><span class=\"k\">def</span> <span class=\"nf\">test</span>\n  <span class=\"nb\">puts</span> <span class=\"s1\">&#39;test&#39;</span>\n<span class=\"k\">end</span>\n</pre></div>\n<p>classy!</p>\n</div>"

      without_code_coloring = display_content_property('mark_prop', prop)
      without_code_coloring.should eq "<div class=\"cb-type-markdown cb-prop-mark_prop\"><p>this <strong>is</strong></p>\n\n<blockquote>\n<p>multiline</p>\n</blockquote>\n\n<pre><code class=\"ruby\" data-language=\"ruby\">def test\n  puts 'test'\nend\n</code></pre>\n\n<p>classy!</p>\n</div>"
    end

    it 'renders image gallery properties displaying every images' do
      rendered = display_content_property('image_gallery_prop',
                                          {'title' => 'Image property',
                                           'value' => [{'url' => 'http://img.us/test.jpg', 'legend' => 'image test'},
                                                       {'url' => 'http://img.us/test2.jpg', 'legend' => 'image test 2'}],
                                           'type' => 'image_gallery'})

      rendered.should eq '<div class="cb-type-img_gal cb-prop-image_gallery_prop"><figure class="cb-type-image cb-prop-image_gallery_prop "><img alt="image test" src="http://img.us/test.jpg" /></figure><figure class="cb-type-image cb-prop-image_gallery_prop "><img alt="image test 2" src="http://img.us/test2.jpg" /></figure></div>'
    end

    it 'renders the first image using the legend as a title if summary option is passed' do
      rendered = display_content_property('image_gallery_prop',
                                          {'title' => 'Image property',
                                           'value' => [{'url' => 'http://img.us/test.jpg', 'legend' => 'image test'},
                                                       {'url' => 'http://img.us/test2.jpg', 'legend' => 'image test 2'}],
                                           'type' => 'image_gallery'}, summary: true)
      rendered.should eq '<figure class="cb-type-image cb-prop-image_gallery_prop "><img alt="image test" src="http://img.us/test.jpg" /></figure>'
    end
  end

end