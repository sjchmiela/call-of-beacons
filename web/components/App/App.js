import React, { Component } from 'react';
import Header from './Header/Header';
import Console from '../Console/Console';
import Dashboard from '../Dashboard/Dashboard';
import './App.scss';
import configuration from 'json!../../../configuration.json';

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
      gamers: {},
    };
  }

  _onOpen() {
    this.setState({ error: false });
  }

  _onMessage(message) {
    const parsedMessage = JSON.parse(message.data);
    const gamers = this.state.gamers;
    gamers[parsedMessage.gamer.nick] = parsedMessage;
    this.setState({
      messages: [message].concat(this.state.messages),
      gamers,
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
          <Dashboard
            knownBeacons={configuration.beacons}
            gamers={this.state.gamers}
          />
        </div>
      </div>
    );
  }
}
