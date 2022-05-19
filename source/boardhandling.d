import raylib;
import enums;
//static bool whichbrown=false;
//void swapbrown(){ whichbrown=!whichbrown;}
//auto brown(){return whichbrown? brown1 : brown2;}
//void drawcell(int x,int y){
//	DrawRectangle(x,y,cellw,cellh,brown);
//	swapbrown;
//}
//void drawpiece(int localx,int localy,int universex, int universey,int realx, int realy){
//	import chess;
//	import boardstate;
//	if(metaboard[universex,universey].isnull){return;}
//	if(metaboard[universex,universey][localx,localy].isnull){return;}
//	draw(metaboard[universex,universey][localx,localy],realx,realy);
//}
//
//void drawbroad(int x,int y){
//	static assert(w==8,"This code assumes an even number of squares");
//	whichbrown=false;
//	auto x_=x;
//	auto y_=y;
//	x*=universew; x+=uiw+cellw/2;
//	y*=universeh; y+=uih+cellh/2;
//	foreach(x1;0..w){
//	foreach(y1;0..h){
//		drawcell(x+x1*cellw,y+y1*cellh);
//		drawpiece(x1,y1,x_,y_,x+x1*cellw,y+y1*cellh);
//	}
//		swapbrown;
//	}
//}