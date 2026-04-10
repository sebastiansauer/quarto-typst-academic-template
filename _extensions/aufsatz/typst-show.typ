// typst-show.typ – Quarto-Metadaten an die Aufsatz-Vorlage übergeben

#show: aufsatz.with(
  $if(title)$title: "$title$",$endif$
  $if(logo)$logo: "$logo$",$endif$
  $if(subtitle)$subtitle: "$subtitle$",$endif$
  $if(by-author)$
  author: (
    $for(by-author)$"$it.name.literal$"$sep$, $endfor$
  ),
  $elseif(author)$
  author: "$author$",
  $endif$
  $if(date)$date: "$date$",$endif$
  $if(thesis-type)$thesis-type: "$thesis-type$",$endif$
  $if(module)$module: "$module$",$endif$
  $if(institution)$institution: "$institution$",$endif$
  $if(department)$department: "$department$",$endif$
  $if(degree-program)$degree-program: "$degree-program$",$endif$
  $if(semester)$semester: "$semester$",$endif$
  $if(course)$course: "$course$",$endif$
  $if(supervisor)$supervisor: "$supervisor$",$endif$
  $if(student-id)$student-id: "$student-id$",$endif$
  $if(lang)$lang: "$lang$",$endif$
  $if(abstract)$
  abstract: [
    $abstract$
  ],
  $endif$
  $if(paper-size)$paper-size: "$paper-size$",$endif$
  $if(font)$font: "$font$",$endif$
  $if(fontsize)$font-size: $fontsize$,$endif$
  $if(linestretch)$line-spacing: $linestretch$em,$endif$
  $if(toc)$toc: $toc$,$endif$
  $if(toc-depth)$toc-depth: $toc-depth$,$endif$
  $if(toc-title)$toc-title: "$toc-title$",$endif$
  $if(section-numbering)$section-numbering: "$section-numbering$",$endif$
)
