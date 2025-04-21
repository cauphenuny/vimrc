#import "@preview/ori:0.2.2": *
#import "@local/math-abbr:1.0.0": *
#import "@local/fonts:1.0.0": font
#let split-full = align(center, line(stroke: 0.04em, length: 100%))
#let split-semi = align(center, line(stroke: 0.04em, length: 60%))

#let conf(title: "Title", doc) = {
  set heading(numbering: numbly("{1:一}、", default: "1.1  "))
  show: ori.with(
    title: title,
    author: "袁晨圃",
    subject: "Subject",
    semester: "Semester",
    date: datetime.today(),
    maketitle: true,
    // makeoutline: true,
    // theme: "dark",
    // media: "screen",
    font: font,
  )
  import cosmos.rainbow: *
  show: show-theorion
  show math.equation: eq => math.display(math.thin + eq + math.thin)
  set enum(numbering: numbly("{1:(1)}", default: "a.i."))
  doc
}
