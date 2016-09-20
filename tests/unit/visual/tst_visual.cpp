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
 *
 */
#include <QtQuickTest/quicktest.h>
#include <qqml.h>

#include "tabsmodel.h"

class Register
{
public:
    Register()
    {
        qmlRegisterType<TabsModel>("TestObjects", 0, 1, "TabsModel");

        savedDataDirs = qgetenv("XDG_DATA_DIRS");
        qputenv("XDG_DATA_DIRS", "/usr/share");
    }

    ~Register()
    {
        qputenv("XDG_DATA_DIRS", savedDataDirs);
    }

private:
    QByteArray savedDataDirs;
};

Register r;

QUICK_TEST_MAIN(components)
