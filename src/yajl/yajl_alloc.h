/*
 * Copyright (c) 2007-2014, Lloyd Hilaiel <me@lloyd.io>
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

/**
 * This is the common header used to declare a yajl_alloc_funcs object and to
 * provide helper macros for calling the memory allocation routines set within
 * such an object, as well as the prototype for the helper function which can be
 * used to assign the default allocator functions to such an object.
 **/

#ifndef __YAJL_ALLOC_H__
#define __YAJL_ALLOC_H__

#include "yajl/yajl_common.h"

#define YA_MALLOC(afs, sz) (afs)->malloc((afs)->ctx, (sz))
#define YA_FREE(afs, ptr) (afs)->free((afs)->ctx, (ptr))
#define YA_REALLOC(afs, ptr, sz) (afs)->realloc((afs)->ctx, (ptr), (sz))

void yajl_set_default_alloc_funcs(yajl_alloc_funcs * yaf);

#endif
