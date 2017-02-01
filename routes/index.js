const express = require('express')
const passport = require('passport')
const User = require('../models/user')

const router = express.Router()

router.get('/', function (req, res) {
  res.render('index', { user: req.user })
})

router.get('/register', function (req, res) {
  User.register(new User({ username: req.body.username }), req.body.password, (err, account) => {
    if (err) {
      return res.render('register', { error: err.message })
    }

    passport.authenticate('local')(req, res, () => {
      req.session.save(err => {
        if (err) {
          return next(err)
        }
        res.redirect('/')
      })
    })
  })
})

router.post('/register', function (req, res) {
  User.register(new User({ username: req.body.username }), req.body.password, function (err, account) {
    if (err) {
      return res.render('register', { account: account })
    }

    passport.authenticate('local')(req, res, function () {
      res.redirect('/')
    })
  })
})

router.get('/login', function (req, res) {
  res.render('login', { user: req.user })
})

router.post('/login', passport.authenticate('local'), function (req, res) {
  res.redirect('/')
})

router.get('/logout', function (req, res) {
  req.logout()
  res.redirect('/')
})

// social auth
router.get('/auth/github',
  passport.authenticate('github'))

router.get('/auth/github/callback',
  passport.authenticate('github', {failureRedirect: '/login'}),
  (req, res) => {
    // Successful auth, redirect home.
    console.log(req.user)
    res.json({success: true})
  }
  )
