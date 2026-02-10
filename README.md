# Chandra-Furst-Lipton

[![.github/workflows/push.yml](https://github.com/YaelDillies/chandra-furst-lipton/actions/workflows/push.yml/badge.svg)](https://github.com/YaelDillies/chandra-furst-lipton/actions/workflows/push.yml)
[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/YaelDillies/chandra-furst-lipton)

The purpose of this repository is to *digitise* some mathematical definitions, theorem statements
and theorem proofs. Digitisation, or formalisation, is a process where the source material,
typically a mathematical textbook or a pdf file or website or video, is transformed into definitions
in a target system consisting of a computer implementation of a logical theory (such as set theory
or type theory).

## The source

The definitions, theorems and proofs in this repository are taken from the now classic [multi-party protocols paper of Chandra-Furst Lipton](https://www.cs.umd.edu/~gasarch/BLOGPAPERS/multiparty-vdw.pdf).

## The target

The formal system which we are using as a target is Lean 4,
a theorem prover based on the Calculus of Inductive Constructions, a dependent type theory.
Lean is being developed by the [Lean FRO](https://lean-lang.org).

## Content of this project

### Code organisation

The Lean code is contained in the directory `ChandraFurstLipton/`.

## Getting the project

To build the Lean files of this project, you need to have a working version of Lean.
See [the installation instructions](https://lean-lang.org/install/).
Alternatively, click on the button below to open an Ona workspace containing the project.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/YaelDillies/chandra-furst-lipton)

In either case, run `lake exe cache get` and then `lake build` to build the project.

## Contributing

This project is currently not open to contribution.

## Source reference

`[CFL]` : https://www.cs.umd.edu/~gasarch/BLOGPAPERS/multiparty-vdw.pdf

[CFL]: https://www.cs.umd.edu/~gasarch/BLOGPAPERS/multiparty-vdw.pdf
