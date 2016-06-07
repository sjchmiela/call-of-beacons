import React, { Component, PropTypes } from 'react';
import classNames from 'classNames';
import Block from '../Block/Block';
import './TitledBlock.scss';

export default class Console extends Component {
  static propTypes = {
    title: PropTypes.string,
    blockClassName: PropTypes.string,
    children: PropTypes.node,
  }

  render() {
    const className = classNames(this.props.className, 'TitledBlock');
    const blockClassName = classNames(this.props.blockClassName, 'TitledBlock-block');
    return (
      <div {...this.props} className={className}>
        <div className="TitledBlock-header"><h1>{this.props.title}</h1></div>
        <Block className={blockClassName}>
          {this.props.children}
        </Block>
      </div>
    );
  }
}
