package Classes {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.system.*;
	
	public class MenuScreen extends MovieClip {
		
		var GC:GameController;
		var tmpPlayer:PlayerShip;
		var b:Boolean = false;
		var direct:Number = 0;
		
		public function MenuScreen(gc:GameController) {
			// constructor code
			GC = gc;
			tmpPlayer = new PlayerShip(115, 500);
			btnPlay.addEventListener(MouseEvent.CLICK, btnPlay_Click);
			btnExit.addEventListener(MouseEvent.CLICK, btnExit_Click);
			tmpPlayer.addEventListener(Event.ENTER_FRAME, fl_RotateContinuously);
			tmpPlayer.Move();
			this.addChild(tmpPlayer);
		}
		function fl_RotateContinuously(event:Event)
		{
			if (tmpPlayer.y > 20 && !b){
				tmpPlayer.rotation = 45;
				tmpPlayer.x += 5;
				tmpPlayer.y -= 5;
			}
			else{
				b = true;
			}
			if (tmpPlayer.y < 500 && b){
				tmpPlayer.rotation = 225;
				tmpPlayer.x -= 5;
				tmpPlayer.y += 5;
			}
			else{
				b = false;
			}
		}

		private function btnExit_Click(event:MouseEvent):void{
			trace("Exiting");
			fscommand("quit");
		}
		
		private function btnPlay_Click(event:MouseEvent):void{
			trace("Playing");
			GC.StartGame();
			this.visible = false;
		}
	}
	
}
