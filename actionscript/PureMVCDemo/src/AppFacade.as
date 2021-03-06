package  
{
	import controller.StartUpCommand;
	import org.puremvc.as3.patterns.facade.Facade;
	/**
	 * ...
	 * @author Tower Joo
	 */
	public class AppFacade extends Facade
	{
		
		public static const START_UP : String = "Start Up";
		
		public static function getInstance() : AppFacade {
			if (instance == null) {
				instance = new AppFacade();
			}
			return instance as AppFacade;
		}
		
		override protected function initializeController():void 
		{
			super.initializeController();
			registerCommand(START_UP, StartUpCommand);
		}
		
		public function startup(app : Object) : void {
			sendNotification(START_UP, app);
		}
		
	}

}