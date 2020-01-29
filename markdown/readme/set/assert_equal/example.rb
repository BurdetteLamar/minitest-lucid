require 'minitest/autorun'
require 'set'

class Example < Minitest::Test

  require_relative 'data'

  def test_assert_equal
    begin
      assert_equal(expected, actual)
    rescue Minitest::Assertion => x
      File.open('default.txt', 'w') do |file|
        file.write(x.message)
      end
    end
    begin
      Minitest::Test.make_my_diffs_pretty!
      assert_equal(expected, actual)
    rescue Minitest::Assertion => x
      File.open('better.txt', 'w') do |file|
        file.write(x.message)
      end
    end

    begin
      require 'minitest/lucid'
      assert_equal(expected, actual)
    rescue Minitest::Assertion => x
      file_path = File.read('lucid.txt').split(' ').last
      FileUtils.copy(file_path, './elucidation.html')
      File.open('lucid.txt', 'w') do |file|
        file.write(x.message)
      end
    end
  end

end


