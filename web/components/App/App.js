import React, { Component } from 'react';
import Header from './Header/Header';
import Console from '../Console/Console';
import Dashboard from '../Dashboard/Dashboard';
import Leaderboard from '../Leaderboard/Leaderboard';
import TitledBlock from '../Block/TitledBlock';
import R from 'ramda';
import './App.scss';
import configuration from 'json!../../../configuration.json';

export default class App extends Component {
  constructor(props) {
    super(props);

    const websocket = new WebSocket(configuration.websocketUpdateUrl);
    websocket.onmessage = (data) => this._onMessage(data);
    websocket.onerror = () => this._onError();
    websocket.onopen = () => this._onOpen();
    websocket.onclose = () => this._onClose();

    this._clearGamersInterval = setInterval(() => this._clearGamers(), 5000);

    this.state = {
      websocket,
      error: undefined,
      messages: [],
      gamers: {},
    };
  }

  componentWillUnmount() {
    clearInterval(this._clearGamersInterval);
  }

  _clearGamers() {
    const gamersArray = R.values(this.state.gamers);
    const now = new Date();
    const filteredGamers = R.filter((state) => now - state.updated_at < 5000, gamersArray);
    var gamers = {};
    R.forEach((state) => gamers[state.gamer.nick] = state, filteredGamers);
    this.setState({ gamers });
  }

  _onOpen() {
    this.setState({ error: false });
  }

  _onMessage(message) {
    const parsedMessage = JSON.parse(message.data);
    const gamers = this.state.gamers;
    gamers[parsedMessage.gamer.nick] = parsedMessage;
    gamers[parsedMessage.gamer.nick].updated_at = new Date();
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
        <Header status={this._status()} connectionUrl={configuration.websocketUpdateUrl} />
        <div className="App-content">
          <Console messages={this.state.messages} />
          <Dashboard
            knownBeacons={configuration.beacons}
            gamers={this.state.gamers}
          />
          <Leaderboard gamers={this.state.gamers} />
        </div>
      </div>
    );
  }
}
