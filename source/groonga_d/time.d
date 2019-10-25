/*
  Copyright(C) 2016 Brazil

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
module groonga_d.time;


private static import groonga_d.groonga;
private static import core.stdc.time;

extern(C):
nothrow @nogc:

/+
#include <time.h>

#define GRN_TIMEVAL_TO_MSEC(timeval) (((timeval)->tv_sec * GRN_TIME_MSEC_PER_SEC) + ((timeval)->tv_nsec / GRN_TIME_NSEC_PER_MSEC))
+/

enum GRN_TIME_NSEC_PER_SEC = 1000000000;
enum GRN_TIME_NSEC_PER_SEC_F = 1000000000.0;
enum GRN_TIME_NSEC_PER_MSEC = 1000000;
/+
#define GRN_TIME_NSEC_PER_USEC (GRN_TIME_NSEC_PER_SEC / GRN_TIME_USEC_PER_SEC)
+/
enum GRN_TIME_MSEC_PER_SEC = 1000;
/+
#define GRN_TIME_NSEC_TO_USEC(nsec) ((nsec) / GRN_TIME_NSEC_PER_USEC)
#define GRN_TIME_USEC_TO_NSEC(usec) ((usec) * GRN_TIME_NSEC_PER_USEC)
+/

enum GRN_TIME_USEC_PER_SEC = 1000000;
enum GRN_TIME_USEC_PER_SEC_F = 1000000.0;
/+
#define GRN_TIME_PACK(sec, usec) ((long)(sec) * GRN_TIME_USEC_PER_SEC + (usec))
#define GRN_TIME_UNPACK(time_value, sec, usec) sec = cast(time_value)(/ GRN_TIME_USEC_PER_SEC); usec = cast(time_value)( % GRN_TIME_USEC_PER_SEC);
+/

//GRN_API
groonga_d.groonga.grn_rc grn_timeval_now(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_timeval* tv);

//GRN_API
void grn_time_now(groonga_d.groonga.grn_ctx* ctx, groonga_d.groonga.grn_obj* obj);

/+
#define GRN_TIME_NOW(ctx, obj) (grn_time_now((ctx), (obj)))
+/

//GRN_API
ubyte grn_time_to_tm(groonga_d.groonga.grn_ctx* ctx, long time, core.stdc.time.tm* tm);

//GRN_API
ubyte grn_time_from_tm(groonga_d.groonga.grn_ctx* ctx, long* time, core.stdc.time.tm* tm);
