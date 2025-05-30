/* 
 Следует ГОСТ 7.32-2017
 */

#let set_terms_format(doc) = {
  set terms(
    separator: [ --- ],
    indent: 0em,
  ) 
  doc
}

// #let definition(name, definition) = {
//   /* 4.9 */
//   par(
//     first-line-indent: (
//       amount: 0em,
//     ),
//   )[#name --- #definition]
// }

#let set_figures_format(doc) = {
  set figure.caption(separator: [ --- ])
  /* 4.5 Изображения */
  show figure.where(kind: image): set figure(supplement: "Рисунок")
  /* 4.6 Таблицы */
  show figure.where(kind: table): set figure(supplement: "Таблица")
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption.where(kind: table): it => [
    #align(left)[#it]
  ]
  doc
}

#let set_text_format(doc) = {
  set text(
    font: "Times New Roman",
    size: 14pt,
    spacing: 150%,
    lang: "ru",
  )
  set par(
    first-line-indent: ( // красная строка в параграфе
      amount: 1.25cm,
      all: true,
    ),
    justify: true, // выравнивание по ширине
    spacing: 1em,
    leading: 1em, // междустрочный интервал
  )
  doc
}

#let thesis_format(
  title,
  author,
  title_page: [],
  doc,
) = {

  /* 4.3 Титульник не нумеруется */
  set page(numbering: "1")
  title_page

  set document(
    title: title,
    author: author,
  )

  /* 4.2 стиль для основного текста без титульника */
  set page(
    paper: "a4",
    margin: (
      left: 30mm,
      right: 15mm,
      top: 20mm,
      bottom: 20mm,
    ),
    numbering: "1",
  )

  show heading: set block(spacing: 1.5em)
  show heading.where(depth: 2): it => {
    block(inset: (left: 1.25cm), it)
  }

  set list(marker: [--])
  set enum(numbering: "1.")

  show: set_terms_format
  show: set_figures_format
  show: set_text_format


  // counter(page).update(2)
  set heading(numbering: "1.1")

  doc
}

/* 4.4.3 */
#let chapter(name) = {
  /* 4.4.2 */
  pagebreak()
  heading[#name]
}

/* 4.4 Оформление заголовков
   4.4.1 Структурные элементы */
#let struct(name, outlined: true) = {
  /* 4.4.2 */
  pagebreak()
  align(center)[
    #heading(
      numbering: none,
      outlined: outlined,
    )[#upper(name)]
  ]
  v(1em)
}

