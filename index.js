const path = require('path')
const express = require('express')
const cookieParser = require('cookie-parser')
const bodyParser = require('body-parser')
const session = require('express-session')
const passport = require('passport')
const LocalStrategy = require('passport-local').Strategy
const GitHubStrategy = require('passport-github').Strategy
const mongoose = require('mongoose')

// models
const User = require('./models/user')

// routes
const routes = require('./routes')
const users = require('./routes/user')

const app = express()

// serve static files
app.use(express.static(path.join(__dirname, 'public')))

// parse requests
app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json())
app.use(cookieParser())

// session: setup
app.use(session({
  secret: 'keyboard cat',
  resave: false,
  saveUninitialized: false
}))

// auth: setup
app.use(passport.initialize())
app.use(passport.session())

// auth: local
passport.use(new LocalStrategy(User.authenticate()))
passport.serializeUser(User.serializeUser())
passport.deserializeUser(User.deserializeUser())

// auth: github
// passport.use(new GitHubStrategy({
//   clientID: process.env.GITHUB_CLIENT_ID,
//   clientSecret: process.env.GITHUB_CLIENT_SECRET,
//   callbackURL: `http://localhost:3000/auth/github/callback`
// },
// (accessToken, refreshToken, profile, done) => {
//   // User.findOrCreate({githubId: profile.id}, (err, user) => {
//   //  return done(err, user)
//   // })
//   User.findOne({githubID: profile.id}, (err, user) => {
//     if (err) {
//       console.log(err)
//       return done(err)
//     }
//     if (!err && user !== null) {
//       return done(null, user)
//     }
//     user = new User({
//       githubID: profile.id,
//       name: profile.displayName,
//       created: Date.now()
//     })
//     user.save(err => {
//       if (err) {
//         console.log(err)  // handle errors!
//       } else {
//         console.log('saving user ...')
//         done(null, user)
//       }
//     })
//   })
// }))

// mongoose connect
mongoose.connect('mongodb://localhost/chest-registry')

// routes
app.use('/', routes)
app.use('/users', users)
// app.get('/profile',
//   ensureAuthenticated,
//   (req, res) => {
//     res.render('profile', {user: req.user})
//   }
// )

// server-side rendering
// const React = require('react')
// const Router = require('react-router')

// app.use((req, res, next) => {
//   const router = Router.create({location: req.url, routes: routes})
//   router.run((Handler, state) => {
//     const html = React.renderToString(React.createElement(Handler))
//     return res.render('react_page', {html: html})
//   })
// })

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  const err = new Error('Not Found')
  err.status = 404
  next(err)
})

// helper: check auth status
function ensureAuthenticated (req, res, next) {
  if (req.isAuthenticated()) {
    return next()
  }
  res.redirect('/')
}

module.exports = app
