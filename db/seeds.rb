1234.times do
  person = Person.create(first_name: 'first', last_name: 'last')
  person.destroy
end

666.times do
  m = Membership.create
  m.destroy
end

999.times do
  e = Event.create
  e.destroy
end

owen    = Youth.where(first_name: 'Owen',    last_name: 'McNamara', rank: 'Scout').first_or_create
luis    = Youth.where(first_name: 'Luis',    last_name: 'Johnson',  rank: 'Scout').first_or_create
jack    = Youth.where(first_name: 'Jack',    last_name: 'Jones',    rank: 'Star').first_or_create
aidan   = Youth.where(first_name: 'Aidan',   last_name: 'Riordan',  rank: 'Life').first_or_create
marc    = Youth.where(first_name: 'Marc',    last_name: 'Wilson',   rank: 'First Class').first_or_create

ray     = Adult.where(first_name: 'Ray',     last_name: 'McNamara').first_or_create
fred    = Adult.where(first_name: 'Fred',    last_name: 'Marquez').first_or_create
vince   = Adult.where(first_name: 'Vincent', last_name: 'Jones').first_or_create
ed      = Adult.where(first_name: 'Edward',  last_name: 'Smith').first_or_create

puts "People: #{Person.count}"

Guardianship.find_or_create_by(
  guardian: ray,
  guardee: owen
)

puts "Guardianships: #{Guardianship.count}"

troop = Troop.where(number: '28', location: 'Santa Ana, CA').first_or_create

Person.all.each do |person|
  troop.memberships.where(person: person).first_or_create
end

puts "Memberships: #{Membership.count}"

# Ray is an admin
m = Membership.where(unit: troop, person: ray).first
m.role = :admin
m.save

m = Membership.where(unit: troop, person: marc).first
m.active = false
m.save

# Ray is a user
user = User.where(
  email: 'ray@scoutaround.org',
  person: ray
).first

user = User.create(
  email: 'ray@scoutaround.org',
  person: ray,
  password: 'goscoutaround'
) unless user.present?

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
  person: owen,
  event: summer_camp
).first_or_create

ray_registration = EventRegistration.where(
  person: ray,
  event: summer_camp
).first_or_create

EventRegistration.where(
  person: luis,
  event: summer_camp
).first_or_create

EventRegistration.where(
  person: aidan,
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
