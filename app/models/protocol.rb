require "prawn/measurement_extensions"
require "redcarpet/render_strip"

class Protocol < ActiveRecord::Base
	has_many :topics
	accepts_nested_attributes_for :topics
	has_many :tags, through: :topics
	
	accepts_nested_attributes_for :topics, reject_if: Proc.new{|attributes| attributes['headline'].blank? and attributes['text'].blank?}

	def filename
		"Protokoll-#{dateCreated}"
	end

	def to_pdf!
		markdown = Redcarpet::Markdown.new(RendererMarkdownPDF, autolink: true, tables: false)
		code = ""

		topics.each do |topic|
			code << "pdf.text '#{topic.headline}', size: 16.pt, style: :bold\n" 
			code << "pdf.move_down 5.mm\n" 
			code << markdown.render("#{topic.text}")
			code << "pdf.move_down 10.mm\n"
		end

		code = code.gsub(/<\/(b|i|u|li|ul)>\n/, '</\1>')

		puts code

		pdf = Prawn::Document.new(page_size: 'A4', margin: 20.mm)
		
		pdf.font("Helvetica", :size => 10)
		pdf.text "Protokoll #{dateCreated}"
		pdf.move_down 20.mm

		eval code
		pdf.render
	end

	class RendererMarkdownPDF < Redcarpet::Render::StripDown
	 # Methods where the first argument is the text content
	 [
	   # block-level calls
	   :block_code, :block_quote,
	   :block_html, :list, :list_item,

	   # span-level calls
	   :autolink, :codespan, :double_emphasis,
	   :emphasis, :underline, :raw_html,
	   :triple_emphasis, :strikethrough,
	   :superscript,

	   # footnotes
	   :footnotes, :footnote_def, :footnote_ref,

	   # low level rendering
	   :entity, :normal_text
	 ].each do |method|
	   define_method method do |*args|
	     args.first
	   end
	 end

	 # Other methods where we don't return only a specific argument
	 def link(link, title, content)
	   "<u><link href='#{link}'>#{content}</link></u>"
	 end

	 def header(text, header_level)
	 	size = "10.pt"
	   case header_level
	   when 1
	   	size = "16.pt"
	   when 2
	   	size = "14.pt"
	   when 3
	   	size = "12.pt"
	   when 5
	   	size = "9.pt"
	   when 6
	   	size = "8.pt"	   		
	   else
	   	size = "10.pt"
	   end
	   "pdf.text '#{text}', inline_format: :true, size: " + size + ", style: :bold\npdf.move_down 5.mm\n"
	 end

	 def paragraph(text)
	   "pdf.text '#{text}', inline_format: :true\n"
	 end

	 def triple_emphasis(text)
	   "<b><i>#{text}</i></b>"
	 end

	 def double_emphasis(text)
	   "<b>#{text}</b>"
	 end

	 def emphasis(text)
	   "<i>#{text}</i>"
	 end

	 def underline(text)
	   "<u>#{text}</u>"
	 end

	 def normal_text(text)
	   "#{text}"
	 end

	 def block_quote(text)
	   "pdf.text_box '" + "#{text}'\n".gsub("', inline_format: :true\n",'').gsub("pdf.text '",'').rstrip + ", at: [10.mm, pdf.cursor]\npdf.move_down 20.pt\n"
	 end

	 def list(text, something)
	   "pdf.move_down 10.pt\n#{text}"
	 end

	 def list_item(text, list_level)
	 	# FIXME: text_box mit Variabler Höhe beachten, derzeit nur "einzeilig", d.h. movedown um 20.pt pro Spiegelstrich
	   "pdf.fill_circle  [7.mm, pdf.cursor - 4], 2\npdf.text_box '" + "#{text}'\n".gsub("', inline_format: :true\n",'').gsub("pdf.text '",'').gsub("\n",'') + ", at: [10.mm, pdf.cursor]\npdf.move_down 20.pt\n"
	 end

	end
end
