// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn A() -> i32 { return 1; }
fn B() -> i32 { return 2; }

fn F() -> i32 {
  return if true then A() else B();
}

fn G() -> i32 {
  return if false then A() else B();
}

// CHECK:STDOUT: --- constant_condition.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace {.A = %A, .B = %B, .F = %F, .G = %G}
// CHECK:STDOUT:   %A: <function> = fn_decl @A
// CHECK:STDOUT:   %B: <function> = fn_decl @B
// CHECK:STDOUT:   %F: <function> = fn_decl @F
// CHECK:STDOUT:   %G: <function> = fn_decl @G
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @A() -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc7: i32 = int_literal 1
// CHECK:STDOUT:   return %.loc7
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @B() -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc8: i32 = int_literal 2
// CHECK:STDOUT:   return %.loc8
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F() -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc11_13: bool = bool_literal true
// CHECK:STDOUT:   if %.loc11_13 br !if.expr.then else br !if.expr.else
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then:
// CHECK:STDOUT:   %A.ref: <function> = name_ref A, file.%A
// CHECK:STDOUT:   %.loc11_24.1: init i32 = call %A.ref()
// CHECK:STDOUT:   %.loc11_24.2: i32 = value_of_initializer %.loc11_24.1
// CHECK:STDOUT:   %.loc11_24.3: i32 = converted %.loc11_24.1, %.loc11_24.2
// CHECK:STDOUT:   br !if.expr.result(%.loc11_24.3)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else:
// CHECK:STDOUT:   %B.ref: <function> = name_ref B, file.%B
// CHECK:STDOUT:   %.loc11_33: init i32 = call %B.ref()
// CHECK:STDOUT:   %.loc11_27.1: i32 = value_of_initializer %.loc11_33
// CHECK:STDOUT:   %.loc11_27.2: i32 = converted %.loc11_33, %.loc11_27.1
// CHECK:STDOUT:   br !if.expr.result(%.loc11_27.2)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result:
// CHECK:STDOUT:   %.loc11_10: i32 = block_arg !if.expr.result
// CHECK:STDOUT:   return %.loc11_10
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G() -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc15_13: bool = bool_literal false
// CHECK:STDOUT:   if %.loc15_13 br !if.expr.then else br !if.expr.else
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then:
// CHECK:STDOUT:   %A.ref: <function> = name_ref A, file.%A
// CHECK:STDOUT:   %.loc15_25.1: init i32 = call %A.ref()
// CHECK:STDOUT:   %.loc15_25.2: i32 = value_of_initializer %.loc15_25.1
// CHECK:STDOUT:   %.loc15_25.3: i32 = converted %.loc15_25.1, %.loc15_25.2
// CHECK:STDOUT:   br !if.expr.result(%.loc15_25.3)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else:
// CHECK:STDOUT:   %B.ref: <function> = name_ref B, file.%B
// CHECK:STDOUT:   %.loc15_34: init i32 = call %B.ref()
// CHECK:STDOUT:   %.loc15_28.1: i32 = value_of_initializer %.loc15_34
// CHECK:STDOUT:   %.loc15_28.2: i32 = converted %.loc15_34, %.loc15_28.1
// CHECK:STDOUT:   br !if.expr.result(%.loc15_28.2)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result:
// CHECK:STDOUT:   %.loc15_10: i32 = block_arg !if.expr.result
// CHECK:STDOUT:   return %.loc15_10
// CHECK:STDOUT: }
// CHECK:STDOUT:
