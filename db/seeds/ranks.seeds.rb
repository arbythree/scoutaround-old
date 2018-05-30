after :merit_badges do
  scout         = Rank.where(ordinal: 0, name: 'Scout').first_or_create
  tenderfoot    = Rank.where(ordinal: 1, name: 'Tenderfoot').first_or_create
  second_class  = Rank.where(ordinal: 2, name: 'Second Class').first_or_create
  first_class   = Rank.where(ordinal: 3, name: 'First Class').first_or_create
  star          = Rank.where(ordinal: 4, name: 'Star').first_or_create
  life          = Rank.where(ordinal: 5, name: 'Life').first_or_create
  eagle         = Rank.where(ordinal: 6, name: 'Eagle').first_or_create

  puts "Ranks: #{Rank.count}"
end
