package Classes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class GameOverScreen extends MovieClip {
		
		var GC:GameController;
		
		public function GameOverScreen(gc:GameController) {
			// constructor code
			GC = gc;
			btnMainMenu.addEventListener(MouseEvent.CLICK, btnMainMenu_Click);
		}
		
		function btnMainMenu_Click(evt:MouseEvent):void{
			trace("going");
			GC.GotoMainMenu();
		}
		
		public function GotoMainMenufl(){
			GC.GotoMainMenu();
		}
	}
	
}
