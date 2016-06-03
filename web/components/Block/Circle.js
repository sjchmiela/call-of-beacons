import React, { PropTypes } from 'react';

export default function Circle(props) {
  const minusOffset = props.size * (-1 / 2);

  let styles = {
    position: 'absolute',
    border: '1px solid #3F525B',
    width: props.size,
    height: props.size,
  };

  if (props.top) { styles.top = minusOffset; }
  if (props.bottom) { styles.bottom = minusOffset; }
  if (props.left) { styles.left = minusOffset; }
  if (props.right) { styles.right = minusOffset; }

  return (
    <div
      className="Circle"
      {...props}
      style={styles}
    />
  );
}

Circle.propTypes = {
  top: PropTypes.bool,
  right: PropTypes.bool,
  bottom: PropTypes.bool,
  left: PropTypes.bool,
  size: PropTypes.number,
};

Circle.defaultProps = {
  size: 16,
};
