# Part of the Carbon Language project, under the Apache License v2.0 with LLVM
# Exceptions. See /LICENSE for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

# This file is symlinked into a configured Clang toolchain repository as the
# root `BUILD` file for that repository.

load(":cc_toolchain_config.bzl", "cc_local_toolchain_suite")

cc_local_toolchain_suite(
    name = "bazel_cc_toolchain",
    cpus = [
        "aarch64",
        "darwin",
        "darwin_arm64",
        "freebsd",
        "k8",
        "x64_windows",
    ],
)
