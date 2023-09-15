package Classes {
	
	import flash.display.MovieClip;
	
	
	public class GameScreen extends MovieClip {
		
		
		public function GameScreen() {
			// constructor code
			
		}
		
		public function UpdateScore(playerScore:Number){
			txtScore.text = String(playerScore);
		}
	}
	
}
