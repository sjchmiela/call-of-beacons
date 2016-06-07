import React, { Component, PropTypes } from 'react';
import classNames from 'classNames';
import Isvg from 'react-inlinesvg';

export default class Beacon extends Component {
  static propTypes = {
    color: PropTypes.string,
  }

  static defaultProps = {
    color: '#ffffff',
  }

  render() {
    const className = classNames('Beacon', this.props.className);
    const styles = {
      ...this.props.style,
      'alignSelf': 'flex-start',
    };

    return (
      <div {...this.props} style={styles} className={className}>
        <Isvg src="/images/beacon.svg" style={{ fill: this.props.color }} />
      </div>
    );
  }
}
