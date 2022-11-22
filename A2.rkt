;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname A2) (compthink-settings #hash((prefix-types? . #f))))
; Cutting and Replacing parts of DNA
; ==================================

; A DNA sequence can be represented by a text containing only the letters "A", "C", "G", and "T".
; This assignment ends up producing functions that meaningully alter such sequences, but nothing
;  will need to assume that text contains only those characters. In fact, the functions will all
;  be useful in many other situations involving text.

; The specifications refer to “cuts”: a cut will mean a text split into two pieces:
;  • the part up to a particular point, and
;  • the part from that point onward
; Since that is two pieces of information, we'll represent that as a list with the two parts.

; Complete all the parts marked with a “★”.

; cut-at : text number → cut
; ——————————————————————————
; For a text, and an index n to cut at, produce a cut with the first n characters and the remainder.
(check (cut-at "string" 4) (list "stri" "ng"))
(check (cut-at "string" 6) (list "string" ""))

; ★ Add a check for a non-special case, with a different first argument than in the previous checks:


; ★ Add two checks, for two more kinds of special/extreme/boundary/edge case (one case might be a
;    a “more” special case of the other one):


; ★ For your non-special check, add one or more Design versions of it, ending with a Full Design:


; ★ Define  cut-at  according to your Full Design:
#;(define (cut-at t i)
    )

; cuts : text → list-of-cut
; —————————————————————————
; Produce a list of all cuts of a text.
#;(check (cuts "wood") (list (list "" "wood")
                             (list "w" "ood")
                             (list "wo" "od")
                             (list "woo" "d")
                             (list "wood" "")))

; ★ Add a check for a non-special case, with a different first argument than in the previous check:


; ★ Add a check for a special case:


; ★ Add a Partial Design check that shows how to produce the result of the first  cuts  check,
;    by replacing each cut with a call of  cut-at :


; The five expressions for the elements should be the same except for one changing value.
; So, each element is a function of that one changable value. Let's define that function ...
#;(check (cut-wood 1) (list "w" "ood"))
; ★ Define a function  cut-wood  that specifically cuts the text "wood":


; ★ Add a version of your previous Partial Design check, using  cut-wood  instead of cut-at :


; ★ Add a version of your previous Partial Design check, that mentions  cut-wood  only once.


; ★ Replace one of the references to  cut-wood  in the following check, with an anonymous version
;    of  cut-wood :
#;(check (cut-wood 2) (cut-wood 2))


; ★ Add a version of your previous Partial Design check that uses that anonymous function:


; ★ If that wasn't a Full Design for  cuts , turn it into one now:


; ★ Define  cuts  according to your Full Design:


; For the DNA work, the cuts are more meaningful than their positions.
; For the rest of the assignment:
;  • do not use  cut-at  to produce a cut (and don't manually mimic it)
;  • use the following aliases  left  and  right  when referring one of the pieces of a cut
(define left   first)
(define right second)

; prefix? : text text → boolean
; —————————————————————————————
; Is a text the start of another text?
#;(check (prefix? "blue" "blueberry") #true)
#;(check (prefix? "blue" "raspberry") #false)

; ★ Add three checks to demonstrate that:
;  • the result can be false when the first text occurs somewhere other than at the start
;  • the result can be false when the second text is the start of the first text
;  • two texts can be prefixes of each other


; ★ Turn each of the five of the previous checks into Design checks:


; ★ Define  prefix?  according to your Design checks:


; match? : cut text → boolean
; ———————————————————————————
; Does the right part of a cut start with a particular text?
#;(check (match? (list "where's " "waldo?") "waldo") #true)
#;(check (match? (list "where's" " waldo?") "waldo") #false)

; ★ Design and define  match? :


; For the rest of the assignment we'll refer to a text used for matching as an “enzyme”, which is
;  what would be used to manipulate DNA.

; matches : text enzyme → list-of-cuts
; ————————————————————————————————————
; All cuts of a text that match a particular enzyme, according to  match? :
#;(check (matches "scooby doo" "oo")
         (list (list "sc" "ooby doo")
               (list "scooby d" "oo")))
#;(check (matches "scooby doo" "oo")
         (list #;(list "" "scooby doo") #;(match? (list "" "scooby doo") "oo")
               #;(list "s" "cooby doo")
               (list "sc" "ooby doo")   #;(match? (list "sc" "ooby doo") "oo")
               #;(list "sco" "oby doo")
               #;(list "scoo" "by doo")
               #;(list "scoob" "y doo")
               #;(list "scooby" " doo")
               #;(list "scooby " "doo")
               (list "scooby d" "oo")
               #;(list "scooby do" "o")
               #;(list "scooby doo" "")))

; ★ Beside one of the included cuts, and beside one of the excluded cuts, show why it was included
;    or excluded: write a commented-out expression that produce true for the included cut, and a
;    commented-out expression that produces false for the excluded cut. The two expressions should
;    be the same, except where they mention the particular cut. This is a situation again where we
;    have similar expressions representing a unary function of their part that varies.

; ★ Write a commented-out anonymous function that takes a cut and determines whether it should be
;    included in the above result:


; ★ Design and define  matches :


; first-match : text enzyme → cut
; ———————————————————————————————
; The first cut of a text that matches a particular enzyme.
#;(check (first-match "scooby doo" "oo")
         (list "sc" "ooby doo"))

; ★ Define  first-match :


; fix : text text enzyme → text
; —————————————————————————————
; For a text representing a “mutated” piece of DNA, and a text representing a “clean” piece of DNA,
;  and an enzyme that matches each of them at least once, replace the part of the mutant after its
;  first match with the part of the clean text after its first match.
#;(check (fix "ACGTGGCCTAGCT" "ACGGCCTT" "GGCC") "ACGTGGCCTT")

; ★  Design and define  fix :


; maybe-fix text text enzyme → text
; —————————————————————————————————
; For a “mutated” and a “clean” piece of DNA text, if an enzyme matches exactly one of the mutant's
;  cuts, fix the mutant using the clean piece, otherwise just produce the mutant.
#;(check (maybe-fix "ACGTGGCCTAGCT" "ACGGCCTT" "GGCC") "ACGTGGCCTT")
#;(check (maybe-fix "CAGCTGATCG" "ACGGCCTT" "GGCC") "CAGCTGATCG")

; ★ Add a third check illustrating that  fix  happens only when there is *exactly* one match.


; ★ Define  maybe-fix :


; cut-out : text enzyme enzyme → text
; ———————————————————————————————————
; Produce a list of three parts of the text:
;  • before the first enzyme's match
;     (assume there is one)
;  • from the first enzyme's match up to but not including the second enzyme's match
;     (assume there is one after the first enzyme's match)
;  • from that second enzyme's match onward
#;(check (cut-out "ABCDE" "B" "D") (list "A" "BC" "DE"))

; ★ Design and define  cut-out :


; in-fix : text text enzyme enzyme → text
; —————————————————————————————————————
; For a “mutated” and a “clean” piece of DNA, and two enzymes that can  cut-out  each of them,
;  replace the middle piece (according to cut-out) of the the mutant with the middle piece of
;  the clean piece.

; ★ Write at least one check for  in-fix :


; ★ Define  in-fix :

