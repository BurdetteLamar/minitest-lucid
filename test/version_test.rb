require "test_helper"

require_relative '../lib/minitest/lucid/version'

class VersionTest < Minitest::Test

  def test_version
    refute_nil Minitest::Lucid::VERSION
  end
end
