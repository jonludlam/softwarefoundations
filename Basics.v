Inductive day : Type :=
  | monday : day
  | tuesday : day
  | wednesday : day
  | thursday : day
  | friday : day
  | saturday : day
  | sunday : day.

Definition next_weekday (d:day) : day :=
  match d with
  | monday => tuesday
  | tuesday => wednesday
  | wednesday => thursday
  | thursday => friday
  | friday  => monday
  | saturday => monday
  | sunday => monday
  end.

Compute (next_weekday friday).

Compute (next_weekday (next_weekday saturday)).

Example test_next_weekday:
  (next_weekday (next_weekday saturday)) = tuesday.

Proof. simpl. reflexivity. Qed.


Inductive bool : Type :=
  | true : bool
  | false : bool.

Definition negb (b:bool) : bool :=
  match b with
  | true => false
  | false => true
  end.

Definition andb (b1:bool) (b2:bool) : bool :=
  match b1 with
  | true => b2
  | false => false
  end.

Definition orb (b1:bool) (b2:bool) : bool :=
  match b1 with
  | true => true
  | false => b2
  end.

Example test_orb1: (orb true false) = true.
Proof. simpl. reflexivity. Qed.
Example test_orb2: (orb false false) = false.
Proof. simpl. reflexivity. Qed.
Example test_orb3: (orb true true) = true.
Proof. simpl. reflexivity. Qed.
Example test_orb4: (orb false true) = true.
Proof. simpl. reflexivity. Qed.


Notation "x && y" := (andb x y).
Notation "x || y" := (orb x y).

Example test_orb5: false || false || true = true.
Proof. simpl. reflexivity. Qed.

Definition nandb (b1: bool) (b2: bool) : bool :=
  match b1 with
  | false => true
  | true => negb b2
  end.
Example test_nandb1: (nandb true false) = true.
Proof. simpl. reflexivity. Qed.
Example test_nandb2: (nandb false false) = true.
Proof. simpl. reflexivity. Qed.
Example test_nandb3: (nandb true true) = false.
Proof. simpl. reflexivity. Qed.
Example test_nandb4: (nandb true false) = true.
Proof. simpl. reflexivity. Qed.

Check true.

Inductive rgb : Type :=
  | red : rgb
  | green : rgb
  | blue : rgb.

Inductive color : Type :=
  | black : color
  | white : color
  | primary : rgb -> color.

Check primary.

Module NatPlayground.

  Inductive nat : Type :=
    | O : nat
    | S : nat -> nat.

  Definition pred (n : nat) : nat :=
    match n with
    | O => O
    | S n' => n'
    end.
  
End NatPlayground.


Check (S (S (S O))).
Definition minustwo (n : nat) : nat :=
  match n with
  | O => O
  | S O => O
  | S (S (n')) => n'
  end.
Example test_minustwo: (minustwo 5) = 3.
Proof. simpl. reflexivity. Qed.

Check 3.
Check O.
Check S 0.


Fixpoint evenb (n:nat) : bool :=
  match n with
  | O => true
  | S O => false
  | S (S n') => evenb n'
  end.

Definition oddb (n:nat) : bool := negb (evenb n).

Example test_oddb1: oddb 1 = true.
Proof. simpl. reflexivity. Qed.
Example test_oddb2: oddb 4 = false.
Proof. simpl. reflexivity. Qed.

Module NatPlayground2.

Fixpoint plus (n : nat) (m : nat) : nat :=
  match n with
  | 0 => m
  | S n' => S (plus n' m)
  end.

Compute (plus 3 2).

Fixpoint mult (n m : nat) : nat :=
  match m with
  | 0 => 0
  | S m' => plus (mult n m') n
  end.

Example test_mult1: (mult 3 3) = 9.
Proof. simpl. reflexivity. Qed.

Fixpoint minus (n m : nat) : nat :=
  match (n, m) with
  | (0, _) => 0
  | (S _, 0) => n
  | (S n', S m') => minus n' m'
  end.

End NatPlayground2.

Fixpoint exp (base power : nat) : nat :=
  match power with 
  | 0 => S 0
  | S p => mult base (exp base p)
  end.

Fixpoint factorial (n:nat) : nat :=
  match n with
  | 0 => S 0
  | S p => mult n (factorial p)
  end.

Example test_factorial1: (factorial 3) = 6.
Proof. simpl. reflexivity. Qed.

Example test_factorial2: (factorial 5) = (mult 10 12).
Proof. simpl. reflexivity. Qed.

Notation "x + y" := (plus x y)
                       (at level 50, left associativity)
                       : nat_scope.
Notation "x - y" := (minus x y)
                       (at level 50, left associativity)
                       : nat_scope.
Notation "x * y" := (mult x y)
                       (at level 40, left associativity)
                       : nat_scope.
Check ((0 + 1) + 1).

Fixpoint beq_nat (n m : nat) : bool :=
  match (n, m) with
  | (O, O) => true
  | (O, S _) => false
  | (S _, O) => false
  | (S n', S m') => beq_nat n' m'
  end.

Fixpoint leb (n m: nat) : bool :=
  match (n,m) with
  | (0,_) => true
  | (S n', 0) => false
  | (S n', S m') => leb n' m'
  end.

Example test_leb1: (leb 2 2) = true.
Proof. simpl. reflexivity. Qed.
Example test_leb2: (leb 2 4) = true.
Proof. simpl. reflexivity. Qed.
Example test_leb3: (leb 4 2) = false.
Proof. simpl. reflexivity. Qed.

Definition blt_nat (n m : nat) : bool :=
  (leb n m) && (negb (beq_nat n m)).

Example test_blt_nat1: (blt_nat 2 2) = false.
Proof. simpl. reflexivity. Qed.

Example test_blt_nat2: (blt_nat 2 4) = true.
Proof. simpl. reflexivity. Qed.
Example test_blt_nat3: (blt_nat 4 2) = false.
Proof. simpl. reflexivity. Qed.

Theorem plus_0_n : forall n : nat, 0 + n = n.
Proof.
  intros n. simpl. reflexivity. Qed.


Theorem plus_1_l : forall n : nat, 1 + n = S n.
Proof.
intros n. simpl. reflexivity. Qed.

Theorem mult_0_l : forall n : nat, 0*n=0.
Proof.
intros n. reflexivity. Qed.

Theorem plus_id_example: forall n m: nat,
  n=m -> n + n = m + m.

Proof.
  intros n m.
  intros H.
  rewrite -> H.
  reflexivity.
  Qed.

Theorem plus_id_exercise : forall n m o : nat,
  n = m -> m = o -> n + m = m + o.
Proof.
  intros n m o.
  intros H.
  intros L.
  rewrite -> H.
  rewrite -> L.
  reflexivity.
Qed.

Theorem mult_0_plus : forall n m : nat,
  (0 + n) * m = n * m.
Proof.
  intros n m.
  rewrite -> plus_0_n.
  reflexivity. Qed.

Theorem mult_S_1 : forall n m : nat,
  m = S n ->
  m * (1 + n) = m * m.
Proof.
  intros n m.
  intros H.
  rewrite plus_1_l.
  rewrite H.
  reflexivity.
Qed.

Theorem plus_1_neq_0_firsttry : forall n : nat,
  beq_nat (n + 1) 0 = false.
Proof.
  intros.
  simpl.
Abort.

Theorem plus_1_neq_0 : forall n : nat,
  beq_nat (n + 1) 0 = false.
Proof.
  intros n. destruct n as [| n' ].
  - reflexivity.
  - reflexivity.
  Qed.

Theorem negb_involute : forall b : bool,
  negb (negb b) = b.
Proof.
  intros b. destruct b.
  - reflexivity.
  - reflexivity.
Qed.

Theorem andb_commutative : forall b c, andb b c = andb c b.
Proof.
  intros b c. destruct b.
  - destruct c.
    + reflexivity.
    + reflexivity.
  - destruct c.
    + reflexivity.
    + reflexivity.
Qed.

Theorem plus_one_neq_0' : forall n : nat,
  beq_nat (n + 1) 0 = false.
Proof.
  intros [|n].
  - reflexivity.
  - reflexivity.
Qed.

Theorem andb_commutative' : forall b c, andb b c = andb c b.
Proof.
  intros [] [].
  reflexivity.
  reflexivity.
  reflexivity.
  reflexivity.
Qed.

Theorem andb_true_elim2 : forall b c : bool, andb b c = true -> c = true.
Proof.
  intros [] [].
  - reflexivity.
  - simpl.
    intros H.
    rewrite -> H.
    reflexivity.
  - reflexivity.
  - simpl.
    intros H.
    rewrite -> H.
    reflexivity.
Qed.

Theorem zero_nbeq_plus_1 : forall n : nat,
  beq_nat 0 (n + 1) = false.
Proof.
  intros [|n].
  - simpl. reflexivity.
  - simpl. reflexivity.
Qed.

Fixpoint plus' (n : nat) (m : nat) : nat :=
  match n with
  | O => m
  | S n' => S (plus' n' m)
  end.

Theorem identity_fn_applied_twice :
  forall f : bool -> bool, (forall x : bool, f x = x) -> forall b : bool, f(f(b))= b.
Proof.
  intros.
  rewrite -> H.
  rewrite -> H.
  reflexivity.
Qed.

Theorem identity_neg_fn_applied_twice :
  forall f : bool -> bool, (forall x : bool, f x = negb x) -> forall b : bool, f(f(b))= b.
Proof.
  intros.
  destruct b.
  + rewrite -> H.
    rewrite -> H.
    simpl.
    reflexivity.
  + rewrite -> H.
    rewrite -> H.
    simpl.
    reflexivity.
Qed.

Theorem andb_eq_orb :
  forall b c : bool,
  (andb b c = orb b c) ->
  b = c.
Proof.
  intros b c.
  destruct b.
  - simpl. intros H. rewrite -> H. reflexivity.
  - simpl. intros H. rewrite -> H. reflexivity.
Qed. 

Inductive bin : Type := Zero : bin | Twice : bin -> bin | TwicePlusOne : bin -> bin.

Fixpoint myincr (n : bin) : bin :=
  match n with
  | Zero => TwicePlusOne Zero
  | Twice x => TwicePlusOne x
  | TwicePlusOne x => Twice (myincr x)
  end.

