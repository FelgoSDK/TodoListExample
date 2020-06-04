import QtQuick 2.0

QtObject {
  id: root

  readonly property real _saturation: 0.2
  readonly property real _value: 0.9
  readonly property real _baseHue: 0.1

  // How much difference we tolerate between similar hues.
  readonly property real _spread: 0.1

  function getBaseColor() {
    return Qt.hsva(_baseHue, 1.0, 0.9, 1.0)
  }

  // Here we return a color which is similar to baseColor (their hue are very close)
  function getPseudoRandomColor(id) {
    var pseudoRandomHue = 1.0 + _baseHue + Math.sin(id * 1000) * _spread
    return Qt.hsva(pseudoRandomHue % 1, _saturation, _value, 1.0)
  }
}
