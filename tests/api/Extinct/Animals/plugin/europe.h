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
 * Author: Christian Dywan <christian.dywan@canonical.com>
 */

#ifndef EA_EUROPE_H
#define EA_EUROPE_H

#include <QtCore/QObject>

class EAEurope : public QObject
{
    Q_OBJECT
    Q_ENUMS(ModernContinent)

public:
    static EAEurope& instance() {
        static EAEurope instance;
        return instance;
    }

    enum ModernContinent {
        America,
        Europe,
    };
    explicit EAEurope(QObject *parent = 0);
};

class EAEurope42 : public EAEurope
{
    Q_OBJECT
    Q_PROPERTY(quint16 era READ era NOTIFY eraChanged REVISION 1)
public:
    explicit EAEurope42(QObject *parent = 0) : EAEurope(parent)
    {
    }

    Q_INVOKABLE quint16 era(quint8 year);

Q_SIGNALS:
    void eraChanged();

protected:
    virtual quint16 era() const
    {
        return 0;
    }
};

#endif // EA_EUROPE_H
