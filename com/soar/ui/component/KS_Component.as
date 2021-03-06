package com.soar.ui.component {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */

	public class KS_Component extends Sprite {
		
		public function KS_Component(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0):void {
			super();
			
			this.mouseChildren = this.mouseEnabled = false;
			this.tabEnabled = this.tabChildren = false;
			this.move(xpos, ypos);
			
			if (parent != null) {
				parent.addChild(this);
			}
		}
		
		public function move(xpos:Number, ypos:Number):void {
			this.x = Math.round(xpos);
			this.y = Math.round(ypos);
		}
		
	}
}