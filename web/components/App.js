import React, { Component } from 'react';
import './app.scss';

export default class App extends Component {
  constructor(props) {
    super(props);

    this._ws = new WebSocket('ws://127.0.0.1:1880/ws/positions');
    this._ws.onmessage = (event) => this._handleData(JSON.parse(event.data));
  }

  _handleData(data) {
    console.log(data);
  }

  render() {
    return (
      <div className="App">
        <h1>Hello, world.</h1>
      </div>
    );
  }
}
