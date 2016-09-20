/*
 * Copyright 2013-2015 Canonical Ltd.
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

StyledItem {
    id: item
    property string styleDocument
    onStyleDocumentChanged: style = Theme.createStyleComponent(styleDocument, item)

    property string themeName
    onThemeNameChanged: Theme.name = themeName;

    // make sure we start with Ambiance theme by invoking resetName()
    Component.onCompleted: Theme.name = undefined
}
