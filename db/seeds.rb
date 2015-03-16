user = User.create(
  name: 'uetchy',
  email: 'uetchy@randompaper.co',
  password: 'inyasuxs',
  password_confirmation: 'inyasuxs')
user.token = 'test'
user.save
