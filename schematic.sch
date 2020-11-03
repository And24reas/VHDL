# File saved with Nlview 7.0.19  2019-03-26 bk=1.5019 VDI=41 GEI=35 GUI=JA:9.0 non-TLS-threadsafe
# 
# non-default properties - (restore without -noprops)
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 12
property maxzoom 5
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #ff6666
property objecthighlight4 #0000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #eb591b
property overlapcolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 8
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 12
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 4
property timelimit 1
#
module new full_adder work:full_adder:NOFILE -nosplit
load symbol IBUF hdi_primitives BUF pin O output pin I input fillcolor 1
load symbol OBUF hdi_primitives BUF pin O output pin I input fillcolor 1
load symbol LUT3 hdi_primitives BOX pin O output.right pin I0 input.left pin I1 input.left pin I2 input.left fillcolor 1
load port A input -pg 1 -lvl 0 -x 0 -y 180
load port B input -pg 1 -lvl 0 -x 0 -y 110
load port CIN input -pg 1 -lvl 0 -x 0 -y 40
load port COUT output -pg 1 -lvl 4 -x 600 -y 60
load port SUM output -pg 1 -lvl 4 -x 600 -y 170
load inst A_IBUF_inst IBUF hdi_primitives -attr @cell(#000000) IBUF -pg 1 -lvl 1 -x 40 -y 180
load inst B_IBUF_inst IBUF hdi_primitives -attr @cell(#000000) IBUF -pg 1 -lvl 1 -x 40 -y 110
load inst CIN_IBUF_inst IBUF hdi_primitives -attr @cell(#000000) IBUF -pg 1 -lvl 1 -x 40 -y 40
load inst COUT_OBUF_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 3 -x 440 -y 60
load inst COUT_OBUF_inst_i_1 LUT3 hdi_primitives -attr @cell(#000000) LUT3 -pg 1 -lvl 2 -x 290 -y 30
load inst SUM_OBUF_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 3 -x 440 -y 170
load inst SUM_OBUF_inst_i_1 LUT3 hdi_primitives -attr @cell(#000000) LUT3 -pg 1 -lvl 2 -x 290 -y 140
load net A -port A -pin A_IBUF_inst I
netloc A 1 0 1 NJ 180
load net A_IBUF -pin A_IBUF_inst O -pin COUT_OBUF_inst_i_1 I2 -pin SUM_OBUF_inst_i_1 I1
netloc A_IBUF 1 1 1 200 80n
load net B -port B -pin B_IBUF_inst I
netloc B 1 0 1 NJ 110
load net B_IBUF -pin B_IBUF_inst O -pin COUT_OBUF_inst_i_1 I1 -pin SUM_OBUF_inst_i_1 I2
netloc B_IBUF 1 1 1 220 60n
load net CIN -port CIN -pin CIN_IBUF_inst I
netloc CIN 1 0 1 NJ 40
load net CIN_IBUF -pin CIN_IBUF_inst O -pin COUT_OBUF_inst_i_1 I0 -pin SUM_OBUF_inst_i_1 I0
netloc CIN_IBUF 1 1 1 180 40n
load net COUT -port COUT -pin COUT_OBUF_inst O
netloc COUT 1 3 1 NJ 60
load net COUT_OBUF -pin COUT_OBUF_inst I -pin COUT_OBUF_inst_i_1 O
netloc COUT_OBUF 1 2 1 NJ 60
load net SUM -port SUM -pin SUM_OBUF_inst O
netloc SUM 1 3 1 NJ 170
load net SUM_OBUF -pin SUM_OBUF_inst I -pin SUM_OBUF_inst_i_1 O
netloc SUM_OBUF 1 2 1 NJ 170
levelinfo -pg 1 0 40 290 440 600
pagesize -pg 1 -db -bbox -sgen -80 0 690 230
show
fullfit
#
# initialize ictrl to current module full_adder work:full_adder:NOFILE
ictrl init topinfo |
