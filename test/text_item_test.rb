require 'test_helper'
require 'text_item'

class TextItemTest < Minitest::Test
  def test_parsing_highlight_with_page
    highlight = <<-END
Любовь к трем цукербринам (Виктор Олегович Пелевин)
- Your Highlight on Location 6896 | Added on Thursday, March 26, 2015 1:20:28 PM

Краудфандинга не хватало даже на дауншифтинг.
    END

    text_item = TextItem.new(highlight)
    assert text_item.highlight?
    assert_equal text_item.book, 'Любовь к трем цукербринам (Виктор Олегович Пелевин)'
    assert_equal text_item.book_title, 'Любовь к трем цукербринам'
    assert_equal text_item.book_author, 'Виктор Олегович Пелевин'

    assert text_item.highlight?
    assert_equal text_item.kind, 'Highlight'
    assert_equal text_item.location, '6896'
    assert_nil text_item.page
    assert_equal text_item.created_at.to_i, Time.gm(2015, 3, 26, 13, 20, 28).to_i

    assert_equal text_item.content, 'Краудфандинга не хватало даже на дауншифтинг.'
  end

  def test_parsing_highlight_without_page
    highlight = <<-END
The Clean Coder: A Code of Conduct for Professional Programmers (Robert C. Martin Series) (Martin, Robert C.)
- Your Highlight on page 462 | Location 7072-7072 | Added on Monday, May 4, 2015 8:35:09 AM

Random text or something
    END

    text_item = TextItem.new(highlight)
    assert text_item.highlight?
    assert_equal text_item.book, 'The Clean Coder: A Code of Conduct for Professional Programmers (Robert C. Martin Series) (Martin, Robert C.)'
    assert_equal text_item.book_title, 'The Clean Coder: A Code of Conduct for Professional Programmers (Robert C. Martin Series)'
    assert_equal text_item.book_author, 'Martin, Robert C.'

    assert text_item.highlight?
    assert_equal text_item.kind, 'Highlight'
    assert_equal text_item.location, '7072-7072'
    assert_equal text_item.page, '462'
    assert_equal text_item.created_at.to_i, Time.gm(2015, 5, 4, 8, 35, 9).to_i

    assert_equal text_item.content, 'Random text or something'
  end

  def test_bookmark_parsing
    bookmark = <<-END
Бегущий по лезвию бритвы (Мечтают ли андроиды об электроовцах?) (Филип Киндред Дик)
- Your Bookmark on Location 3548-3550 | Added on Saturday, July 26, 2014 1:44:29 AM


    END

    text_item = TextItem.new(bookmark)

    assert_equal text_item.book, 'Бегущий по лезвию бритвы (Мечтают ли андроиды об электроовцах?) (Филип Киндред Дик)'
    assert_equal text_item.book_title, 'Бегущий по лезвию бритвы (Мечтают ли андроиды об электроовцах?)'
    assert_equal text_item.book_author, 'Филип Киндред Дик'

    assert text_item.bookmark?
    assert_equal text_item.kind, 'Bookmark'
    assert_equal text_item.location, '3548-3550'
    assert_nil text_item.page
    assert_equal text_item.created_at.to_i, Time.gm(2014, 7, 26, 1, 44, 29).to_i

    assert_nil text_item.content
  end

  def test_note_parsing
    bookmark = <<-END
Любовь к трем цукербринам (Виктор Олегович Пелевин)
- Your Note on Location 5963 | Added on Sunday, May 10, 2015 7:31:34 PM

Замтка или как?
    END

    text_item = TextItem.new(bookmark)

    assert_equal text_item.book, 'Любовь к трем цукербринам (Виктор Олегович Пелевин)'
    assert_equal text_item.book_title, 'Любовь к трем цукербринам'
    assert_equal text_item.book_author, 'Виктор Олегович Пелевин'

    assert text_item.note?
    assert_equal text_item.kind, 'Note'
    assert_equal text_item.location, '5963'
    assert_nil text_item.page
    assert_equal text_item.created_at.to_i, Time.gm(2015, 5, 10, 19, 31, 34).to_i

    assert_equal text_item.content, 'Замтка или как?'
  end
end