require 'rubygems'
require 'test/unit'

class RegExTest < Test::Unit::TestCase
  def change_alphabet(str)
    rz = str.gsub(/—/) do |word|
      word = '-'
    end
    return rz
  end
  def escape(str)
    rz = str.gsub(/-/) do |word|
      word = '\\'+word
    end
    return rz
  end
  def test_slush
    input = 'a:a-b'
    assert_not_equal(nil, /-/ =~ input)
    
    input = 'Linus Torvalds\'s style of development—release early and often, delegate everything you can, be open to the point of promiscuity—came as a surprise.'
    input = change_alphabet(input)
    assert_not_equal(nil, /-/ =~ input)
    input = escape(input)
    output = 'Linus Torvalds\'s style of development\-release early and often, delegate everything you can, be open to the point of promiscuity\-came as a surprise.'
    
    assert_equal(output, input)
    
    input = "I had released a good deal of open-source software onto the net, developing or co-developing several programs (nethack, Emacs's VC and GUD modes, xlife, and others) that are still in wide use today."
    change_alphabet input
    escape input
    puts input
  end
end