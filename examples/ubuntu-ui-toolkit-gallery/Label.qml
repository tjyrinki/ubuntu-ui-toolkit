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

Template {
    objectName: "labelsTemplate"

    TemplateSection {
        className: "Label"

        Column {
            spacing: units.gu(2)

            Label {
                textSize: Label.XxSmall
                text: "Label.XxSmall"
            }
            Label {
                textSize: Label.XSmall
                text: "Label.XSmall"
            }
            Label {
                textSize: Label.Small
                text: "Label.Small"
            }
            Label {
                textSize: Label.Medium
                text: "Label.Medium"
            }
            Label {
                textSize: Label.Large
                text: "Label.Large"
            }
            Label {
                textSize: Label.XLarge
                text: "Label.XLarge"
            }
        }
    }
}
