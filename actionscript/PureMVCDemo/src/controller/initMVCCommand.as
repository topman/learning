package controller 
{
	import flash.display.Sprite;
	import model.TargetProxy;
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
			initProxy(obj);		
			initView(obj);
			initController(obj);
				
		}
		
		private function initProxy(obj : Sprite):void 
		{
			facade.registerProxy(new TargetProxy());
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