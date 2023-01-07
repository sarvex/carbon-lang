// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// RUN: %{not} %{explorer-run}
// RUN: %{not} %{explorer-run-trace}
// CHECK:STDERR: Please report issues to https://github.com/carbon-language/carbon-lang/issues and include the crash backtrace.
// CHECK:STDERR: Stack dump:
// CHECK:STDERR: 0.	Program arguments: ./bazel-bin/explorer/explorer {{.*}}/explorer/testdata/destructor/fail_delete_without_new.carbon
// CHECK:STDERR: #0 0x0000556d081ed133 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) (./bazel-bin/explorer/explorer+0x1ca133)
// CHECK:STDERR: #1 0x0000556d081eaeee llvm::sys::RunSignalHandlers() (./bazel-bin/explorer/explorer+0x1c7eee)
// CHECK:STDERR: #2 0x0000556d081ed51a SignalHandler(int) Signals.cpp:0:0
// CHECK:STDERR: #3 0x00007fdc92b41520 (/lib/x86_64-linux-gnu/libc.so.6+0x42520)
// CHECK:STDERR: #4 0x00007fdc92b95a7c pthread_kill (/lib/x86_64-linux-gnu/libc.so.6+0x96a7c)
// CHECK:STDERR: #5 0x00007fdc92b41476 gsignal (/lib/x86_64-linux-gnu/libc.so.6+0x42476)
// CHECK:STDERR: #6 0x00007fdc92b277f3 abort (/lib/x86_64-linux-gnu/libc.so.6+0x287f3)
// CHECK:STDERR: #7 0x0000556d081b2a72 Carbon::Internal::ExitingStream::Done() (./bazel-bin/explorer/explorer+0x18fa72)
// CHECK:STDERR: FATAL failure at explorer/interpreter/heap.cpp:85: deallocating an already dead value: B{} base A{}

package ExplorerTest api;


base class A{
    virtual destructor[self: Self]{
        Print("DESTRUCTOR A");
    }
}

class B extends A {
    impl destructor[self: Self]{
        Print("DESTRUCTOR B");
    }
}

fn Main() -> i32 {
  var b: B = {.base={}};
  var pb: B* = &b;
  heap.Delete(pb);
  return 0;
}
