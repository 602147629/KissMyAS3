﻿package com.soar.events{
	import flash.events.Event;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
		
	public class GeneralEvent extends Event{
		public static const BTN_DOWN:String = "btnDown";
		public static const BTN_OVER:String = "btnOver";
		public static const BTN_OUT:String = "btnOut";
		
		public var eventName:String;
		public var eventData:Object;

		public function GeneralEvent( type:String, eventName:String = null, eventData:Object = null ):void{
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