import React, { Component } from 'react';
import Header from './Header/Header';
import Console from '../Console/Console';
import Dashboard from '../Dashboard/Dashboard';
import './App.scss';

export default class App extends Component {
  constructor(props) {
    super(props);

    const websocket = new WebSocket('ws://127.0.0.1:1880/ws/positions');
    websocket.onmessage = (data) => this._onMessage(data);
    websocket.onerror = () => this._onError();
    websocket.onopen = () => this._onOpen();
    websocket.onclose = () => this._onClose();

    this.state = {
      websocket,
      error: undefined,
      messages: [],
    };
  }

  _onOpen() {
    this.setState({ error: false });
  }

  _onMessage(message) {
    this.setState({
      messages: [message].concat(this.state.messages),
    });
  }

  _onClose() {
    this.setState({ error: true });
  }

  _onError() {
    this.setState({ error: true });
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
        <div className="App-content">
          <Console messages={this.state.messages} />
          <Dashboard />
        </div>
      </div>
    );
  }
}
