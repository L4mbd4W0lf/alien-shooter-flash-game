package Classes {
	
	import flash.display.MovieClip;
	
	
	public class Bullet extends MovieClip {
		
		
		public function Bullet(xPos:Number, yPos:Number)
		{
			this.x = xPos;
			this.y = yPos;
		}
		
		public function update()
		{
			this.y -= 20;
		}
		
		public function notInScreen():Boolean
		{
			return (this.y <= 0);
		}
	}
	
}
