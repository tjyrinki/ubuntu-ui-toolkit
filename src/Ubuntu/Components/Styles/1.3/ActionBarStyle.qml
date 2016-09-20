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

/*!
    \qmltype ActionBarStyle
    \inqmlmodule Ubuntu.Components.Styles 1.3
    \ingroup style-api
    \brief Style API for action bar.

    The component defines the style API for the \l ActionBar component.
  */
Item {
    /*!
      The color of the background of the action bar.
     */
    property color backgroundColor

    /*!
      Configuration of the colors of the action buttons in the action bar.
     */
    readonly property ActionItemProperties buttons: ActionItemProperties { }

    /*!
      The default action delegate if the styled item does
      not provide a different delegate.
     */
    property Component defaultDelegate

    /*!
      The default number of slots for the action bar.
     */
    property int defaultNumberOfSlots

    /*!
      The icon name for action of the overflow button.
     */
    property string overflowIconName

    /*!
      The icon source for the action of the overflow button. Setting the icon source
      will override the icon name.
     */
    property url overflowIconSource

    /*!
      The text for the action of the overflow button, which may be used
      in the action delegate.
     */
    property string overflowText
}
