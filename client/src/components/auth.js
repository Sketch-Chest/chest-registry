import React from 'react';
import { Route, Redirect, withRouter } from 'react-router-dom';

export const fakeAuth = {
  isAuthenticated: false,
  authenticate(cb) {
    this.isAuthenticated = true;
    setTimeout(cb, 100);
  },
  signout(cb) {
    this.isAuthenticated = false;
    setTimeout(cb, 100);
  },
};

export const AuthButton = withRouter(
  ({ history }) =>
    fakeAuth.isAuthenticated ? (
      <p>
        Welcome!
        <button onClick={() => fakeAuth.signout(() => history.push('/'))}>
          Sign out
        </button>
      </p>
    ) : (
      <p>You are not logged in.</p>
    )
);

export const PrivateRoute = ({ component: Component, ...args }) => (
  <Route
    {...args}
    render={props =>
      fakeAuth.isAuthenticated ? (
        <Component {...props} />
      ) : (
        <Redirect
          to={{
            pathname: '/login',
            state: { from: props.location },
          }}
        />
      )}
  />
);
