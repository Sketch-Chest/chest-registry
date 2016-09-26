const path = require('path');
const express = require('express');
const logger = require('morgan');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');
const session = require('express-session');
const mongoose = require('mongoose');
const passport = require('passport');

// passport middleware
const LocalStrategy = require('passport-local').Strategy;

// model
const User = require('./models/user');

// route
const routes = require('./routes/index');
const users = require('./routes/user');

const app = express();

app.use(logger('dev'));
app.use(express.static(path.join(__dirname, 'public')));

app.use(cookieParser());
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

// session
app.use(session({
	secret: 'keyboard cat',
	resave: true,
	saveUninitialized: true
}));

// authentication
app.use(passport.initialize());
app.use(passport.session());
passport.use(new LocalStrategy(
	(username, password, done) => {
		User.findOne({username}, (err, user) => {
			if (err) {
				return done(err);
			}
			if (!user) {
				return done(null, false, {message: 'Incorrect username.'});
			}
			if (!user.validPassword(password)) {
				return done(null, false, {message: 'Incorrect password.'});
			}
			return done(null, user);
		});
	}
));

// route
app.use('/', routes);
app.use('/users', users);

// handle 404
app.use((req, res, next) => {
	const err = new Error('Not Found');
	err.status = 404;
	next(err);
});

// for development
if (app.get('env') === 'development') {
	app.use((err, req, res) => {
		res.status(err.status || 500);
		res.render('error', {
			message: err.message,
			error: err
		});
	});
}

// for production
app.use((err, req, res) => {
	res.status(err.status || 500);
	res.render('error', {
		message: err.message,
		error: {}
	});
});

module.exports = app;
