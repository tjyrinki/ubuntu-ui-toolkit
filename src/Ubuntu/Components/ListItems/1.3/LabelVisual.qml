/*
 * Copyright 2015 Canonical Ltd.
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

// internal helper class for text inside the list items.
Label {
    id: label
    property bool selected: false
    property bool secondary: false

    // FIXME: very ugly hack to detect whether the list item is inside a Popover
    property bool overlay: isInsideOverlay(label)
    function isInsideOverlay(item) {
        if (!item.parent) return false;
        return item.parent.hasOwnProperty("pointerTarget") || label.isInsideOverlay(item.parent)
    }

    elide: Text.ElideRight
    color: selected
           ? theme.palette.selected.backgroundText
           : (secondary
              ? (overlay
                 ? theme.palette.normal.overlaySecondaryText
                 : theme.palette.normal.backgroundSecondaryText)
              : (overlay
                 ? theme.palette.normal.overlayText
                 : theme.palette.normal.backgroundText))
    opacity: label.enabled ? 1.0 : 0.5
}
