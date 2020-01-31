# Minitest Lucid

Note:  The gem is not yet released.

[![Gem](https://img.shields.io/gem/v/minitest-lucid.svg?style=flat)](http://rubygems.org/gems/minitest-lucid "View this project in Rubygems")

When you test using gem ```minitest```, a failed assertion for a large or complex object can be difficult to understand.

Using method ```make_my_diffs_pretty!``` (it's part of ```minitest```) can sometimes help, but sometimes not enough.

Use gem ```minitest-lucid``` to get detailed elucidations for certain failures.

## Is This Overkill?

Yes!  (Until it isn't.)

Because when you have a failed assertion:

* How much information is enough?
* More is better.
* Too much is just about right.

## Usage

To use ```minitest-lucid```:
 
1. Install the gem:  ```gem install minitest-lucid```.
2. In your tests, change ```require 'minitest/autorun'``` to ```require 'minitest/lucid'```.

That's it.  No other code change is required.

See example elucidations below.

## Supported Classes

For supported classes, method ```assert_equal``` gets elucidated handling.

For other classes and assertion methods, the original assertion behaviors are unchanged.

The supported classes:

- [Set](#set)

Each example below shows:

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
```text
--- expected
+++ actual
@@ -1 +1 @@
-#<Set: {"Eia do elab same.", "Uati nua iaam caea.", "Nulla paal dolor maatat.", "Exerad iame ulpa ipari.", "Veaat ea conaaectat noat.", "Euaab voat doloa caecat.", "Idatia naat paaat inia.", "Prem fatiaa fad ulpaat.", "Ea re deni utat.", "Irud ming fat int.", "Utaag quis aut ing.", "Siaa miaation vagna alaa.", "Ut dolla laat nonse.", "Enaat alam nonse magnaat.", "Sequaa nulp duisic na.", "Seqa quips sitataa exae.", "Vate eu adip quata.", "Tatua ididun offia doaut."}>
+#<Set: {"Euaab voat doloa caecat.", "Suntat fugiame sici exad.", "Idatia naat paaat inia.", "Ea re deni utat.", "Eia do elab same.", "Nulla paal dolor maatat.", "Dolo mod eaamet ena.", "Exerad iame ulpa ipari.", "Ut dolla laat nonse.", "Sequaa nulp duisic na.", "Dat dolor laboat caalit.", "Seqa quips sitataa exae.", "Dolo esera id samcomaa.", "Irud ming fat int.", "Siaa miaation vagna alaa.", "Cuate adid do nim.", "Tatua ididun offia doaut.", "Ocaada iaamaa fatioa anaat."}>
```

Message using ```make_my_diffs_pretty!```:

```better.txt```:
```text
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

* [Elucidation](http://htmlpreview.github.io/?https://github.com/BurdetteLamar/minitest-lucid/blob/master/markdown/readme/set/assert_equal/elucidation.html)



