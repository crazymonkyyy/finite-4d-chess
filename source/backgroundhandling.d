import enums;
import raylib;

static bool rightmostcolor=0;
static int turntimer=2;//2/2==1

//----


void drawuniverselables(){
	static assert(para==5,"this code assumes 5 by 5");
	DrawRectangle(0,0          +uih,uiw,universeh*2,backwhite);
	DrawRectangle(0,universeh*2+uih,uiw,universeh*1,brown1);
	DrawRectangle(0,universeh*3+uih,uiw,universeh*2,backblack);
	import std.string;
	static foreach(i,s;universenames){ {
		static assert(cellh==16,"this code assumes cellh = 16");
		enum top=uih+universeh*i+19;
		static foreach(j,c;s){
			DrawText([c].toStringz,7,top+j*21, 20, i>2?Colors.WHITE:Colors.BLACK);
		}
	}}
}
void drawparalables(){
	bool color=rightmostcolor;
	auto text(){return color?Colors.WHITE:Colors.BLACK;}
	auto lable(){return !color?white:black;}
	auto back(){return !color?backwhite:backblack;}
	void poke(){color=!color;}
	import std.conv; import std.string;
	static foreach(i;0..time){ {
		enum left=uiw+universew*i;
		DrawRectangle(left,0,universew,uih,lable);
		DrawRectangle(left,uih,universew,windowy-uih,back);
		DrawText( 
				((turntimer+i)/2)
					.to!string.toStringz,
				left+(w)/2*cellw+(turntimer>20?-20:0)
				,4,20,text);
		poke;
	} }
}

void drawuilables(){
	drawuniverselables;
	drawparalables;
}
