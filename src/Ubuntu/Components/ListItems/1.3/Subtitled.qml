/*
 * Copyright 2012 Canonical Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.4
import Ubuntu.Components 1.3

/*!
    \qmltype MultiValue
    \inqmlmodule Ubuntu.Components.ListItems 1.0
    \ingroup ubuntu-listitems
    \brief List item displaying a second string under the main label.
    \note \b{The component is deprecated. Use ListItem component instead.}

    Examples:
    \qml
        import Ubuntu.Components.ListItems 1.3 as ListItem
        Column {
            ListItem.Subtitled {
                text: "Idle"
                subText: "Secondary label"
            }
            ListItem.Subtitled {
                text: "Disabled"
                enabled: false
                subText: "Secondary label"
            }
            ListItem.Subtitled {
                text: "Selected"
                selected: true
                subText: "Secondary label"
            }
            ListItem.Subtitled {
                text: "Progression"
                subText: "Secondary label"
                progression: true
            }
            ListItem.Subtitled {
                text: "Icon"
                subText: "Secondary label"
                iconName: "compose"
            }
            ListItem.Subtitled {
                text: "Multiple lines"
                subText: "This is a multi-line subText.\nUp to 5 lines are supported."
            }
            ListItem.Subtitled {
                text: "Multiple lines"
                subText: "It also works well with icons and progression."
                iconName: "compose"
                progression: true
            }
        }
    \endqml
*/
Base {
    id: subtitledListItem
    __height: Math.max(middleVisuals.height, units.gu(6))

    /*!
      The list of strings that will be shown under the label text
      \qmlproperty string subText
     */
    property alias subText: subLabel.text

    Item  {
        id: middleVisuals
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        height: childrenRect.height + label.anchors.topMargin + subLabel.anchors.bottomMargin

        LabelVisual {
            id: label
            text: subtitledListItem.text
            selected: subtitledListItem.selected
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
        }
        LabelVisual {
            id: subLabel
            selected: subtitledListItem.selected
            secondary: true
            anchors {

                left: parent.left
                right: parent.right
                top: label.bottom
            }
            textSize: Label.Small
            wrapMode: Text.Wrap
            maximumLineCount: 5
        }
    }
}
