package com.traceFight {
	import com.soar.events.GeneralEvent;
	import flash.display.Sprite;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class TimerBar extends Sprite {
		public var AspdTime:Number = 0;
		public var NowArg:Number = 1.0;
		
		public function TimerBar():void {
			this.graphics.beginFill(0x009900, 1);
			this.graphics.lineStyle(1, 0xffffff, 1);
			this.graphics.drawRect(0, 0, 0, 7)
		}
		
		private function draw():void {
			NowArg = AspdTime + arguments[0];
			this.graphics.beginFill(0x009900, 1);
			this.graphics.lineStyle(1, 0xffffff, 1);
			this.graphics.drawRect(0, 0, NowArg + AspdTime, 7);
			
			if (arguments[0] < 100) {
				setTimeout(draw, 100, NowArg + AspdTime);
			} else {
				DrawFinal();
			}
		}
		
		public function set ATime(_val:Number):void {
			AspdTime = _val;
		}
		
		public function DrawStop():void {
			this.graphics.clear();
			this.graphics.beginFill(0x009900, 1);
			this.graphics.lineStyle(1, 0xffffff, 1);
			this.graphics.drawRect(0, 0, NowArg, 7)
		}
		
		public function DrawFinal():void {
			this.graphics.clear();
			this.graphics.beginFill(0x009900, 0);
			this.graphics.lineStyle(1, 0xffffff, 1);
			this.graphics.drawRect(0, 0, NowArg, 7);
			dispatchEvent(new GeneralEvent("TimerUP", [this.name, name]));
		}
		
		public function DrawStart():void {
			setTimeout(draw, 500, NowArg);
		}
	
	}
}