Set Warnings "-notation-overridden,-parsing".
Require Export Structured.

Inductive list (X:Type) : Type :=
  | nil : list X
  | cons : X -> list X -> list X.

