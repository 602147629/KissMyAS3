package com.soar.filter {
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class ChangeColorCode {
		
		public function ChangeColorCode():void {}
		
		/**
		 * HEX 2 RGB
		 * @param	hex : uint
		 * @return
		 */
		public function Hex2Rgb(hex:uint):Array {
			var rgb:Array = new Array();
			rgb[0] = hex >> 16;
			rgb[1] = hex >> 8 & 0xFF;
			rgb[2] = hex & 0xFF;
			trace("RGB :" + ChangeRGB(0xFFFF00));
			return rgb;
		}
		
		public function Hex2Argb(hex:Number) :Object {
			var col:Object = { };
			col.red = (val >> 24) & 0xFF;
			col.green = (val >> 16) & 0xFF;
			col.blue = (val >> 8) & 0xFF;
			col.alpha = val  & 0xFF;
			return col;
		}
		
		public function tra():ColorTransform {
			var argb:Object = HextoARGB(0x9F9176FF);
			var alpha:Number = argb.alpha;
			var red:Number = argb.red;
			var green:Number = argb.green;
			var blue:Number = argb.blue;
			trace("alpha", alpha, "red", red, "green", green, "blue", blue);
			
			var cols:ColorTransform = new ColorTransform(0, 0, 0, 0, red, green, blue, alpha);
			trace(cols);
			return cols;
		}
		
		/**
		 * RGB 2 HEX
		 * @param	rgb : Array
		 * @return uint
		 */
		public function Rgb2Hex(rgb:Array):uint {
			var hex:uint = rgb[0] << 16 ^ rgb[1] << 8 ^ rgb[2];
			trace("HEX :" + hex);
			return hex;
		}
		
		// 10進制 轉 16進制
		public function decimalColor2hex(color:Number):void {
			// input: (Number) decimal color (i.e. 16711680)
			// returns: (String) hex color (i.e. 0xFF0000)
			var colArr:Array = color.toString(16).toUpperCase().split('');
			var numChars:int = colArr.length;
			
			for (var a:int = 0; a < (6 - numChars); a++) {
				colArr.unshift("0");
			}
			
			var c:uint = 0xFFFFFF;
			trace(c); // 16777215
			trace(c.toString(16)); // ffffff
			trace("0x" + c.toString(16).toUpperCase()); // 0xFFFFFF
			trace(uint("0x" + c.toString(16).toUpperCase())); // 16777215
			
			trace("0x" + colArr.join(''));
		}
		
		private function returnRGBFun(theSourceBitmapData:BitmapData, theX:int, theY:int):String {
			var pixelValue:uint = theSourceBitmapData.getPixel32(theX, theY);
			var alphaValue:uint = pixelValue >> 24 & 0xFF;
			var red:uint = pixelValue >> 16 & 0xFF;
			var green:uint = pixelValue >> 8 & 0xFF;
			var blue:uint = pixelValue & 0xFF;
			
			var tempR = red.toString(16).length == 1 ? "0" + red.toString(16) : red.toString(16);
			var tempG = green.toString(16).length == 1 ? "0" + green.toString(16) : green.toString(16);
			var tempB = blue.toString(16).length == 1 ? "0" + blue.toString(16) : blue.toString(16);
			var returnRGB = "0x" + tempR + tempG + tempB;
			return (returnRGB);
		}
	}
}