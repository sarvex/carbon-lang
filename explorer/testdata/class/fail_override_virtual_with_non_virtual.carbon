// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// NOAUTOUPDATE

package ExplorerTest api;

base class A {
  virtual fn Foo[self: Self]() {}
}

class B {
  extend base: A;
  // CHECK:STDERR: COMPILATION ERROR: fail_override_virtual_with_non_virtual.carbon:[[@LINE+1]]: Error declaring `Foo`: method is declared virtual in base class, use `impl` to override it.
  fn Foo[self: Self]() {}
}

fn Main() -> i32 {
  return 0;
}
