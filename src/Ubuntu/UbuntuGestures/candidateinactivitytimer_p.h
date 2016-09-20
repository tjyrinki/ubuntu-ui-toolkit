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

#ifndef UBUNTUGESTURES_CANDIDATE_INACTIVITY_TIMER_H
#define UBUNTUGESTURES_CANDIDATE_INACTIVITY_TIMER_H

#include <QObject>

class QQuickItem;

#include <UbuntuGestures/private/timer_p.h>

UG_NAMESPACE_BEGIN

class UBUNTUGESTURES_EXPORT CandidateInactivityTimer : public QObject {
    Q_OBJECT
public:
    CandidateInactivityTimer(int touchId, QQuickItem *candidate,
                             AbstractTimer *timer,
                             QObject *parent = nullptr);

    virtual ~CandidateInactivityTimer();

    const int durationMs = 1000;

Q_SIGNALS:
    void candidateDefaulted(int touchId, QQuickItem *candidate);
private Q_SLOTS:
    void onTimeout();
private:
    AbstractTimer *m_timer;
    int m_touchId;
    QQuickItem *m_candidate;
};

UG_NAMESPACE_END

#endif // UBUNTUGESTURES_CANDIDATE_INACTIVITY_TIMER_H
