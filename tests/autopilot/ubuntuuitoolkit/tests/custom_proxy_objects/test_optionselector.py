# -*- Mode: Python; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Copyright (C) 2013, 2014, 2015 Canonical Ltd.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation; version 3.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

import os
import ubuntuuitoolkit
from ubuntuuitoolkit import tests


class OptionSelectorCustomDelegateTestCase(tests.QMLFileAppTestCase):

    path = os.path.abspath(__file__)
    dir_path = os.path.dirname(path)
    test_qml_file_path = os.path.join(
        dir_path,
        'test_optionselector.OptionSelectorCustomDelegateTestCase.qml')

    def setUp(self):
        super().setUp()
        self.option_selector = self.main_view.select_single(
            ubuntuuitoolkit.OptionSelector,
            objectName="test_option_selector_collapsed")

    def test_get_option_count(self):
        """get_option_count() must return number of options"""
        self.assertEqual(self.option_selector.get_option_count(), 5)

    def test_expand(self):
        """expand() must expand a collapsed option elector"""
        self.assertFalse(self.option_selector.currentlyExpanded)
        self.option_selector._expand()
        self.assertTrue(self.option_selector.currentlyExpanded)

    def test_negative_select_text(self):
        """select_text() must raise a ValueError if text does not exist"""
        error = self.assertRaises(
            ubuntuuitoolkit.ToolkitException,
            lambda: self.option_selector.select_option(text="this should fail")
        )
        self.assertEqual(
            "OptionSelectorDelegate with kwargs {'text': 'this should fail'}"
            " not found",
            str(error)
        )

    def test_select_option(self):
        """select_text() must select the text in the OptionSelector"""
        self.option_selector.select_option(objectName="three")
        self.assertEqual(2, self.option_selector.selectedIndex)

    def test_get_selected_text(self):
        """get_selected_text() must return the text selected item"""
        self.option_selector.select_option(text="Value 2")
        self.assertEqual(1, self.option_selector.selectedIndex)
        self.assertEqual(
            self.option_selector.get_selected_text(), "Value 2")

    def test_same_item_2_times(self):
        """Emulator must be able to select 2 items in a row"""
        self.option_selector.select_option(text="Value 3")
        self.assertEqual(
            self.option_selector.get_selected_text(), "Value 3")
        self.assertEqual(2, self.option_selector.selectedIndex)
        self.option_selector.select_option(text="Value 3")
        self.assertEqual(
            self.option_selector.get_selected_text(), "Value 3")
        self.assertEqual(2, self.option_selector.selectedIndex)


class OptionSelectorTestCase(tests.QMLFileAppTestCase):

    path = os.path.abspath(__file__)
    dir_path = os.path.dirname(path)
    test_qml_file_path = os.path.join(
        dir_path, 'test_optionselector.OptionSelectorTestCase.qml')

    def setUp(self):
        super().setUp()
        self.option_selector = self.main_view.select_single(
            ubuntuuitoolkit.OptionSelector,
            objectName="option_selector")

    def test_get_option_count(self):
        """get_option_count() must return number of options"""
        self.assertEqual(self.option_selector.get_option_count(), 5)

    def test_negative_select_text(self):
        """select_text() must raise a ValueError if object and
        text does not exist"""
        error = self.assertRaises(
            ubuntuuitoolkit.ToolkitException,
            lambda: self.option_selector.select_option('Label',
                                                       text="this should fail")
        )
        self.assertEqual(
            "OptionSelectorDelegate with args ('Label',) and kwargs {'text': "
            "'this should fail'} not found",
            str(error)
        )

    def test_select_option(self):
        """select_text() must select the text in the OptionSelector"""
        self.option_selector.select_option('UCLabel', text="Green")
        self.assertEqual(2, self.option_selector.selectedIndex)

    def test_get_selected_text(self):
        """get_selected_text() must return the text selected item"""
        self.option_selector.select_option('UCLabel', text="Blue")
        self.assertEqual(1, self.option_selector.selectedIndex)
        self.assertEqual(
            self.option_selector.get_selected_text(), "Blue")

    def test_same_item_2_times(self):
        """Emulator must be able to select 2 items in a row"""
        self.option_selector.select_option('UCLabel', text="Green")
        self.assertEqual(
            self.option_selector.get_selected_text(), "Green")
        self.assertEqual(2, self.option_selector.selectedIndex)
        self.option_selector.select_option('UCLabel', text="Green")
        self.assertEqual(
            self.option_selector.get_selected_text(), "Green")
        self.assertEqual(2, self.option_selector.selectedIndex)
