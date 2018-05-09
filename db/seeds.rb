olin = Scout.where(first_name: 'Olin', last_name: 'Bradley').first_or_create
ray  = Adult.where(first_name: 'Ray', last_name: 'Bradley').first_or_create
Guardianship.where(
  guardian: ray,
  guardee: olin
).first_or_create

troop_2 = Troop.where(number: '2', location: 'Scarsdale, NY').first_or_create
troop_2.memberships.where(person: olin).first_or_create
troop_2.memberships.where(person: ray).first_or_create

ray_user = User.where(
  email: 'ray@bradleys.io',
  person: ray,
).first

ray_user = User.create(
  email: 'ray@bradleys.io',
  person: ray,
  password: 'scoutaround'
) unless ray_user.present?

summer_camp = Event.where(
  name: '2018 Camp Read',
  unit: troop_2,
  starts_at: '2018-07-05',
  ends_at: '2018-07-12'
).first_or_create

EventRequirement.where(
  type: 'DocumentEventRequirement',
  description: 'Medical Form',
  event: summer_camp
).first_or_create

Registration.where(
  person: olin,
  event: summer_camp
).first_or_create

Registration.where(
  person: ray,
  event: summer_camp
).first_or_create
