const React = require('react')

export default class Login extends React.Component {
	render() {
		return (
			<form>
				<input type="email"/>
				<input type="password"/>
				<button type="submit">Login</button>
			</form>
		)
	}
}
