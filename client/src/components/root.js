import React from 'react';

export default class Root extends React.Component {
  render() {
    return (
      <div>
        <h1>Root</h1>
        {this.props.children}
      </div>
    );
  }
}
