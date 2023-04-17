/*
  Copyright (C) 2016  Brazil
  Copyright (C) 2022  Sutou Kouhei <kou@clear-code.com>

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
/**
 * License: LGPL-2.1
 */
module groonga.time;


private static import core.stdc.time;
private static import groonga.groonga;
private import groonga.groonga: GRN_API;
public import core.sys.posix.sys.time;

extern (C):
nothrow @nogc:

version (Posix)
pragma(inline, true)
pure nothrow @trusted @nogc @live
auto GRN_TIMEVAL_TO_MSEC(scope const core.sys.posix.sys.time.timeval* timeval_)

	in
	{
		assert(timeval_ != null);
	}

	do
	{
		return (timeval_.tv_sec * .GRN_TIME_MSEC_PER_SEC) + (timeval_.tv_nsec / .GRN_TIME_NSEC_PER_MSEC);
	}

version (Posix)
pragma(inline, true)
pure nothrow @trusted @nogc @live
auto GRN_TIMEVAL_TO_NSEC(scope const core.sys.posix.sys.time.timeval* timeval_)

	in
	{
		assert(timeval_ != null);
	}

	do
	{
		return (timeval_.tv_sec * .GRN_TIME_NSEC_PER_SEC) + timeval_.tv_nsec;
	}

enum GRN_TIME_NSEC_PER_SEC = 1000000000;
enum GRN_TIME_NSEC_PER_SEC_F = 1000000000.0;
enum GRN_TIME_NSEC_PER_MSEC = 1000000;
enum GRN_TIME_NSEC_PER_USEC = 1000;

pragma(inline, true)
NSEC GRN_TIME_NSEC_TO_USEC(NSEC)(NSEC nsec)

	do
	{
		return nsec / .GRN_TIME_NSEC_PER_USEC;
	}

pragma(inline, true)
USEC GRN_TIME_USEC_TO_NSEC(USEC)(USEC usec)

	do
	{
		return usec * .GRN_TIME_NSEC_PER_USEC;
	}

enum GRN_TIME_MSEC_PER_SEC = 1000;

enum GRN_TIME_USEC_PER_SEC = 1000000;
enum GRN_TIME_USEC_PER_SEC_F = 1000000.0;
enum GRN_TIME_USEC_PER_MSEC = 1000;

pragma(inline, true)
USEC GRN_TIME_USEC_TO_SEC(USEC)(USEC usec)

	do
	{
		return usec / .GRN_TIME_USEC_PER_SEC;
	}

pragma(inline, true)
MSEC GRN_TIME_MSEC_TO_USEC(MSEC)(MSEC msec)

	do
	{
		return msec * .GRN_TIME_USEC_PER_MSEC;
	}

pragma(inline, true)
long GRN_TIME_PACK(long sec, long usec)

	do
	{
		return (sec * .GRN_TIME_USEC_PER_SEC) + usec;
	}

pragma(inline, true)
void GRN_TIME_UNPACK(TIME_VALUE, SEC, USEC)(TIME_VALUE time_value, ref SEC sec, ref USEC usec)

	do
	{
		sec = time_value / .GRN_TIME_USEC_PER_SEC;
		usec = cast(int)((time_value) % .GRN_TIME_USEC_PER_SEC);
	}

@GRN_API
groonga.groonga.grn_rc grn_timeval_now(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_timeval* tv);

@GRN_API
void grn_time_now(groonga.groonga.grn_ctx* ctx, groonga.groonga.grn_obj* obj);

@GRN_API
groonga.groonga.grn_timeval grn_timeval_from_double(groonga.groonga.grn_ctx* ctx, double value);

alias GRN_TIME_NOW = .grn_time_now;

@GRN_API
groonga.groonga.grn_bool grn_time_to_tm(groonga.groonga.grn_ctx* ctx, long time, core.stdc.time.tm* tm);

@GRN_API
groonga.groonga.grn_bool grn_time_from_tm(groonga.groonga.grn_ctx* ctx, long* time, core.stdc.time.tm* tm);
