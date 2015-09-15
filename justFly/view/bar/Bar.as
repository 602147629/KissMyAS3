package justFly.view.bar {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	
	public class Bar extends Sprite {
		public var _width:Number = 100;
		public var _height:Number = 20;
		public var _color:uint = 0;
		public var _fBar:Shape;
		public var _border:Shape;
		public var _percent:Number = 1;
		public var _txt:TextField;
		
		public function Bar() {
			super();
			
			this._fBar = new Shape();
			addChild(this._fBar);
			
			this._border = new Shape();
			addChild(this._border);
			
			this._txt = new TextField();
			this._txt.textColor = 0xFFFFFF;
			addChild(this._txt);
			
			this.redraw();
		}
		
		public function redraw(value:Boolean = true):void {
			if (value) {
				this._border.graphics.clear();
				this._border.graphics.lineStyle(0, 0xFFFFFF, 0.5, true);
				this._border.graphics.drawRoundRect(0, 0, this._width, this._height, 3, 3);
			}
			
			this._fBar.graphics.clear();
			this._fBar.graphics.lineStyle(0, 0, 0, true);
			this._fBar.graphics.beginFill(this._color);
			this._fBar.graphics.drawRoundRect(0, 0, Math.max(1, this._width * this._percent), this._height, 2, 2);
			this._fBar.graphics.endFill();
		}
		
		public function setProgress(min:Number, max:Number):void {
			if (!isNaN(min)&& !isNaN(max) && max > 0) {
				this._percent = Math.max(0, Math.min(1, min / max));
				this._txt.text = min + " / " + max;
				this.redraw(false);
			}
		}
		
		public function create(width:Number, height:Number, x:Number, y:Number, color:uint) :void{
			var bar:Bar = new Bar;
			bar.width = width;
			bar.height = height;
			bar.color = color;
			bar.x = x;
			bar.y = y;
			bar.redraw();
		}
		
		public function get color():uint {
			return this._color;
		}
		
		public function set color(value:uint):void {
			this._color = value;
		}
		
		public function get percent():Number {
			return _percent;
		}
		
		public function set percent(value:Number):void {
			if (!isNaN(value)) {
				this._percent = value;
				this._txt.text = "";
				this.redraw(false);
			}
		}
	
	}

}