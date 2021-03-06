package com.soar.ui.component {
	import com.soar.ui.component.KS_Component;
	import com.soar.ui.style.Style;
	import flash.display.DisplayObjectContainer;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class KS_InputText extends KS_Component {
		private var _dropShow:DropShadowFilter = new DropShadowFilter(2, 45, Style.DROPSHADOW, 1, 2, 2, 0.3, 1, true);
		private var _tf:TextField;
		
		public function KS_InputText(parent:DisplayObjectContainer = null, width:Number = 0, height:Number = 0, size:int = 0, color:uint = 0, label:String = "", xpos:Number = 0, ypos:Number = 0):void {
			super(parent, xpos, ypos);
			parent.addChild(this);
			
			this.mouseChildren = true;
			
			this.graphics.beginFill(0xfefefe, 1);
			this.graphics.drawRoundRect(0, 0, width, height, 32, 32);
			this.filters = [this._dropShow];
			
			this._tf = new TextField();
			this._tf.type = TextFieldType.INPUT;
			this._tf.defaultTextFormat = new TextFormat("Verdana", size, color);
			this._tf.width = width - 16;
			this._tf.height = height + 4;
			this._tf.x = 8;
			this._tf.y = 4;
			
			if (label != "") {
				this._tf.text = label;
				this._tf.autoSize = TextFormatAlign.LEFT;
			}
			
			this.addChild(this._tf);
		}
		
		public function get text():String {
			return this._tf.text;
		}
	
	}
}