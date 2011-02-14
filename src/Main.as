package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Tower Joo
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			AppFacade.getInstance().startup(this);
		}
					
	}
	
}