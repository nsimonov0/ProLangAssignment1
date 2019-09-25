-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParLambdaNat where
import AbsLambdaNat
import LexLambdaNat
import ErrM

}

%name pProgram Program
%name pExp1 Exp1
%name pExp2 Exp2
%name pExp3 Exp3
%name pExp4 Exp4
%name pExp6 Exp6
%name pExp7 Exp7
%name pExp8 Exp8
%name pExp9 Exp9
%name pExp10 Exp10
%name pExp11 Exp11
%name pExp5 Exp5
%name pExp Exp
-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype {Token}
%token
  '#' { PT _ (TS _ 1) }
  '(' { PT _ (TS _ 2) }
  ')' { PT _ (TS _ 3) }
  '.' { PT _ (TS _ 4) }
  '0' { PT _ (TS _ 5) }
  ':' { PT _ (TS _ 6) }
  '=' { PT _ (TS _ 7) }
  'S' { PT _ (TS _ 8) }
  '\\' { PT _ (TS _ 9) }
  'else' { PT _ (TS _ 10) }
  'hd' { PT _ (TS _ 11) }
  'if' { PT _ (TS _ 12) }
  'in' { PT _ (TS _ 13) }
  'let' { PT _ (TS _ 14) }
  'minus_one' { PT _ (TS _ 15) }
  'rec' { PT _ (TS _ 16) }
  'then' { PT _ (TS _ 17) }
  'tl' { PT _ (TS _ 18) }
  L_Id { PT _ (T_Id $$) }

%%

Id :: { Id}
Id  : L_Id { Id ($1)}

Program :: { Program }
Program : Exp { AbsLambdaNat.Prog $1 }
Exp1 :: { Exp }
Exp1 : '\\' Id '.' Exp { AbsLambdaNat.EAbs $2 $4 } | Exp2 { $1 }
Exp2 :: { Exp }
Exp2 : 'if' Exp '=' Exp 'then' Exp 'else' Exp { AbsLambdaNat.EIf $2 $4 $6 $8 }
     | Exp3 { $1 }
Exp3 :: { Exp }
Exp3 : 'let' Id '=' Exp 'in' Exp { AbsLambdaNat.ELet $2 $4 $6 }
     | Exp4 { $1 }
Exp4 :: { Exp }
Exp4 : 'let' 'rec' Id '=' Exp 'in' Exp { AbsLambdaNat.ERec $3 $5 $7 }
     | Exp5 { $1 }
Exp6 :: { Exp }
Exp6 : 'hd' Exp { AbsLambdaNat.EHd $2 }
     | 'tl' Exp { AbsLambdaNat.ETl $2 }
     | Exp7 { $1 }
Exp7 :: { Exp }
Exp7 : 'minus_one' Exp { AbsLambdaNat.EMinusOne $2 } | Exp8 { $1 }
Exp8 :: { Exp }
Exp8 : Exp8 Exp9 { AbsLambdaNat.EApp $1 $2 } | Exp9 { $1 }
Exp9 :: { Exp }
Exp9 : '#' { AbsLambdaNat.ENil }
     | Exp10 ':' Exp9 { AbsLambdaNat.ECons $1 $3 }
     | Exp10 { $1 }
Exp10 :: { Exp }
Exp10 : '0' { AbsLambdaNat.ENat0 }
      | 'S' Exp10 { AbsLambdaNat.ENatS $2 }
      | Exp11 { $1 }
Exp11 :: { Exp }
Exp11 : Id { AbsLambdaNat.EVar $1 } | '(' Exp ')' { $2 }
Exp5 :: { Exp }
Exp5 : Exp6 { $1 }
Exp :: { Exp }
Exp : Exp1 { $1 }
{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ id(prToken t) ++ "'"

myLexer = tokens
}

