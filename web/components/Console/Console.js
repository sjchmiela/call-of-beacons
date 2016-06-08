import React, { Component, PropTypes } from 'react';
import TitledBlock from '../Block/TitledBlock';
import './Console.scss';

export default class Console extends Component {
  static propTypes = {
    messages: PropTypes.array,
  }

  _renderMessage(message, index) {
    return (
      <div className="Console-message" key={index}>
        <pre>{JSON.stringify(JSON.parse(message.data), null, 2)}</pre>
        <div className="Console-message-timestamp">
          {new Date(message.timeStamp).toString()}
        </div>
      </div>
    );
  }

  _renderNoMessageInfo() {
    return (
      <div className="Console-message">
        <pre>No messages received yet.</pre>
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
      <TitledBlock title="Console" className="Console" blockClassName="Console-block">
        <div className="Console-content">
        {this._renderMessages(this.props.messages)}
      </div>
      </TitledBlock>
    );
  }
}
