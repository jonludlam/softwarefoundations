Set Warnings "-notation-overridden,-parsing".
Require Export Structured.

Inductive list (X:Type) : Type :=
  | nil : list X
  | cons : X -> list X -> list X.

Check list.

Check nil.

Check (cons nat 3 (nil nat)).

Fixpoint repeat (X : Type) (x : X) (count : nat) : list X :=
  match count with
  | 0 => nil X
  | S count' => cons X x (repeat X x count')
  end.
  
Example test_repeat1 :
  repeat nat 4 2 = cons nat 4 (cons nat 4 (nil nat)).
Proof. reflexivity. Qed.

Example test_repeat2 :
  repeat bool true 2 = cons bool true (cons bool true (nil bool)).
Proof. reflexivity. Qed.

Module MumbleGrumble.

  Inductive mumble : Type :=
    | a : mumble
    | b : mumble -> nat -> mumble
    | c : mumble.

  Inductive grumble (X : Type) : Type :=
    | d : mumble -> grumble X
    | e : X -> grumble X.

  (* Check (d (b a 5)) *)
  Check (d mumble (b a 5)).
  Check (d bool (b a 5)).
  Check (e bool true).
  Check (e mumble (b c 0)).
  (* Check (e bool (b c 0)). *)
  Check c.

End MumbleGrumble.


    
