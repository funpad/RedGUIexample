Red [
	Needs: 'View
]

system/view/debug?: yes
live?: system/view/auto-sync?: no

workstation?: system/view/platform/product = 1

print [
	"Windows" switch system/view/platform/version [
		10.0.0	[pick ["10"			 "10 Server"	 ] workstation?]
		6.3.0	[pick ["8.1"		 "Server 2012 R2"] workstation?]
		6.2.0	[pick ["8"			 "Server 2012"	 ] workstation?]
		6.1.0	[pick ["7"			 "Server 2008 R1"] workstation?]
		6.0.0	[pick ["Vista"		 "Server 2008"	 ] workstation?]
		5.2.0	[pick ["Server 2003" "Server 2003 R2"] workstation?]
		5.1.0	["XP"]
		5.0.0	["2000"]
	] 
	"build" system/view/platform/build
]

; Initialize board margin and field size
margin-board: margin-x: margin-y: 20
field-size: field-width: field-height: 40
image-size: 30
half-size: image-size / 2
half-offset: 0x0
half-offset/1: half-offset/2: half-size
half-field: 0x0
half-field/1: half-field/2: field-size / 2
image-format: 0x0
image-format/1: image-format/2: image-size
correction-offset: 0x0
correction-offset/1: correction-offset/2: margin-board - half-size
correction-offset: correction-offset + 100x100

; Simple declaration of all pieces to support compilation
white-king: 
white-advisor-1: 
white-advisor-2: 
white-elephant-1: 
white-elephant-2:
white-horse-1: 
white-horse-2: 
white-chariot-1: 
white-chariot-2: 
white-canon-1: 
white-canon-2:
white-pawn-1:
white-pawn-2:
white-pawn-3:
white-pawn-4:
white-pawn-5:

black-king:
black-advisor-1:
black-advisor-2:
black-elephant-1:
black-elephant-2:
black-horse-1:
black-horse-2:
black-chariot-1:
black-chariot-2:
black-canon-1:
black-canon-2:
black-pawn-1:
black-pawn-2:
black-pawn-3:
black-pawn-4:
black-pawn-5: make face! []
;

image-actors: object [
		on-drag-start: func [face [object!] event [event!]][
			print "drag starts"
		]
		on-drag: func [face [object!] event [event!]][
			prin dot
		]
		on-drop: function [face [object!] event [event!]][
			print "dropping"
		]
]

; Pieces to be placed on the canvas
all-pieces: [
	; piece		 		id	 offset piece-Type Western/Traditional(art) color
	"white-king"       "WK"  4x9 "General"  "T" "R"
	"white-advisor-1"  "WA1" 3x9 "Advisor"  "T" "R"
	"white-advisor-2"  "WA2" 5x9 "Advisor"  "T" "R"
	"white-elephant-1" "WE1" 2x9 "Elephant" "T" "R"
	"white-elephant-2" "WE2" 6x9 "Elephant" "T" "R"
	"white-horse-1"    "WH1" 1x9 "Horse"    "T" "R"
	"white-horse-2"    "WH2" 7x9 "Horse"    "T" "R"
	"white-chariot-1"  "WR1" 0x9 "Chariot"  "T" "R"
	"white-chariot-2"  "WR2" 8x9 "Chariot"  "T" "R"
	"white-canon-1"    "WC1" 1x7 "Cannon"   "T" "R"
	"white-canon-2"    "WC2" 7x7 "Cannon"   "T" "R"
	"white-pawn-1"     "WP1" 0x6 "Soldier"  "T" "R"
	"white-pawn-2"     "WP2" 2x6 "Soldier"  "T" "R"
	"white-pawn-3"     "WP3" 4x6 "Soldier"  "T" "R"
	"white-pawn-4"     "WP4" 6x6 "Soldier"  "T" "R"
	"white-pawn-5"     "WP5" 8x6 "Soldier"  "T" "R"
	
	"black-king"       "BK"  4x0 "General"  "T" "B"
	"black-advisor-1"  "BA1" 3x0 "Advisor"  "T" "B"
	"black-advisor-2"  "BA2" 5x0 "Advisor"  "T" "B"
	"black-elephant-1" "BE1" 2x0 "Elephant" "T" "B"
	"black-elephant-2" "BE2" 6x0 "Elephant" "T" "B"
	"black-horse-1"    "BH1" 1x0 "Horse"    "T" "B"
	"black-horse-2"    "BH2" 7x0 "Horse"    "T" "B"
	"black-chariot-1"  "BR1" 0x0 "Chariot"  "T" "B"
	"black-chariot-2"  "BR2" 8x0 "Chariot"  "T" "B"
	"black-canon-1"    "BC1" 1x2 "Cannon"   "T" "B"
	"black-canon-2"    "BC2" 7x2 "Cannon"   "T" "B"
	"black-pawn-1"     "BP1" 0x3 "Soldier"  "T" "B"
	"black-pawn-2"     "BP2" 2x3 "Soldier"  "T" "B"
	"black-pawn-3"     "BP3" 4x3 "Soldier"  "T" "B"
	"black-pawn-4"     "BP4" 6x3 "Soldier"  "T" "B"
	"black-pawn-5"     "BP5" 8x3 "Soldier"  "T" "B"
]

image-path: %../project/gui/

make-piece-faces: does [
	foreach [p i o t a c] all-pieces [
		; declare piece image
		declare-piece: copy []
		declare-piece-string: copy ""
		append declare-piece-string p
		append declare-piece-string {: make face! [
	type: 'image offset: }
		piece-offset: o * field-size + correction-offset
		append declare-piece-string piece-offset
		append declare-piece-string " size: "
		append declare-piece-string image-format
		append declare-piece-string {
	data: [%}
		append declare-piece-string image-path 
		append declare-piece-string "Xiangqi_"
		append declare-piece-string t
		append declare-piece-string "_"
		append declare-piece-string a
		append declare-piece-string c
		append declare-piece-string {.png]
}
		append declare-piece-string {
	options: [drag-on: 'down]
	id: "}
		append declare-piece-string i
		append declare-piece-string {"
	actors: image-actors
]}
		declare-piece: load declare-piece-string
		do declare-piece		
	]	; end foreach piece
]

make-piece-faces


; Declaring the window
win: make face! [
	type: 'window text: "Xiangqi Board Demo" offset: 500x500 size: 800x800

]

win/pane: reduce [
	
	canvas: make face! [
		type: 'base text: "Xiangqi in Red" offset: 100x100 size: 360x400 color: silver
		draw: [
			dummy draw contents
		]
	]

	make face! [ ; Quit button
		type: 'button text: "Quit" offset: 500x440 size: 60x24
		actors: object [
			on-click: func [face [object!] event [event!]][
				print "calling unview"
				unview/all
			]
		]
	]

	white-king
	white-advisor-1
	white-advisor-2
	white-elephant-1
	white-elephant-2
	white-horse-1
	white-horse-2
	white-chariot-1
	white-chariot-2
	white-canon-1
	white-canon-2
	white-pawn-1
	white-pawn-2
	white-pawn-3
	white-pawn-4
	white-pawn-5

	black-king
	black-advisor-1
	black-advisor-2
	black-elephant-1
	black-elephant-2
	black-horse-1
	black-horse-2
	black-chariot-1
	black-chariot-2
	black-canon-1
	black-canon-2
	black-pawn-1
	black-pawn-2
	black-pawn-3
	black-pawn-4
	black-pawn-5

]

; Start drawing board on the canvas
canvas/draw: [
	line-cap round
	pen black
]

; Initialize board margin and field size
margin-board: margin-x: margin-y: 20
field-size: field-width: field-height: 40
image-size: 30

; Set canvas size (360x400)
canvas/size/1: 2 * margin-board + ( 8 * field-size )
canvas/size/2: 2 * margin-board + ( 9 * field-size )

; Draw outline
p1: p2: p3: p4: 0x0
p1/1: p1/2: p2/2: p4/1: margin-board
p2/1: p3/1: 8 * field-size + margin-board
p3/2: p4/2: 9 * field-size + margin-board

append canvas/draw reduce ['line p1 p2 p3 p4 p1] 

; Draw top vertical lines
p1: p2: 0x0
p1/2: margin-board
p2/2: field-size * 4 + margin-board 

repeat count 7 [
	vert: count * field-size + margin-board
	p1/1: vert
	p2/1: vert
	append canvas/draw reduce ['line p1 p2] 
]

; Draw bottom vertical lines
p1: p2: 0x0
p1/2: 5 * field-size + margin-board ; 220
p2/2: 9 * field-size + margin-board ; 380

repeat count 7 [
	vert: count * field-size + margin-board
	p1/1: vert
	p2/1: vert
	append canvas/draw reduce ['line p1 p2] 
]

; Draw horizontal lines
p1: p2: 0x0
p1/1: margin-board
p2/1: field-size * 8 + margin-board

repeat count 3 [
	vert: count * field-size + margin-board
	p1/2: vert
	p2/2: vert
	append canvas/draw reduce ['line p1 p2] 
]
; We skip the river, this is done later in blue
repeat count 3 [
	vert: count + 5 * field-size + margin-board ; count + 5 is calculated first!
	p1/2: vert
	p2/2: vert
	append canvas/draw reduce ['line p1 p2] 
]

; Draw the dots
dot-size: 4
p1/1: p1/2: margin-board

append canvas/draw [
	pen black
	fill-pen black
]

board-dots: [
	0x3 1x2 2x3 4x3 6x3 7x2 8x3
	0x6 1x7 2x6 4x6 6x6 7x7 8x6
]

foreach board-dot board-dots [
	append canvas/draw reduce [
		'circle board-dot * field-size + p1 dot-size
	]
]

; Draw the palace crosses
cross-points: [
	3x0 5x2
	5x0 3x2
	3x9 5x7
	5x9 3x7
]

foreach [p2 p3] cross-points [
	append canvas/draw reduce [
		'line p2 * field-size + p1 p3 * field-size + p1
	]
]

; Draw 'the river' in blue
append canvas/draw [
	pen blue
]

river-points: [
	0x4 8x4
	0x5 8x5
]

foreach [p2 p3] river-points [
	append canvas/draw reduce [
		'line p2 * field-size + p1 p3 * field-size + p1
	]
]
; board is ready

; show window
show win

do-events
