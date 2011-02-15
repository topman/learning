package view 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import model.TargetProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author Tower Joo
	 */
	public class StartUpMediator extends Mediator
	{
		public static const NAME : String = "StartUpMediator";
		public static const START_UP : String = NAME + "Start Up";
		
		public static const GAME_START : String = NAME + "START";
		public static const GAME_PAUSE : String = NAME + "PAUSE";
		public static const GAME_RESUME : String = NAME + "RESUME";
		public static const GAME_OVER : String = NAME + "OVER";
		
		private const INIT : int = 0;
		private const RUNNING : int = 1;
		private const PAUSE : int = 2;
		private const STOP : int = 3;
		
		public var start_btn : TextField = new TextField();
		public var game_state : int = INIT;
		
		private var ball_container : Array = new Array();
		private var racket : Sprite = new Sprite();
		
		private var active_ball : Shape;

		private var timer: Timer;
		
		private var _main_scene : Sprite; // cache the main scene
		
		private var ceiling : Shape = new Shape();
		
		private var _sizeProxy : TargetProxy;
		
		private var _ballNum : int = 0;
		
		public function StartUpMediator(obj:Sprite) 
		{
			super(NAME, obj);	
			
			_main_scene = obj;
			
			timer = new Timer(200);
			timer.addEventListener(TimerEvent.TIMER, timerListener);
			
			_sizeProxy = facade.retrieveProxy(TargetProxy.NAME) as TargetProxy;
			
			init_game(obj);
		}
		
		private function init_game(obj:Sprite):void 
		{
			_ballNum = _sizeProxy.Size;	// 从proxy获得,控制目标的大小
			init_board(obj);
			init_racket(obj);
			init_btn(obj);
			init_ceiling(obj);
			
		}
		
		private function reset_game(obj : Sprite):void 
		{
			while (obj.numChildren > 0) {
				obj.removeChildAt(0);
			}
			var i : int;
			while (ball_container.length > 0) {
				ball_container.pop();
			}
			timer.stop();
		}
		
		private function init_ceiling(obj:Sprite):void 
		{
			ceiling.graphics.beginFill(0xFF0000);
			ceiling.graphics.drawRect(0, 0, 300, 5);
			ceiling.graphics.endFill();
			ceiling.x = 50;
			ceiling.y = 50;
			obj.addChild(ceiling);
		}
		
		private function timerListener(e:TimerEvent):void 
		{
			var i : int;
			var is_hit : Boolean = false;
			if (ceiling.hitTestObject(active_ball)) {
				// Game Over
				sendNotification(GAME_OVER);
				return;
			}
			for (i = 0; i < ball_container.length; i++) {
				var ball : Shape = ball_container[i];
				if (ball.hitTestObject(active_ball)) {
					_main_scene.removeChild(ball);
					ball_container.splice(i, 1);
					i = 0; // reiterate the array
				}
			}
			active_ball.y -= 6;
		}
		
		private function init_btn(obj:Sprite):void 
		{
			start_btn.x = 300;
			start_btn.y = 500;
			start_btn.text = "Click to Start";
			start_btn.mouseEnabled = true;
			obj.addChild(start_btn);
			start_btn.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			switch(game_state) {
				case INIT:
					sendNotification(GAME_START);
					break;
				case RUNNING:
					sendNotification(GAME_PAUSE);
					break;
				case PAUSE:
					sendNotification(GAME_RESUME);
					break;
				case STOP:
					break;
			}
		}
		
		private function init_racket(obj : Sprite):void 
		{
			racket.graphics.beginFill(0x000000);
			racket.graphics.drawRect(0, 0, 100, 5);
			racket.graphics.endFill();
			racket.x = 150;
			racket.y = 500;
			obj.addChild(racket);
			active_ball = get_ball(20, 200, 480);
			obj.addChild(active_ball);
			
		}
		
		override public function listNotificationInterests():Array 
		{
			return [START_UP, GAME_START, GAME_RESUME, GAME_PAUSE, GAME_OVER];
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			var obj : Sprite = notification.getBody() as Sprite;
			switch(notification.getName()) {
				case GAME_START:
					start_game();
					break;
				case GAME_PAUSE:
					pause_game();
					break;
				case GAME_RESUME:
					resume_game();
					break;
				case GAME_OVER:
					stop_game();
					break;
				default:
					break;
			}
		}
		
		private function pause_game():void 
		{
			game_state = PAUSE;
			start_btn.text = "Click to Resume";
			// pause the game
			timer.stop();
		}
		
		private function resume_game():void 
		{
			game_state = RUNNING;
			start_btn.text = "Click to Pause";
			timer.start();
		}
		
		private function stop_game():void 
		{
			// show Game Over
			reset_game(_main_scene);
			init_game(_main_scene);
		}
		
			
		private function start_game():void 
		{
			game_state = RUNNING;
			start_btn.text = "Click to Pause";
			// other logic here
			timer.start();
		}
		
		private function get_ball(radius : Number, x : Number, y : Number): Shape {
			var ball : Shape = new Shape();
			ball.graphics.beginFill(int(0xFFFFF * Math.random()));
			ball.graphics.drawCircle(0, 0, radius);
			ball.graphics.endFill();
			ball.x = x;
			ball.y = y;
			return ball;
		}
		
		private function init_board(obj:Sprite):void 
		{
			game_state = INIT;
			var i : int, j : int;
			trace(_ballNum);
			for (i = 1; i < _ballNum; i++) {
				for (j = 0; j < i; j++) {
					var ball : Shape = get_ball(20, 200+j*40-20*(i-1), 100+i*20*1.732);
					ball_container.push(ball);
					obj.addChild(ball);
				}
			}
		}
		
				
	}

}