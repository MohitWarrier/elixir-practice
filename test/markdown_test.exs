defmodule MarkdownTest do
  use ExUnit.Case

  # Headings
  test "h1 heading" do
    assert Markdown.to_html("# Hello") == "<h1>Hello</h1>"
  end

  test "h2 heading" do
    assert Markdown.to_html("## World") == "<h2>World</h2>"
  end

  test "h3 heading" do
    assert Markdown.to_html("### Sub") == "<h3>Sub</h3>"
  end

  # Bold and italic
  test "bold text" do
    assert Markdown.to_html("**hello**") == "<p><strong>hello</strong></p>"
  end

  test "italic text" do
    assert Markdown.to_html("*hello*") == "<p><em>hello</em></p>"
  end

  test "bold and italic in same line" do
    assert Markdown.to_html("**bold** and *italic*") == "<p><strong>bold</strong> and <em>italic</em></p>"
  end

  # Paragraph
  test "plain text becomes a paragraph" do
    assert Markdown.to_html("hello world") == "<p>hello world</p>"
  end

  # Unordered list
  test "single list item" do
    assert Markdown.to_html("- item") == "<ul><li>item</li></ul>"
  end

  test "multiple list items" do
    input = "- one\n- two\n- three"
    assert Markdown.to_html(input) == "<ul><li>one</li><li>two</li><li>three</li></ul>"
  end

  # Multi-line document
  test "heading followed by paragraph" do
    input = "# Title\nhello world"
    assert Markdown.to_html(input) == "<h1>Title</h1><p>hello world</p>"
  end

  test "full document" do
    input = "# Intro\nThis is **bold** text.\n- item one\n- item two"
    assert Markdown.to_html(input) ==
      "<h1>Intro</h1><p>This is <strong>bold</strong> text.</p><ul><li>item one</li><li>item two</li></ul>"
  end
end
