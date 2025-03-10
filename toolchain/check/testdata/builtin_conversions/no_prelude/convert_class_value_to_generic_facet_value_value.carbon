// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/check/testdata/builtin_conversions/no_prelude/convert_class_value_to_generic_facet_value_value.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/check/testdata/builtin_conversions/no_prelude/convert_class_value_to_generic_facet_value_value.carbon

// --- core.carbon

package Core;

interface ImplicitAs(T:! type) {
  fn Convert[self: Self]() -> T;
}

// --- convert_class_value_to_generic_facet_value_value.carbon

library "[[@TEST_NAME]]";

import Core;

interface Generic(Scalar:! type) {
  fn F();
}

class GenericParam {}

class ImplsGeneric {}
impl ImplsGeneric as Generic(GenericParam) {
  fn F() {}
}

fn CallGenericMethod2[T:! type, U:! Generic(T)](a: U, s: T) {
  U.F();
}

fn G() {
  CallGenericMethod2({} as ImplsGeneric, {} as GenericParam);
}

// CHECK:STDOUT: --- core.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %ImplicitAs.type.96f: type = generic_interface_type @ImplicitAs [concrete]
// CHECK:STDOUT:   %ImplicitAs.generic: %ImplicitAs.type.96f = struct_value () [concrete]
// CHECK:STDOUT:   %ImplicitAs.type.07f: type = facet_type <@ImplicitAs, @ImplicitAs(%T)> [symbolic]
// CHECK:STDOUT:   %Self: %ImplicitAs.type.07f = bind_symbolic_name Self, 1 [symbolic]
// CHECK:STDOUT:   %Self.as_type: type = facet_access_type %Self [symbolic]
// CHECK:STDOUT:   %Convert.type: type = fn_type @Convert, @ImplicitAs(%T) [symbolic]
// CHECK:STDOUT:   %Convert: %Convert.type = struct_value () [symbolic]
// CHECK:STDOUT:   %ImplicitAs.assoc_type: type = assoc_entity_type %ImplicitAs.type.07f [symbolic]
// CHECK:STDOUT:   %assoc0: %ImplicitAs.assoc_type = assoc_entity element0, @ImplicitAs.%Convert.decl [symbolic]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [concrete] {
// CHECK:STDOUT:     .ImplicitAs = %ImplicitAs.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %ImplicitAs.decl: %ImplicitAs.type.96f = interface_decl @ImplicitAs [concrete = constants.%ImplicitAs.generic] {
// CHECK:STDOUT:     %T.patt.loc4_22.1: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc4_22.2 (constants.%T.patt)]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %T.loc4_22.1: type = bind_symbolic_name T, 0 [symbolic = %T.loc4_22.2 (constants.%T)]
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic interface @ImplicitAs(%T.loc4_22.1: type) {
// CHECK:STDOUT:   %T.loc4_22.2: type = bind_symbolic_name T, 0 [symbolic = %T.loc4_22.2 (constants.%T)]
// CHECK:STDOUT:   %T.patt.loc4_22.2: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc4_22.2 (constants.%T.patt)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %ImplicitAs.type: type = facet_type <@ImplicitAs, @ImplicitAs(%T.loc4_22.2)> [symbolic = %ImplicitAs.type (constants.%ImplicitAs.type.07f)]
// CHECK:STDOUT:   %Self.2: %ImplicitAs.type.07f = bind_symbolic_name Self, 1 [symbolic = %Self.2 (constants.%Self)]
// CHECK:STDOUT:   %Convert.type: type = fn_type @Convert, @ImplicitAs(%T.loc4_22.2) [symbolic = %Convert.type (constants.%Convert.type)]
// CHECK:STDOUT:   %Convert: @ImplicitAs.%Convert.type (%Convert.type) = struct_value () [symbolic = %Convert (constants.%Convert)]
// CHECK:STDOUT:   %ImplicitAs.assoc_type: type = assoc_entity_type @ImplicitAs.%ImplicitAs.type (%ImplicitAs.type.07f) [symbolic = %ImplicitAs.assoc_type (constants.%ImplicitAs.assoc_type)]
// CHECK:STDOUT:   %assoc0.loc5_32.2: @ImplicitAs.%ImplicitAs.assoc_type (%ImplicitAs.assoc_type) = assoc_entity element0, %Convert.decl [symbolic = %assoc0.loc5_32.2 (constants.%assoc0)]
// CHECK:STDOUT:
// CHECK:STDOUT:   interface {
// CHECK:STDOUT:     %Self.1: @ImplicitAs.%ImplicitAs.type (%ImplicitAs.type.07f) = bind_symbolic_name Self, 1 [symbolic = %Self.2 (constants.%Self)]
// CHECK:STDOUT:     %Convert.decl: @ImplicitAs.%Convert.type (%Convert.type) = fn_decl @Convert [symbolic = @ImplicitAs.%Convert (constants.%Convert)] {
// CHECK:STDOUT:       %self.patt: @Convert.%Self.as_type.loc5_20.1 (%Self.as_type) = binding_pattern self
// CHECK:STDOUT:       %self.param_patt: @Convert.%Self.as_type.loc5_20.1 (%Self.as_type) = value_param_pattern %self.patt, call_param0
// CHECK:STDOUT:       %return.patt: @Convert.%T (%T) = return_slot_pattern
// CHECK:STDOUT:       %return.param_patt: @Convert.%T (%T) = out_param_pattern %return.patt, call_param1
// CHECK:STDOUT:     } {
// CHECK:STDOUT:       %T.ref: type = name_ref T, @ImplicitAs.%T.loc4_22.1 [symbolic = %T (constants.%T)]
// CHECK:STDOUT:       %self.param: @Convert.%Self.as_type.loc5_20.1 (%Self.as_type) = value_param call_param0
// CHECK:STDOUT:       %.loc5_20.1: type = splice_block %.loc5_20.3 [symbolic = %Self.as_type.loc5_20.1 (constants.%Self.as_type)] {
// CHECK:STDOUT:         %.loc5_20.2: @Convert.%ImplicitAs.type (%ImplicitAs.type.07f) = specific_constant @ImplicitAs.%Self.1, @ImplicitAs(constants.%T) [symbolic = %Self (constants.%Self)]
// CHECK:STDOUT:         %Self.ref: @Convert.%ImplicitAs.type (%ImplicitAs.type.07f) = name_ref Self, %.loc5_20.2 [symbolic = %Self (constants.%Self)]
// CHECK:STDOUT:         %Self.as_type.loc5_20.2: type = facet_access_type %Self.ref [symbolic = %Self.as_type.loc5_20.1 (constants.%Self.as_type)]
// CHECK:STDOUT:         %.loc5_20.3: type = converted %Self.ref, %Self.as_type.loc5_20.2 [symbolic = %Self.as_type.loc5_20.1 (constants.%Self.as_type)]
// CHECK:STDOUT:       }
// CHECK:STDOUT:       %self: @Convert.%Self.as_type.loc5_20.1 (%Self.as_type) = bind_name self, %self.param
// CHECK:STDOUT:       %return.param: ref @Convert.%T (%T) = out_param call_param1
// CHECK:STDOUT:       %return: ref @Convert.%T (%T) = return_slot %return.param
// CHECK:STDOUT:     }
// CHECK:STDOUT:     %assoc0.loc5_32.1: @ImplicitAs.%ImplicitAs.assoc_type (%ImplicitAs.assoc_type) = assoc_entity element0, %Convert.decl [symbolic = %assoc0.loc5_32.2 (constants.%assoc0)]
// CHECK:STDOUT:
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     .Self = %Self.1
// CHECK:STDOUT:     .T = <poisoned>
// CHECK:STDOUT:     .Convert = %assoc0.loc5_32.1
// CHECK:STDOUT:     witness = (%Convert.decl)
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic fn @Convert(@ImplicitAs.%T.loc4_22.1: type, @ImplicitAs.%Self.1: @ImplicitAs.%ImplicitAs.type (%ImplicitAs.type.07f)) {
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic = %T (constants.%T)]
// CHECK:STDOUT:   %ImplicitAs.type: type = facet_type <@ImplicitAs, @ImplicitAs(%T)> [symbolic = %ImplicitAs.type (constants.%ImplicitAs.type.07f)]
// CHECK:STDOUT:   %Self: %ImplicitAs.type.07f = bind_symbolic_name Self, 1 [symbolic = %Self (constants.%Self)]
// CHECK:STDOUT:   %Self.as_type.loc5_20.1: type = facet_access_type %Self [symbolic = %Self.as_type.loc5_20.1 (constants.%Self.as_type)]
// CHECK:STDOUT:
// CHECK:STDOUT:   fn[%self.param_patt: @Convert.%Self.as_type.loc5_20.1 (%Self.as_type)]() -> @Convert.%T (%T);
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @ImplicitAs(constants.%T) {
// CHECK:STDOUT:   %T.loc4_22.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc4_22.2 => constants.%T
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @Convert(constants.%T, constants.%Self) {
// CHECK:STDOUT:   %T => constants.%T
// CHECK:STDOUT:   %ImplicitAs.type => constants.%ImplicitAs.type.07f
// CHECK:STDOUT:   %Self => constants.%Self
// CHECK:STDOUT:   %Self.as_type.loc5_20.1 => constants.%Self.as_type
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @ImplicitAs(@Convert.%T) {}
// CHECK:STDOUT:
// CHECK:STDOUT: specific @ImplicitAs(%T.loc4_22.2) {}
// CHECK:STDOUT:
// CHECK:STDOUT: --- convert_class_value_to_generic_facet_value_value.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Scalar: type = bind_symbolic_name Scalar, 0 [symbolic]
// CHECK:STDOUT:   %Scalar.patt: type = symbolic_binding_pattern Scalar, 0 [symbolic]
// CHECK:STDOUT:   %Generic.type.c21: type = generic_interface_type @Generic [concrete]
// CHECK:STDOUT:   %empty_tuple.type: type = tuple_type () [concrete]
// CHECK:STDOUT:   %Generic.generic: %Generic.type.c21 = struct_value () [concrete]
// CHECK:STDOUT:   %Generic.type.91ccba.1: type = facet_type <@Generic, @Generic(%Scalar)> [symbolic]
// CHECK:STDOUT:   %Self: %Generic.type.91ccba.1 = bind_symbolic_name Self, 1 [symbolic]
// CHECK:STDOUT:   %F.type.f439a9.1: type = fn_type @F.1, @Generic(%Scalar) [symbolic]
// CHECK:STDOUT:   %F.8a2d67.1: %F.type.f439a9.1 = struct_value () [symbolic]
// CHECK:STDOUT:   %Generic.assoc_type.de973d.1: type = assoc_entity_type %Generic.type.91ccba.1 [symbolic]
// CHECK:STDOUT:   %assoc0.29ce53.1: %Generic.assoc_type.de973d.1 = assoc_entity element0, @Generic.%F.decl [symbolic]
// CHECK:STDOUT:   %GenericParam: type = class_type @GenericParam [concrete]
// CHECK:STDOUT:   %empty_struct_type: type = struct_type {} [concrete]
// CHECK:STDOUT:   %complete_type.357: <witness> = complete_type_witness %empty_struct_type [concrete]
// CHECK:STDOUT:   %ImplsGeneric: type = class_type @ImplsGeneric [concrete]
// CHECK:STDOUT:   %Generic.type.769: type = facet_type <@Generic, @Generic(%GenericParam)> [concrete]
// CHECK:STDOUT:   %F.type.4cf: type = fn_type @F.1, @Generic(%GenericParam) [concrete]
// CHECK:STDOUT:   %F.118: %F.type.4cf = struct_value () [concrete]
// CHECK:STDOUT:   %Generic.assoc_type.9f1: type = assoc_entity_type %Generic.type.769 [concrete]
// CHECK:STDOUT:   %assoc0.9b7: %Generic.assoc_type.9f1 = assoc_entity element0, @Generic.%F.decl [concrete]
// CHECK:STDOUT:   %impl_witness: <witness> = impl_witness (@impl.%F.decl) [concrete]
// CHECK:STDOUT:   %F.type.17b: type = fn_type @F.2 [concrete]
// CHECK:STDOUT:   %F.a56: %F.type.17b = struct_value () [concrete]
// CHECK:STDOUT:   %Generic.facet.b0a: %Generic.type.769 = facet_value %ImplsGeneric, %impl_witness [concrete]
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %Generic.type.91ccba.2: type = facet_type <@Generic, @Generic(%T)> [symbolic]
// CHECK:STDOUT:   %U: %Generic.type.91ccba.2 = bind_symbolic_name U, 1 [symbolic]
// CHECK:STDOUT:   %U.patt: %Generic.type.91ccba.2 = symbolic_binding_pattern U, 1 [symbolic]
// CHECK:STDOUT:   %U.as_type: type = facet_access_type %U [symbolic]
// CHECK:STDOUT:   %CallGenericMethod2.type: type = fn_type @CallGenericMethod2 [concrete]
// CHECK:STDOUT:   %CallGenericMethod2: %CallGenericMethod2.type = struct_value () [concrete]
// CHECK:STDOUT:   %require_complete.7b2: <witness> = require_complete_type %U.as_type [symbolic]
// CHECK:STDOUT:   %require_complete.4ae: <witness> = require_complete_type %T [symbolic]
// CHECK:STDOUT:   %F.type.f439a9.2: type = fn_type @F.1, @Generic(%T) [symbolic]
// CHECK:STDOUT:   %F.8a2d67.2: %F.type.f439a9.2 = struct_value () [symbolic]
// CHECK:STDOUT:   %Generic.assoc_type.de973d.2: type = assoc_entity_type %Generic.type.91ccba.2 [symbolic]
// CHECK:STDOUT:   %assoc0.29ce53.2: %Generic.assoc_type.de973d.2 = assoc_entity element0, @Generic.%F.decl [symbolic]
// CHECK:STDOUT:   %require_complete.02a: <witness> = require_complete_type %Generic.type.91ccba.2 [symbolic]
// CHECK:STDOUT:   %U.as_wit: <witness> = facet_access_witness %U [symbolic]
// CHECK:STDOUT:   %Generic.facet.2ea: %Generic.type.91ccba.2 = facet_value %U.as_type, %U.as_wit [symbolic]
// CHECK:STDOUT:   %.da8: type = fn_type_with_self_type %F.type.f439a9.2, %Generic.facet.2ea [symbolic]
// CHECK:STDOUT:   %impl.elem0: %.da8 = impl_witness_access %U.as_wit, element0 [symbolic]
// CHECK:STDOUT:   %specific_fn: <specific function> = specific_function %impl.elem0, @F.1(%T, %Generic.facet.2ea) [symbolic]
// CHECK:STDOUT:   %G.type: type = fn_type @G [concrete]
// CHECK:STDOUT:   %G: %G.type = struct_value () [concrete]
// CHECK:STDOUT:   %ImplsGeneric.val: %ImplsGeneric = struct_value () [concrete]
// CHECK:STDOUT:   %GenericParam.val: %GenericParam = struct_value () [concrete]
// CHECK:STDOUT:   %CallGenericMethod2.specific_fn: <specific function> = specific_function %CallGenericMethod2, @CallGenericMethod2(%GenericParam, %Generic.facet.b0a) [concrete]
// CHECK:STDOUT:   %complete_type.997: <witness> = complete_type_witness %Generic.type.769 [concrete]
// CHECK:STDOUT:   %.db1: type = fn_type_with_self_type %F.type.4cf, %Generic.facet.b0a [concrete]
// CHECK:STDOUT:   %F.specific_fn: <specific function> = specific_function %F.a56, @F.1(%GenericParam, %Generic.facet.b0a) [concrete]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: imports {
// CHECK:STDOUT:   %Core: <namespace> = namespace file.%Core.import, [concrete] {
// CHECK:STDOUT:     import Core//default
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [concrete] {
// CHECK:STDOUT:     .Core = imports.%Core
// CHECK:STDOUT:     .Generic = %Generic.decl
// CHECK:STDOUT:     .GenericParam = %GenericParam.decl
// CHECK:STDOUT:     .ImplsGeneric = %ImplsGeneric.decl
// CHECK:STDOUT:     .CallGenericMethod2 = %CallGenericMethod2.decl
// CHECK:STDOUT:     .G = %G.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core.import = import Core
// CHECK:STDOUT:   %Generic.decl: %Generic.type.c21 = interface_decl @Generic [concrete = constants.%Generic.generic] {
// CHECK:STDOUT:     %Scalar.patt.loc6_19.1: type = symbolic_binding_pattern Scalar, 0 [symbolic = %Scalar.patt.loc6_19.2 (constants.%Scalar.patt)]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %Scalar.loc6_19.1: type = bind_symbolic_name Scalar, 0 [symbolic = %Scalar.loc6_19.2 (constants.%Scalar)]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %GenericParam.decl: type = class_decl @GenericParam [concrete = constants.%GenericParam] {} {}
// CHECK:STDOUT:   %ImplsGeneric.decl: type = class_decl @ImplsGeneric [concrete = constants.%ImplsGeneric] {} {}
// CHECK:STDOUT:   impl_decl @impl [concrete] {} {
// CHECK:STDOUT:     %ImplsGeneric.ref: type = name_ref ImplsGeneric, file.%ImplsGeneric.decl [concrete = constants.%ImplsGeneric]
// CHECK:STDOUT:     %Generic.ref: %Generic.type.c21 = name_ref Generic, file.%Generic.decl [concrete = constants.%Generic.generic]
// CHECK:STDOUT:     %GenericParam.ref: type = name_ref GenericParam, file.%GenericParam.decl [concrete = constants.%GenericParam]
// CHECK:STDOUT:     %Generic.type: type = facet_type <@Generic, @Generic(constants.%GenericParam)> [concrete = constants.%Generic.type.769]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %impl_witness: <witness> = impl_witness (@impl.%F.decl) [concrete = constants.%impl_witness]
// CHECK:STDOUT:   %CallGenericMethod2.decl: %CallGenericMethod2.type = fn_decl @CallGenericMethod2 [concrete = constants.%CallGenericMethod2] {
// CHECK:STDOUT:     %T.patt.loc17_23.1: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc17_23.2 (constants.%T.patt)]
// CHECK:STDOUT:     %U.patt.loc17_33.1: @CallGenericMethod2.%Generic.type.loc17_46.2 (%Generic.type.91ccba.2) = symbolic_binding_pattern U, 1 [symbolic = %U.patt.loc17_33.2 (constants.%U.patt)]
// CHECK:STDOUT:     %a.patt: @CallGenericMethod2.%U.as_type.loc17_52.2 (%U.as_type) = binding_pattern a
// CHECK:STDOUT:     %a.param_patt: @CallGenericMethod2.%U.as_type.loc17_52.2 (%U.as_type) = value_param_pattern %a.patt, call_param0
// CHECK:STDOUT:     %s.patt: @CallGenericMethod2.%T.loc17_23.2 (%T) = binding_pattern s
// CHECK:STDOUT:     %s.param_patt: @CallGenericMethod2.%T.loc17_23.2 (%T) = value_param_pattern %s.patt, call_param1
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %T.loc17_23.1: type = bind_symbolic_name T, 0 [symbolic = %T.loc17_23.2 (constants.%T)]
// CHECK:STDOUT:     %.loc17_46: type = splice_block %Generic.type.loc17_46.1 [symbolic = %Generic.type.loc17_46.2 (constants.%Generic.type.91ccba.2)] {
// CHECK:STDOUT:       %Generic.ref: %Generic.type.c21 = name_ref Generic, file.%Generic.decl [concrete = constants.%Generic.generic]
// CHECK:STDOUT:       %T.ref.loc17_45: type = name_ref T, %T.loc17_23.1 [symbolic = %T.loc17_23.2 (constants.%T)]
// CHECK:STDOUT:       %Generic.type.loc17_46.1: type = facet_type <@Generic, @Generic(constants.%T)> [symbolic = %Generic.type.loc17_46.2 (constants.%Generic.type.91ccba.2)]
// CHECK:STDOUT:     }
// CHECK:STDOUT:     %U.loc17_33.1: @CallGenericMethod2.%Generic.type.loc17_46.2 (%Generic.type.91ccba.2) = bind_symbolic_name U, 1 [symbolic = %U.loc17_33.2 (constants.%U)]
// CHECK:STDOUT:     %a.param: @CallGenericMethod2.%U.as_type.loc17_52.2 (%U.as_type) = value_param call_param0
// CHECK:STDOUT:     %.loc17_52.1: type = splice_block %.loc17_52.2 [symbolic = %U.as_type.loc17_52.2 (constants.%U.as_type)] {
// CHECK:STDOUT:       %U.ref.loc17: @CallGenericMethod2.%Generic.type.loc17_46.2 (%Generic.type.91ccba.2) = name_ref U, %U.loc17_33.1 [symbolic = %U.loc17_33.2 (constants.%U)]
// CHECK:STDOUT:       %U.as_type.loc17_52.1: type = facet_access_type %U.ref.loc17 [symbolic = %U.as_type.loc17_52.2 (constants.%U.as_type)]
// CHECK:STDOUT:       %.loc17_52.2: type = converted %U.ref.loc17, %U.as_type.loc17_52.1 [symbolic = %U.as_type.loc17_52.2 (constants.%U.as_type)]
// CHECK:STDOUT:     }
// CHECK:STDOUT:     %a: @CallGenericMethod2.%U.as_type.loc17_52.2 (%U.as_type) = bind_name a, %a.param
// CHECK:STDOUT:     %s.param: @CallGenericMethod2.%T.loc17_23.2 (%T) = value_param call_param1
// CHECK:STDOUT:     %T.ref.loc17_58: type = name_ref T, %T.loc17_23.1 [symbolic = %T.loc17_23.2 (constants.%T)]
// CHECK:STDOUT:     %s: @CallGenericMethod2.%T.loc17_23.2 (%T) = bind_name s, %s.param
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %G.decl: %G.type = fn_decl @G [concrete = constants.%G] {} {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic interface @Generic(%Scalar.loc6_19.1: type) {
// CHECK:STDOUT:   %Scalar.loc6_19.2: type = bind_symbolic_name Scalar, 0 [symbolic = %Scalar.loc6_19.2 (constants.%Scalar)]
// CHECK:STDOUT:   %Scalar.patt.loc6_19.2: type = symbolic_binding_pattern Scalar, 0 [symbolic = %Scalar.patt.loc6_19.2 (constants.%Scalar.patt)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %Generic.type: type = facet_type <@Generic, @Generic(%Scalar.loc6_19.2)> [symbolic = %Generic.type (constants.%Generic.type.91ccba.1)]
// CHECK:STDOUT:   %Self.2: %Generic.type.91ccba.1 = bind_symbolic_name Self, 1 [symbolic = %Self.2 (constants.%Self)]
// CHECK:STDOUT:   %F.type: type = fn_type @F.1, @Generic(%Scalar.loc6_19.2) [symbolic = %F.type (constants.%F.type.f439a9.1)]
// CHECK:STDOUT:   %F: @Generic.%F.type (%F.type.f439a9.1) = struct_value () [symbolic = %F (constants.%F.8a2d67.1)]
// CHECK:STDOUT:   %Generic.assoc_type: type = assoc_entity_type @Generic.%Generic.type (%Generic.type.91ccba.1) [symbolic = %Generic.assoc_type (constants.%Generic.assoc_type.de973d.1)]
// CHECK:STDOUT:   %assoc0.loc7_9.2: @Generic.%Generic.assoc_type (%Generic.assoc_type.de973d.1) = assoc_entity element0, %F.decl [symbolic = %assoc0.loc7_9.2 (constants.%assoc0.29ce53.1)]
// CHECK:STDOUT:
// CHECK:STDOUT:   interface {
// CHECK:STDOUT:     %Self.1: @Generic.%Generic.type (%Generic.type.91ccba.1) = bind_symbolic_name Self, 1 [symbolic = %Self.2 (constants.%Self)]
// CHECK:STDOUT:     %F.decl: @Generic.%F.type (%F.type.f439a9.1) = fn_decl @F.1 [symbolic = @Generic.%F (constants.%F.8a2d67.1)] {} {}
// CHECK:STDOUT:     %assoc0.loc7_9.1: @Generic.%Generic.assoc_type (%Generic.assoc_type.de973d.1) = assoc_entity element0, %F.decl [symbolic = %assoc0.loc7_9.2 (constants.%assoc0.29ce53.1)]
// CHECK:STDOUT:
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     .Self = %Self.1
// CHECK:STDOUT:     .F = %assoc0.loc7_9.1
// CHECK:STDOUT:     witness = (%F.decl)
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: impl @impl: %ImplsGeneric.ref as %Generic.type {
// CHECK:STDOUT:   %F.decl: %F.type.17b = fn_decl @F.2 [concrete = constants.%F.a56] {} {}
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .F = %F.decl
// CHECK:STDOUT:   witness = file.%impl_witness
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @GenericParam {
// CHECK:STDOUT:   %complete_type: <witness> = complete_type_witness %empty_struct_type [concrete = constants.%complete_type.357]
// CHECK:STDOUT:   complete_type_witness = %complete_type
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%GenericParam
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @ImplsGeneric {
// CHECK:STDOUT:   %complete_type: <witness> = complete_type_witness %empty_struct_type [concrete = constants.%complete_type.357]
// CHECK:STDOUT:   complete_type_witness = %complete_type
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%ImplsGeneric
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic fn @F.1(@Generic.%Scalar.loc6_19.1: type, @Generic.%Self.1: @Generic.%Generic.type (%Generic.type.91ccba.1)) {
// CHECK:STDOUT:   fn();
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F.2() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic fn @CallGenericMethod2(%T.loc17_23.1: type, %U.loc17_33.1: @CallGenericMethod2.%Generic.type.loc17_46.2 (%Generic.type.91ccba.2)) {
// CHECK:STDOUT:   %T.loc17_23.2: type = bind_symbolic_name T, 0 [symbolic = %T.loc17_23.2 (constants.%T)]
// CHECK:STDOUT:   %T.patt.loc17_23.2: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc17_23.2 (constants.%T.patt)]
// CHECK:STDOUT:   %Generic.type.loc17_46.2: type = facet_type <@Generic, @Generic(%T.loc17_23.2)> [symbolic = %Generic.type.loc17_46.2 (constants.%Generic.type.91ccba.2)]
// CHECK:STDOUT:   %U.loc17_33.2: %Generic.type.91ccba.2 = bind_symbolic_name U, 1 [symbolic = %U.loc17_33.2 (constants.%U)]
// CHECK:STDOUT:   %U.patt.loc17_33.2: %Generic.type.91ccba.2 = symbolic_binding_pattern U, 1 [symbolic = %U.patt.loc17_33.2 (constants.%U.patt)]
// CHECK:STDOUT:   %U.as_type.loc17_52.2: type = facet_access_type %U.loc17_33.2 [symbolic = %U.as_type.loc17_52.2 (constants.%U.as_type)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %require_complete.loc17_50: <witness> = require_complete_type @CallGenericMethod2.%U.as_type.loc17_52.2 (%U.as_type) [symbolic = %require_complete.loc17_50 (constants.%require_complete.7b2)]
// CHECK:STDOUT:   %require_complete.loc17_56: <witness> = require_complete_type @CallGenericMethod2.%T.loc17_23.2 (%T) [symbolic = %require_complete.loc17_56 (constants.%require_complete.4ae)]
// CHECK:STDOUT:   %require_complete.loc18: <witness> = require_complete_type @CallGenericMethod2.%Generic.type.loc17_46.2 (%Generic.type.91ccba.2) [symbolic = %require_complete.loc18 (constants.%require_complete.02a)]
// CHECK:STDOUT:   %Generic.assoc_type: type = assoc_entity_type @CallGenericMethod2.%Generic.type.loc17_46.2 (%Generic.type.91ccba.2) [symbolic = %Generic.assoc_type (constants.%Generic.assoc_type.de973d.2)]
// CHECK:STDOUT:   %assoc0: @CallGenericMethod2.%Generic.assoc_type (%Generic.assoc_type.de973d.2) = assoc_entity element0, @Generic.%F.decl [symbolic = %assoc0 (constants.%assoc0.29ce53.2)]
// CHECK:STDOUT:   %U.as_wit.loc18_4.2: <witness> = facet_access_witness %U.loc17_33.2 [symbolic = %U.as_wit.loc18_4.2 (constants.%U.as_wit)]
// CHECK:STDOUT:   %F.type: type = fn_type @F.1, @Generic(%T.loc17_23.2) [symbolic = %F.type (constants.%F.type.f439a9.2)]
// CHECK:STDOUT:   %Generic.facet: @CallGenericMethod2.%Generic.type.loc17_46.2 (%Generic.type.91ccba.2) = facet_value %U.as_type.loc17_52.2, %U.as_wit.loc18_4.2 [symbolic = %Generic.facet (constants.%Generic.facet.2ea)]
// CHECK:STDOUT:   %.loc18_4.3: type = fn_type_with_self_type %F.type, %Generic.facet [symbolic = %.loc18_4.3 (constants.%.da8)]
// CHECK:STDOUT:   %impl.elem0.loc18_4.2: @CallGenericMethod2.%.loc18_4.3 (%.da8) = impl_witness_access %U.as_wit.loc18_4.2, element0 [symbolic = %impl.elem0.loc18_4.2 (constants.%impl.elem0)]
// CHECK:STDOUT:   %specific_fn.loc18_4.2: <specific function> = specific_function %impl.elem0.loc18_4.2, @F.1(%T.loc17_23.2, %Generic.facet) [symbolic = %specific_fn.loc18_4.2 (constants.%specific_fn)]
// CHECK:STDOUT:
// CHECK:STDOUT:   fn[%T.patt.loc17_23.1: type, %U.patt.loc17_33.1: @CallGenericMethod2.%Generic.type.loc17_46.2 (%Generic.type.91ccba.2)](%a.param_patt: @CallGenericMethod2.%U.as_type.loc17_52.2 (%U.as_type), %s.param_patt: @CallGenericMethod2.%T.loc17_23.2 (%T)) {
// CHECK:STDOUT:   !entry:
// CHECK:STDOUT:     %U.ref.loc18: @CallGenericMethod2.%Generic.type.loc17_46.2 (%Generic.type.91ccba.2) = name_ref U, %U.loc17_33.1 [symbolic = %U.loc17_33.2 (constants.%U)]
// CHECK:STDOUT:     %.loc18_4.1: @CallGenericMethod2.%Generic.assoc_type (%Generic.assoc_type.de973d.2) = specific_constant @Generic.%assoc0.loc7_9.1, @Generic(constants.%T) [symbolic = %assoc0 (constants.%assoc0.29ce53.2)]
// CHECK:STDOUT:     %F.ref: @CallGenericMethod2.%Generic.assoc_type (%Generic.assoc_type.de973d.2) = name_ref F, %.loc18_4.1 [symbolic = %assoc0 (constants.%assoc0.29ce53.2)]
// CHECK:STDOUT:     %U.as_type.loc18: type = facet_access_type %U.ref.loc18 [symbolic = %U.as_type.loc17_52.2 (constants.%U.as_type)]
// CHECK:STDOUT:     %.loc18_4.2: type = converted %U.ref.loc18, %U.as_type.loc18 [symbolic = %U.as_type.loc17_52.2 (constants.%U.as_type)]
// CHECK:STDOUT:     %U.as_wit.loc18_4.1: <witness> = facet_access_witness %U.ref.loc18 [symbolic = %U.as_wit.loc18_4.2 (constants.%U.as_wit)]
// CHECK:STDOUT:     %impl.elem0.loc18_4.1: @CallGenericMethod2.%.loc18_4.3 (%.da8) = impl_witness_access %U.as_wit.loc18_4.1, element0 [symbolic = %impl.elem0.loc18_4.2 (constants.%impl.elem0)]
// CHECK:STDOUT:     %specific_fn.loc18_4.1: <specific function> = specific_function %impl.elem0.loc18_4.1, @F.1(constants.%T, constants.%Generic.facet.2ea) [symbolic = %specific_fn.loc18_4.2 (constants.%specific_fn)]
// CHECK:STDOUT:     %F.call: init %empty_tuple.type = call %specific_fn.loc18_4.1()
// CHECK:STDOUT:     return
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %CallGenericMethod2.ref: %CallGenericMethod2.type = name_ref CallGenericMethod2, file.%CallGenericMethod2.decl [concrete = constants.%CallGenericMethod2]
// CHECK:STDOUT:   %.loc22_23.1: %empty_struct_type = struct_literal ()
// CHECK:STDOUT:   %ImplsGeneric.ref: type = name_ref ImplsGeneric, file.%ImplsGeneric.decl [concrete = constants.%ImplsGeneric]
// CHECK:STDOUT:   %.loc22_23.2: ref %ImplsGeneric = temporary_storage
// CHECK:STDOUT:   %.loc22_23.3: init %ImplsGeneric = class_init (), %.loc22_23.2 [concrete = constants.%ImplsGeneric.val]
// CHECK:STDOUT:   %.loc22_23.4: ref %ImplsGeneric = temporary %.loc22_23.2, %.loc22_23.3
// CHECK:STDOUT:   %.loc22_25.1: ref %ImplsGeneric = converted %.loc22_23.1, %.loc22_23.4
// CHECK:STDOUT:   %.loc22_43.1: %empty_struct_type = struct_literal ()
// CHECK:STDOUT:   %GenericParam.ref: type = name_ref GenericParam, file.%GenericParam.decl [concrete = constants.%GenericParam]
// CHECK:STDOUT:   %.loc22_43.2: ref %GenericParam = temporary_storage
// CHECK:STDOUT:   %.loc22_43.3: init %GenericParam = class_init (), %.loc22_43.2 [concrete = constants.%GenericParam.val]
// CHECK:STDOUT:   %.loc22_43.4: ref %GenericParam = temporary %.loc22_43.2, %.loc22_43.3
// CHECK:STDOUT:   %.loc22_45.1: ref %GenericParam = converted %.loc22_43.1, %.loc22_43.4
// CHECK:STDOUT:   %Generic.facet: %Generic.type.769 = facet_value constants.%ImplsGeneric, constants.%impl_witness [concrete = constants.%Generic.facet.b0a]
// CHECK:STDOUT:   %.loc22_60: %Generic.type.769 = converted constants.%ImplsGeneric, %Generic.facet [concrete = constants.%Generic.facet.b0a]
// CHECK:STDOUT:   %CallGenericMethod2.specific_fn: <specific function> = specific_function %CallGenericMethod2.ref, @CallGenericMethod2(constants.%GenericParam, %.loc22_60) [concrete = constants.%CallGenericMethod2.specific_fn]
// CHECK:STDOUT:   %.loc22_25.2: %ImplsGeneric = bind_value %.loc22_25.1
// CHECK:STDOUT:   %.loc22_45.2: %GenericParam = bind_value %.loc22_45.1
// CHECK:STDOUT:   %CallGenericMethod2.call: init %empty_tuple.type = call %CallGenericMethod2.specific_fn(%.loc22_25.2, %.loc22_45.2)
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @Generic(constants.%Scalar) {
// CHECK:STDOUT:   %Scalar.loc6_19.2 => constants.%Scalar
// CHECK:STDOUT:   %Scalar.patt.loc6_19.2 => constants.%Scalar
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @F.1(constants.%Scalar, constants.%Self) {}
// CHECK:STDOUT:
// CHECK:STDOUT: specific @Generic(%Scalar.loc6_19.2) {}
// CHECK:STDOUT:
// CHECK:STDOUT: specific @Generic(constants.%GenericParam) {
// CHECK:STDOUT:   %Scalar.loc6_19.2 => constants.%GenericParam
// CHECK:STDOUT:   %Scalar.patt.loc6_19.2 => constants.%GenericParam
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %Generic.type => constants.%Generic.type.769
// CHECK:STDOUT:   %Self.2 => constants.%Self
// CHECK:STDOUT:   %F.type => constants.%F.type.4cf
// CHECK:STDOUT:   %F => constants.%F.118
// CHECK:STDOUT:   %Generic.assoc_type => constants.%Generic.assoc_type.9f1
// CHECK:STDOUT:   %assoc0.loc7_9.2 => constants.%assoc0.9b7
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @F.1(constants.%GenericParam, constants.%Generic.facet.b0a) {}
// CHECK:STDOUT:
// CHECK:STDOUT: specific @Generic(constants.%T) {
// CHECK:STDOUT:   %Scalar.loc6_19.2 => constants.%T
// CHECK:STDOUT:   %Scalar.patt.loc6_19.2 => constants.%T
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %Generic.type => constants.%Generic.type.91ccba.2
// CHECK:STDOUT:   %Self.2 => constants.%Self
// CHECK:STDOUT:   %F.type => constants.%F.type.f439a9.2
// CHECK:STDOUT:   %F => constants.%F.8a2d67.2
// CHECK:STDOUT:   %Generic.assoc_type => constants.%Generic.assoc_type.de973d.2
// CHECK:STDOUT:   %assoc0.loc7_9.2 => constants.%assoc0.29ce53.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @CallGenericMethod2(constants.%T, constants.%U) {
// CHECK:STDOUT:   %T.loc17_23.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc17_23.2 => constants.%T
// CHECK:STDOUT:   %Generic.type.loc17_46.2 => constants.%Generic.type.91ccba.2
// CHECK:STDOUT:   %U.loc17_33.2 => constants.%U
// CHECK:STDOUT:   %U.patt.loc17_33.2 => constants.%U
// CHECK:STDOUT:   %U.as_type.loc17_52.2 => constants.%U.as_type
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @Generic(@CallGenericMethod2.%T.loc17_23.2) {}
// CHECK:STDOUT:
// CHECK:STDOUT: specific @F.1(constants.%T, constants.%Generic.facet.2ea) {}
// CHECK:STDOUT:
// CHECK:STDOUT: specific @F.1(@CallGenericMethod2.%T.loc17_23.2, @CallGenericMethod2.%Generic.facet) {}
// CHECK:STDOUT:
// CHECK:STDOUT: specific @CallGenericMethod2(constants.%GenericParam, @G.%.loc22_60) {
// CHECK:STDOUT:   %T.loc17_23.2 => constants.%GenericParam
// CHECK:STDOUT:   %T.patt.loc17_23.2 => constants.%GenericParam
// CHECK:STDOUT:   %Generic.type.loc17_46.2 => constants.%Generic.type.769
// CHECK:STDOUT:   %U.loc17_33.2 => constants.%Generic.facet.b0a
// CHECK:STDOUT:   %U.patt.loc17_33.2 => constants.%Generic.facet.b0a
// CHECK:STDOUT:   %U.as_type.loc17_52.2 => constants.%ImplsGeneric
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %require_complete.loc17_50 => constants.%complete_type.357
// CHECK:STDOUT:   %require_complete.loc17_56 => constants.%complete_type.357
// CHECK:STDOUT:   %require_complete.loc18 => constants.%complete_type.997
// CHECK:STDOUT:   %Generic.assoc_type => constants.%Generic.assoc_type.9f1
// CHECK:STDOUT:   %assoc0 => constants.%assoc0.9b7
// CHECK:STDOUT:   %U.as_wit.loc18_4.2 => constants.%impl_witness
// CHECK:STDOUT:   %F.type => constants.%F.type.4cf
// CHECK:STDOUT:   %Generic.facet => constants.%Generic.facet.b0a
// CHECK:STDOUT:   %.loc18_4.3 => constants.%.db1
// CHECK:STDOUT:   %impl.elem0.loc18_4.2 => constants.%F.a56
// CHECK:STDOUT:   %specific_fn.loc18_4.2 => constants.%F.specific_fn
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @CallGenericMethod2(constants.%GenericParam, constants.%Generic.facet.b0a) {
// CHECK:STDOUT:   %T.loc17_23.2 => constants.%GenericParam
// CHECK:STDOUT:   %T.patt.loc17_23.2 => constants.%GenericParam
// CHECK:STDOUT:   %Generic.type.loc17_46.2 => constants.%Generic.type.769
// CHECK:STDOUT:   %U.loc17_33.2 => constants.%Generic.facet.b0a
// CHECK:STDOUT:   %U.patt.loc17_33.2 => constants.%Generic.facet.b0a
// CHECK:STDOUT:   %U.as_type.loc17_52.2 => constants.%ImplsGeneric
// CHECK:STDOUT: }
// CHECK:STDOUT:
