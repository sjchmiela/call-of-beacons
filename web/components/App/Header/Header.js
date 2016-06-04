import React, { Component, PropTypes } from 'react';
import Block from '../../Block/Block';
import Circle from '../../Block/Circle';
import './Header.scss';

export default class Header extends Component {
  static propTypes = {
    status: PropTypes.string,
  }

  render() {
    return (
      <Block className="Header">
        <img src="/images/logo.svg" />
        <Circle right top status={this.props.status} />
      </Block>
    );
  }
}
