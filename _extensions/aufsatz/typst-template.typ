// Quarto Typst Template: Aufsatz
// Vorlage für wissenschaftliche Arbeiten von Studierenden
// Author: Sebastian Sauer



#show <refs>: set par(
  first-line-indent: 0cm,
  hanging-indent: 1.27cm,
)


#let safe-meta-text(x) = {
  if x == none {
    []
  } else {
    let s = str(x)
      .replace("\\", "\\\\")
      .replace(".", "\\.")
    eval(s, mode: "markup")
  }
}



#let aufsatz(
  // Metadaten des Dokuments
  title: none,
  subtitle: none,
  logo: none,
  author: none,
  date: none,
  thesis-type: "Seminararbeit",
  // Institutionelle Angaben
  institution: none,
  department: none,
  module: none,
  course: none,
  supervisor: none,
  // Angaben zur Person
  student-id: none,
  degree-program: none,
  semester: none,
  // Dokumentoptionen
  lang: "de",
  abstract: none,
  paper-size: "a4",
  font: "Linux Libertine",
  font-size: 12pt,
  line-spacing: 1.5em,
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2.5cm),
  // Inhaltsverzeichnis
  toc: true,
  toc-depth: 3,
  toc-title: auto,
  // Nummerierung
  section-numbering: none,
  // Inhalt (Bibliographie wird von Quarto/citeproc in den Body injiziert)
  body,

  // BODY -----
) = {

  // Grundlegende Dokumenteinstellungen
  set document(
    title: title,
    author: if author != none { author } else { () },
  )

  set page(
    paper: paper-size,
    margin: margin,
    numbering: "1",
    number-align: center,
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 9pt, fill: luma(100))
        align(right)[#title]
        line(length: 100%, stroke: 0.5pt + luma(150))
      }
    },
    footer: context {
      if counter(page).get().first() > 1 {
        set text(size: 9pt, fill: luma(100))
        line(length: 100%, stroke: 0.5pt + luma(150))
        align(center)[#counter(page).display("1")]
      }
    },
  )

  set text(
    font: font,
    size: font-size,
    lang: lang,
    region: if lang == "de" { "DE" } else { "US" },
  )

  set par(
    justify: true,
    leading: 0.65em,
    first-line-indent: 1.5em,
  )

  // Überschriften-Formatierung
  set heading(numbering: section-numbering)

  show heading.where(level: 1): it => {
    set text(size: 14pt, weight: "bold")
    set par(first-line-indent: 0em)
    v(1.2em, weak: true)
    it
    v(0.6em, weak: true)
  }

  show heading.where(level: 2): it => {
    set text(size: 12pt, weight: "bold")
    set par(first-line-indent: 0em)
    v(1.6em, weak: true)
    it
    v(0.7em, weak: true)
  }

  show heading.where(level: 3): it => {
    set text(size: 12pt, weight: "bold", style: "italic")
    set par(first-line-indent: 0em)
    v(1.3em, weak: true)
    it
    v(0.7em, weak: true)
  }

  // Links
  show link: underline

  // Hilfsfunktion für Autorenanzeige
  let author-text = if author != none {
    if type(author) == array {
      author.join(", ")
    } else {
      author
    }
  } else {
    none
  }



  // ─── Titelseite ──────────────────────────────────────────────────────────
  page(
    numbering: none,
    header: none,
    footer: none,
  )[
    #set par(first-line-indent: 0em)

    // Oberer Bereich: Hochschule / Fachbereich
    #align(center)[
    // Logo oben
      #if $logo$ != none and type($logo$) == str {image($logo$, width: 4cm)}
      #v(1.2cm)

      #if institution != none [
        #text(size: 14pt)[#institution]
        #linebreak()
      ]

      #if department != none [
        #text(size: 12pt)[#department]
        #linebreak()
      ]

      #if module != none [
        #v(0.6cm)
        #text(size: 11pt)[Modul: #module]
      ]

      #if course != none [
        #text(size: 11pt)[Lehrveranstaltung: #course]
      ]
    ]

    #v(2.4cm)

    // Mittlerer Bereich: Art der Arbeit und Titel
    #align(center)[
      #text(size: 13pt, weight: "semibold")[#thesis-type]

      #v(1.1cm)

      #text(size: 20pt, weight: "bold")[#title]

      #if subtitle != none [
        #v(0.5cm)
        #text(size: 14pt, style: "italic")[#subtitle]
      ]
    ]

    #v(2.0cm)

    #line(length: 100%, stroke: 0.7pt + luma(140))

    #v(1.1cm)

    // Unterer Block: typische Angaben einer Seminararbeit
    #grid(
      columns: (auto, 1fr),
      column-gutter: 1.2cm,
      row-gutter: 0.45cm,

      [Name:], [#if author-text != none [#author-text] else []],
      [Matrikelnummer:], [#if student-id != none [#student-id] else []],
      //[Studiengang:], [#if degree-program != none [#degree-program] else []],
     // [Fachsemester:], [#if semester != none [#semester] else []],
      //[Modul:], [#if module != none [#module] else []],
      //[Lehrveranstaltung:], [#if course != none [#course] else []],
      [Dozent/in:], [#safe-meta-text(supervisor)],
      //[Hochschule:], [#if institution != none [#institution] else []],
      [Abgabedatum:], [
        #if date != none [#date]
      ],
    )

    #v(1fr)
  ]



  // ─── Abstract ────────────────────────────────────────────────────────────
  if abstract != none {
    page(numbering: none, header: none, footer: none)[
      #set par(first-line-indent: 0em)
      #v(2em)
      #align(center)[
        #text(weight: "bold", size: 13pt)[Abstract]
      ]
      #v(1em)
      #set text(size: 12pt)
      #abstract
    ]
  }

  // ─── Inhaltsverzeichnis ──────────────────────────────────────────────────
  if toc {
    set page(numbering: "i", header: none, footer: context {
      set text(size: 9pt, fill: luma(100))
      line(length: 100%, stroke: 0.5pt + luma(150))
      align(center)[#counter(page).display("i")]
    })
    counter(page).update(1)

    set par(first-line-indent: 0em)
    let toc-title-text = if toc-title == auto {
      if lang == "de" { "Inhaltsverzeichnis" } else { "Table of Contents" }
    } else {
      toc-title
    }
    outline(
      title: toc-title-text,
      depth: toc-depth,
      indent: auto,
    )
    pagebreak()
  }

  // ─── Hauptteil ───────────────────────────────────────────────────────────
  set page(numbering: "1")
  counter(page).update(1)

  body
}
