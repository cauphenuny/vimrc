#import "@preview/ori:0.2.2": *
#import "@local/math-abbr:1.0.0": *
#import "@local/fonts:1.0.0": font
#set heading(numbering: numbly("{1:一}、", default: "1.1  "))
#show math.equation: eq => math.display(eq)
#show: ori.with(
  title: "Title",
  author: "袁晨圃",
  subject: "Subject",
  semester: "2025 春",
  date: datetime.today(),
  // maketitle: true,
  // makeoutline: true,
  // theme: "dark",
  // media: "screen",
  font: font,
)
