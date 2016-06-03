import React, { Component } from 'react';
import classNames from 'classNames';
import Circle from './Circle.js';
import './Block.scss';

export default function Block(props) {
  const className = classNames('Block', props.className);

  return (
    <div className={className}>
      <Circle top left />
      <Circle top right />
      <Circle bottom left />
      <Circle bottom right />
      {props.children}
    </div>
  )
}
