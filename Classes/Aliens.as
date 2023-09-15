package Classes {
	
	import flash.display.MovieClip;
	
	
	public class Aliens extends MovieClip {
		
		private var score:Number;
		
		public function Aliens() {
			// constructor code
			var slecetedAlien:Number;
			do{
				slecetedAlien = fl_GenerateRandomNumber(3);
			}while(slecetedAlien > 3 && slecetedAlien < 0);
			gotoAndStop(slecetedAlien);
			var xCoord:Number;
			do{
				xCoord = fl_GenerateRandomNumber(750);
			}while(xCoord < 120 && xCoord > 680);
			this.x = xCoord;
			this.height = 50;
			this.width = 50;
			score = 20;
		}

		function fl_GenerateRandomNumber(limit:Number):Number
		{
			var randomNumber:Number = Math.floor(Math.random()*(limit+1));
			return randomNumber;
		}
		
		public function update()
		{	
			this.y += 5;
			//this.score -= 2;
		}
		
		public function getPointsWorth():Number
		{
			return this.score;
		}
	}
	
}
