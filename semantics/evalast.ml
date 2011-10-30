(*
Modeling Kernel Language (MKL) toolchain
Copyright (C) 2010-2011 David Broman
MKL toolchain is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

MKL toolchain is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with MKL toolchain.  If not, see <http://www.gnu.org/licenses/>.
*)

open Sundials
open Info


type level = int
type index = int
type sym = int
type typeid = int
type specialize = bool

type uenv = (int * int) list
type env = tm list


and ty =
  | TyBool      
  | TyInt       
  | TyReal      
  | TyString    
  | TyArrow     of ty * ty 
  | TyUnit      
  | TyList      of ty
  | TyTuple     of ty list
  | TyModel     of ty
  | TyAnyModel  
  | TyBot        
  | TyUserdef   of typeid
  | TyArray     of ty
  | TyMap       of ty * ty
  | TySet       of ty 
  | TyDAESolver


and tm =
  | TmVar         of index
  | TmSpecSym     of sym
  | TmLam         of tm 
  | TmClos        of tm * env * Ast.ident
  | TmApp         of tm * tm * specialize
  | TmFix         of tm
  | TmIf          of tm * tm * tm
  | TmConst       of Ast.const
  | TmSym         of sym * ty 
  | TmGenSym      of ty
  | TmModApp      of tm * tm 
  | TmVal         of tm * ty
  | TmDecon       of tm * mpat * tm * tm
  | TmEqual       of tm * tm
  | TmLcase       of tm * tm * tm
  | TmCons        of tm * tm
  | TmNil         
  | TmTuple       of tm list
  | TmProj        of int * tm
  | TmArray       of tm array
  | TmArrayOp     of Ast.arrayop * tm list
  | TmMap         of int * (tm,tm) PMap.t
  | TmMapOp       of Ast.mapop * tm list
  | TmSet         of int * (tm,unit) PMap.t
  | TmSetOp       of Ast.setop * tm list
  | TmDAESolver   of Ida.st * tm array * tm array
  | TmDAESolverOp of Ast.daesolverop * tm list
  | TmDPrint      of tm
  | TmDPrintType  of tm
  | TmError       of info * tm
  | TmDebugId     of Ast.ident * tm



and mpat = 
  | MPatUk         of ty
  | MPatModApp     
  | MPatModIfGuard
  | MPatModIfThen
  | MPatModIfElse
  | MPatModEqual     
  | MPatModProj     
  | MPatVal        of ty

