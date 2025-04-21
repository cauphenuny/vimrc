#import "@local/theme-homework:1.0.0"
#import "@local/math-abbr:1.0.0": *
#import "@local/theorem-presets:1.0.0": *
#let split-full = align(center, line(stroke: 0.04em, length: 100%))
#let split-semi = align(center, line(stroke: 0.04em, length: 60%))
#let conf(title: none, doc) = theme-homework.conf(
  title: title,
  semister: "2025春",
  course: "Course",
  doc,
)
