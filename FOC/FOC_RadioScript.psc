Scriptname FOC:FOC_RadioScript extends Quest Conditional

; News related


;How many news pieces there are
int property cyclesPlayed Auto conditional

int property lastNewsPlayed01 auto conditional

int property lastNewsPlayed02 auto conditional

;/ - THESE ARE FOR MORE NEWS

int property lastNewsPlayed03 auto conditional

int property lastNewsPlayed04 auto conditional

int property lastNewsPlayed05 auto conditional

int property lastNewsPlayed06 auto conditional

int property lastNewsPlayed07 auto conditional

int property lastNewsPlayed08 auto conditional

int property lastNewsPlayed09 auto conditional
/;


; Defines "CurrentNews" property.
int property currentNews auto conditional


; Song related


; Defines "CurrentSong" property.
Int Property CurrentSong Auto Conditional


; How many songs there are.
Int Property LastSongPlayed01 Auto Conditional

Int Property LastSongPlayed02 Auto Conditional

Int Property LastSongPlayed03 Auto Conditional

Int Property LastSongPlayed04 Auto Conditional

Int Property LastSongPlayed05 Auto Conditional

Int Property LastSongPlayed06 Auto Conditional

Int Property LastSongPlayed07 Auto Conditional

Int Property LastSongPlayed08 Auto Conditional

Int Property LastSongPlayed09 Auto Conditional

;/    THESE ARE FOR MORE SONGS

Int Property LastSongPlayed10 Auto Conditional

Int Property LastSongPlayed11 Auto Conditional

Int Property LastSongPlayed12 Auto Conditional

Int Property LastSongPlayed13 Auto Conditional

Int Property LastSongPlayed14 Auto Conditional

Int Property LastSongPlayed15 Auto Conditional

Int Property LastSongPlayed16 Auto Conditional

Int Property LastSongPlayed17 Auto Conditional

Int Property LastSongPlayed18 Auto Conditional
/;






Function UpdateRadio()
;/ - THESE ARE FOR MORE SONGS
LastSongPlayed18=LastSongPlayed17
LastSongPlayed17=LastSongPlayed16
LastSongPlayed16=LastSongPlayed15
LastSongPlayed15=LastSongPlayed14
LastSongPlayed14=LastSongPlayed13
LastSongPlayed13=LastSongPlayed12
LastSongPlayed12=LastSongPlayed11
LastSongPlayed11=LastSongPlayed10
LastSongPlayed10=LastSongPlayed09
/;
LastSongPlayed09=LastSongPlayed08
LastSongPlayed08=LastSongPlayed07
LastSongPlayed07=LastSongPlayed06
LastSongPlayed06=LastSongPlayed05
LastSongPlayed05=LastSongPlayed04
LastSongPlayed04=LastSongPlayed03
LastSongPlayed03=LastSongPlayed02
LastSongPlayed02=LastSongPlayed01
LastSongPlayed01=CurrentSong

cyclesPlayed+=1


EndFunction

Function updateNews()

;/ - THESE ARE MORE MORE NEWS
	lastNewsPlayed07=06
	lastNewsPlayed06=05
	lastNewsPlayed05=04
	lastNewsPlayed04=03
	lastNewsPlayed03=02
/;
	lastNewsPlayed02=01
	lastNewsPlayed01=currentNews

endfunction


