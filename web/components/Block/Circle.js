import React, { PropTypes } from 'react';

export default function Circle(props) {
  const minusOffset = props.size * (-1 / 2);

  let color = null;
  switch (props.status) {
    case 'active':
      color = '#3CAE1D';
      break;
    case 'loading':
      color = '#D2E13C';
      break;
    case 'error':
      color = '#B1132C';
      break;
  }

  let styles = {
    position: 'absolute',
    border: `1px solid ${color || '#3F525B'}`,
    background: color || 'none',
    ...props.style,
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
  status: PropTypes.oneOf(['active', 'loading', 'error']),
};

Circle.defaultProps = {
  size: 16,
};
