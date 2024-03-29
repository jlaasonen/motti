10 MAXW%=10:MAXH%=10
20 MARGIN%=16
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
140 DIM TILES%(6)
150 TILES%(1)=1
160 TILES%(2)=12
170 TILES%(3)=4
180 TILES%(4)=5
190 TILES%(5)=6
200 TILES%(6)=8
210 GOSUB 9000
220 P% = 1
230 VP% = 2
240 HOME

300 REM Main menu =====================
310 PRINT:PRINT:PRINT SPC(10) "Motituspeli":PRINT:PRINT
320 FOR M = 1 TO N%
330 PRINT SPC(4) M " - " NAMES$(M) " (" SIZES%(M,1) "x" SIZES%(M,2) ")"
340 NEXT M
350 PRINT SPC(4) "0 - Lopetus"
360 PRINT:PRINT SPC(8) "Valitse kartta";
370 INPUT S%
380 IF S% = 0 THEN HOME:END
390 W% = SIZES%(S%,1):H% = SIZES%(S%,2)
400 FOR ROW = 1 TO W%: FOR COL = 1 TO H%
410 MAP%(COL,ROW) = MD%(S%, COL,ROW)
420 NEXT COL: NEXT ROW


500 REM Main loop =====================
510 GR
520 GOSUB 8000
530 X=1:Y=1:CROSS%=0
540 COLOR=TILES%(2*P%+1),1:RECT (8,8),(247,183)
550 GOSUB 7000
560 GOSUB 800
570 IF CROSS%=0 THEN 550
580 CROSS%=0
590 GOSUB 1000
600 IF OK% = 0 THEN SOUND(100,5,10): GOTO 550
610 MAP%(X,Y) = TAKEN%(P%)
620 GOSUB 8500
630 VP% = P%
640 P% = 2-P%+1
650 FOR Y = 1 TO H%
660 FOR X = 1 TO W%
670 GOSUB 1000
680 IF OK% = 1 THEN 540
690 NEXT X
700 NEXT Y
710 TEXT:HOME
720 PRINT "Pelaaja " VP% " voitti pelin!"
730 GOTO 300

800 REM Read input =====================
810 GET K$
820 IF K$=" " THEN CROSS%=1
830 IF K$="A" THEN X=X-1
840 IF K$="S" THEN Y=Y+1
850 IF K$="D" THEN X=X+1
860 IF K$="W" THEN Y=Y-1
870 IF X < 1 THEN X=1
880 IF X > W% THEN X=W%
890 IF Y < 1 THEN Y=1
900 IF Y > H% THEN Y=H%
910 RETURN

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


6000 REM Calculate tile bounds ======
6010 GOSUB 6100
6020 GOSUB 6200
6030 RETURN

6100 REM Calculate tile X bounds ======
6110 XL% = (X-1)*16+1+MARGIN%
6120 XR% = XL%+14
6130 RETURN

6200 REM Calculate tile Y bounds ======
6210 YT% = (Y-1)*16+1+MARGIN%
6220 YB% = YT%+14
6230 RETURN


7000 REM Plot cursor ==================
7010 IF CX = 0 AND CY = 0 THEN 7060
7020 BX=X:BY=Y
7030 X=CX:Y=CY
7040 COLOR=TILES%(MAP%(CX,CY) + 1), 1
7050 GOSUB 7090
7050 X=BX:Y=BY
7060 CX = X
7070 CY = Y
7080 COLOR=15,1
7090 GOSUB 6000
7100 RECT (XL%,YT%),(XR%,YB%)
7110 RETURN

8000 REM Print map ====================
8010 HOME
8020 COLOR=15,1:RECT (0,0),(255,191)
8030 FOR Y = 1 TO H%
8040 GOSUB 6200
8050 FOR X = 1 TO W%
8060 GOSUB 6100
8070 COLOR=TILES%(MAP%(X,Y) + 1), 1
8080 GOSUB 8520
8090 NEXT X
8100 NEXT Y
8110 RETURN

8500 REM Print tile ===================
8510 GOSUB 6000
8520 REM Print prepared tile ==========
8530 COLOR=TILES%(MAP%(X,Y) + 1), 1
8540 FOR YLINE = YT% TO YB%
8560 PLOT XL%,YLINE TO XR%,YLINE
8570 NEXT YLINE
8580 RETURN


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
10040 DATA 3

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

10400 DATA 7,7,"Burg"
10410 DATA 4,4,1,1,1,1,4
10420 DATA 4,0,0,1,0,0,1
10430 DATA 1,0,2,1,2,0,1
10440 DATA 1,1,1,0,1,1,1
10450 DATA 1,0,2,1,2,0,1
10460 DATA 1,0,0,1,0,0,4
10470 DATA 4,1,1,1,1,4,4
