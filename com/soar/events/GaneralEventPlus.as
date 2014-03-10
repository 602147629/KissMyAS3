package com.soar.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GaneralEventPlus extends Event 
	{
		
		public static const BTN_DOWN:String = "btnDown";
		public static const BTN_OVER:String = "btnOver";
		public static const BTN_OUT:String = "btnOut";
		
		public var eventName:String;
		public var eventData:Object;
		
		public function GaneralEventPlus( type:String, eventName:String = null, eventData:Object = null ):void{
			super(type, true);
			this.eventName = eventName;
			this.eventData = eventData;
		}

		public override function clone():Event{
			return new GeneralEvent( this.type, eventName, eventData );
		}
		
		public function get eventInfo():Object {
			return this.eventData;
		}
		
		public override function toString():String {
			return formatToString( "Event:", "type", "bubbles", "cancelable", "eventInfo" );
		}
		
	}

}