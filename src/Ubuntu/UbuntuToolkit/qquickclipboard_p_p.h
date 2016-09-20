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
 * Author: Zsombor Egri <zsombor.egri@canonical.com>
 */

#ifndef QQUICKCLIPBOARD_P_H
#define QQUICKCLIPBOARD_P_H

#include "qquickclipboard_p.h"
#include <QtGui/QClipboard>
#include <QtCore/private/qobject_p.h>

UT_NAMESPACE_BEGIN

class QQuickMimeData;
class QQuickClipboardPrivate : public QObjectPrivate {
    Q_DECLARE_PUBLIC(QQuickClipboard)
public:
    QQuickClipboardPrivate();
    void init();

    QClipboard *clipboard;
    QClipboard::Mode mode;
    QQuickMimeData *mimeData;

    void updateMimeData();
};

UT_NAMESPACE_END

#endif // QQUICKCLIPBOARD_P_H
