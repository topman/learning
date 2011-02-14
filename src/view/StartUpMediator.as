package view 
{
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author Tower Joo
	 */
	public class StartUpMediator extends Mediator
	{
		public static const NAME : String = "StartUpMediator";
		
		public function StartUpMediator(obj:Sprite) 
		{
			super(NAME, obj);
			trace("hello");
		}
		
		override public function listNotificationInterests():Array 
		{
			return [AppFacade.START_UP];
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			switch(notification.getName()) {
				case AppFacade.START_UP:
					handle_startup(notification.getBody() as Sprite);
					break;
				default:
					break;
			}
		}
		
		private function handle_startup(viewComponent:Sprite):void 
		{
			trace(viewComponent.x);
			trace("world");
		}
		
		
		
	}

}