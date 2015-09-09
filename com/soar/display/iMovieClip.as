package com.soar.display {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	dynamic public class iMovieClip extends MovieClip {
		private var _lis:Array; //定義一數組保存偵聽
		
		public function iMovieClip() {
			this._lis = new Array()
			this.addEventListener(Event.REMOVED, remove) //偵聽刪除事件
		}
		
		//重寫addEventListener,在增加偵聽的時候..把相應的事件保存到數組
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			this._lis.push([type, listener, useCapture])
			super.addEventListener(type, listener, useCapture, priority, useWeakReference)
		}
		
		//"自我毀滅"的方法
		private function remove(e:Event):void {
			if (e.currentTarget != e.target)
				return stop();
			//刪除子對象
			trace("刪除前有子對象", numChildren);
			
			while (numChildren > 0) {
				removeChildAt(0)
			}
			trace("刪除後有子對象", numChildren);
			
			//刪除動態屬性
			for (var k:String in this) {
				trace("刪除屬性", k);
				delete this[k]
			}
			
			//刪除偵聽
			for (var i:uint = 0; i < this._lis.length; i++) {
				trace("刪除Listener", this._lis[i][0]);
				removeEventListener(this._lis[i][0], this._lis[i][1], this._lis[i][2]);
			}
			
			this._lis = null;
		}
	}
}