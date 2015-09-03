package com.soar.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class GeneralEvent extends Event {
		public var evtData:Array;
		
		public function GeneralEvent(type:String, evtData:Array = null, bubbles:Boolean = false, cancelable:Boolean = false):void {
			super(type, bubbles);
			this.evtData = evtData;
		}
		
		public override function clone():Event {
			return new GeneralEvent(type, evtData, bubbles, cancelable);
		}
		
		public override function toString():String {
			return formatToString("GeneralEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		public function get eventInfo():Array {
			return this.eventData;
		}
	
	}
}