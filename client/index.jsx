// import 'babel-polyfill'
// import './stylus/index.styl'

const React = require('react')
const {render} = require('react-dom')
const {Router, Route, browserHistory} = require('react-router')

const App = require('./components/app')
const Signup = require('./components/signup')

render((
	<Router history={browserHistory}>
		<Route path="/" component={App}>
			<Route path="signup" component={Signup}/>
		</Route>
	</Router>
), document.getElementById('root'))
