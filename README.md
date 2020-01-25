# Minitest Lucid

[![Gem](https://img.shields.io/gem/v/minitest-lucid.svg?style=flat)](http://rubygems.org/gems/minitest-lucid "View this project in Rubygems")

When you use gem ```minitest```, a failed assertion for a large or complex object can be difficult to understand.

Using method ```make_my_diffs_pretty!``` (it's part of ```minitest```) can sometimes help, but sometimes not enough.

Use gem ```minitest-lucid``` to get detailed elucidations for certain failures.

## Is This Overkill?

Yes!  (Until it isn't.)

When you have a failed assertion:

* How much information is enough?
* More is better.
* Too much is just about right!

## Usage

To use ```minitest-lucid```, install the gem and then in your tests,

```ruby
require 'minitest-lucid'
```

instead of

```ruby
require 'minitest/autorun'
```

No other code change is required.

For example, change this test

```ruby
require 'minitest/autorun'

class MyTest < Minitest::Test
  def test_foo
    expected = {:a => 0, :b => 1}
    actual = {}
    assert_equal(expected, actual)
  end
end
```

to this

```ruby
require 'minitest-lucid'

class MyTest < Minitest::Test
  def test_foo
    expected = {:a => 0, :b => 1}
    actual = {}
    assert_equal(expected, actual)
  end
end
```

See example outputs below.

## Supported Classes

For supported classes, method ```assert_equal``` gets elucidated handling.

For other classes and assertion methods, the original assertion behaviors are unchanged.

The supported classes:

- [Set](#set)

The examples below show:

- The message from a normal failed assertion.
- The message as modified by the use of ```make_my_diffs_pretty!``` (which is part of ```minitest``` itself).
- The detailed elucidation from ```minitest-lucid```.

### Set

#### assert_equal

Here are sets, expected and actual, to be compared.

```data.rb```:
```ruby
def expected
  Set.new([
              'Eia do elab same.',
              'Uati nua iaam caea.',
              'Nulla paal dolor maatat.',
              'Exerad iame ulpa ipari.',
              'Veaat ea conaaectat noat.',
              'Euaab voat doloa caecat.',
              'Idatia naat paaat inia.',
              'Prem fatiaa fad ulpaat.',
              'Ea re deni utat.',
              'Irud ming fat int.',
              'Utaag quis aut ing.',
              'Siaa miaation vagna alaa.',
              'Ut dolla laat nonse.',
              'Enaat alam nonse magnaat.',
              'Sequaa nulp duisic na.',
              'Seqa quips sitataa exae.',
              'Vate eu adip quata.',
              'Tatua ididun offia doaut.',
          ])
end
def actual
  Set.new([
              'Euaab voat doloa caecat.',
              'Suntat fugiame sici exad.',
              'Idatia naat paaat inia.',
              'Ea re deni utat.',
              'Eia do elab same.',
              'Nulla paal dolor maatat.',
              'Dolo mod eaamet ena.',
              'Exerad iame ulpa ipari.',
              'Ut dolla laat nonse.',
              'Sequaa nulp duisic na.',
              'Dat dolor laboat caalit.',
              'Seqa quips sitataa exae.',
              'Dolo esera id samcomaa.',
              'Irud ming fat int.',
              'Siaa miaation vagna alaa.',
              'Cuate adid do nim.',
              'Tatua ididun offia doaut.',
              'Ocaada iaamaa fatioa anaat.',
          ])
end
```

The default ```Minitest::Assertion``` message:

```default.txt```:
```diff
--- expected
+++ actual
@@ -1 +1 @@
-#<Set: {"Eia do elab same.", "Uati nua iaam caea.", "Nulla paal dolor maatat.", "Exerad iame ulpa ipari.", "Veaat ea conaaectat noat.", "Euaab voat doloa caecat.", "Idatia naat paaat inia.", "Prem fatiaa fad ulpaat.", "Ea re deni utat.", "Irud ming fat int.", "Utaag quis aut ing.", "Siaa miaation vagna alaa.", "Ut dolla laat nonse.", "Enaat alam nonse magnaat.", "Sequaa nulp duisic na.", "Seqa quips sitataa exae.", "Vate eu adip quata.", "Tatua ididun offia doaut."}>
+#<Set: {"Euaab voat doloa caecat.", "Suntat fugiame sici exad.", "Idatia naat paaat inia.", "Ea re deni utat.", "Eia do elab same.", "Nulla paal dolor maatat.", "Dolo mod eaamet ena.", "Exerad iame ulpa ipari.", "Ut dolla laat nonse.", "Sequaa nulp duisic na.", "Dat dolor laboat caalit.", "Seqa quips sitataa exae.", "Dolo esera id samcomaa.", "Irud ming fat int.", "Siaa miaation vagna alaa.", "Cuate adid do nim.", "Tatua ididun offia doaut.", "Ocaada iaamaa fatioa anaat."}>
```

Message using ```make_my_diffs_pretty!```:

```better.txt```:
```diff
--- expected
+++ actual
@@ -1,18 +1,18 @@
-#<Set: {"Eia do elab same.",
- "Uati nua iaam caea.",
- "Nulla paal dolor maatat.",
- "Exerad iame ulpa ipari.",
- "Veaat ea conaaectat noat.",
- "Euaab voat doloa caecat.",
+#<Set: {"Euaab voat doloa caecat.",
+ "Suntat fugiame sici exad.",
  "Idatia naat paaat inia.",
- "Prem fatiaa fad ulpaat.",
  "Ea re deni utat.",
- "Irud ming fat int.",
- "Utaag quis aut ing.",
- "Siaa miaation vagna alaa.",
+ "Eia do elab same.",
+ "Nulla paal dolor maatat.",
+ "Dolo mod eaamet ena.",
+ "Exerad iame ulpa ipari.",
  "Ut dolla laat nonse.",
- "Enaat alam nonse magnaat.",
  "Sequaa nulp duisic na.",
+ "Dat dolor laboat caalit.",
  "Seqa quips sitataa exae.",
- "Vate eu adip quata.",
- "Tatua ididun offia doaut."}>
+ "Dolo esera id samcomaa.",
+ "Irud ming fat int.",
+ "Siaa miaation vagna alaa.",
+ "Cuate adid do nim.",
+ "Tatua ididun offia doaut.",
+ "Ocaada iaamaa fatioa anaat."}>
```

Elucidation using ```minitest-lucid```:

* [Elucidation](elucidation.html)



