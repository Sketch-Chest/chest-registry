// import 'babel-polyfill'
// import './stylus/index.styl'

import React from 'react'
import {render} from 'react-dom'
import {Router, Route, browserHistory} from 'react-router'

import App from './components/app'
import Signup from './components/signup'

render((
	<Router history={browserHistory}>
		<Route path="/" component={App}>
			<Route path="signup" component={Signup}/>
		</Route>
	</Router>
), document.getElementById('root'))
