package com.soar.math {
	import flash.events.Event;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/5/10 下午 01:36
	 * @version	：1.0.12
	 */
	
	public class PhysicalFormula_Example {
		private var g:Number = 0.6;
		private var v:Number = 0.618;
		private var h:Number = 500;
		private var k:Number = 0.6;
		
		public function PhysicalFormula_Example() {
			(stage) ? init() :addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init( e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			spball = new ball();
			addChild(spball);
			spball.x = 400;
			this.addEventListener(Event.ENTER_FRAME, Freefall);
		}
		
		//自由落體公式，g為重力加速度，v為落體速度，h為落體高度，k為損耗係數
		public function Freefall(e:Event):void {
			v += g;
			spball.y += v;
			trace( "spball : " + spball );
			
			if (spball.y > h) {
				spball.y = h;
				v *= -1 * k;
			}
		}
		
	}

}



class ball extends flash.display.Sprite {
	function ball():void {
		this.graphics.beginFill(0x990000, 1);
		this.graphics.drawCircle(0, 0, 50);
	}
}