package justFly.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author sam
	 */
	public class MissionEvent extends Event 
	{
		
		public function MissionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}