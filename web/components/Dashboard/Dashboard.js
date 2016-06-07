import React, { Component, PropTypes } from 'react';
import Beacon from '../Beacon/Beacon';
import Block from '../Block/Block';
import Draggable from 'react-draggable';
import './Dashboard.scss';

export default class Dashboard extends Component {
  render() {
    return (
      <Block className="Dashboard">
        <Draggable bounds="parent">
          <Beacon color="#fff" />
        </Draggable>
      </Block>
    );
  }
}
