/*
  Copyright(C) 2018 Kouhei Sutou <kou@clear-code.com>

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/
module groonga_d.version_;


private static import groonga_d.groonga;

extern(C):
nothrow @nogc:

enum GRN_VERSION = "10.0.6";
enum GRN_VERSION_MAJOR = 10;
enum GRN_VERSION_MINOR = 0;
enum GRN_VERSION_MICRO = 6;

/+
#define GRN_VERSION_OR_LATER(major, minor, micro) (GRN_VERSION_MAJOR > (major) || (GRN_VERSION_MAJOR == (major) && GRN_VERSION_MINOR > (minor)) || (GRN_VERSION_MAJOR == (major) && GRN_VERSION_MINOR == (minor) && GRN_VERSION_MICRO >= (micro)))
+/
