/*
 * Copyright 2016 Canonical Ltd.
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
import Ubuntu.Test 1.3
import Ubuntu.Components 1.3
import Ubuntu.Components.Labs 1.0

Item {
    id: main
    width: units.gu(200)
    height: units.gu(70)

    Component {
        id: testLayout
        SplitView {
            id: splitView
            anchors.fill: parent
            property int columns: 4

            layouts: [
                SplitViewLayout {
                    id: mainLayout
                    when: splitView.columns == 4
                    ViewColumn {
                        preferredWidth: units.gu(40)
                        maximumWidth: units.gu(100)
                    }
                    ViewColumn {
                        fillWidth: true
                        minimumWidth: units.gu(10)
                        maximumWidth: units.gu(150)
                    }
                    ViewColumn {
                        preferredWidth: units.gu(50)
                    }
                    ViewColumn {
                        fillWidth: true
                        minimumWidth: units.gu(15)
                    }
                },
                SplitViewLayout {
                    when: splitView.columns == 2
                    ViewColumn {
                        preferredWidth: units.gu(10)
                        minimumWidth: units.gu(30)
                    }
                    ViewColumn {
                        fillWidth: true
                        minimumWidth: units.gu(40)
                    }
                }
            ]

            Repeater {
                objectName: "ignored"
                model: splitView.columns
                Page {
                    objectName: "column" + index
                    height: splitView.height
                    header: PageHeader {
                        title: "Column #" + index
                    }

                    Rectangle {
                        color: UbuntuColors.red
                        anchors.fill: parent
                    }
                }
            }
        }
    }

    Sections {
        id: sections
        actions: [
            Action {
                text: "4 columns"
                onTriggered: testLoader.item.columns = 4
            },
            Action {
                text: "2 columns"
                onTriggered: testLoader.item.columns = 2
            }
        ]
    }

    Loader {
        id: testLoader
        anchors {
            fill: parent
            topMargin: sections.height
        }
        asynchronous: false
        sourceComponent: testLayout
    }

    UbuntuTestCase {
        when: windowShown

        function cleanup() {
            testLoader.sourceComponent = null;
        }

        function loadTest(testCase) {
            testLoader.asynchronous = false;
            testLoader.sourceComponent = testCase;
            tryCompare(testLoader, "status", Loader.Ready)
            verify(testLoader.item);
            waitForRendering(testLoader.item);
            return testLoader.item;
        }

        function test_patched_page_anchoring() {
            var test = loadTest(testLayout);
            // we cannot set expectFail() on ignoreWarning, therefore we must check
            // if the Pages are having proper widths and different x values set
            var prevX = -1;
            for (var i in test.children) {
                var child = test.children[i];
                if (child.objectName != "ignored") {
                    compare(child.objectName, "column" + i);
                    verify(child.width > 0, "column width not set");
                    verify(prevX < child.x, "column not positioned properly");
                    prevX = child.x;
                }
            }
        }
    }
}
