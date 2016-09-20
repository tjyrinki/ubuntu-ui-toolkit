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

#ifndef LISTITEMDRAGAREA_H
#define LISTITEMDRAGAREA_H

#include <ubuntutoolkitglobal.h>
#include "uclistitem_p.h"
#include <QtCore/QBasicTimer>
#include <QtCore/QPointer>

class QQuickFlickable;

UT_NAMESPACE_BEGIN

class ListItemDragArea : public QQuickItem
{
    Q_OBJECT
public:
    explicit ListItemDragArea(QQuickItem *parent = 0);
    void init(UCViewItemsAttached *viewItems);
    void reset();

protected:
    void timerEvent(QTimerEvent *event) override;
    void mousePressEvent(QMouseEvent *event) override;
    void mouseReleaseEvent(QMouseEvent *event) override;
    void mouseMoveEvent(QMouseEvent *event) override;

private:
    QBasicTimer scrollTimer;
    QPointer<UCListItem> item;
    QQuickFlickable *listView;
    UCViewItemsAttached *viewAttached;
    QPointF lastPos, mousePos;
    int scrollDirection;
    int fromIndex, toIndex, min, max;

    QPointF mapDragAreaPos();
    int indexAt(qreal x, qreal y);
    UCListItem *itemAt(qreal x, qreal y);
    void createDraggedItem(UCListItem *baseItem);
    void updateDraggedItem();
};

UT_NAMESPACE_END

#endif // LISTITEMDRAGAREA_H
