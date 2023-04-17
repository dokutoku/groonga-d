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
module groonga.version_;


private static import groonga.groonga;

extern (C):
nothrow @nogc:

enum GRN_VERSION = "13.0.1";
enum GRN_VERSION_MAJOR = 13;
enum GRN_VERSION_MINOR = 0;
enum GRN_VERSION_MICRO = 1;

pragma(inline, true)
bool GRN_VERSION_OR_LATER(int major, int minor, int micro)

	do
	{
		return (.GRN_VERSION_MAJOR > major) || ((.GRN_VERSION_MAJOR == major) && (.GRN_VERSION_MINOR > minor)) || ((.GRN_VERSION_MAJOR == major) && (.GRN_VERSION_MINOR == minor) && (.GRN_VERSION_MICRO >= micro));
	}
