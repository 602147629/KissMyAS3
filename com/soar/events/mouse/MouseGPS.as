package com.soar.events.mouse {
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class MouseGPS {
		private var _coordinate:Point;
		private var _display:Object;
		
		private static var instance:MouseGPS;
		
		public static function getInstance():MouseGPS {
			return (instance ||= new MouseGPS);
		}
		
		public function MouseGPS() {
		}
		
		public function getGps(display:DisplayObject):void {
			this._display = display;
			this._display.stage.addEventListener(MouseEvent.MOUSE_MOVE, downHandler);
		}
		
		public function downHandler(e:MouseEvent):void {
			this._coordinate = new Point(this._display.stage.mouseX, this._display.stage.mouseY);
		}
	
	}

}