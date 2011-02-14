package controller 
{
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import view.StartUpMediator;
	/**
	 * ...
	 * @author Tower Joo
	 */
	public class initMVCCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void 
		{
			var obj : Sprite = notification.getBody() as Sprite;
			initView(obj);
			initController(obj);
			initProxy(obj);
			sendNotification(AppFacade.START_UP, obj);
		}
		
		private function initProxy(obj : Sprite):void 
		{
			
		}
		
		private function initController(obj: Sprite):void 
		{
			
		}
		
		private function initView(obj : Sprite):void 
		{
			facade.registerMediator(new StartUpMediator(obj));
		}
		
	}

}