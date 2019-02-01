\version "2.19.0"
#(ly:set-option 'strokeadjust #t)
#(set-global-staff-size 15.5)

ml = #(define-music-function (parser location off) (number?)
       #{ \once \override Lyrics.LyricText.X-offset = #off #})

\paper {
  systems-per-page = 4
  page-count = 4

  top-margin = 6 \mm
  left-margin = 16 \mm
  right-margin = 15 \mm
  last-bottom-spacing.basic-distance = 8
  top-system-spacing.basic-distance = 10
  markup-system-spacing.basic-distance = 10

  oddFooterMarkup = \markup {
    \fill-line {
      \fromproperty #'header:tagline
    }
  }
  oddHeaderMarkup = \markup \small \fill-line {
    \line {
      \on-the-fly #not-first-page \fromproperty #'header:title
      \on-the-fly #not-first-page \concat {
        "(" \fromproperty #'header:composer ")"
      }
      \on-the-fly #not-first-page "-"
      \on-the-fly #print-page-number-check-first \normalsize \bold \fromproperty #'page:page-number-string
    }
  }
  evenHeaderMarkup = \oddHeaderMarkup
}

\header {
  title = "Eja, Mater"
  composer = "Antonín Dvořák"
  tagline = \markup \small {
    skład nut: Jan Warchoł
    (jan.warchol@gmail.com, 509 078 203)
  }
}

\markup \scale #'(0.85 . 0.85) {
  \typewriter {
    \column {
      \bold
      "Eia, Mater, fons   amoris,  me sentire vim  doloris fac, ut   tecum  lugeam."
      "O,   Matko, źródło miłości, mi odczuć  siłę bólu    daj, abym z Tobą smucił się."
    }
  }
}

Layout = \layout {
  indent = 0
  \dynamicUp
  \compressFullBarRests
  \override DynamicTextSpanner.style = #'none
  \override TextScript.direction = #UP
  \override Staff.StaffSymbol.thickness = #0.7
  \override Stem.thickness = #1.4
  \override Slur.thickness = #1.5
  \override Tie.line-thickness = #1
  \override Hairpin.thickness = #1.25

  \context {
    \Lyrics
    \override LyricText.font-size = #0.5
    \override VerticalAxisGroup.nonstaff-unrelatedstaff-spacing.padding = #0.5
    \override VerticalAxisGroup.nonstaff-relatedstaff-spacing.padding = #0.35
  }
  \context {
    \Score
    \override BarNumber.break-visibility = #'#(#f #t #t)
    \override BarNumber.self-alignment-X =
    #(lambda (grob)
      (let ((break-dir (ly:item-break-dir grob)))
        (if (= break-dir RIGHT)
          1
          0)))

    \override BarNumber.stencil =
    #(lambda (grob)
        (let ((break-dir (ly:item-break-dir grob)))
          (set! (ly:grob-property grob 'font-size)
                (if (= break-dir RIGHT)
                    -1
                    -3))
          (ly:text-interface::print grob)))
  }
  \context {
    \Staff
    \consists "Ambitus_engraver"
    \autoBeamOff
    \override VerticalAxisGroup.remove-empty = ##f
    \override VerticalAxisGroup.remove-first = ##f
  }
}

SopranoMusic = \include "sopranoMusic.ily"
SopranoLyrics = \include "sopranoWords.ily"
AltoMusic = \include "altoMusic.ily"
AltoLyrics = \include "altoWords.ily"
TenorMusic = \include "tenorMusic.ily"
TenorLyrics = \include "tenorWords.ily"
BassMusic = \include "bassMusic.ily"
BassLyrics = \include "bassWords.ily"

SopranoInstrumentName = "S "
SopranoShortInstrumentName = "S "
AltoInstrumentName = "A "
AltoShortInstrumentName = "A "
TenorInstrumentName = "T "
TenorShortInstrumentName = "T "
BassInstrumentName = "B "
BassShortInstrumentName = "B "


\include "satb.ly"

%{
\score {
  \new ChoirStaff
  <<
    \new Staff = soprany \with { \consists "Ambitus_engraver" } {
      \clef treble
      \set Staff.instrumentName = "S "
      \set Staff.shortInstrumentName = "S "
      \autoBeamOff
      \include "sopranoMusic.ily"
    }
    \addlyrics { \include "sopranoWords.ily" }

    \new Staff = alty \with { \consists "Ambitus_engraver" } {
      \clef treble
      \set Staff.instrumentName = "A "
      \set Staff.shortInstrumentName = "A "
      \autoBeamOff
      \include "altoMusic.ily"
    }
    \addlyrics { \include "altoWords.ily" }

    \new Staff = tenory \with { \consists "Ambitus_engraver" } {
      \clef "treble_8"
      \set Staff.instrumentName = "T "
      \set Staff.shortInstrumentName = "T "
      \autoBeamOff
      \include "tenorMusic.ily"
    }
    \addlyrics { \include "tenorWords.ily" }

    \new Staff = basy \with { \consists "Ambitus_engraver" } {
      \clef bass
      \set Staff.instrumentName = "B "
      \set Staff.shortInstrumentName = "B "
      \autoBeamOff
      \include "bassMusic.ily"
    }
    \addlyrics { \include "bassWords.ily" }
  >>

}

%}