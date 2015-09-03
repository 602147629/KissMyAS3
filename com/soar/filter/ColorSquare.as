package soar.filter {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class ColorSquare extends Sprite {
		private var colorBmp:Bitmap;
		private var colorBmpD:BitmapData;
		private var padding:int = 4;
		private var color:uint = 0x333333;
		private var bmpW:int = 32;
		private var bmpH:int = 20;
		
		public function ColorSquare():void {
			this.graphics.lineStyle(1, 0x999999);
			this.graphics.beginFill(0xFFFFFF, 1);
			this.graphics.drawRect(0, 0, bmpW + padding, bmpH + padding);
			colorBmpD = new BitmapData(bmpW, bmpH, false, color);
			colorBmp = new Bitmap();
			this.addChild(colorBmp);
			
			colorBmp.bitmapData = colorBmpD;
			colorBmp.x = (this.width - colorBmpD.width) * 0.5;
			colorBmp.y = (this.height - colorBmpD.height) * 0.5;
		}
		
		public function setColor(hex:uint):void {
			var rect:Rectangle = new Rectangle(0, 0, bmpW, bmpH);
			colorBmpD.fillRect(rect, hex);
		}
	
	}
}