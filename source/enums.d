enum cellw=16;
enum cellh=16;

enum w=8;
enum h=8;
enum time_=5;
enum time=time_*2;
enum para=5;

enum uiw=24;
enum uih=24;

enum universew=cellw*(w+1);
enum universeh=cellh*(h+1);
enum windowx=universew*time+uiw;
enum windowy=universeh*para+uih;

import raylib;
enum Color black=Color(0,0,0,255);
enum Color white=Color(200,200,200,255);

enum Color backblack=Color(50,30,10,255);
enum Color backwhite=Color(255,215,200,255);

enum Color brown1=Color(193, 154, 107,255);
enum Color brown2=Color(133,94,66,255);



enum universenames=["alpha","beta","gamma","delta","omega"];//espilson seems hard to spell and unnesserily longer
enum piecenames=["white pawn","white castle", "white bishop","white king","white queen","white horsey",
						"black pawn","black castle", "black bishop","black king","black queen","black horsey",];
static bool consideringcursor=false;