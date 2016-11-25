const path = require('path')
const express = require('express')
const logger = require('morgan')
const cookieParser = require('cookie-parser')
const bodyParser = require('body-parser')
const session = require('express-session')
const passport = require('passport')
const GitHubStrategy = require('passport-github').Strategy
const mongoose = require('mongoose')

if (process.env.NODE_ENV !== 'production') {
	require('dotenv').config()
}

mongoose.connect('mongodb://localhost/chest-registry')

// model
const User = require('./app/models/user')

// route
const users = require('./app/routes/user')

const app = express()

app.use(logger('dev'))
app.use(express.static(path.join(__dirname, 'public')))
app.use(cookieParser())
app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json())

// session
app.use(session({
	secret: 'keyboard cat',
	resave: true,
	saveUninitialized: true
}))

// authentication
app.use(passport.initialize())
app.use(passport.session())

passport.use(new GitHubStrategy({
	clientID: process.env.GITHUB_CLIENT_ID,
	clientSecret: process.env.GITHUB_CLIENT_SECRET,
	callbackURL: `http://localhost:3000/auth/github/callback`
},
(accessToken, refreshToken, profile, done) => {
	// User.findOrCreate({githubId: profile.id}, (err, user) => {
	// 	return done(err, user)
	// })
	User.findOne({githubID: profile.id}, (err, user) => {
		if (err) {
			console.log(err)
			return done(err)
		}
		if (!err && user !== null) {
			return done(null, user)
		}
		user = new User({
			githubID: profile.id,
			name: profile.displayName,
			created: Date.now()
		})
		user.save(err => {
			if (err) {
				console.log(err)  // handle errors!
			} else {
				console.log('saving user ...')
				done(null, user)
			}
		})
	})
}))

// In order to restore authentication state across HTTP requests, Passport needs
// to serialize users into and deserialize users out of the session.  In a
// production-quality application, this would typically be as simple as
// supplying the user ID when serializing, and querying the user record by ID
// from the database when deserializing.  However, due to the fact that this
// example does not have a database, the complete Twitter profile is serialized
// and deserialized.
passport.serializeUser((user, done) => {
	done(null, user)
})

passport.deserializeUser((obj, done) => {
	done(null, obj)
})

// route
app.use('/users', users)
app.get('/logout', (req, res) => {
	req.logout()
	res.redirect('/')
})
app.get('/auth/github',
	passport.authenticate('github'))

app.get('/auth/github/callback',
	passport.authenticate('github', {failureRedirect: '/login'}),
	(req, res) => {
		// Successful authentication, redirect home.
		console.log(req.user)
		res.json({success: true})
	})

app.get('/profile',
	ensureAuthenticated,
	(req, res) => {
		res.render('profile', {user: req.user})
	}
)

const React = require('react')
const Router = require('react-router')

app.use((req, res, next) => {
	const router = Router.create({location: req.url, routes: routes})
	router.run((Handler, state) => {
		const html = React.renderToString(React.createElement(Handler))
		return res.render('react_page', {html: html})
	})
})

// helper: test authentication
function ensureAuthenticated(req, res, next) {
	if (req.isAuthenticated()) {
		return next()
	}
	res.redirect('/')
}

module.exports = app
