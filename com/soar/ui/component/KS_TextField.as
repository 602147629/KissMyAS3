package com.soar.ui.component {
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/8/5 下午 02:39
	 * @version	：1.0.12
	 */
	
	public class KS_TextField extends TextField {
		public static const font:String = 'Verdana';
		private var _format:TextFormat;
		private var _filter:GlowFilter;
		
		public function KS_TextField( size:int , color:uint , bold:Boolean ):void {
			super();
			this.selectable = this.mouseEnabled = false;
			this.height = 21;
			this._format = new TextFormat(font, size, color, bold);
		}
		
		/**
		 * 設置對齊
		 */
		public function set align(type:String):void {
			switch (type) {
				case "center": 
					this._format.align = TextFormatAlign.CENTER;
					break;
				case "left": 
					this._format.align = TextFormatAlign.LEFT;
					break;
				case "right": 
					this._format.align = TextFormatAlign.RIGHT;
					break;
			}
			this.flush();
		}
		
		/**
		 * 文字描邊
		 */
		public function set fontBorder(color:uint):void {
			this.filter = new GlowFilter(color, 1, 2, 2, 1000);
			this.filters = new Array(this.filter);
		}
		
		/**
		 * 自動調整寬度和高度
		 */
		public function autoGrow():void {
			this.width = this.textWidth + 6;
			this.height = this.textHeight + 6;
		}
		
		override public function set text(t:String):void {
			super.text = t;
			this.flush();
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	PRIVATE 
		///////////////////////////////////////////////////////////////////////////////
		private function flush():void {
			this.setTextFormat(this._format);
		}
	
	}
}