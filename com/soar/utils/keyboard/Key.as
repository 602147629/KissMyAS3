package com.soar.utils.keyboard{
        import flash.display.Stage;
        import flash.events.Event;
        import flash.events.KeyboardEvent;

	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
		
        /*
        * Usage:
        * Key.initialize(stage);
        * if (Key.isDown(Keyboard.LEFT)) {
        * // Left key is being pressed
        * }
        */         
        public class Key { //工具類
                private static var initialized:Boolean = false; 
                private static var keysDown:Object = new Object(); //可用數組,也可用對像

                public static function initialize(stage:Stage) { //靜態初始化方法
                        if (!initialized) { //單例
                                stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
                                stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
                                stage.addEventListener(Event.DEACTIVATE, clearKeys);
                                initialized = true;
                        }
                }

                public static function isDown(keyCode:uint):Boolean { //主方法
                        if (!initialized) {
                                throw new Error("Key class has yet been initialized.");
                        }
                        return Boolean(keyCode in keysDown);
                }

                private static function keyPressed(event:KeyboardEvent):void {
                        keysDown[event.keyCode] = true;
                }

                private static function keyReleased(event:KeyboardEvent):void {
                        if (event.keyCode in keysDown) {
                                delete keysDown[event.keyCode];
                        }
                }

                private static function clearKeys(event:Event):void {
                        keysDown = new Object();
                }
        }
}