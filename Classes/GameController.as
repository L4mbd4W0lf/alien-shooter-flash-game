package Classes {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.system.*;
	
	public class GameController extends MovieClip{
		
		private var player:PlayerShip;
		private var playerScore:Number;
		
		private var enemies:Array;
		private var bullets:Array;
		
		private var movePlayerX:Number;
		private var lastBulletTime:Number;
		private var fireBullet:Boolean;
		
		private var mainMenu:MenuScreen;
		private var game:GameScreen;
		private var gameover:GameOverScreen;
		
		public function GameController(){
			// constructor code
			mainMenu = new MenuScreen(this);
			stage.addChild(mainMenu);
			gameover = new GameOverScreen(this);
		}
		
		public function StartGame(){
			trace("Game Started");
			game = new GameScreen();
			stage.addChild(game);
			player = new PlayerShip(400, 500);
			stage.addChild(player);
			
			playerScore = 0;
			movePlayerX = 0;
			fireBullet = false;
			lastBulletTime = getTimer();
			
			enemies = new Array();
			bullets = new Array();
			playerScore = 0;
			game.UpdateScore(playerScore);
			
			if (stage != null){
				stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
				stage.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
				stage.addEventListener(Event.ENTER_FRAME,update);
			}
		}
		
		public function StopGame(){
			stage.removeEventListener(Event.ENTER_FRAME,update);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			stage.removeEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
			for (var a=enemies.length - 1; a >= 0; a--)
			{
				stage.removeChild(enemies[a]);
				enemies.splice(a,1);
			}
			for (var b=bullets.length - 1; b >= 0; b--){
				stage.removeChild(bullets[b]);
				bullets.splice(b,1);
			}
			stage.removeChild(player);
			player = null;
			stage.removeChild(game);
			game = null;
		}
		
		private function keyDownHandler(evt:KeyboardEvent):void{
			if (evt.keyCode == 32){
				//Fire bullet
				fireBullet = true;
				trace("Bullet away!");
			}
			else if (evt.keyCode == 37){
				//Move player left
				player.Move();
				movePlayerX = -1;
				trace("Moving Left!");
			}
			else if (evt.keyCode == 39){
				//Move player right
				player.Move();
				movePlayerX = 1;
				trace("Moving Right!");
			}
			else if (evt.keyCode == 27){
				StopGame();
				GotoMainMenu();
			}
		}
	
		private function keyUpHandler(evt:KeyboardEvent):void{
			if (evt.keyCode == 37){
				movePlayerX = 0;
				player.StopMove();
			}
			else if (evt.keyCode == 39){
				movePlayerX = 0;
				player.StopMove();
			}
		}
		
		private function update(evt:Event){
			
			if (movePlayerX > 0){
				if (player.x <= 750){
					player.x += 10;
				}
			}
			else if (movePlayerX < 0){
				if (player.x > 50){
					player.x -= 10;
				}
			}
			
			if (fireBullet){
				var currTime = getTimer();
				if (currTime - lastBulletTime > 250){
					lastBulletTime = currTime;
					var newBullet = new Bullet(player.x, player.y);
					bullets.push(newBullet);
					stage.addChild(newBullet);
				}
				fireBullet = false;
			}
			
			if (Math.random() < 0.03)
			{
				//Create a new enemy
				var newEnemy = new Aliens();
				enemies.push(newEnemy);
				stage.addChild(newEnemy);
			}
			
			for (var a=enemies.length - 1; a >= 0; a--)
			{
				enemies[a].update();
				if (enemies[a].y > 650){
					stage.removeChild(enemies[a]);
					enemies.splice(a,1);
					playerScore -= 10;
				}
			}
			
			for (var b=bullets.length - 1; b >= 0; b--){
				bullets[b].update();
				if (bullets[b].notInScreen()){
					stage.removeChild(bullets[b]);
					bullets.splice(b,1);
				}
			}
			
			for (var c=bullets.length - 1; c >= 0; c--)
			{
				for (var d=enemies.length - 1; d >= 0; d--)
				{
					if (bullets[c].hitTestObject(enemies[d]))
					{
						//Increase player score
						playerScore += enemies[d].getPointsWorth();
						
						//Remove bullet and enemy
						stage.removeChild(bullets[c]);
						stage.removeChild(enemies[d]);
						bullets.splice(c,1);
						enemies.splice(d,1);
						
						break;
					}
				}
			}
			
			for (var e=enemies.length - 1; e >= 0; e--)
			{
				if (player.hitTestObject(enemies[e]))
				{
					gameOver();
					break;
				}
			}
			if (playerScore >= 0){
				game.UpdateScore(playerScore);
			}
			else{
				gameOver();
			}
		}
		
		public function GotoMainMenu(){
			stage.removeChild(gameover);
			mainMenu.visible = true;
		}
		
		private function gameOver()
		{
			StopGame();
			stage.addChild(gameover);
		}
	}
}
