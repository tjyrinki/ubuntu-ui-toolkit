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

import QtQuick 2.0
import QtTest 1.0
import Ubuntu.Components 1.1

TestCase {
     name: "ActivityIndicatorAPI"

     function test_running() {
        compare(activityIndicator.running,false,"Running is boolean and false by default")
        activityIndicator.running = true
        compare(activityIndicator.running,true,"can set/get running")
     }

     function test_size() {
        compare(activityIndicator.implicitWidth, units.gu(3), "Default implicitWidth is 3GUs")
        compare(activityIndicator.implicitHeight, units.gu(3), "Default implicitHeight is 3GUs")
        compare(activityIndicator.width, units.gu(3), "Default width is 3GUs")
        compare(activityIndicator.height, units.gu(3), "Default height is 3GUs")
     }

     ActivityIndicator {
         id: activityIndicator
     }
}
