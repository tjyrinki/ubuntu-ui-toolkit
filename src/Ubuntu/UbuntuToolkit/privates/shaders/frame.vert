/*
 * Copyright 2016 Canonical Ltd.
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
 * Author: Loïc Molinari <loic.molinari@canonical.com>
 */

uniform highp mat4 matrix;
attribute highp vec4 positionAttrib;
attribute mediump vec2 outerCoordAttrib;
attribute mediump vec2 innerCoordAttrib;
attribute lowp vec4 colorAttrib;
varying mediump vec2 outerCoord;
varying mediump vec2 innerCoord;
varying lowp vec4 color;

void main()
{
    outerCoord = outerCoordAttrib;
    innerCoord = innerCoordAttrib;
    color = colorAttrib;
    gl_Position = matrix * positionAttrib;
}
