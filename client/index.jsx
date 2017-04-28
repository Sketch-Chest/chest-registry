import './stylus/index.styl'

import React from 'react'
import { render } from 'react-dom'
import { BrowserRouter, Route} from 'react-router-dom'

import App from './components/app'
import Login from './components/login'
import Signup from './components/signup'

render(
  <BrowserRouter>
    <div>
      <Route exact path="/" component={App} />
      <Route path="login" component={Login} />
      <Route path="signup" component={Signup} />
    </div>
  </BrowserRouter>,
  document.getElementById('root')
)
