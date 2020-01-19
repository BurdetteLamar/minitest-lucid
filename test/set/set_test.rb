require "test_helper"

class SetTest < Minitest::Test

  include TestHelper

  class SubSet < Set; end

  EXPECTED = Set.new([
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
  ACTUAL = Set.new([
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
  MESSAGE = 'My message'
  SUB_EXPECTED = SubSet.new.merge(EXPECTED)
  SUB_ACTUAL = SubSet.new.merge(ACTUAL)
  def test_set
    [
      [EXPECTED, ACTUAL],
      [SUB_EXPECTED, ACTUAL],
      [EXPECTED, SUB_ACTUAL],
      [SUB_EXPECTED, SUB_ACTUAL]
    ].each do |pair|
      do_test(Set, *pair)
    end
  end

end
