package Classes {
	
	import flash.display.MovieClip;
	
	
	public class PlayerShip extends MovieClip {
		
		
		public function PlayerShip(xPos:Number, yPos:Number) {
			// constructor code
			this.height = 75;
			this.width = 55;
			this.x = xPos;
			this.y = yPos;
		}
		
		public function Move(){
			gotoAndStop(2);
		}
		
		public function StopMove(){
			gotoAndStop(1);
		}
	}
	
}
