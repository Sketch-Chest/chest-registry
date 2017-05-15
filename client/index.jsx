import './stylus/index.styl'

import React from 'react'
import { render } from 'react-dom'
import { BrowserRouter, Route, Link } from 'react-router-dom'

import App from './components/app'
import Login from './components/login'
import Signup from './components/signup'
import { PrivateRoute, AuthButton } from './components/auth'

const Public = () => <div>Public</div>
const Protected = () => <div>Protected</div>

render(
  <BrowserRouter>
    <div>
      <AuthButton />
      <ul>
        <li><Link to="/public">Public Page</Link></li>
        <li><Link to="/protected">Protected Page</Link></li>
      </ul>
      <Route exact path="/" component={App} />
      <Route path="/signup" component={Signup} />
      <Route path="/login" component={Login} />
      <Route path="/public" component={Public} />
      <PrivateRoute path="/protected" component={Protected} />
    </div>
  </BrowserRouter>,
  document.getElementById('root')
)
