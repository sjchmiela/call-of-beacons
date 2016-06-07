import React, { Component, PropTypes } from 'react';
import TitledBlock from '../Block/TitledBlock';
import R from 'ramda';
import './Leaderboard.scss';

export default class Leaderboard extends Component {
  static propTypes = {
    gamers: PropTypes.object,
  }

  _sortGamers(gamersObject) {
    const gamers = Object.keys(gamersObject).map((key) => gamersObject[key]);
    return R.sort((state1, state2) => state2.gamer.score - state1.gamer.score, gamers);
  }

  _renderGamer(state, key) {
    return (
      <li key={key}>{state.gamer.nick} — {state.gamer.score}</li>
    );
  }

  render() {
    return (
      <TitledBlock title="Leaderboard" className="Leaderboard">
        <ol>
          {this._sortGamers(this.props.gamers).map((gamer, key) => this._renderGamer(gamer, key))}
        </ol>
      </TitledBlock>
    );
  }
}
