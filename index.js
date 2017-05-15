import path from 'path'
import express from 'express'
import cookieParser from 'cookie-parser'
import bodyParser from 'body-parser'
import session from 'express-session'
import passport from 'passport'
import { Strategy as LocalStrategy } from 'passport-local'
import { Strategy as GitHubStrategy } from 'passport-github'
import mongoose from 'mongoose'

// models
import User from './models/user'

// routes
import routes from './routes'
import usersRoutes from './routes/user'

const app = express()

// serve static files
app.use(express.static(path.resolve(__dirname, 'public')))

// parse requests
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())
app.use(cookieParser())

// session: setup
app.use(
  session({
    secret: process.env.SECRET || 'keyboard cat',
    resave: false,
    saveUninitialized: false
  })
)

// auth: setup
app.use(passport.initialize())
app.use(passport.session())

// auth: local
passport.use(new LocalStrategy(User.authenticate()))
passport.serializeUser(User.serializeUser())
passport.deserializeUser(User.deserializeUser())

// mongoose connect
mongoose.connect(
  process.env.MONGODB_URL || 'mongodb://localhost/chest-registry'
)

// API routes
app.get('*', (req, res) => {
  res.render('index')
})
app.use('/', routes)
app.use('/users', usersRoutes)
// app.get('/profile',
//   ensureAuthenticated,
//   (req, res) => {
//     res.render('profile', {user: req.user})
//   }
// )

// catch 404 and forward to error handler
app.use((req, res, next) => {
  const err = new Error('Not Found')
  err.status = 404
  next(err)
})

// helper: check auth status
function ensureAuthenticated(req, res, next) {
  if (req.isAuthenticated()) {
    return next()
  }
  res.redirect('/')
}

export default app
