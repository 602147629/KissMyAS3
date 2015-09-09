package com.soar.filter {
	
	import com.soar.ui.component.PushButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class GradientCSS extends Sprite {
		private var _pickColor:uint;
		private var _text:TextField;
		
		private var _btn:PushButton;
		private var clickHadker:Function;
		
		public function GradientCSS():void {
			this._btn = new PushButton(this, 96, 32, "PickView", 100, 100, clickHadker);
		}
		
		public function clickHadker(e:Event):void {
		
		}
	}
}