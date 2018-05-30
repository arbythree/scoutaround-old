after :ranks do
  life = Rank.find_by(name: 'Life')
  TenureRequirement.where(program_code: 'bsa', achievable: life, param: 6.months, precursor: Rank.find_by(name: 'Star')).first_or_create
end
