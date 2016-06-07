import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import Beacon from '../Beacon/Beacon';
import Gamer from '../Gamer/Gamer';
import Block from '../Block/Block';
import Draggable from 'react-draggable';
import R from 'ramda';
import './Dashboard.scss';

export default class Dashboard extends Component {
  static propTypes = {
    knownBeacons: PropTypes.array,
    gamers: PropTypes.object,
  }

  constructor(props) {
    super(props);

    this._beaconRefs = [];
    this._dashboardRef = null;

    this.state = {
      beacons: props.knownBeacons,
      started: props.knownBeacons.length === 0,
    };
  }

  _setDashboardRef(ref) {
    if (ref !== null) {
      this._dashboardRef = ref;
    }
  }

  _setBeaconRef(ref, key) {
    if (ref !== null) {
      this._beaconRefs[key] = ref;
    }
  }

  _renderBeacon(beacon, key) {
    return (
      <Draggable
        bounds="parent"
        ref={(ref) => this._setBeaconRef(ref, key)}
        key={key}
        onStop={(event) => this._onDragStop(event, key)}
      >
        <Beacon beacon={beacon} />
      </Draggable>
    );
  }

  _onDragStop(event, key) {
    var beacons = this.state.beacons;
    beacons[key].layout = this._beaconLayout(key);
    this.setState({
      beacons,
      started:
        this.state.started
        || R.reduce((allNonEmpty, beacon) => allNonEmpty && (beacon.layout !== undefined), true, beacons),
    });
  }

  _beaconLayout(key) {
    const ref = this._beaconRefs[key];
    const dashboardRef = this._dashboardRef;
    if (ref && dashboardRef) {
      const rect = ReactDOM.findDOMNode(ref).getBoundingClientRect();
      const dashboardRect = ReactDOM.findDOMNode(this._dashboardRef).getBoundingClientRect();
      return {
        top: rect.top - dashboardRect.top,
        right: rect.right - dashboardRect.right,
        bottom: rect.bottom - dashboardRect.bottom,
        left: rect.left - dashboardRect.left,
        width: rect.width,
        height: rect.height,
      };
    }
    return undefined;
  }

  _renderGamers() {
    if (!this.state.started) { return null; }

    return Object.keys(this.props.gamers).map(
      (gamerNick, index) =>
        <Gamer
          beacons={this.state.beacons}
          gamer={this.props.gamers[gamerNick].gamer}
          key={index}
        />
    );
  }

  render() {
    return (
      <Block className="Dashboard" ref={(ref) => this._setDashboardRef(ref)}>
        {this.state.beacons.map((beacon, index) => this._renderBeacon(beacon, index))}
        {this._renderGamers()}
      </Block>
    );
  }
}
