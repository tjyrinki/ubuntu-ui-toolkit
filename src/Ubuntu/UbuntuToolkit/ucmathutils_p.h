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
 *
 */

#ifndef UCMATHUTILS_H
#define UCMATHUTILS_H

#include <QObject>
#include <ubuntutoolkitglobal.h>

QT_FORWARD_DECLARE_CLASS(QQmlEngine)
QT_FORWARD_DECLARE_CLASS(QJSEngine)

UT_NAMESPACE_BEGIN

class UBUNTUTOOLKIT_EXPORT UCMathUtils : public QObject
{
    Q_OBJECT
public:
    explicit UCMathUtils(QObject *parent = 0);

    Q_INVOKABLE static double clamp(double x, double min, double max);
    Q_INVOKABLE static double lerp(double delta, double from, double to);
    Q_INVOKABLE static double projectValue(double x, double xmin, double xmax, double ymin, double ymax);
    Q_INVOKABLE static double clampAndProject(double x, double xmin, double xmax, double ymin, double ymax);
};

UT_NAMESPACE_END

#endif // UCMATHUTILS_H
