package model 
{
	import org.puremvc.as3.patterns.proxy.Proxy;
	/**
	 * ...
	 * @author Tower Joo
	 */
	public class TargetProxy extends Proxy
	{
		public static const NAME : String = "TargetProxy";
		public function TargetProxy() 
		{
			super(NAME);			
		}
		
		
		public function get Size() : int {
			var _data : int = int(6 * Math.random()) + 3;
			return _data as int;
		}
		
	}

}