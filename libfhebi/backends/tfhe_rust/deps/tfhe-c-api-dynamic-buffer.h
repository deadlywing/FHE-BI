// Copyright © 2024 ZAMA.
// All rights reserved.

#ifndef TFHE_DYNAMIC_BUFFER_C_API_H
#define TFHE_DYNAMIC_BUFFER_C_API_H

// Warning, this file is autogenerated by cbindgen. Do not modify this manually.

#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>

typedef struct DynamicBuffer {
  uint8_t *pointer;
  size_t length;
  int (*destructor)(uint8_t *, size_t);
} DynamicBuffer;

typedef struct DynamicBufferView {
  const uint8_t *pointer;
  size_t length;
} DynamicBufferView;

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

int destroy_dynamic_buffer(struct DynamicBuffer *dynamic_buffer);

#ifdef __cplusplus
}  // extern "C"
#endif  // __cplusplus

#endif /* TFHE_DYNAMIC_BUFFER_C_API_H */
