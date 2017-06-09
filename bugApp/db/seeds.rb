# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
State.create(device: 'iPhone5', os: 'iOS', memory: 512, storage: 8192)
State.create(device: 'iPhone6', os: 'iOS', memory: 1024, storage: 32768)
State.create(device: 'iPhone7', os: 'iOS', memory: 2048, storage: 65536)

Bug.create(appToken: 'H1234ABC', number: 1200, status: :closed, priority: 'critical', comment: 'Original', state_id: 2)
Bug.create(appToken: 'H1234ABC', number: 1200, status: :in_progress, priority: 'minor', comment: 'This should not be here', state_id: 2)
Bug.create(appToken: 'H1234ABC', number: 1201, status: :in_progress, priority: 'minor', comment: 'This should be here, it\'s fine', state_id: 2)
Bug.create(appToken: 'H1234ABF', number: 1200, status: :fresh, priority: 'critical', comment: 'Please Help!', state_id: 1)
