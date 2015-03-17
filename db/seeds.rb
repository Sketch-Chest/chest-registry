user = User.create(
  name: 'test',
  email: 'test@example.com',
  password: 'inyasuxs',
  password_confirmation: 'inyasuxs')
user.token = 'test'
user.save
