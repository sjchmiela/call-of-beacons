import React, { Component, PropTypes } from 'react';
import classNames from 'classNames';
import Isvg from 'react-inlinesvg';

export default class Gamer extends Component {
  render() {
    const className = classNames('Gamer', this.props.className);
    const styles = {
      ...this.props.style,
      'alignSelf': 'flex-start',
      position: 'relative',
    }

    return (
      <div {...this.props} style={styles} className={className}>
        <Isvg src="/images/user.svg" />
      </div>
    );
  }
}
