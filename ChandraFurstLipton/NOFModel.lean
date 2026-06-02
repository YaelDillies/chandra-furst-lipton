/-
Copyright (c) 2024 Yaël Dillies, Isabel Dahlgren. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Yaël Dillies, Isabel Dahlgren
-/
module

public import ChandraFurstLipton.MultidimCorners
public import Mathlib.Data.ENat.Lattice
public import Mathlib.Data.ZMod.Defs

/-!
# The Number-On-the-Forehead model
-/

@[expose] public section

namespace NOF

variable {ι G : Type*} {d : ℕ} [Fintype ι]

variable (G d) in
structure Protocol where
  nextBit (i : ZMod d) : ({j : ZMod d // j ≠ i} → G) → List Bool → Bool
  guess (i : ZMod d) : ({j : ZMod d // j ≠ i} → G) → List Bool → Bool

variable {F : (ZMod d → G) → Bool} {P : Protocol G d} {a : ZMod d → ZMod d → G} {v : ZMod d → G}
  {B : List Bool} {t : ℕ}

namespace Protocol

def broadcast (P : Protocol G d) (x : ZMod d → G) : ℕ → List Bool
  | 0 => []
  | t + 1 => P.nextBit t (forget (t : ZMod d) x) (broadcast P x t) :: broadcast P x t

@[simp] lemma broadcast_zero (P : Protocol G d) (x : ZMod d → G) : broadcast P x 0 = [] := rfl

lemma broadcast_succ (P : Protocol G d) (x : ZMod d → G) (t : ℕ) :
    broadcast P x (t + 1)
      = P.nextBit t (forget (t : ZMod d) x) (broadcast P x t) :: broadcast P x t := rfl

def IsValid (P : Protocol G d) (F : (ZMod d → G) → Bool) (t : ℕ) : Prop :=
  ∀ x i, P.guess i (forget i x) (broadcast P x t) = F x

@[simp]
lemma length_broadcast (P : Protocol G d) (x : ZMod d → G) : ∀ t, (broadcast P x t).length = t
  | 0 => rfl
  | t + 1 => by simpa [broadcast_succ] using length_broadcast _ _ _

noncomputable
def complexity (P : Protocol G d) (F : (ZMod d → G) → Bool) : ENat :=
  ⨅ (t : ℕ) (_ : IsValid P F t), t

@[simp] lemma le_complexity : t ≤ Protocol.complexity P F ↔ ∀ r : ℕ, P.IsValid F r → t ≤ r := by
  simp [complexity]

end Protocol

noncomputable def funComplexity (F : (ZMod d → G) → Bool) := ⨅ P : Protocol G d, P.complexity F

@[simp] lemma le_funComplexity : t ≤ funComplexity F ↔ ∀ P : Protocol G d, t ≤ P.complexity F := by
  simp [funComplexity]

lemma IsForbiddenPatternWithTip.broadcast_eq (hF : IsForbiddenPatternWithTip a v)
    (hB : ∀ i, P.broadcast (a i) t = B) : P.broadcast v t = B := by
  induction t generalizing B with
  | zero => simpa using hB 0
  | succ t ih =>
  simp_rw [Protocol.broadcast_succ] at *
  obtain _ | ⟨b, B⟩ := B
  · cases hB 0
  simp only [List.cons.injEq, forall_and] at hB
  specialize ih hB.2
  subst ih
  have h₁ : forget (t : ZMod d) v = forget (t : ZMod d) (a t) := hF.forget t
  have h₂ : P.broadcast v t = P.broadcast (a t) t := (hB.2 t).symm
  rw [h₁, h₂, hB.1]

end NOF
