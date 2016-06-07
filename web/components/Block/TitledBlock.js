import React, { Component, PropTypes } from 'react';
import classNames from 'classNames';
import Block from '../Block/Block';
import './TitledBlock.scss';

export default class Console extends Component {
  static propTypes = {
    title: PropTypes.string,
    children: PropTypes.node,
  }

  render() {
    const className = classNames(this.props.className, 'TitledBlock');
    return (
      <div {...this.props} className={className}>
        <div className="TitledBlock-header"><h1>{this.props.title}</h1></div>
        <Block className="TitledBlock-block">
          {this.props.children}
        </Block>
      </div>
    );
  }
}
