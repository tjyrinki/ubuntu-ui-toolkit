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

/*!
    \qmltype OptionSelectorDelegate
    \inqmlmodule Ubuntu.Components
    \ingroup ubuntu-components
    \brief OptionSelector delegate which can display text, subtext and an image from a custom model.

    Examples:
    \qml
        import Ubuntu.Components 1.3
        Column {
            width: 250
            OptionSelector {
                text: i18n.tr("Label")
                model: customModel
                delegate: OptionSelectorDelegate { text: name; subText: description; iconSource: image }
            }
            ListModel {
                id: customModel
                ListElement { name: "Name 1"; description: "Description 1"; image: "images.png" }
                ListElement { name: "Name 2"; description: "Description 2"; image: "images.png" }
                ListElement { name: "Name 3"; description: "Description 3"; image: "images.png" }
                ListElement { name: "Name 4"; description: "Description 4"; image: "images.png" }
            }
        }
    \endqml
*/

import QtQuick 2.4
import Ubuntu.Components.ListItems 1.3 as ListItem
import Ubuntu.Components 1.3 as Toolkit

ListItem.Empty {
    id: option

    __height: units.gu(5)

    /*!
      Subtext which appears below the main text.
     */
    property string subText

    /*!
      \deprecated

      \b{Use iconName or iconSource instead.}

      Left icon url.
     */
    property url icon: iconSource
    onIconChanged: if (icon != iconSource) {
                       console.warn("WARNING: OptionSelectorDelegate.icon is DEPRECATED. " +
                                     "Use iconName and iconSource instead.")
                   }

    /*!
      Constrains the size of the image to nothing greater than that of the delegate. Changes fillMode to Image.PreserveAspectFit.
     */
    property bool constrainImage: false

    /*!
      Whether or not left image is coloured by our theme.
     */
    property bool colourImage: listView.container.colourImage

    /*!
      Colour of left image.
     */
    property color assetColour: listView.container.themeColour

    /*!
      OptionSelector's ListView.
     */
    readonly property ListView listView: ListView.view

    /*!
      Colourising fragment shader.
     */
    readonly property string fragColourShader:
        "varying highp vec2 qt_TexCoord0;
         uniform sampler2D source;
         uniform lowp vec4 colour;
         uniform lowp float qt_Opacity;

         void main() {
            lowp vec4 sourceColour = texture2D(source, qt_TexCoord0);
            gl_FragColor = colour * sourceColour.a * qt_Opacity;
        }"

    showDivider: index !== listView.count - 1 ? 1 : 0
    highlightWhenPressed: false
    selected: ListView.isCurrentItem
    anchors {
        left: parent.left
        right: parent.right
    }
    onClicked: {
        if (listView.container.currentlyExpanded) {
            listView.delegateClicked(index);

            if (!listView.multiSelection) {
                listView.previousIndex = listView.currentIndex;
                listView.currentIndex = index;
            } else {
                selected = !selected;
            }
        }

        if (!listView.expanded && !listView.multiSelection) {
            listView.container.currentlyExpanded = !listView.container.currentlyExpanded;
        }
    }

    Component.onCompleted: {
        height = listView.itemHeight = Qt.binding(function() { return childrenRect.height; });
    }

    //Since we don't want to add states to our divider, we use the exposed alias provided in Empty to access it and alter it's opacity from here.
    states: [ State {
            name: "dividerExpanded"
            when: listView.container.state === "expanded" && index === listView.currentIndex
            PropertyChanges {
                target: option.divider
                opacity: 1
            }
        }, State {
            name: "dividerCollapsed"
            when: listView.container.state === "collapsed" && index === listView.currentIndex
            PropertyChanges {
                target: option.divider
                opacity: 0
            }
        }
    ]

    //As with our states, we apply the transition with our divider as the target.
    transitions: [ Transition {
            from: "dividerExpanded"
            to: "dividerCollapsed"
            Toolkit.UbuntuNumberAnimation {
                target: option.divider
                properties: "opacity"
                duration: Toolkit.UbuntuAnimation.SlowDuration
            }
        }
    ]

    resources: [
        Connections {
            target: listView.container
            onCurrentlyExpandedChanged: {
                imageExpansion.stop();
                selectedImageCollapse.stop();
                deselectedImageCollapse.stop();

                if (listView.container.currentlyExpanded === true) {
                    if (!option.selected) {
                        optionExpansion.start();

                        //Ensure a source change. This solves a bug which happens occasionaly when source is switched correctly. Probably related to the image.source binding.
                        image.source = listView.container.tick
                    } else {
                        imageExpansion.start();
                    }
                } else {
                    if (!option.selected) {
                        optionCollapse.start();
                    } else {
                        if (listView.previousIndex !== listView.currentIndex)
                            selectedImageCollapse.start();
                        else {
                            deselectedImageCollapse.start();
                        }
                    }
                }
            }
        }, SequentialAnimation {
            id: imageExpansion

            PropertyAnimation {
                target: image
                properties: "opacity"
                from : 1.0
                to: 0.0
                duration: Toolkit.UbuntuAnimation.FastDuration
            }
            PauseAnimation { duration: Toolkit.UbuntuAnimation.BriskDuration - Toolkit.UbuntuAnimation.FastDuration }
            PropertyAction {
                target: image
                property: "source"
                value: listView.container.tick
            }
            PropertyAnimation {
                target: image
                properties: "opacity"
                from : 0.0
                to: 1.0
                duration: Toolkit.UbuntuAnimation.FastDuration
            }
        }, PropertyAnimation {
            id: optionExpansion

            target: option
            properties: "opacity"
            from : 0.0
            to: 1.0
            duration: Toolkit.UbuntuAnimation.SlowDuration
        }, SequentialAnimation {
            id: deselectedImageCollapse

            PauseAnimation { duration: Toolkit.UbuntuAnimation.BriskDuration }
            PropertyAnimation {
                target: image
                properties: "opacity"
                from : 1.0
                to: 0.0
                duration: Toolkit.UbuntuAnimation.FastDuration
            }
            PauseAnimation { duration: Toolkit.UbuntuAnimation.FastDuration }
            PropertyAction {
                target: image
                property: "source"
                value: listView.container.chevron
            }
            PropertyAnimation {
                target: image
                properties: "opacity"
                from : 0.0
                to: 1.0
                duration: Toolkit.UbuntuAnimation.FastDuration
            }
        }, SequentialAnimation {
            id: selectedImageCollapse

            PropertyAnimation {
                target: image
                properties: "opacity"
                from : 0.0
                to: 1.0
                duration: Toolkit.UbuntuAnimation.FastDuration
            }
            PauseAnimation { duration: Toolkit.UbuntuAnimation.BriskDuration - Toolkit.UbuntuAnimation.FastDuration }
            PropertyAnimation {
                target: image
                properties: "opacity"
                from : 1.0
                to: 0.0
                duration: Toolkit.UbuntuAnimation.FastDuration
            }
            PauseAnimation { duration: Toolkit.UbuntuAnimation.FastDuration }
            PropertyAction {
                target: image
                property: "source"
                value: listView.container.chevron
            }
            PropertyAnimation {
                target: image
                properties: "opacity"
                from : 0.0
                to: 1.0
                duration: Toolkit.UbuntuAnimation.FastDuration
            }
        }, PropertyAnimation {
                id: optionCollapse
                target: option
                properties: "opacity"
                from : 1.0
                to: 0.0
                duration: Toolkit.UbuntuAnimation.SlowDuration
        }
    ]

    Row {
        spacing: units.gu(1)

        anchors {
            left: parent.left
            leftMargin: units.gu(2)
            verticalCenter: parent.verticalCenter
        }

        Image {
            id: leftIcon
            objectName: "icon"

            height: constrainImage ? option.height : sourceSize.height
            source: option.iconSource
            fillMode: constrainImage ? Image.PreserveAspectFit : Image.Stretch

            ShaderEffect {
                property color colour: assetColour
                property Image source: parent

                width: source.width
                height: source.height
                visible: colourImage

                fragmentShader: fragColourShader
             }
        }

        Column {
            anchors {
                verticalCenter: parent.verticalCenter
            }
            clip: true
            width: option.width - leftIcon.width - image.width
                - parent.spacing * 2 - parent.anchors.leftMargin

            Toolkit.Label {
                text: option.text === "" ? modelData : option.text
                width: parent.width
                elide: Text.ElideRight
            }
            Toolkit.Label {
                text: option.subText
                width: parent.width
                elide: Text.ElideRight
                visible: option.subText !== "" ? true : false
                textSize: Toolkit.Label.Small
            }
        }

        Image {
            id: image

            width: units.gu(2)
            height: units.gu(2)
            source: listView.expanded || listView.multiSelection ? listView.container.tick : listView.container.chevron
            opacity: option.selected ? 1.0 : 0.0
            anchors {
                verticalCenter: parent.verticalCenter
            }

            //Our behaviour is only enabled for our expanded list due to flickering bugs in relation to all this other animations running on the expanding version.
            Behavior on opacity {
                enabled: listView.expanded

                Toolkit.UbuntuNumberAnimation {
                    properties: "opacity"
                    duration: Toolkit.UbuntuAnimation.FastDuration
                }
            }

            ShaderEffect {
                property color colour: assetColour
                property Image source: parent

                width: source.width
                height: source.height

                fragmentShader: fragColourShader
             }
        }
    }
}
