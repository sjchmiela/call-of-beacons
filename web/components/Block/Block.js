import React, { Component } from 'react';
import classNames from 'classNames';
import Circle from './Circle.js';
import './Block.scss';

export default class Block extends Component {
  render() {
    const className = classNames('Block', this.props.className);

    return (
      <div {...this.props} className={className}>
        <Circle top left />
        <Circle top right />
        <Circle bottom left />
        <Circle bottom right />
        {this.props.children}
      </div>
    );
  }
}
