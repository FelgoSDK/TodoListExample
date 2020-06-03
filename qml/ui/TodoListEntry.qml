import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.11
import "../ui"

Item {
  id: root

  readonly property real saturation: 0.2
  readonly property real value: 0.9

  property int todoId
  property bool todoDraft
  property string todoTitle
  property bool todoComplete

  // Each entry will have its pseudo random color (or grey if in draft)
  property color color: todoDraft ? "lightgray" : getPseudoRandomColor(todoId)
  property color textColor: "#99000000"
  property color iconColor: Qt.darker(color, 1.5)
  property real margins: dp(8)

  height: Math.max(title.contentHeight + 4 * margins, dp(64))
  width: parent.width

  AppPaper {
    anchors.fill: parent
    anchors.margins: margins
    background.color: color
    background.radius: margins
    elevated: true

    // The todo text will be displayed as striked out and bold when completed
    AppText {
      id: title
      anchors { left: parent.left; right: icon.left; top: parent.top; margins: root.margins }
      color: textColor
      text: todoTitle
      font.bold: completed
      font.strikeout: completed
    }

    // A checked icon will be displayed when the task is completed
    Icon {
      id: icon
      anchors { right: parent.right; verticalCenter: parent.verticalCenter }
      width: dp(64)
      height: dp(64)
      color: iconColor
      visible: todoComplete
      icon: IconType.checkcircle
    }

    MouseArea {
      anchors.fill: parent
      onClicked: page.navigationStack.popAllExceptFirstAndPush(detailPageComponent, { todoId: root.todoId })
    }
  }

  function getPseudoRandomColor(id) {
    var pseudoRandomHue = Math.abs(Math.sin(id * 1000))
    return Qt.hsva(pseudoRandomHue, saturation, value, 1.0)
  }
}
