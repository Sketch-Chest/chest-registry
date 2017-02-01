const should = require('should')
const mongoose = require('mongoose')
const User = require('../models/user')
var db

describe('User', () => {
  before(done => {
    db = mongoose.connect('mongodb://localhost/test')
    done()
  })

  after(done => {
    mongoose.connection.close()
    done()
  })

  beforeEach(done => {
    const account = new User({
      username: '12345',
      password: 'testy'
    })

    account.save(error => {
      if (error) {
        console.log('error' + error.message)
      } else {
        console.log('no error')
      }
      done()
    })
  })

  it('find a user by username', function (done) {
    User.findOne({ username: '12345' }, (err, account) => {
      account.username.should.eql('12345')
      console.log('   username: ', account.username)
      done()
    })
  })

  afterEach(done => {
    User.remove({}, () => {
      done()
    })
  })
})
