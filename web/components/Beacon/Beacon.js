import React, { Component, PropTypes } from 'react';
import classNames from 'classNames';
import Isvg from 'react-inlinesvg';
import { Tooltip } from 'pui-react-tooltip';
import { OverlayTrigger } from 'pui-react-overlay-trigger';

export default class Beacon extends Component {
  static propTypes = {
    beacon: PropTypes.object,
  }

  _renderTooltip() {
    const name = this.props.beacon.name ? ` “${this.props.beacon.name}”` : null;
    return (
      <Tooltip>
        Beacon{name}<br />
        {this.props.beacon.major} : {this.props.beacon.minor}
      </Tooltip>
    );
  }

  render() {
    const className = classNames('Beacon', this.props.className);
    const styles = {
      ...this.props.style,
      alignSelf: 'flex-start',
      position: 'relative',
      fill: this.props.beacon.color || '#ffffff',
      opacity: this.props.beacon.layout ? 1 : 0.5,
      cursor: 'move',
    }

    return (
      <OverlayTrigger placement="top" overlay={this._renderTooltip()}>
        <div
          {...this.props}
          style={styles}
          className={className}
          data-immediate-proximity-radius={this.props.immediateProximityRadius}
        >
          <Isvg src="/images/beacon.svg" />
          <div style={{
            position: 'absolute',
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            fontSize: '0.618em',
            display: 'flex',
            textAlign: 'center',
            alignItems: 'center',
            opacity: this.props.beacon.layout ? 0 : 1,
            borderRadius: '1em',
            background: 'rgba(0,0,0,0.5)',
            color: '#fff',
            cursor: 'inherit',
          }}>
            Position me to&nbsp;start.
          </div>
        </div>
      </OverlayTrigger>
    );
  }
}
