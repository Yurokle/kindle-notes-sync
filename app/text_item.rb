# Warning
# TextItem#created_at should used always in UTC timezone,
# since kindle doesn't store timezone tag and it's considered to be in user-set device timezone.

# Sample #1:
# The Clean Coder: A Code of Conduct for Professional Programmers (Robert C. Martin Series) (Martin, Robert C.)
# - Your Highlight on page 462 | Location 7072-7072 | Added on Monday, May 4, 2015 8:35:09 AM
#
# Random text or something

# Sample #2:
# Любовь к трем цукербринам (Виктор Олегович Пелевин)
# - Your Highlight on Location 6896 | Added on Thursday, March 26, 2015 1:20:28 PM
#
# Краудфандинга не хватало даже на дауншифтинг.

require 'time'

class TextItem
  attr_reader :book, :book_title, :book_author, :kind, :page, :location, :content, :created_at

  def initialize text
    @text = text
    parse
  end

  def blank?
    @content == nil || @content == ''
  end

  def highlight?
    @kind == 'Highlight'
  end

  def bookmark?
    @kind == 'Bookmark'
  end

  def note?
    @kind == 'Note'
  end

  protected

  def parse
    @lines = @text.split("\n")
    @book, @meta, _, @content = @lines

    @book_title, @book_author = @book.scan(/(.*)\s\((.*)\)/)[0]

    @kind = @meta.scan(/Your (\w+) on/)[0][0]
    @location = @meta.scan(/Location (\d+(\-\d+)?)/)[0][0]
    @page = @meta.scan(/page (\d+)/) && $1
    @created_at = @meta.scan(/Added on (.*)$/) && $1 && Time.parse("#{$1} UTC")

    @content = @content.strip unless @content.nil?
  rescue => ex
    raise %{Error raised #{ex.inspect}, unable to parse "#{@text}"}
  end
end