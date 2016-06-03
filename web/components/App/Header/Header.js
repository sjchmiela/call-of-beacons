import React, { Component, PropTypes } from 'react';
import Block from '../../Block/Block';
import './Header.scss';

export default class Header extends Component {
  render() {
    return (
      <Block className="Header">
        <img src="/images/logo.svg" />
      </Block>
    );
  }
}
