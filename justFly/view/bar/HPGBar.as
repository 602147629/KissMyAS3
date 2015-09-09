package justFly.view.bar {
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	
	 [Event(name="resize", type="flash.events.Event")]
	[Event(name = "draw", type = "flash.events.Event")]
	
	public class HPGBar extends GBar {
		
		public function HPGBar(parent:DisplayObjectContainer = null, width:Number = 0, height:Number = 0, label:String = "", xpos:Number = 0, ypos:Number = 0) {
			super(parent, width, height, label, xpos, ypos);
			//decimalColor2hex(16777215);
		}
		
		override public function draw():void {
			var color:uint = undefined;
			
			this._border.graphics.clear();
			this._border.graphics.lineStyle(0, 16777215, 0.5, true);
			this._border.graphics.drawRoundRect(0.5, 0.5, this._width, this._height, 3, 3);
			
			// 血條依比例變顏色
			if (this._percent > 0.5) {
				color = 256 * 256 * Math.floor((1 - this._percent) * 2 * 255) + 256 * 255;
			} else {
				color = 256 * 256 * 255 + 256 * Math.floor(this._percent * 2 * 255);
			}
			
			this._fBar.graphics.clear();
			this._fBar.graphics.lineStyle(0, 0, 0, true);
			this._fBar.graphics.beginFill(color);
			this._fBar.graphics.drawRoundRect(0.5, 0.5, Math.max(1, this._width * this._percent), this._height, 2, 2);
			this._fBar.graphics.endFill();
			
			this.reLabelPostion();
		}
		
	}

}