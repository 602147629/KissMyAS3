package com.soar.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/5/7 下午 02:02
	 * @version	：1.0.12
	 */
	
	public class GeneralLoadEvent extends Event {
		public var sourceIndex:int;
		public var sourceTotal:int;
		public var sourceName:String;
		public var source:Object;
		
		public function GeneralLoadEvent(type:String, _sourceIndex:int, _sourceTotal:int, _sourceName:String, _source:Object):void {
			super(type);
			sourceIndex = _sourceIndex;
			sourceTotal = _sourceTotal;
			sourceName = _sourceName;
			source = _source;
		}
		
		override public function clone():Event {
			return new MultiLoadEvent(this.type, sourceIndex, sourceTotal, sourceName, source);
		}
	}

}