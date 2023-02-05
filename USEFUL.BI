'**********************************qb.lib***********************************
' QB.BI - Assembly Support Include File
'       Copyright <C> 1987 Microsoft Corporation
' Purpose:
'      This include file defines the types and gives the DECLARE
'       statements for the assembly language routines ABSOLUTE,
'       INTERRUPT, INTERRUPTX, INT86OLD, and INT86XOLD.
'***************************************************************************
' Define the type needed for INTERRUPT
TYPE RegType
     ax    AS INTEGER
     bx    AS INTEGER
     cx    AS INTEGER
     dx    AS INTEGER
     bp    AS INTEGER
     si    AS INTEGER
     di    AS INTEGER
     flags AS INTEGER
END TYPE
' Define the type needed for INTERUPTX
TYPE RegTypeX
     ax    AS INTEGER
     bx    AS INTEGER
     cx    AS INTEGER
     dx    AS INTEGER
     bp    AS INTEGER
     si    AS INTEGER
     di    AS INTEGER
     flags AS INTEGER
     ds    AS INTEGER
     es    AS INTEGER
END TYPE
'                 DECLARE statements for the 5 routines
'                 -------------------------------------
' Generate a software interrupt, loading all but the segment registers
DECLARE SUB INTERRUPT (intnum AS INTEGER, inreg AS RegType, outreg AS RegType)
'
' Generate a software interrupt, loading all registers
DECLARE SUB INTERRUPTX (intnum AS INTEGER, inreg AS RegTypeX, outreg AS RegTypeX)
'
' Call a routine at an absolute address.
' NOTE: If the routine called takes parameters, then they will have to
'       be added to this declare statement before the parameter given.
DECLARE SUB ABSOLUTE (Address AS INTEGER)
'
' Generate a software interrupt, loading all but the segment registers
'       (old version)
DECLARE SUB INT86OLD (intnum AS INTEGER, inarray() AS INTEGER, OutArray() AS INTEGER)
'
' Generate a software interrupt, loading all the registers
'       (old version)
DECLARE SUB INT86XOLD (intnum AS INTEGER, inarray() AS INTEGER, OutArray() AS INTEGER)
'---------------------------------BUTTON.BAS-------------------------------
DECLARE SUB Button (r1%, c1%, r2%, c2%, Io%, ForeC%, BackC%)
CONST UnPressed = 0, Pressed = NOT UnPressed
' Subroutine to display unpressed-out or pressed-in buttons
' Parameters:       r1 : Number of starting row of button.
'                   c1 : Number of starting column of button.
'                   r2 : Number of ending row of button.
'                   c2 : Number of ending column of button.
'                   Io : Tells if button is pressed or not.
'                ForeC : Tells what Foreground Color is.
'                BackC : Tells what Background Color is.
'--------------------------------COMLINE.BAS--------------------------------
DECLARE SUB Comline (NumArgs%, Args$())
' Subroutine to get command line and split into arguments.
' Parameters:  NumArgs : Number of command line args found.
'              Args$() : Array in which to return arguments.
'                        Upper and lower bounds do not matter.
'                        Only inputs enough to fill this array.
'--------------------------------DIRLIST.BAS---------------------------------
DECLARE SUB DirList (Entry$(), Path$, TmpFile$)
'Program to get directory list by making a temporary file on the disk.
'Fills Entry$() array with the lines of the DOS directory listing.
'Params:    Entry$() -  Array to hold directory.
'                       Upper and lower bounds can be anything.
'           Path$ -     Path of directory to read.
'           TmpFile$ -  Name of the temporary file.
'                       Created in the Path$, then deleted on return.
'-------------------------------CHKFIL.BAS--------------------------------
DECLARE SUB ChkFil (Fil$, ErrorFlag%)
'Checks if Fil$ exists.  ErrorFlag% returns TRUE if it does not exist.
'-------------------------------TDISK.BAS----------------------------------
DECLARE SUB TDisk (DiskNum%, Status%)
'Checks for a good disk in drive.  Only for physical drives.  80H and 81H are
'hard drives.
'Params:    DiskNum% - 0=A:    1=B:
'           Status% returns TRUE with a good disk in drive.
'--------------------------------FREEBYTE.BAS-------------------------------
DECLARE FUNCTION FreeBytes& (DiskNum%)
'Returns free space on disk specified by DiskNum% (see TDisk above)
'Locks up if there is not a formatted disk in the drive.
'---------------------------------DEFDISK.BAS-------------------------------
DECLARE FUNCTION DefaultDisk% ()
'Returns number of default disk. 0=A:,1=B:,etc
'--------------------------------DIR.BAS-------------------------------------
TYPE DirBuffer
    Attr AS INTEGER
    Tim AS STRING * 8
    Dat AS STRING * 10
    Size AS LONG
    FileName AS STRING * 12
END TYPE
DECLARE SUB Directory (Spec$, Arr() AS DirBuffer)
'Reads Directory of all entries (volume labels, directories, etc) into an
'array.  Locks up if there is no good disk in drive.
'Params:  Spec$ - directory path to search form:  d:\path\filespec.ext
'         Arr() - Array of type DirBuffer holding directory info
'              dim needed:  DIM Arr(x to y) as DirBuffer
'-------------------------------CENTER.BAS---------------------------------
DECLARE FUNCTION Center% (Text$)
'Returns column to place Text$,so it would be centered on 80-character screen
'-------------------------------DELAY.BAS---------------------------------
DECLARE SUB Delay (WaitFor!)
'Suspends execution for specified time in seconds.
'--------------------------------KBDUMP.BAS-------------------------------
DECLARE SUB KBDump ()
'Clears keyboard buffer.
'---------------------------------CALC.BAS----------------------------------
DECLARE SUB Calculator (CRow!, CCol1, Fg!, LN!)
'Pops up a 4-function calculator
'Params:    CRow - UpperLeft Corner for positioning
'           CCol1 - UpperLeft Corner for Positioning
'           FG - Color of Calculator block
'           LN - Color of Calculator buttons
'--------------------------------NULLFILT.BAS---------------------------------
DECLARE FUNCTION NullFilter$ (Instring AS STRING)
'Returns Instring stripped of NULL characters
'--------------------------------INFILT.BAS----------------------------
DECLARE FUNCTION InFilter$ (Txt$, FilterString$)
'Returns Txt$ stripped of any charaters not included in FilterString$
'---------------------------------OUTFILT.BAS---------------------------
DECLARE FUNCTION OutFilter$ (Txt$, FilterString$)
'Returns Txt$ stripped of any characters included in FilterString$
'---------------------------------KEYS.BAS----------------------------------
DECLARE FUNCTION NumLock% ()
DECLARE FUNCTION Scrl% ()
DECLARE FUNCTION RShift% ()
DECLARE FUNCTION LShift% ()
DECLARE FUNCTION Ctrl% ()
DECLARE FUNCTION Alt% ()
DECLARE FUNCTION Caps% ()
DECLARE FUNCTION Insert% ()
'Returns TRUE if the respective key is active.
'----------------------------------POP.BAS-----------------------------------
DECLARE SUB PopUp (Array() AS INTEGER, ForeColor%, BackColor%, Border%)
'Pop up window
DECLARE SUB PopDown (Array() AS INTEGER)
'Restore the background of a popped window

'This program will pop unlimited windows on top of each other.
'The coordinates for the window are set in the DIM statement for the array to
'   hold the screen data. eg.
'   DIM Array(StartLine TO EndLine, StartCol TO EndCol)
'Foreground and BackGround refer to the colors.
'Border is the number of lines in the border - 0,1, or 2.
'---------------------------------DRAWBOX.BAS-----------------
DECLARE SUB DrawBox (StartLin%, StartCol%, EndLin%, EndCol%, Border%)
'Draws a box using the current colors.  (Used by PopUp SUBPROGRAM.)
'    Border% - number of lines for box (0-2)
'---------------------------------DOSVER.BAS---------------------------------
DECLARE FUNCTION DosVer! ()
'Returns the DOS version number.
'----------------------------------GETVID.BAS------------------------
DECLARE FUNCTION GetVid% ()
'Returns video screen mode according to INT 10H.
'---------------------------------DOCOLR.BAS-------------------------------
DECLARE SUB DoColr (Fg%, Bg%)
'Saves the Foreground and Background colors, when a program starts, to be
'restored at the end of a program.
'-------------------SOUND1.BAS,SOUND2.BAS,SOUND3.BAS---------------------------------
DECLARE SUB Sound1 (SoundFreq!, SoundVol%)
DECLARE SUB Sound2 (SoundFreq!, SoundVol%)
DECLARE SUB Sound3 (SoundFreq!, SoundVol%)
'These 3 produce tones in their respective voice channels.
'Params:    SoundFreq$ -    Frequency of tone
'           SoundVol% -     Volume of tone (0-15)
'-----------------------------NOISE.BAS---------------------------------
DECLARE SUB Noise (SoundCode%, SoundVol%)
'Produces periodic or white noise according to SoundCode%
'SoundCode% and SoundVol% follow the specs for GW-BASIC NOISE command.
'       Note: There is no set duration for the tones and noises.
'-------------------------------EDITSTR$.BAS---------------------------------
DECLARE FUNCTION EditString$ (InputInStr$, InputLength%, InputNext%, InputAccept%, InputFore%, InputBack%)
'* EditString$ - Edits a specified string. This function
'* implements a subset of editing functions used in the QuickBASIC
'* environment and in Windows. Common editing keys are recognized,
'* including direction keys, DEL, BKSP, INS (for insert and overwrite
'* modes), ESC, and ENTER. TAB is recognized only if the InputNext
'* flag is set. CTRL-key equivalents are recognized for most keys.
'* A null string can be specified if no initial value is desired.
'* You could modify this function to handle additional QB edit
'* commands, such as CTRL+A (word back) and CTRL+F (word forward).
'* Params: InputInStr$ - The input string (can be null)
'*         InputLength - Maximum length of string (the function beeps and
'*           refuses additional keys if the user tries to enter more)
'*         InputNext - Sets flag to check for TAB or SHIFT-TAB according
'*           to bit:    bit 1 = TAB        bit 2 = SHIFT-TAB
'*           Returns number according to which was pressed on exit.
'                   0 = ENTER, 1 = TAB, 2 = SHIFT-TAB, 3 = ESC
'          InputAccept - Passes Sets of Characters that are valid according to bit:
'                   bit 1 = 0-9
'                   bit 2 = Punctuation
'                   bit 3 = a-z,A-Z
'                   bit 4 = CHR$(128)-CHR$(255)
'          InputFore - InputFore color for field
'          InputBack - Background color for field
'* Input:  Keyboard
'* Ouput:  Screen - Noncontrol keys are echoed.
'*         Speaker - beep if key is invalid or string is too long
'* Return: The edited string
'Constants for InputAccept**
CONST AcceptNum = 1, AcceptPunc = 2
CONST AcceptAlpha = 4, AcceptExt = 8
'------------------------------EDITTEXT.BAS----------------------------------
DECLARE FUNCTION EditText$ (InputInStr$, InputLength%, TermByte$, TermWord$, InputAccept%, InputFore%, InputBack%)
'Same as EDITSTRING but you specify the possible terminating keys.
'TermByte$ - Sequential list of ascii codes for one-byte terminating keys
'TermWord$ -     "        "  "  the 2nd byte in two-byte terminating keys
'            (no 0 codes)
'           ex. - chr$(ShiftTab)+chr$(Down)  for Shift-Tab or Down key
'The key used to terminate is returned in the corresponding variable while
'the other will have a 0 code.  EditText$ returns the edited form of
'InputInStr$ no matter what key terminated.
'-------------------------------TOKEN.BAS---------------------------------
DECLARE FUNCTION StrTok$ (Srce$, Delim$)
'Tokenizes a string and returns the tokens in order each time called.
'   Delim$ =    delimiters that separate tokens
'   Srce$ =     Initial string to be tokenized.
'               Pass "" as Srce$ to get the next token in the initial string.
'-------------------------------PRINT.BAS-----------------------------------
DECLARE SUB Cprint (Text$)
'Automatically centers and prints a line of text on the current line.  The
'screen width is automatically adjusted for 80 or 40 characters.  Current
'line does not advance to the next line.
'   Text$ = String to center and print.
'-------------------------WINDOW.BAS,WINDOW2.BAS----------------------------
DECLARE SUB WindowOff ()
'            Erases window by copying page 1 to 0
DECLARE SUB WindowOn (WinStartRow, WinStartCol, WinEndRow, WinEndCol, WinFore, WinBack, WinBorder, WinTemp)
'       Displays windows in the space and colors specified.
'           Saves old screen (page 0) in page 1.
DECLARE SUB Window2Off ()
'            Erases window by copying page 2 to 0
DECLARE SUB Window2On (WinStartRow, WinStartCol, WinEndRow, WinEndCol, WinFore, WinBack, WinBorder, WinTemp)
'       Displays windows in the space and colors specified.
'           Saves old screen (page 0) in page 2.
'Params:
'           WinStartRow -   Top row of window.
'           WinStartCol -   Left column of window.
'           WinEndRow -     Bottom row of window.
'           WinEndCol -     Right column of window.
'           WinFore -       Foreground color.
'           WinBack -       Background color.
'           WinBorder -     Number of lines in border (1 or 2).
'           WinTemp -       TRUE so it can be popped down.
'                           FALSE so it is permanent.
'-------------------------------ASNDEX.BAS--------------------
DECLARE FUNCTION ASoundex$ (Word$)
'Returns code of 1 letter + 3 numbers based on the sound of the word.  Used
'in comparisons of like sounding words.
'-------------------------------ISNDEX.BAS-------------------------------
DECLARE FUNCTION ISoundex% (Word$)
'Returns integer of 4 digits based on the sound of the word.  Like ASoundex.
'---------------------------------BIN.BAS-----------------------------------
DECLARE FUNCTION Bin% (Bit$)
'Returns integer from binary number in Bit$.
'--------------------------------BSOUND.BAS-----------------------
DECLARE SUB BSound (Frequency%, Duration%)
'Smaller replacement routine for BASIC's SOUND command.  Doesn't need to
'handle floating-point math.
'----------------------------------CEIL.BAS------------------------------
DECLARE FUNCTION Ceil% (Value!)
'Returns next integer if Value! is not already integer.
'Opposite of INT function.
'-------------------------------CHDRIVE.BAS-------------------------------
DECLARE SUB ChDrive (Drive%)
'Changes current drive.  Drive% = number of drive (0=a: ; 1=b:)
'-------------------------------DELSTR.BAS--------------------------------
DECLARE SUB DeleteStr (Work$)
'Deletes Work$ and uses less code each call.
'-------------------------------FILEXIST.BAS------------------------------
DECLARE FUNCTION FileExist% (Spec$)
'Returns TRUE if file specified by Spec$ exists.
'--------------------------------GETCOLOR.BAS------------------------------
DECLARE SUB GetColor (Fore%, Back%)
'Returns current color settings in the parameters passed.
'----------------------------------GETDIR.BAS-----------------------------
DECLARE FUNCTION GetDir$ (Drive%)
'Returns current directory for Drive% (0=a: , 1=b:)
'---------------------------------MONITOR.BAS-----------------------------
DECLARE FUNCTION Monitor% (Segment%)
'Monitor% returns type of monitor
'   1=Monochrome
'   2=Hercules
'   3=CGA
'   4=EGA
'   5=VGA
'   ELSE=UNKNOWN
'Segment% returns segment of display memory.
'---------------------------------MOREFILE.BAS----------------------------
DECLARE SUB MoreFiles (NumFiles)
'Increases number of files possible.  Requires DOS 3.3+.
'------------------------------PEEKLONG.BAS-------------------------------
DECLARE FUNCTION PeekLong& (Segment%, Address%)
'Same as BASIC's PEEK functions, but returns 4 bytes.
'-------------------------------ROUND.BAS----------------------------------
DECLARE FUNCTION Round# (Value#, Digits%)
'Returns Round# with value of Value# rounded to the specified decimal digits.
'-------------------------------STUFFBUF.BAS-------------------------------
DECLARE SUB StuffBuffer (Cmd$)
'Clears the keyboard buffer and puts Cmd$ into the buffer.
'--------------------------------TYPESORT.BAS--------------------------------
DECLARE SUB TypeSort (Segment%, Address%, ElSize%, Offset%, KeySize%, NumEls%)
'Quick Sorts an array of a user-defined type.
'Params:    Segment =   Segment of starting array element
'           Address =   Address of starting array element
'           ElSize  =   Length of an element
'           Offset  =   Start position of key in each element
'           KeySize =   Length of key
'           NumEls  =   Number of elements to sort
'--------------------------------UNSGNINT.BAS------------------------------
DECLARE FUNCTION ToUnSgn% (Work&)
DECLARE FUNCTION FromUnSgn& (Work%)
'Converts between long integers to unsigned integers for use with assembly
'interfaces
'---------------------------------COMPARE.ASM------------------------------
DECLARE FUNCTION CompareAddr% ALIAS "Compare" (BYVAL Seg1%, BYVAL Adr1%, BYVAL Seg2%, BYVAL Adr2%, NumBytes%)
DECLARE FUNCTION CompareType% ALIAS "Compare" (SEG Type1 AS ANY, SEG Type2 AS ANY, NumBytes%)
'Compares two memory locations or type variables.
'Returns TRUE if every byte matched
'---------------------------------COMPARE2.ASM-------------------------------
DECLARE FUNCTION Compare2Addr% ALIAS "Compare2" (BYVAL Seg1%, BYVAL Adr1%, BYVAL Seg2%, BYVAL Adr2%, NumBytes%)
DECLARE FUNCTION Compare2Type% ALIAS "Compare2" (SEG Type1 AS ANY, SEG Type2 AS ANY, NumBytes%)
'Same as COMPARE.ASM, but case-insensitive.
'---------------------------------COMPARE3.ASM------------------------------
DECLARE FUNCTION Compare3Addr% ALIAS "Compare3" (BYVAL Seg1%, BYVAL Adr1%, BYVAL Seg2%, BYVAL Adr2%, NumBytes%)
DECLARE FUNCTION Compare3Type% ALIAS "Compare3" (SEG Type1 AS ANY, SEG Type2 AS ANY, NumBytes%)
'Compares two memory locations of type variables.
'Returns:    0 if equal
'           -1 if 1st<2nd
'            1 if 1st>2nd
'---------------------------------COPYFILE.BAS------------------------------
DECLARE SUB CopyFile (InFile$, OutFile$)
'Copies file from spec in InFile$ to spec in OutFile$.
'Both parameters need full paths and filenames.
'-------------------------------DOSINT.ASM---------------------------------
DECLARE SUB DosInt (Registers AS ANY)
'Calls DOS interrupt using register values in Registers.
'Returns results in Registers.
'Registers should be dimensioned RegType or RegTypeX
'--------------------------------MEMCOPY.ASM---------------------------------
DECLARE SUB MemCopyAddr ALIAS "MemCopy" (BYVAL Seg1%, BYVAL Adr1%, BYVAL Seg2%, BYVAL Adr2%, NumBytes%)
DECLARE SUB MemCopyType ALIAS "MemCopy" (SEG AnyVar1 AS ANY, SEG AnyVar2 AS ANY, NumBytes%)
'Copies a block of memory or variable to another location or variable
'--------------------------------SWAPMEM.ASM---------------------------------
DECLARE SUB SwapMemAddr ALIAS "SwapMem" (BYVAL Seg1%, BYVAL Adr1%, BYVAL Seg2%, BYVAL Adr2%, NumBytes%)
DECLARE SUB SwapMemType ALIAS "SwapMem" (SEG AnyVar1 AS ANY, SEG AnyVar2 AS ANY, NumBytes%)
'Swaps to variables or blocks of memory.
'--------------------------------NOREBOOT.ASM-------------------------------
DECLARE SUB NoReboot (BYVAL InstallFlag%)
'Controls Ctrl-Alt-Del for rebooting.
'InstallFlag%   :   0 = stop inhibition
'                   1 = install inhibition
'-------------------------------PEEKPOKE.ASM-------------------------------
DECLARE FUNCTION PeekWord% (BYVAL Segment%, BYVAL Address%)
DECLARE SUB PokeWord (BYVAL Segment%, BYVAL Address%, BYVAL Value%)
'Same as BASIC's PEEK and POKE, but this one works with 2 bytes at a time.
'----------------------------------SORT.ASM---------------------------------
DECLARE SUB Sort (Array$(), Direction)
'Quick Sorts an array of variable length strings.
'Direction: 0   =   ascending order
'           ELSE=   descending order
'--------------------------------ACTDRIVE.BAS-----------------------------
DECLARE FUNCTION GetActiveDrive% ()
'Returns number of the active drive for a single-floppy system
DECLARE SUB SetActiveDrive (Drive%)
'Set the active drive number to Drive%
'----------------------------------FRE.BAS------------------------------
DECLARE FUNCTION FreStack& ()
DECLARE FUNCTION FreNonString& ()
DECLARE FUNCTION FreString& ()
'Returns free memory for each respective memory area.
'Replaces BASIC's FRE(x) function
'-----------------------------WRAPPER.BAS---------------------------------
DECLARE FUNCTION SCInstr% (Text1$, Text2$)
DECLARE FUNCTION SCPos% ()
DECLARE FUNCTION SCRnd% ()
DECLARE SUB SCClose (FileNumber%)
DECLARE SUB SCColor (Fore%, Back%)
DECLARE SUB SCLocate (Lin%, Col%)
DECLARE SUB SCScreen (Mode%)
DECLARE SUB SCWidth (Wid%)
'Replacements for respective BASIC commands to enable the command to be
'called with less code.
DECLARE SUB CsrOff ()
'Turns Cursor off
DECLARE SUB CsrOn ()
'Turns Cursor on
'------------------------------GETSEG.ASM-----------------------
DECLARE FUNCTION GetSeg% ()
'Returns current segment.
'-------------------------------GETKEY.BAS---------------------------------
DECLARE FUNCTION GetKey$ ()
'Waits for a key to be pressed and returns a 1- or 2- byte code like INKEY$.
'--------------------------------DSKREADY.BAS-------------------------------
DECLARE FUNCTION DiskReady% (Drive%)
'Returns TRUE if the specified drive is ready; FALSE - it's not ready.
'Drive% - 0=A:  1=B:  etc.
'--------------------------------DSKERROR.BAS------------------------------
DECLARE SUB DiskError (Drive%)
'Uses specified drive to initiate any possible errors.
'Drive% - 0=A:  1=B:  etc.
'-----------------------------SCRAMBLE.BAS---------------------------------
DECLARE FUNCTION ScrambleString$ (In$, ScramByte$)
'Returns scrambled In$ by XORing it with the first byte of ScramByte$.
'To Unscramble just scramble the scrambled string.
'---------------------------------FIELD.BAS--------------------------------
DECLARE SUB FieldEdit (InText$, Lin%, Col%, NumLins%, NumCols%, Nxt%)
'Edits a block of text w/ wraparound, insert mode.
'   InText$     = Text to edit w/ CR's to start new line
'   Lin%        = Top line of field
'   Col%        = Left Column of field
'   NumLins%    = Number of lines in the field
'   NumCols%    = Number of columns in field, last column unuseable
'   Nxt% passes acceptable terminating keys and returns terminating key
'       Set: bit 0 - TAB
'            bit 1 - Shift-TAB
'       Return: 0 - Ctrl-ENTER
'               1 - TAB
'               2 - Shift-TAB
'               3 - ESC - InText$ not changed
'-------------------------------WORDWRAP.BAS--------------------------------
DECLARE SUB WordWrap (x$, Wide%, LeftMargin%)
'Prints wrapped text starting at current line.  CR advances line.
'   x$          = input text
'   Wide%       = max width of line
'   LeftMargin% = Column to start printing
'--------------------------------WRAPARR.BAS---------------------------------
DECLARE SUB WrapArray (x$, Wide%, OutArray$())
'Divides a line of text into an array of wrapped lines. CR advances line.
'   x$          = input line of text
'   Wide%       = max line width
'   OutArray$() = output array
'---------------------------------INC_DEC.BAS-------------------------------
DECLARE SUB DEC (x&)
DECLARE SUB INC (x&)
'Routines to INCrement or DECrement the passed variable.
'--------------------------------CLIPFILE.BAS-------------------------------
DECLARE SUB ClipFile (FileSpec$, Length&)
'Opens FileSpec$, reassigns its length to Length& and closes the file again.
'---------------------------------POPMENU.BAS------------------------------
DECLARE FUNCTION PopMenu% (Lin%, Col%, Array$(), Hot$(), TotLins%, ForeC%, BackC%, Leave%)
'Pops up a menu w/ highlight bar and Hotkeys.
'Use PopUp routine to save/replace background.  Automatic width adjustment.
'Returns number of option or 0 for Esc or nothing chosen.
'   Lin%        = Top of menu
'   Col%        = Left of menu
'   Array$()    = String array with menu options
'   Hot$()      = String array with hotkey to highlight in corresponding
'                 Array$().  Set null for no hotkeys.
'   TotLins%    = Total lines for menu w/o borders.
'   ForeC       = Foreground color
'   BackC       = Background color
'   Leave       = Returns method for leaving menu.
'                   -1=Left Arrow
'                    1=Right Arrow
'                    0=Enter or Esc
'-------------------------------ERROR.OBJ-----------------------------------
DECLARE FUNCTION Error$ (Code%)
'Returns the text description of the error represented by Code%

