import raylib;
import enums;
import backgroundhandling;
import boardhandling;

void main(){
	InitWindow(windowx, windowy, "Hello, Raylib-D!");
	SetWindowPosition(2000,0);
	SetTargetFPS(60);
	import chess;
	import boardstate;
	mixin setupdraw!("chess");
	
	static bool whichbrown=false;
	void swapbrown(){ whichbrown=!whichbrown;}
	auto brown(){return whichbrown? brown1 : brown2;}
	void drawcell(int x,int y,bool which){
		DrawRectangle(x,y,cellw,cellh,which?Colors.BLUE:brown);
		swapbrown;
	}
	void testmouse(int localx,int localy,int universex, int universey,int realx, int realy){
		realx-=GetMouseX-cellw;
		realy-=GetMouseY-cellh;
		if(realx>0&&realx<cellw){
		if(realy>0&&realy<cellh){
			mousetime.isnull=false;
			mousetime=universex;
			mousede  =universey;
			mousex   =localx;
			mousey   =localy;
		}}
	}
	void drawpiece(int localx,int localy,int universex, int universey,int realx, int realy){
		if(metaboard[universex,universey].isnull){return;}
		if(metaboard[universex,universey][localx,localy].isnull){return;}
		draw(metaboard[universex,universey][localx,localy],realx,realy);
	}
	
	void drawbroad(int x,int y){
		auto x_=x;
		auto y_=y;
		x*=universew; x+=uiw+cellw/2;
		y*=universeh; y+=uih+cellh/2;
		foreach(x1;0..w){
		foreach(y1;0..h){
			testmouse(x1,y1,x_,y_,x+x1*cellw,y+y1*cellh);
		}}
		if(metaboard[x_,y_].isnull){
			DrawRectangleLinesEx(
				Rectangle(x,y,cellw*w,cellh*h),
				4,brown);
			return;
		}
		static assert(w==8,"This code assumes an even number of squares");
		whichbrown=false;
		
		foreach(x1;0..w){
		foreach(y1;0..h){
			drawcell(x+x1*cellw,y+y1*cellh,highlight[x_,y_][x1,y1]);
			drawpiece(x1,y1,x_,y_,x+x1*cellw,y+y1*cellh);
		}
			swapbrown;
		}
	}
	//BAD: lazy copy and paste to get the sprite drawing in scope, belongs in boardhandling
	//---
	
	metaboard[0,2]=standardboard;
	
	while (!WindowShouldClose()){
		BeginDrawing();
			ClearBackground(Colors.BLACK);
			drawuilables;
			if(consideringcursor){ShowCursor;}
			else{consideringcursor=true;}
			mousetime.isnull=true;
			foreach(i;0..time*para){
				drawbroad(i%time,i/time);
			}
			bool shift(){
				return IsKeyDown(KeyboardKey.KEY_LEFT_SHIFT);}
			bool alt(){
				return IsKeyDown(KeyboardKey.KEY_LEFT_ALT);}
			
			if( !shift && !alt){
				if(IsMouseButtonPressed(3)){selectpiece;}
				if(IsMouseButtonPressed(0)){placepiece;}
				if(IsMouseButtonPressed(1)){deletepiece;}
				if(IsMouseButtonPressed(2)){copypiece;}
			}
			if(shift && !alt){
				if(IsMouseButtonPressed(3)){defualtclipboard;}
				if(IsMouseButtonPressed(0)){pasteboard;}
				if(IsMouseButtonPressed(1)){emptymouse;}
				if(IsMouseButtonPressed(2)){copyboard;}
			}
			if(!shift && alt){
				if(IsMouseButtonDown(3)){drawpostionlong;} else {drawpostionshort;}
				if(IsMouseButtonPressed(0)){mouselight=true;}
				if(IsMouseButtonPressed(1)){mouselight=false;}
				if(IsMouseButtonPressed(2)){clearhighlights;}
			}
			if(alt && IsKeyPressed(KeyboardKey.KEY_TAB)){
				movespacetime;}
			
			//drawpiecename;
			//DrawText("Hello, World!", 10,10, 20, Colors.WHITE);
			//DrawFPS(10,10);
		EndDrawing();
	}
	CloseWindow();
}