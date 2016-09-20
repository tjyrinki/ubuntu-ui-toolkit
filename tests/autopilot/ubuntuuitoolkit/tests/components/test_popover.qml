/*
 * Copyright 2014-2015 Canonical Ltd.
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
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0

MainView {
    width: units.gu(48)
    height: units.gu(60)
    objectName: "mainView"

    Page {
        title: "Popover"

        Column {
            Button {
                objectName: "button_small"
                text: "Small"
                onClicked: PopupUtils.open(smallDialogComponent)
            }
            Button {
                objectName: "button_huge"
                text: "Huge"
                onClicked: PopupUtils.open(hugeDialogComponent)
            }
        }

        Component {
            id: smallDialogComponent
            Dialog {
                objectName: "dialog_small"
                Column {
                    Button {
                        text: "Just a button"
                    }
                }
            }
        }

        Component {
            id: hugeDialogComponent
            Dialog {
                objectName: "dialog_huge"
                Column {
                    Repeater {
                        model: 50

                        Button {
                            objectName: "buttlet%1".arg(index)
                            text: "Button %1".arg(index)
                        }
                    }
                }
            }
        }
    }
}
