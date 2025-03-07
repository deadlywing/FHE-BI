# Copyright 2021 Ant Group Co., Ltd.
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

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def fhebi_deps():
    _com_github_xtensor_xtensor()
    _com_github_xtensor_xtl()
    _com_github_openfheorg_openfhe()

def _com_github_xtensor_xtensor():
    maybe(
        http_archive,
        name = "xtensor",
        sha256 = "32d5d9fd23998c57e746c375a544edf544b74f0a18ad6bc3c38cbba968d5e6c7",
        strip_prefix = "xtensor-0.25.0",
        build_file = "@fhe_bi//bazel:xtensor.BUILD",
        type = "tar.gz",
        urls = [
            "https://github.com/xtensor-stack/xtensor/archive/refs/tags/0.25.0.tar.gz",
        ],
    )

def _com_github_xtensor_xtl():
    maybe(
        http_archive,
        name = "xtl",
        sha256 = "44fb99fbf5e56af5c43619fc8c29aa58e5fad18f3ba6e7d9c55c111b62df1fbb",
        strip_prefix = "xtl-0.7.7",
        build_file = "@fhe_bi//bazel:xtl.BUILD",
        type = "tar.gz",
        urls = [
            "https://github.com/xtensor-stack/xtl/archive/refs/tags/0.7.7.tar.gz",
        ],
    )

def _com_github_openfheorg_openfhe():
    # OpenFHE backend and dependencies
    maybe(
        git_repository,
        name = "cereal",
        build_file = "@fhe_bi//bazel/openfhe:cereal.BUILD",
        commit = "ebef1e929807629befafbb2918ea1a08c7194554",
        remote = "https://github.com/USCiLab/cereal.git",
    )

    maybe(
        git_repository,
        name = "rapidjson",
        build_file = "@fhe_bi//bazel/openfhe:rapidjson.BUILD",
        commit = "f54b0e47a08782a6131cc3d60f94d038fa6e0a51",
        remote = "https://github.com/Tencent/rapidjson.git",
    )

    maybe(
        git_repository,
        name = "openfhe",
        build_file = "@fhe_bi//bazel/openfhe:openfhe.BUILD",
        # use v1.1.4, 2024-03-08
        # commit = "94fd76a1d965cfde13f2a540d78ce64146fc2700",
        # use v1.2.3, 2024-10-30
        commit = "7b8346f4eac27121543e36c17237b919e03ec058",
        patches = ["@fhe_bi//bazel/openfhe:add_config_core.patch"],
        remote = "https://github.com/openfheorg/openfhe-development.git",
    )
