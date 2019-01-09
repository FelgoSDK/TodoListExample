import VPlayApps 1.0
import QtQuick 2.0

// UI Item for todo details
Item {
  anchors.fill: parent
  anchors.margins: dp(Theme.navigationBar.defaultBarItemPadding)

  // show / hide items using state
  state: !!todoData || dataModel.isBusy ? "default" : "nodata"

  // state definition
  states: [
    State {
      name: "nodata"
      PropertyChanges { target: contentColumn; visible: false }
      PropertyChanges { target: noDataMessage; visible: true }
    },
    State {
      name: "default"
      PropertyChanges { target: contentColumn; visible: true }
      PropertyChanges { target: noDataMessage; visible: false }
    }
  ]

  // column to show all todo object properties, if data is available
  Column {
    id: contentColumn
    y: spacing
    width: parent.width
    spacing: dp(Theme.navigationBar.defaultBarItemPadding)

    // Repeater creates copies of given item based on configured model data
    Repeater {
      enabled: parent.visible
      model: !!todoData ? Object.keys(todoData) : undefined

      // Text Item to show each property - value pair
      AppText {
        property string propName: modelData
        property string value: todoData[propName]

        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        height: implicitHeight

        text: "<strong>"+propName+":</strong> "+value
        wrapMode: AppText.WrapAtWordBoundaryOrAnywhere
      }
    }
  }

  // show message if data not available
  AppText {
    id: noDataMessage
    anchors.verticalCenter: parent.verticalCenter
    text: qsTr("Todo data not available. Please check your internet connection.")
    width: parent.width
    horizontalAlignment: Qt.AlignHCenter
  }
}
