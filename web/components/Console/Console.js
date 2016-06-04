import React, { Component, PropTypes } from 'react';
import Block from '../Block/Block';
import './Console.scss';

export default class Console extends Component {
  static propTypes = {
    messages: PropTypes.array,
  }

  _renderMessage(message, index) {
    return (
      <div className="Console-message" key={index}>
        {message.data}
        <div className="Console-message-timestamp">
          {new Date(message.timeStamp).toString()}
        </div>
      </div>
    );
  }

  _renderNoMessageInfo() {
    return (
      <div className="Console-message">
        No messages received yet.
        <div className="Console-message-timestamp">
          {new Date().toString()}
        </div>
      </div>
    );
  }

  _renderMessages(messages) {
    if (!messages || messages.length === 0) {
      return this._renderNoMessageInfo();
    }

    return this.props.messages.map((msg, index) => this._renderMessage(msg, index));
  }

  render() {
    return (
      <Block className="Console">
        <div className="Console-content">
          {this._renderMessages(this.props.messages)}
        </div>
      </Block>
    );
  }
}
