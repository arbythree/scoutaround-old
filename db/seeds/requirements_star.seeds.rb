after :ranks do
  star = Rank.find_by(name: 'Star')
  TenureRequirement.where(program_code: 'bsa', achievable: star, param: 4.months, precursor: Rank.find_by(name: 'First Class')).first_or_create
end
