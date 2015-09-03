package com.soar.events {
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/5/14 下午 02:05
	 * @version	：1.0.12
	 */
	
	public class KissMyEventDispatcher {
		private var events:Array;
		
		public function KissMyEventDispatcher(target:IEventDispatcher = null):void {
			super(target);
			events = [];
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			events.push({type: type, fun: listener});
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		override public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false):void{
			super.removeEventListener(type, listener, useCapture);
			
			for(var i:int=0;i< ;i++){
				if( events[i].type == type && events[i].fun== listenner){
					events.splice(i, 1);
				}
			}
		}
		
		public function dispose():void{
			var ev:Object;
			while(events.length){
				ev=events.pop(); 
				super.removeEventListener(ev.type,ev.fun);
			}
		}
	}
}