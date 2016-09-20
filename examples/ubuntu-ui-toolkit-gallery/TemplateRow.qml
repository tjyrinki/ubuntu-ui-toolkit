/*
 * Copyright 2013 Canonical Ltd.
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

import QtQuick 2.0
import Ubuntu.Components 1.3

Item {
    id: templateRow

    property string title
    property real titleWidth: units.gu(10)
    property alias spacing: contentRow.spacing
    default property alias content: contentRow.children

    height: Math.max(contentRow.height, label.height)
    width: parent ? parent.width : 0

    Label {
        id: label
        text: templateRow.title
        width: templateRow.titleWidth
        anchors.left: parent.left
        anchors.top: contentRow.top
        elide: Text.ElideRight
        font.weight: Font.Light
    }

    Row {
        id: contentRow

        anchors.left: label.right
        anchors.leftMargin: units.gu(2)
        anchors.right: parent.right
        spacing: units.gu(2)
    }
}
