package com.soar.utils {
	import flash.display.DisplayObject;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class RightClickLock {
		private static var instance:RightClickLock = new RightClickLock();
		
		public static function lock( display:*):void {
			if (!display.hasEventListener(MouseEvent.CONTEXT_MENU)) {
				display.addEventListener(MouseEvent.CONTEXT_MENU, instance.handler_mouseEvent);
			}
		}
		
		private function handler_mouseEvent(e:MouseEvent):void {
			//Main.mainStage.displayState = StageDisplayState.FULL_SCREEN;
			//Main.mainStage.mouseLock = true;
		}
	}
}