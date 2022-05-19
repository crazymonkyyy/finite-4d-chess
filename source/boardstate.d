import enums;
struct nullable(T){
	T me; alias me this;
	bool isnull=true;
}
struct array2d(T,int x,int y){
	T[y][x] me; alias me this;
	ref T opIndex(int x,int y){
		return me[x][y];
	}
}
unittest{
	array2d!(int,3,5) foo;
	foo[2,4]=1;
	assert(foo[2,4]==1);
}
alias piece=nullable!int;
alias board= nullable!(array2d!(piece,w,h));
alias metaboard_=array2d!(board,time,para);
static array2d!(array2d!(bool,w,h),time,para) highlight;

static metaboard_ metaboard;

static nullable!int mousetime;
static int mousede;
static int mousex;
static int mousey;

ref mousepiece(){
	return metaboard[mousetime,mousede][mousex,mousey];}
ref mouseboard(){
	return metaboard[mousetime,mousede];}
ref mouselight(){
	return highlight[mousetime,mousede][mousex,mousey];}
static board clipboard; //:3
static piece clippiece;

void copypiece(){
	clippiece=mousepiece;
}
string exe(string input){
	import std.process;
	auto config=Config.stderrPassThrough;
	return input.executeShell(null,config).output[0..$-1];
}
void selectpiece(){
	import std.process;import std.conv;
	try{clippiece="./chessselector".exe.to!int;}
	catch(Throwable){}
	clippiece.isnull=false;
}
void placepiece(){
	mousepiece=clippiece;
	mousepiece.isnull=false;
}
void deletepiece(){
	mousepiece.isnull=true;}

//---
import raylib;
void drawonmouse(string s){
	HideCursor; consideringcursor=false;
	enum f=24;
	import std.string;
	auto s_=s.toStringz;
	auto w=MeasureText(s_,24);
	auto x=GetMouseX;
   auto y=GetMouseY;
	if(x+w>windowx ||y+f>windowy){
		x-=w;
		y-=f;
	}
	DrawRectangle(x,y,w,f,Colors.WHITE);
	DrawText(s_,x,y,f,Colors.BLACK);
}
void drawtest(){
	drawonmouse("test");
}
void drawpostionlazy(){
	import std.conv;
	drawonmouse(
		mousetime.me.to!string~
		mousede.to!string~
		mousex.to!string~
		mousey.to!string);
}
char abc(int i){
	return cast(char)(int('a')+i);}
unittest{
	assert(abc(0)=='a');
	assert(abc(1)=='b');
}
void drawpostionshort(){
	import std.conv;
	import backgroundhandling;
	drawonmouse(
		((mousetime.me+turntimer)/2).to!string~
		(((mousetime.me+turntimer)%2)?"½":"")~
		universenames[mousede][0]~
		","~
		abc(mousex)~
		(mousey+1).to!string);
}
void drawpostionlong(){
	import std.conv;
	import backgroundhandling;
	drawonmouse(
		"time: "~
			((mousetime.me+turntimer)/2).to!string~
			(((mousetime.me+turntimer)%2)?"½":"")~
		" universe "~
			universenames[mousede]~
		", 2d:"~
		abc(mousex)~
		(mousey+1).to!string);
}

void drawpiecename(){
	if(mousepiece.isnull){return;}
	drawonmouse(piecenames[mousepiece]);
}
void movespacetime(){
	foreach(x;0..(time-1)){
	foreach(y;0..para){
		metaboard[x,y]=metaboard[x+1,y];
	}}
	foreach(y;0..para){
		metaboard[time-1,y].isnull=true;
	}
	import backgroundhandling;
	rightmostcolor= !rightmostcolor;
	turntimer++;
}
board initboard(int[8] i){
	board o; o.isnull=false;
	if(i[0]==-1){return o;}
	foreach(k,j;i){
		o[cast(int)k,7]=j;
		o[cast(int)k,7].isnull=false;
	}
	foreach(k,j;i){
		o[cast(int)k,0]=j+6;
		o[cast(int)k,0].isnull=false;
	}
	foreach(j;0..8){
		o[j,1]=6;
		o[j,1].isnull=false;
		o[j,6]=0;
		o[j,6].isnull=false;
	}
	return o;
}
auto standardboard(){
	return initboard([1,5,2,3,4,2,5,1]);}
auto emptyboard(){
	return initboard([-1,0,0,0,0,0,0,0]);}
	
void copyboard(){
	clipboard=mouseboard;}
void pasteboard(){
	mouseboard=clipboard;}
void defualtclipboard(){
	clipboard=standardboard;}
void emptymouse(){
	mouseboard=emptyboard;}
void clearhighlights(){
	foreach(ref a;highlight){
	foreach(ref b;a){
	foreach(ref c;b){
	foreach(ref d;c){
		d=false;
	}}}}
}
