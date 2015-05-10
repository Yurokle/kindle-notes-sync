class TextItem
  attr_reader :book, :meta, :location, :created_at, :highlight

  def initialize text
    @text = text
    parse
  end

  def highlight?
    @meta.include? 'Highlight'
  end

  def bookmark?
    @meta.include? 'Bookmark'
  end

  protected

  def parse
    @lines = @text.split("\n")
    @book = @lines.first
    @meta, @location, @created_at = @lines[1].split('|').map(&:strip)
    @highlight = @lines[3].strip if highlight?
  end
end