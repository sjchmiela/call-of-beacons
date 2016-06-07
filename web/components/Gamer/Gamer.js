import React, { Component, PropTypes } from 'react';
import classNames from 'classNames';
import Isvg from 'react-inlinesvg';
import { Tooltip } from 'pui-react-tooltip';
import { OverlayTrigger } from 'pui-react-overlay-trigger';

export default class Gamer extends Component {
  static propTypes = {
    gamer: PropTypes.object,
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
    const className = classNames('Gamer', this.props.className);
    const styles = {
      ...this.props.style,
      'alignSelf': 'flex-start',
      position: 'relative',
    };

    return (
      <OverlayTrigger placement="top" overlay={this._renderTooltip()}>
        <div {...this.props} style={styles} className={className}>
          <Isvg src="/images/user.svg" />
        </div>
      </OverlayTrigger>
    );
  }
}
