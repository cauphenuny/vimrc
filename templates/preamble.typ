#import "@local/theme-default:0.1.3": conf
#show: doc => conf(
  header: "",
  title: "",
  author: "",
  doc,
)
#import "@local/math-abbr:1.0.0": *
#import "@local/typst-sympy-calculator-preset:0.1.0": *
#import "@local/latex-simulation:1.0.1": toprule, bottomrule, midrule, three-line-table
#import "@local/elements-enhance:1.0.0": splitline, wrong
#import "@preview/tablem:0.1.0": tablem

#import "@preview/ctheorems:1.1.3": *
#show: thmrules.with(qed-symbol: $square$)
#let _ans_color = black
#let _theorem_color = aqua.lighten(70%)
#let _lemma_color = olive.lighten(80%)
#let _problem_color = silver.lighten(35%)
#let answer(..args) = text(_ans_color, thmplain("answer", "Answer").with(numbering: none)(..args))
#let proof(..args) = text(_ans_color, thmplain("proof", "Proof").with(numbering: none)(..args))
#let solution(..args) = text(_ans_color, thmplain("solution", "Solution").with(numbering: none)(..args))
#let example = thmplain("example", "例").with(numbering: none)
#let definition = thmbox("definition", "定义")
#let theorem = thmbox("theorem", "定理", fill: _theorem_color)
#let trick = thmbox("trick", "技巧", fill: red.lighten(85%)).with(numbering: none)
#let corollary = thmbox("corollary", "推论", base: "theorem", fill: _lemma_color).with(numbering: none)
#let lemma = thmbox("lemma", "引理", base: "theorem", fill: _lemma_color).with(numbering: none)
#let conclusion = thmbox("conclusion", "结论", fill: _theorem_color).with(numbering: none)
#let problem = thmbox("problem", "例题", fill: _problem_color)
#let variant = thmbox("variant", "变式", base: "problem", fill: _problem_color.lighten(30%))
#let exercise = thmbox("exercise", "习题", base_level: 0, titlefmt: strong, fill: _problem_color)
