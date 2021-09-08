10 MAXW%=10:MAXH%=10
30 DIM MAP%(MAXW%,MAXH%)
40 DIM CLAIMED%(2):DIM TAKEN%(2)
50 CLAIMED%(1) = 2
60 TAKEN%(1) = 3
70 CLAIMED%(2) = 4
80 TAKEN%(2) = 5
90 DIM SEARCH%(4,2)
100 SEARCH%(1,1)=1:SEARCH%(1,2)=0
110 SEARCH%(2,1)=0:SEARCH%(2,2)=1
120 SEARCH%(3,1)=-1:SEARCH%(3,2)=0
130 SEARCH%(4,1)=0:SEARCH%(4,2)=-1
140 DIM TILES$(6)
150 TILES$(1)=CHR$(127)
160 TILES$(2)=" "
170 TILES$(3)="x"
180 TILES$(4)="X"
190 TILES$(5)="o"
200 TILES$(6)="O"
210 GOSUB 9000
220 P% = 1
230 VP% = 2

300 REM Main menu =====================
310 PRINT
320 FOR M = 1 TO N%
330 PRINT SPC(4) M " - " NAMES$(M) " (" SIZES%(M,1) "x" SIZES%(M,2) ")"
340 NEXT M
350 PRINT SPC(4) "0 - Lopetus"
360 PRINT:PRINT "Valitse kartta";
370 INPUT S%
380 IF S% = 0 THEN END
390 W% = SIZES%(S%,1):H% = SIZES%(S%,2)
400 FOR ROW = 1 TO W%: FOR COL = 1 TO H%
410 MAP%(COL,ROW) = MD%(S%, COL,ROW)
420 NEXT COL: NEXT ROW

500 REM Main loop =====================
510 GOSUB 8000
520 PRINT "Pelaaja " P% ", anna koordinaatit";
530 INPUT X,Y
540 IF X<1 OR X>W% OR Y<1 OR Y>H% THEN 520
560 GOSUB 1000
570 IF OK% = 0 THEN 520
580 MAP%(X,Y) = TAKEN%(P%)
590 VP% = P%
600 P% = 2-P%+1
610 FOR Y = 1 TO H%
620 FOR X = 1 TO W%
630 GOSUB 1000
640 IF OK% = 1 THEN 510
650 NEXT X
660 NEXT Y
670 GOSUB 8000
680 PRINT "Pelaaja " VP% " voitti pelin!"
690 GOTO 300


1000 REM Check coordinates ============
1010 OK% = 0:M%=MAP%(X,Y)
1020 IF M% = CLAIMED%(P%) THEN 1120
1030 IF M% = 0 OR M% = TAKEN%(P%) OR M% = TAKEN%(VP%) THEN RETURN
1060 FOR S=1 TO 4
1070 XX%=X+SEARCH%(S,1):YY%=Y+SEARCH%(S,2)
1080 IF XX%<1 OR XX%>W% OR YY%<1 OR YY%>H% THEN 1100
1090 IF MAP%(XX%,YY%) = TAKEN%(P%) THEN 1120
1100 NEXT S
1110 RETURN
1120 OK%=1
1130 RETURN


8000 REM Print map ====================
8010 PRINT
8020 FOR ROW = 1 TO H%
8030 FOR COL = 1 TO W%
8040 PRINT TILES$(MAP%(COL,ROW) + 1);
8050 NEXT COL
8060 PRINT 
8070 NEXT ROW
8080 RETURN


9000 REM Load maps =====================
9010 READ N%
9020 DIM NAMES$(N%)
9030 DIM SIZES%(N%,2)
9040 DIM MD%(N%,MAXW%,MAXH%)
9050 FOR M = 1 TO N%
9060 READ SIZES%(M,1), SIZES%(M, 2)
9070 READ NAMES$(M)
9080 FOR ROW = 1 TO SIZES%(M,2): FOR COL = 1 TO SIZES%(M,1)
9090 READ MD%(M,COL,ROW)
9100 NEXT COL: NEXT ROW
9110 NEXT M
9210 RETURN

10000 REM Map data ====================
10010 REM First data is the number of maps.
10020 REM First data for map are
10030 REM width, height and name.
10040 DATA 2

10100 DATA 5,5,"Small World"
10110 DATA 0,0,2,0,1
10120 DATA 0,1,2,1,0
10130 DATA 0,1,0,1,0
10140 DATA 1,1,1,0,1
10150 DATA 0,0,1,4,4

10200 DATA 10,10,"Saimaa"
10210 DATA 4,4,4,1,1,1,0,0,2,2
10220 DATA 4,4,4,1,1,1,0,0,2,2
10230 DATA 4,1,0,0,1,1,1,0,1,2
10240 DATA 4,1,0,0,0,1,1,1,1,2
10250 DATA 4,1,1,1,0,0,1,0,0,2
10260 DATA 4,1,0,1,0,0,1,0,1,2
10270 DATA 4,0,0,0,0,1,1,1,1,2
10280 DATA 4,1,0,0,0,0,1,1,1,2
10290 DATA 4,4,1,0,0,1,1,2,2,2
10300 DATA 4,4,1,1,1,1,1,2,2,2
