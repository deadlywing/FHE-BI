# Copyright 2025 Ant Group Co., Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""
warpper bazel cc_xx to modify flags, copied from SPU
"""

load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library", "cc_test")
load("@yacl//bazel:yacl.bzl", "yacl_cmake_external")

WARNING_FLAGS = [
    "-Wall",
    "-Wextra",
    "-Werror",
    "-Wno-unused-parameter",
]

DEBUG_FLAGS = ["-O0", "-g"]
RELEASE_FLAGS = ["-O2"]
FAST_FLAGS = ["-O1"]

def _fhebi_copts():
    return select({
        "@fhe_bi//bazel:fhebi_build_as_release": RELEASE_FLAGS,
        "@fhe_bi//bazel:fhebi_build_as_debug": DEBUG_FLAGS,
        "@fhe_bi//bazel:fhebi_build_as_fast": FAST_FLAGS,
        "//conditions:default": FAST_FLAGS,
    }) + WARNING_FLAGS

def fhebi_cc_binary(
        linkopts = [],
        copts = [],
        **kargs):
    cc_binary(
        linkopts = linkopts,
        copts = copts + _fhebi_copts(),
        linkstatic = True,
        **kargs
    )

def fhebi_cc_library(
        linkopts = [],
        copts = [],
        deps = [],
        local_defines = [],
        **kargs):
    cc_library(
        linkopts = linkopts,
        copts = _fhebi_copts() + copts,
        deps = deps + [
            "@spdlog//:spdlog",
        ],
        local_defines = local_defines + [
            "FHEBI_BUILD",
        ],
        linkstatic = True,
        **kargs
    )

fhebi_cmake_external = yacl_cmake_external

def fhebi_cc_test(
        linkopts = [],
        copts = [],
        deps = [],
        local_defines = [],
        **kwargs):
    cc_test(
        # -lm for tcmalloc
        linkopts = linkopts + ["-lm"],
        copts = _fhebi_copts() + copts,
        deps = [
            "@googletest//:gtest_main",
        ] + deps,
        local_defines = local_defines + [
            "FHEBI_BUILD",
        ],
        linkstatic = True,
        **kwargs
    )
