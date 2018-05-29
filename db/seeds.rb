def create_user(type, first_name, last_name, email, rank = nil)
  User.create_with(
    first_name: first_name,
    last_name: last_name,
    type: type,
    rank: rank,
    active: true,
    password: 'goscoutaround'
  ).find_or_create_by(email: email)
end

owen  = create_user('Youth', 'Owen', 'McNamara', 'a1@scoutaround.org', 'Scout')
luis  = create_user('Youth', 'Luis', 'Johnson', 'a2@scoutaround.org', 'Scout')
jack  = create_user('Youth', 'Jack', 'Jones', 'a3@scoutaround.org', 'Star')
aidan = create_user('Youth', 'Aidan', 'Riordan', 'a4@scoutaround.org', 'Life')
marc  = create_user('Youth', 'Marc', 'Wilson', 'a5@scoutaround.org', 'First Class')

ray   = create_user('Adult', 'Ray', 'McNamara', 'ray@scoutaround.org')
fred  = create_user('Adult', 'Fred', 'Marquez', 'a6@scoutaround.org')
vince = create_user('Adult', 'Vincent', 'Jones', 'a7@scoutaround.org')
ed    = create_user('Adult', 'Edward',  'Smith', 'a8@scoutaround.org')

puts "Users: #{User.count}"

Guardianship.find_or_create_by(
  guardian: ray,
  guardee: owen
)

puts "Guardianships: #{Guardianship.count}"

troop = Troop.where(number: '28', location: 'Santa Ana, CA').first_or_create

User.all.each do |user|
  troop.memberships.where(user: user).first_or_create
end

puts "Memberships: #{Membership.count}"

# Ray is an admin
m = Membership.where(unit: troop, user: ray).first
m.role = :admin
m.save

m = Membership.where(unit: troop, user: marc).first
m.active = false
m.save

summer_camp = troop.events.create_with(
  starts_at: 8.weeks.from_now,
  ends_at: 9.weeks.from_now
).find_or_create_by(name: '2018 Camp Itchyowie')

troop.events.create_with(
  starts_at: 4.weeks.from_now,
  ends_at: 4.weeks.from_now
).find_or_create_by(name: 'Whitewater Rafting')

troop.events.create_with(
  starts_at: 56.weeks.ago,
  ends_at: 55.weeks.ago
).find_or_create_by(name: '2017 Summer Camp')

puts "Events: #{Event.count}"

medical_form = summer_camp.event_requirements.where(
  type: 'DocumentEventRequirement',
  description: 'Medical Form'
).first_or_create

waiver = summer_camp.event_requirements.where(
  type: 'DocumentEventRequirement',
  description: 'Waiver'
).first_or_create

summer_camp.event_requirements.where(
  type: 'PaymentEventRequirement',
  description: 'Camp Fee',
  amount: 250
).first_or_create

owen_registration = EventRegistration.where(
  user: owen,
  event: summer_camp
).first_or_create

ray_registration = EventRegistration.where(
  user: ray,
  event: summer_camp
).first_or_create

EventRegistration.where(
  user: luis,
  event: summer_camp
).first_or_create

EventRegistration.where(
  user: aidan,
  event: summer_camp
).first_or_create

EventSubmission.where(
  event_requirement: medical_form,
  event_registration: owen_registration,
  submitter: ray,
  approver: ray,
  approved_at: Time.now
).first_or_create

EventSubmission.where(
  event_requirement: waiver,
  event_registration: ray_registration,
  submitter: ray
).first_or_create

# ranks
scout         = Rank.where(name: 'Scout').first_or_create
tenderfoot    = Rank.where(name: 'Tenderfoot').first_or_create
second_class  = Rank.where(name: 'Second Class').first_or_create
first_class   = Rank.where(name: 'First Class').first_or_create
star          = Rank.where(name: 'Star').first_or_create
life          = Rank.where(name: 'Life').first_or_create
eagle         = Rank.where(name: 'Eagle').first_or_create

# required merit badges

required_merit_badges_names = [
  'Personal Management', 'Swimming', 'Emrgency Preparedness', 'Personal Fitness', 'First Aid',
  'Citizenship in the Community', 'Citizenship in the Nation', 'Citizenship in the World',
  'Lifesaving', 'Camping', 'Communication', 'Cooking', 'Cycling', 'Environmental Science',
  'Family Life', 'Hiking', 'Sustainability'
]

required_merit_badges_names.each do |name|
  badge = MeritBadge.where(program_code: 'bsa', name: name).first_or_create
  AchievementRequirement.where(achievable: eagle, required: badge).first_or_create
end

# tenderfoot requirements
TenureRequirement.where(achievable: tenderfoot, parameter: '3.months').first_or_create
AchievementRequirement.where(achievable: tenderfoot, required: scout).first_or_create

# second class requirements
AchievementRequirement.where(achievable: second_class, required: tenderfoot).first_or_create

# first class requirements
AchievementRequirement.where(achievable: first_class, required: second_class).first_or_create
AchievementRequirement.where(achievable: first_class, required: first_aid).first_or_create

# star requirements
AchievementRequirement.where(achievable: star, required: first_class).first_or_create

# life requirements
AchievementRequirement.where(achievable: life, required: star).first_or_create

# eagle requirements
TenureRequirement.where(achievable: eagle, parameter: '6.months').first_or_create


# all other merit badges
merit_badge_names = [
  'American Business', 'American Cultures', 'American Heritage', 'American Labor', 'Animal Science',
  'Animation', 'Archaeology', 'Archery', 'Architecture', 'Art', 'Astronomy', 'Athletics', 'Automotive Maintenance',
  'Aviation', 'Backpacking', 'Basketry', 'Bird Study', 'Bugling', 'Canoeing', 'Chemistry', 'Chess',
  'Climbing', 'Coin Collecting', 'Collections', 'Composite Materials', 'Crime Prevention', 'Dentistry',
  'Digital Technology', 'Disabilities Awareness', 'Dog Care', 'Drafting', 'Electricity', 'Electronics',
  'Energy', 'Engineering', 'Entrepreneurship', 'Exploration', 'Farm Mechanics', 'Fire Safety', 'Fish and Wildlife Management',
  'Fishing', 'Fly Fishing', 'Forestry', 'Game Design', 'Gardening', 'Geneology', 'Geocaching', 'Geology', 'Golf',
  'Graphic Arts', 'Home Repairs', 'Horsemanship', 'Indian Lore', 'Insect Study', 'Inventing', 'Journalism', 'Kayaking',
  'Landscape Architecture', 'Law', 'Leatherworking', 'Mammal Study', 'Medicine', 'Metalwork', 'Mining in Society'
  'Model Design and Building', 'Motorboating', 'Moviemaking', 'Music', 'Nature', 'Nuclear Science', 'Oceanography',
  'Orienteering', 'Painting', 'Pets', 'Photography', 'Pioneering', 'Plant Science', 'Plumbing', 'Pottery', 'Programming',
  'Public Health', 'Public Speaking', 'Pulp and Paper', 'Radio', 'Railroading', 'Reading', 'Reptile and Amphibian Study',
  'Rifle Shooting', 'Robotics', 'Rowing', 'Safety', 'Salesmanship', 'Scholarship', 'Scouting Heritage', 'Scuba Diving',
  'Sculpture', 'Search & Rescue', 'Shotgun Shooting', 'Signals, Signs, and Codes', 'Skating', 'Small-Boat Sailing',
  'Snow Sports', 'Soil and Water Conservation', 'Space Exploration', 'Sports', 'Stamp Collecting', 'Surveying',
  'Textile', 'Theater', 'Traffic Safety', 'Truck Transportation', 'Veterinary Medicine', 'Water Sports', 'Weather',
  'Welding', 'Whitewater', 'Wilderness Survival', 'Wood Carving', 'Woodwork'
]

merit_badge_names.each do |name|
  MeritBadge.where(program_code: 'bsa', name: name).first_or_create
end
