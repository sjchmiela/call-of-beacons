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
      'alignSelf': 'flex-start',
      position: 'relative',
      'fill': this.props.beacon.color || '#ffffff',
    }

    return (
      <OverlayTrigger placement="top" overlay={this._renderTooltip()}>
        <div {...this.props} style={styles} className={className}>
          <Isvg src="/images/beacon.svg" />
        </div>
      </OverlayTrigger>
    );
  }
}
