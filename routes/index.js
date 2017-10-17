import { Router } from 'express';
import passport from 'passport';
import User from '../models/user';

const router = Router();

router.get('/register', (req, res) => {
  User.register(
    new User({ username: req.body.username }),
    req.body.password,
    (err, account) => {
      if (err) {
        return res.render('register', { error: err.message });
      }

      passport.authenticate('local')(req, res, () => {
        req.session.save(err => {
          if (err) {
            return next(err);
          }
          res.redirect('/');
        });
      });
    }
  );
});

router.post('/register', (req, res) => {
  User.register(
    new User({ username: req.body.username }),
    req.body.password,
    (err, account) => {
      if (err) {
        return res.render('register', { account: account });
      }

      passport.authenticate('local')(req, res, () => {
        res.redirect('/');
      });
    }
  );
});

router.get('/login', (req, res) => {
  res.render('login', { user: req.user });
});

router.post('/login', passport.authenticate('local'), (req, res) => {
  res.redirect('/');
});

router.get('/logout', (req, res) => {
  req.logout();
  res.redirect('/');
});

// social auth
router.get('/auth/github', passport.authenticate('github'));

router.get(
  '/auth/github/callback',
  passport.authenticate('github', { failureRedirect: '/login' }),
  (req, res) => {
    // Successful auth, redirect home.
    console.log(req.user);
    res.json({ success: true });
  }
);

export default router;
