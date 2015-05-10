require 'test_helper'
require 'text_item'

class TextItemTest < Minitest::Test
  def setup
    clippings_path = File.expand_path '../assets/clippings_test.txt', __FILE__
    @clippings = File.read(clippings_path).split "==========\n"
  end

  def test_highlight_parsing
    highlight = <<-END
Любовь к трем цукербринам (Виктор Олегович Пелевин)
- Your Highlight on Location 6896-6896 | Added on Thursday, March 26, 2015 1:20:28 PM

Краудфандинга не хватало даже на дауншифтинг.
    END

    assert TextItem.new(highlight).highlight?
  end

  def test_bookmark_parsing
    bookmark = <<-END
Бегущий по лезвию бритвы (Мечтают ли андроиды об электроовцах?) (Филип Киндред Дик)
- Your Bookmark on Location 3548 | Added on Saturday, July 26, 2014 1:44:29 AM


    END
    assert TextItem.new(bookmark).bookmark?
  end
end