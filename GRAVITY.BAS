DECLARE SUB Instruct ()
DECLARE SUB ShareWare ()
DEFINT A-Z
DECLARE SUB Intro ()
DECLARE FUNCTION AnyColor% ()
DECLARE SUB Quit ()
DECLARE SUB PlayField (Colour)
DECLARE FUNCTION OnLeft% ()
DECLARE FUNCTION OnRight% ()
DECLARE FUNCTION Under% ()
DECLARE FUNCTION Topped% ()
DECLARE SUB PutBlock ()
DECLARE SUB EraseBlock ()
DECLARE SUB RemoveFour ()
DECLARE SUB PrintStats ()
DECLARE FUNCTION Choice$ ()
DECLARE SUB DownCol ()

'$INCLUDE: 'USEFUL.BI'
'$INCLUDE: 'CONSTANT.BI'
CONST BLOCK$ = ""

'$DYNAMIC
DIM SHARED Grid(2 TO 22, 13 TO 28) AS STRING * 1
DIM SHARED Complete AS INTEGER
DIM SHARED Level AS INTEGER
DIM SHARED Score AS INTEGER
DIM SHARED CurColor AS INTEGER
DIM SHARED CurLin AS INTEGER
DIM SHARED CurCol AS INTEGER

SCREEN 0, 0, 0, 0

ShareWare

WIDTH 40
COLOR 7, 0, 0
LOCATE , , 0
CLS

Intro
Instruct

PlayField (White)
Level = 1
PrintStats
DO
	CurLin = LBOUND(Grid, 1)
	CurCol = (LBOUND(Grid, 2) + UBOUND(Grid, 2)) \ 2
	CurColor = AnyColor
	PutBlock
	DO
		SELECT CASE MID$(Choice$, 1, 2)
		CASE CHR$(Esc)
			Quit
		CASE CHR$(0) + CHR$(Left)
			IF NOT OnLeft THEN
				EraseBlock
				CurCol = CurCol - 1
			END IF
		CASE CHR$(0) + CHR$(Right)
			IF NOT OnRight THEN
				EraseBlock
				CurCol = CurCol + 1
			END IF
		CASE CHR$(0) + CHR$(Down)
			IF NOT Under THEN
				EraseBlock
				CurLin = CurLin + 1
			END IF
			IF NOT Under THEN
				EraseBlock
				CurLin = CurLin + 1
			END IF
			IF NOT Under THEN
				EraseBlock
				CurLin = CurLin + 1
			END IF
		CASE ELSE
			IF NOT Under THEN
				EraseBlock
				CurLin = CurLin + 1
			END IF
		END SELECT
		PutBlock
		Delay .16
		Stps = UBOUND(Grid, 1) - LBOUND(Grid, 1)
		Freq! = 600 - ((CurLin - LBOUND(Grid, 1)) * (400 \ Stps))
		Sound1 Freq!, 6
	LOOP UNTIL Under
	Sound1 109, 0
	RemoveFour
	PrintStats
LOOP UNTIL Topped

COLOR Red + Bright + Flash
BEEP
LOCATE 12, 13
PRINT STRING$(14, BLOCK$);
LOCATE 13, 13
PRINT BLOCK$; " GAME OVER! "; BLOCK$;
LOCATE 14, 13
PRINT STRING$(14, BLOCK$);
SLEEP 4
Quit
END

REM $STATIC
FUNCTION AnyColor
RANDOMIZE TIMER
c = RND * 13 + 1
IF c = Yellow THEN
	AnyColor = White + Bright
ELSE
	AnyColor = c
END IF
END FUNCTION

DEFSNG A-Z
FUNCTION Choice$
	Choice$ = INKEY$ + INKEY$ + INKEY$ + INKEY$
END FUNCTION

DEFINT A-Z
SUB DownCol
Noise 5, 15
FOR Lin = CurLin TO LBOUND(Grid, 1) + 1 STEP -1
   Grid(Lin, CurCol) = Grid(Lin - 1, CurCol)
   LOCATE Lin, CurCol
   COLOR ASC(Grid(Lin, CurCol))
   PRINT BLOCK$;
   Grid(Lin - 1, CurCol) = CHR$(0)
   LOCATE Lin - 1, CurCol
   PRINT " ";
NEXT Lin
Noise 1, 0
END SUB

SUB DropCol (Lin)
IF Lin > LBOUND(Grid, 1) THEN
	IF ASC(Grid(Lin - 1, CurCol)) = 0 THEN DropCol (Lin - 1)
END IF
FOR L = Lin TO LBOUND(Grid, 1) + 1 STEP -1
	IF ASC(Grid(L, CurCol)) = 0 THEN
		Grid(L, CurCol) = Grid(L - 1, CurCol)
		Grid(L - 1, CurCol) = CHR$(0)
		LOCATE L - 1, CurCol
		PRINT " ";
		LOCATE L, CurCol
		COLOR ASC(Grid(L, CurCol))
		PRINT BLOCK$;
	END IF
NEXT L
END SUB

SUB EraseBlock
Grid(CurLin, CurCol) = CHR$(0)
LOCATE CurLin, CurCol
PRINT " ";
END SUB

SUB Instruct
COLOR Red + Bright
LOCATE 1, 13
PRINT "*INSTRUCTIONS*";
COLOR Yellow + Bright
LOCATE 3, 1: PRINT "     The Object of the game is to build"
LOCATE 5, 1: PRINT "2x2 squares of the same color.  When a"
LOCATE 7, 1: PRINT "block is completed, it disappears, and"
LOCATE 9, 1: PRINT "everything above it falls into the hole."
LOCATE 11, 1: PRINT "     Pressing <ESC> at any time in the"
LOCATE 13, 1: PRINT "game will exit to DOS.  Use the arrow"
LOCATE 15, 1: PRINT "keys to position the block as it falls,"
LOCATE 17, 1: PRINT "and the <DOWN> key will make it drop"
LOCATE 19, 1: PRINT "faster."

COLOR Blue + Bright
LOCATE 24, 11
PRINT "<SPACE> to play...";
DO
	SELECT CASE UCASE$(INKEY$)
	CASE CHR$(Space)
		Control = 0
		EXIT DO
	CASE CHR$(Esc)
		Quit
	END SELECT
LOOP
CLS
END SUB

SUB Intro
FOR Lin = 1 TO 24 STEP 23
	FOR Col = 1 TO 39 STEP 38
		COLOR AnyColor
		LOCATE Lin, Col
		PRINT BLOCK$; BLOCK$;
		LOCATE Lin + 1, Col
		PRINT BLOCK$; BLOCK$;
	NEXT Col
NEXT Lin
COLOR Red + Bright, Black
LOCATE 10, 10
PRINT "GRAVITY BLOCKS v1.5";
COLOR Yellow + Bright
LOCATE 12, 10
PRINT "By John Flinchbaugh";
LOCATE 13, 17
PRINT "of the";
LOCATE 14, 8
PRINT "HappyJohn Software Group";
COLOR Blue + Bright
LOCATE 24, 12
PRINT "Press <SPACE>...";
DO
	SELECT CASE UCASE$(INKEY$)
	CASE CHR$(Space)
		EXIT DO
	CASE CHR$(Esc)
		Quit
	END SELECT
LOOP
CLS
END SUB

FUNCTION OnLeft
Check = (CurCol = LBOUND(Grid, 2))
IF NOT Check THEN
	Check = (ASC(Grid(CurLin, CurCol - 1)) <> 0)
END IF
OnLeft = Check
END FUNCTION

FUNCTION OnRight
Check = (CurCol = UBOUND(Grid, 2))
IF NOT Check THEN
	Check = (ASC(Grid(CurLin, CurCol + 1)) <> 0)
END IF
OnRight = Check
END FUNCTION

SUB PlayField (Colour)
COLOR Colour, Black
LOCATE 1, 13
PRINT "GRAVITY BLOCKS";
COLOR Colour
FOR Lin = LBOUND(Grid, 1) TO UBOUND(Grid, 1)
	LOCATE Lin, 1
	PRINT STRING$(LBOUND(Grid, 2) - 1, 178);
	LOCATE Lin, UBOUND(Grid, 2) + 1
	PRINT STRING$(40 - UBOUND(Grid, 2), 178);
NEXT Lin
FOR Lin = UBOUND(Grid, 1) + 1 TO 25
	LOCATE Lin, 1
	PRINT STRING$(40, 178);
NEXT Lin
COLOR Black, Colour
LOCATE 24, 4
PRINT "LEVEL:";
LOCATE 24, 21
PRINT "SCORE:";
LOCATE 25, 1
PRINT "COMPLETE:";

COLOR Colour, Black
LOCATE 24, 11
PRINT SPACE$(4);
LOCATE 24, 28
PRINT SPACE$(6);
LOCATE 25, 11
PRINT SPACE$(4);
END SUB

SUB PrintStats
COLOR White + Bright, Black
LOCATE 24, 11
PRINT LTRIM$(STR$(Level));
LOCATE 24, 28
PRINT LTRIM$(STR$(Score));
LOCATE 25, 11
PRINT LTRIM$(STR$(Complete));

END SUB

SUB PutBlock
Grid(CurLin, CurCol) = CHR$(CurColor)
COLOR CurColor
LOCATE CurLin, CurCol
PRINT BLOCK$;
END SUB

SUB Quit
Sound1 109, 0
Noise 1, 0
COLOR 7, 0, 0
SCREEN 0, 0, 0, 0
LOCATE , , 1, 6, 7
WIDTH 80
CLS
PRINT CHR$(1); " Thank you for using a HappyJohn Software Product "; CHR$(1)
END
END SUB

SUB RemoveFour STATIC
FOR Lin = LBOUND(Grid, 1) TO UBOUND(Grid, 1) - 1
	FOR Col = LBOUND(Grid, 2) TO UBOUND(Grid, 2) - 1
		Check1 = (Grid(Lin, Col) = Grid(Lin, Col + 1))
		Check2 = (Grid(Lin, Col) = Grid(Lin + 1, Col + 1))
		Check3 = (Grid(Lin, Col) = Grid(Lin + 1, Col))
		IF Check1 AND Check2 AND Check3 AND ASC(Grid(Lin, Col)) <> 0 THEN
			Recur = Recur + 1
			CurLin = Lin: CurCol = Col
			DownCol
			CurLin = Lin: CurCol = Col + 1
			DownCol
			CurLin = Lin + 1: CurCol = Col
			DownCol
			CurLin = Lin + 1: CurCol = Col + 1
			DownCol
			Score = Score + 100 * Recur
			Complete = Complete + 1
			'recurse to check again    
			RemoveFour
			Recur = Recur - 1
			IF Score MOD 1000 = 0 THEN
				Level = Level + 1
				PlayField (Level MOD 14 + 1)
			END IF
		END IF
	NEXT Col
NEXT Lin
END SUB

SUB ShareWare
COLOR Red + Bright + Flash
LOCATE 1, 36
PRINT "Notice!";
COLOR White + Bright
LOCATE 3, 1
PRINT "You are encouraged to copy this program and give it to your friends."
LOCATE 5, 1
PRINT "    We, the HappyJohn Software Group, would appreciate a registration fee of $1"
LOCATE 7, 1
PRINT "or more -- whatever you think the program is worth.  The money would be taken"
LOCATE 9, 1
PRINT "as incentive to produce more games.  It would also be a good way to tell how"
LOCATE 11, 1
PRINT "many people really like our programs.  Just give your fee to any Group member."
LOCATE 13, 1
PRINT "    The HappyJohn Software Group is John Flinchbaugh and Shannon Aldinger.  We"
LOCATE 15, 1
PRINT "are working on new games and even some potentially useful programs.  We"
LOCATE 17, 1
PRINT "appreciate the "; CHR$(34); "buzz"; CHR$(34); " about this program!"
COLOR Yellow + Bright
LOCATE 20, 40
PRINT "THANKS ALOT!!!!!!"
COLOR Blue + Bright
LOCATE 25, 35
PRINT "Press any key to continue with the program...";

DO: LOOP WHILE INKEY$ = ""
END SUB

FUNCTION Topped
Check = False
FOR Col = LBOUND(Grid, 2) TO UBOUND(Grid, 2)
	IF Grid(LBOUND(Grid, 1), Col) <> CHR$(0) THEN
		Check = True
		EXIT FOR
	END IF
NEXT Col
Topped = Check
END FUNCTION

FUNCTION Under
Check = (CurLin = UBOUND(Grid, 1))
IF NOT Check THEN
	Check = (ASC(Grid(CurLin + 1, CurCol)) <> 0)
END IF
Under = Check
END FUNCTION

