  rem Generated 29/12/2017 17:06:51 by Visual bB Version 1.0.0.554
 rem **********************************
 rem *<Asteroid Dodger >                      *
 rem *<Destroy the asteroids >                   *
 rem *<Giacomo Castellana >                        *
 rem *<giacomo.castellana01@gmail.com >                  *
 rem *<CC0>                       *
 rem **********************************

 set smartbranching on 

 set romsize 4k
 set kernel_option no_blank_lines
 score=0
 scorecolor=$0E
 a=30 : b=70

 rem * Music variables 
 dim sounda = f
 dim soundb = g


opening
 playfield:
 ..XXX.XXX.XXX.XXX.XXX.XXX.X.XX..
 ..X.X.X....X..X...X.X.X.X.X.X.X.
 ..XXX.XXX..X..XX..XX..X.X.X.X.X.
 ..X.X...X..X..X...X.X.X.X.X.X.X.
 ..X.X.XXX..X..XXX.X.X.XXX.X.XX..
 ................................
 ..XX..XXX.XX..XXX.XXX...........
 ..X.X.X.X.X.X.X...X.............
 ..X.X.X.X.X.X.X...XX............
 ..X.X.X.X.X.X.X.X.X.............
 ..XX..XXX.XX..XXX.XXX...........
end

title
 COLUBK = $00
 COLUPF = $0E
 c=(rand/2)+1 : d=(rand/2)+1
 e=(rand/4)+1
 drawscreen
 if joy0fire || joy1fire then score = 3 : goto skiptitle
 goto title
 
skiptitle
 goto main

lose
 playfield:
 ..X.X.XXX.X.X....XX..X.XXX.XX...
 ..X.X.X.X.X.X....X.X.X.X...X.X..
 ...X..X.X.X.X....X.X.X.XX..X.X..
 ...X..X.X.X.X....X.X.X.X...X.X..
 ...X..XXX.XXX....XX..X.XXX.XX...
 ................................
 ....X....XXXX.XXXX.XXXX.XXXX....
 ....X....X..X.X....X....X..X....
 ....X....X..X.XXXX.XX...XXX.....
 ....X....X..X....X.X....X.X.....
 ....XXXX.XXXX.XXXX.XXXX.X..X....
end
loser
 COLUBK = $00
 COLUPF = $0E
 drawscreen
 
 if joy0fire || joy1fire then goto restart 
 goto loser

restart
 goto opening


main
 
 rem * The background will be white 
 COLUBK=$00

 
 COLUP0=$0E
 COLUP1=$0E

 rem * Clear playfield 
 playfield:
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
end
 
 rem * Player sprite 
 player0:
 %00000000
 %00000000
 %00111100
 %11111111
 %11111111
 %00110100
 %00011000
 %00000000
end

 rem * Asteroid 1 sprite 
 player1:
 %00001000
 %01111100
 %00111110
 %01111111
 %00111110
 %00011111
 %00111010
 %00010000
end

 
 drawscreen
 
 if sounda > 0 then sounda = sounda - 1 : AUDC0 = 8 : AUDV0 = 4 : AUDF0 = sounda else AUDV0 = 0
 if soundb > 0 then soundb = soundb - 1 : AUDC1 = 2 : AUDV1 = 4 : AUDF1 = soundb else AUDV1 = 0


 score=score+1 

 rem * Fix player position 
 player0x=a : player0y=b
 rem * Controls for player 
 if joy0up then b=b-1
 if joy0down then b=b+1
 if joy0right then a=a+1
 if joy0left then a=a-1

 if joy0fire then c=(rand/2)+1 : d=(rand/2)+1

 rem * Move the asteroid 1 randomly 
 if player1x<player1y || e>32 then c=c+1 : sounda=44: soundb=22
 if player1x<player1y || e<32 then c=c-1 : sounda=33: soundb=33
 if player1x<player1y || e=32 then c=c-1 : d=d+1 : sounda=22: soundb=44
 if player1y<player1x || e>32 then d=d+1: soundb=55: soundb=66
 if player1y<player1x || e<32 then d=d-1 : sounda=66: soundb=77
 if player1y<player1x || e=32 then c=c+1 : d=d-1 : sounda=77: soundb=55
 

 rem  if player1x=player1y || e<32 then c=c-1 : d=d+1 : sounda=32: soundb=55
 rem   if player1x=player1y || e>=32 then c=c-1 : d=d+1 : sounda=32: soundb=55


 if player1y<8 then d=(rand/2) : e=(rand/4)+1
 if player1y>84 then d=(rand/2) : e=(rand/4)+1
 if player1x<8 then c=(rand/2) : e=(rand/4)+1
 if player1x>150 then c=(rand/2) : e=(rand/4)+1
 player1x = c : player1y = d

 if collision(player0,player1) then c=(rand/2)+1 : d=(rand/2)+1 : a=30 : b=70 : goto lose
 goto main
