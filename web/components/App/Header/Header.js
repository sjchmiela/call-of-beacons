import React, { Component, PropTypes } from 'react';
import Block from '../../Block/Block';
import Circle from '../../Block/Circle';
import './Header.scss';
import { Tooltip } from 'pui-react-tooltip';
import { OverlayTrigger } from 'pui-react-overlay-trigger';

export default class Header extends Component {
  static propTypes = {
    status: PropTypes.string,
    connectionUrl: PropTypes.string,
  }

  _renderTooltip() {
    return (
      <Tooltip>Connecting to: {this.props.connectionUrl}</Tooltip>
    );
  }

  render() {
    return (
      <Block className="Header">
        <img src="/images/logo.svg" />
        <OverlayTrigger placement="right" overlay={this._renderTooltip()}>
          <Circle {...this.props} right top status={this.props.status} />
        </OverlayTrigger>
      </Block>
    );
  }
}
