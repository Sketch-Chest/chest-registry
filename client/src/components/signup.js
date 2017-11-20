import React, { Component } from 'react';

export default class Signup extends Component {
  handleOnSubmit(event) {
    event.preventDefault();
    console.log(event);
  }

  render() {
    return (
      <form onSubmit={this.handleOnSubmit}>
        <input type="email" />
        <input type="password" />
        <button type="submit">Signup</button>
      </form>
    );
  }
}
