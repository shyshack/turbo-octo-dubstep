require 'test_helper'

class TranslationTest < ActiveSupport::TestCase
 
  def setup 
    @translation = Translation.new(first_language: "das Schmetterling", second_language: "motyl")
  end
  
  test "first language should not be empty" do 
    @translation.first_language = "           "
    assert_not @translation.valid?
  end
  
  test "second language should not be empty" do 
    @translation.second_language = ""
    assert_not @translation.valid?
  end
  
end
