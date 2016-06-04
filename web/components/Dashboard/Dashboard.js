import React, { Component, PropTypes } from 'react';
import Block from '../Block/Block';
import './Dashboard.scss';

export default class Dashboard extends Component {
  render() {
    return (
      <Block className="Dashboard">
        <p>Hello world.</p>
      </Block>
    );
  }
}
