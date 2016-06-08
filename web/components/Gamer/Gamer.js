import React, { Component, PropTypes } from 'react';
import classNames from 'classNames';
import Isvg from 'react-inlinesvg';
import { Tooltip } from 'pui-react-tooltip';
import { OverlayTrigger } from 'pui-react-overlay-trigger';
import R from 'ramda';
import mean from '../../utils/mean';
import './Gamer.scss';

export default class Gamer extends Component {
  static propTypes = {
    beacons: PropTypes.array,
    gamer: PropTypes.object,
  }

  _findBeacon(beacon, array) {
    return R.find(R.and(R.propEq('major', beacon.major), R.propEq('minor', beacon.minor)), array);
  }

  _proximityToRadius(proximity) { return Math.pow(2, proximity); }

  _position() {
    const circles = this.props.beacons.map(
      (beacon) => {
        const detectedBeacon = this._findBeacon(beacon, this.props.gamer.beacons);

        if (!detectedBeacon || detectedBeacon.proximity === 0) {
          return null;
        }

        return {
          weight: 1 / this._proximityToRadius(detectedBeacon.proximity),
          x: beacon.layout.left,
          y: beacon.layout.top,
        };
      }
    );

    return {
      x: mean(circles, 'weight', 'x'),
      y: mean(circles, 'weight', 'y'),
    };
  }

  _hpBarStyles() {
    return {
      height: `${this.props.gamer.healthPoints}%`,
    };
  }

  _renderTooltip() {
    return (
      <Tooltip>
        <strong>{this.props.gamer.nick}</strong><br />
        HP: {this.props.gamer.healthPoints}<br />
        Score: {this.props.gamer.score}
      </Tooltip>
    )
  }

  render() {
    const position = this._position();
    const className = classNames('Gamer', this.props.className);
    const styles = {
      ...this.props.style,
      transform: `translate(${position.x}px, ${position.y}px)`,
      fill: this.props.gamer.healthPoints > 0 ? '#fff' : '#f00',
    };

    return (
      <OverlayTrigger placement="top" overlay={this._renderTooltip()}>
        <div {...this.props} style={styles} className={className}>
          <Isvg src="/images/user.svg" />
          <span className="Gamer-nick">{this.props.gamer.nick}</span>
          <div className="Gamer-healthBarWrapper">
            <div className="Gamer-healthBar" style={this._hpBarStyles()} />
          </div>
        </div>
      </OverlayTrigger>
    );
  }
}
