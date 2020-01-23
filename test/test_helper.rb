$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "minitest/lucid"

require "minitest/autorun"

require_relative '../lib/minitest/lucid'

module TestHelper

  include Minitest::Assertions

  def do_test(klass, expected, actual)
    dir_name, name, subname = names_for_class(klass)
    dir_path = File.join(File.dirname(__FILE__), dir_name)
    Dir.chdir(dir_path) do
      msg = "#{expected.class} and #{actual.class}"
      x = assert_raises(Minitest::Assertion) do
        assert_equal(expected, actual, msg)
      end
      exp_name = expected.class == klass ? name: subname
      act_name = actual.class == klass ? name : subname
      exp_file_path = "expected/#{exp_name}.#{act_name}.html"
      act_file_path = "actual/#{exp_name}.#{act_name}.html"
      temp_file_path = x.message.split(' ').last
      # Obfuscate file paths and line numbers in backtrace.
      text = File.read(temp_file_path)
      # Careful with the angle brackets.
      Minitest::Assertions.gsub_git_dir!(text, '&lt;GIT_DIR&gt;')
      Minitest::Assertions.gsub_gem_dir!(text, '&lt;GEM_DIR&gt;')
      Minitest::Assertions.gsub_line_no!(text, '&lt;LINE_NO&gt;')
      File.write(act_file_path, text)
      exp_lines = File.readlines(exp_file_path)
      act_lines = File.readlines(act_file_path)
      diffs = Diff::LCS.diff(exp_lines, act_lines)
      assert_empty(diffs)
    end
  end

  def names_for_class(klass)
    {
      Hash => %w/hash hash subhash/,
      Set => %w/set set subset/,
      Struct => %w/struct struct substruct/,
    }[klass]
  end

end