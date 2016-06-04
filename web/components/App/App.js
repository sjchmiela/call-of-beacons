import React, { Component } from 'react';
import Header from './Header/Header';
import './App.scss';

export default class App extends Component {
  constructor(props) {
    super(props);

    const websocket = new WebSocket('ws://127.0.0.1:1880/ws/positions');
    websocket.onerror = () => this._onError();
    websocket.onopen = () => this._onOpen();
    websocket.onclose = () => this._onClose();

    this.state = {
      websocket,
      error: undefined,
    };
  }

  _onOpen() {
    console.error('Websocket connection is open.');
    this.setState({ error: false });
  }

  _onClose() {
    console.error('Websocket connection is closed.');
    this.setState({ error: true });
  }

  _onError() {
    console.error('Websocket connection encountered an error.');
    this.setState({ error: true });
  }

  _handleData(data) {
    console.log(data);
  }

  _status() {
    if (this.state.error) {
      return 'error';
    } else if (this.state.error === false) {
      return 'active';
    } else {
      return 'loading';
    }
  }

  render() {
    return (
      <div className="App">
        <Header status={this._status()} />
        <h1>Hello, world.</h1>
      </div>
    );
  }
}
