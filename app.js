const express = require('express')
const path = require('path')
const logger = require('morgan')
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
const usersRoutes = require('./routes/user')

const app = express()

app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))
app.use(cookieParser())

// Serve static files from the React app
app.use(express.static(path.join(__dirname, 'client/build')))

// setup session
app.use(
  session({
    secret: process.env.SECRET || 'keyboard cat',
    resave: false,
    saveUninitialized: false,
  })
)

// setup passport
app.use(passport.initialize())
app.use(passport.session())
passport.use(new LocalStrategy(User.authenticate()))
passport.serializeUser(User.serializeUser())
passport.deserializeUser(User.deserializeUser())

// connect to db
mongoose.connect(process.env.MONGODB_URL || 'mongodb://mongo/chest-registry')

// API routes
app.get('*', (req, res) => {
  res.render('index')
})
app.use('/', routes)
app.use('/users', usersRoutes)
app.get('/profile', ensureAuthenticated, (req, res) => {
  res.render('profile', { user: req.user })
})

// The "catchall" handler: for any request that doesn't
// match one above, send back React's index.html file.
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname + '/client/build/index.html'))
})

// check auth status
function ensureAuthenticated(req, res, next) {
  if (req.isAuthenticated()) {
    return next()
  }
  res.redirect('/')
}

module.exports = app
