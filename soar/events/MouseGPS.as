package com.soar.events {
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/5/4 上午 10:31
	 * @version	：1.0.12
	 */
	
	public class MouseGPS {
		private static var coordinate:Point;
		private static var obj:Object;
		
		public function MouseGPS() {
		
		}
		
		public static function getGps(stag:Object):void {
			obj = stag;
			obj.addEventListener(MouseEvent.MOUSE_MOVE, downHandler);
		}
		
		public static function downHandler(e:MouseEvent):void {
			coordinate = new Point(obj.mouseX, obj.mouseY);
		}
	
	}

}