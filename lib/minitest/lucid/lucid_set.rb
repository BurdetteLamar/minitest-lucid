require 'minitest/assertions'

class LucidSet
  def elucidate(test, exception, expected, actual)
    missing = expected - actual
    unexpected = actual - expected
    ok = expected & actual
    Minitest::Assertions.elucidate(test, exception, expected, actual) do
      Minitest::Assertions.elucidate_missing_items(missing)
      Minitest::Assertions.elucidate_unexpected_items(unexpected)
      Minitest::Assertions.elucidate_ok_items(ok)
    end
  end
end
