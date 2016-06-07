import React, { Component, PropTypes } from 'react';
import ReactDOM from 'react-dom';
import Beacon from '../Beacon/Beacon';
import Gamer from '../Gamer/Gamer';
import Block from '../Block/Block';
import Draggable from 'react-draggable';
import './Dashboard.scss';

export default class Dashboard extends Component {
  static propTypes = {
    knownBeacons: PropTypes.array,
    gamers: PropTypes.object,
  }

  _renderBeacon(beacon, key) {
    return (
      <Draggable bounds="parent" ref={`beacon_${key}`} key={key} onStop={(event) => this._onDragStop(event, beacon, key)}>
        <Beacon beacon={beacon} />
      </Draggable>
    );
  }

  _renderGamer(gamer, key) {
    return (<Gamer gamer={gamer} key={key} />);
  }

  _onDragStop(event, beacon, key) {
    const beaconRect = ReactDOM.findDOMNode(this.refs[`beacon_${key}`]).getBoundingClientRect();
    const dashboardPoint = this._clientPointToDashboardPoint({ x: beaconRect.left, y: beaconRect.top });
    console.log(`Beacon ${beacon.name} stopped at position ${dashboardPoint.x}, ${dashboardPoint.y}`);
  }

  _clientPointToDashboardPoint(point) {
    const dashboardRect = ReactDOM.findDOMNode(this.refs.dashboard).getBoundingClientRect();
    return { x: point.x - dashboardRect.left, y: point.y - dashboardRect.top };
  }

  render() {
    return (
      <Block className="Dashboard" ref="dashboard">
        {this.props.knownBeacons.map((beacon, index) => this._renderBeacon(beacon, index))}
        {Object.keys(this.props.gamers).map((gamerNick, index) => this._renderGamer(this.props.gamers[gamerNick].gamer, index))}
      </Block>
    );
  }
}
