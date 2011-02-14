package controller 
{
	import org.puremvc.as3.patterns.command.MacroCommand;
	/**
	 * ...
	 * @author Tower Joo
	 */
	public class StartUpCommand extends MacroCommand
	{
		override protected function addSubCommand(commandClassRef:Class):void 
		{
			super.addSubCommand(initMVCCommand);
		}
		
	}

}