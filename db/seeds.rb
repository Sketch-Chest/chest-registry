user = User.create(
  name: 'test',
  email: 'test@example.com',
  password: 'testpass',
  password_confirmation: 'testpass')
user.token = 'test'
user.save
