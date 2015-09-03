package com.soar.filter {
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class ChangeColorCode {
		
		public function ChangeColorCode():void {
		
		}
		
		/**
		 * HEX 2 RGB
		 * @param	hex : uint
		 * @return
		 */
		public function ChangeRGB(hex:uint):Array {
			var rgb:Array = new Array();
			rgb[0] = hex >> 16;
			rgb[1] = hex >> 8 & 0xFF;
			rgb[2] = hex & 0xFF;
			trace("RGB :" + ChangeRGB(0xFFFF00));
			return rgb;
		}
		
		/**
		 * RGB 2 HEX
		 * @param	rgb : Array
		 * @return
		 */
		public function ChangeHEX(rgb:Array):uint {
			var hex:uint = rgb[0] << 16 ^ rgb[1] << 8 ^ rgb[2];
			trace("HEX :" + ChangeHEX([60, 100, 100]));
			return hex;
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