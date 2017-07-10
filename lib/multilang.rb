module Multilang
  def block_code(code, full_lang_name)
    rouge_lang_name = "json"
    super(code, rouge_lang_name).sub("highlight #{rouge_lang_name}") do |match|
      match + " tab-" + full_lang_name
    end
  end
end

require 'middleman-core/renderers/redcarpet'
Middleman::Renderers::MiddlemanRedcarpetHTML.send :include, Multilang
