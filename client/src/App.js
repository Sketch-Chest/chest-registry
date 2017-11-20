import React, { Component } from 'react';
import { BrowserRouter, Route, Link } from 'react-router-dom';
import Root from './components/root';
import Login from './components/login';
import Signup from './components/signup';
import { PrivateRoute, AuthButton } from './components/auth';

const Public = () => <div>Public</div>;
const Protected = () => <div>Protected</div>;

export default class App extends Component {
  render() {
    return (
      <BrowserRouter>
        <div>
          <AuthButton />
          <ul>
            <li>
              <Link to="/public">Public Page</Link>
            </li>
            <li>
              <Link to="/protected">Protected Page</Link>
            </li>
          </ul>
          <Route exact path="/" component={Root} />
          <Route path="/signup" component={Signup} />
          <Route path="/login" component={Login} />
          <Route path="/public" component={Public} />
          <PrivateRoute path="/protected" component={Protected} />
        </div>
      </BrowserRouter>
    );
  }
}
