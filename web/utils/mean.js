export default function(array, weightKey, valueKey) {
  let numerator = 0;
  let denominator = 0;
  for(let i = 0; i < array.length; i++) {
    const obj = array[i];
    if(obj !== null && obj[weightKey] !== undefined && obj[valueKey] !== undefined) {
      numerator += obj[weightKey] * obj[valueKey];
      denominator += obj[weightKey];
    }
  }
  return numerator / denominator;
}
