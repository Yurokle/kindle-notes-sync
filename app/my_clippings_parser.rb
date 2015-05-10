class MyClippingsParser
  def initialize file_path
    @file_path = file_path
  end

  def items
    @items ||= begin
      file_body = File.read(@file_path).gsub(/\r\n/, "\n")
      file_body.split("==========\n").map{ |node| TextItem.new(node) }
    end
  end

  def highlights
    @highlights = items.find_all(&:highlight?)
  end

  def bookmarks
    @bookmarks = items.find_all(&:bookmark?)
  end
end