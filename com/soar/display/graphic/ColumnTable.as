package com.soar.display.graphic {
	
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class ColumnTable extends Sprite {
		private var HSpace:int = 32;
		private var WSpace:int = 60;
		private var _LineWidth:int = 300;
		private var _LineHeight:int = 300;
		
		private var canWidth:int = 1003;
		private var canHeight:int = 140;
		private var squareW:int = 22;
		
		public function ColumnTable():void {
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRect(0, 0, canWidth, canHeight);
			this.graphics.lineStyle(1, 0x000000);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(canWidth, 0);
			this.graphics.moveTo(0, squareW);
			this.graphics.lineTo(canWidth, squareW);
		}
	
	}
}