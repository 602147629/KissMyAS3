package soar.filter {
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class ColorPick {
		
		public function ColorPick() {
		
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
			
			var tempR:String = red.toString(16).length == 1 ? "0" + red.toString(16) : red.toString(16);
			var tempG:String = green.toString(16).length == 1 ? "0" + green.toString(16) : green.toString(16);
			var tempB:String = blue.toString(16).length == 1 ? "0" + blue.toString(16) : blue.toString(16);
			var returnRGB:String = "0x" + tempR + tempG + tempB;
			return (returnRGB);
		}
		
		private function luminance():void {
			//colorStr=("0x"+color.toString(16)+"00000").slice(0,8); 
		
			// r,b and b are assumed to be in the range 0...1
		/*
		   luminance =  r * 0.299 + g * 0.587 + b * 0.114;
		   u = - r * 0.1471376975169300226 - g * 0.2888623024830699774 + b * 0.436;
		   v =   r * 0.615 - g * 0.514985734664764622 - b * 0.100014265335235378;
		   hue = atan( v, u );
		   saturation = Math.sqrt( u*u + v*v );
		
		   In this case hue will be between -Pi and Pi and saturation will be between 0 and 1 / sqrt(2),
		   so you might want to multiply the saturation by sqrt(2) to get it in a range between 0 and 1.
		
		   Of course this also works the other way round - hsl to rgb looks like this:
		
		   // hue is an angle in radians (-Pi...Pi)
		   // for saturation the range 0...1/sqrt(2) equals 0% ... 100%
		   // luminance is in the range 0...1
		   u = cos( hue ) * saturation;
		   v = sin( hue ) * saturation;
		   r =  luminance  + 1.139837398373983740  * v;
		   g = luminance  - 0.3946517043589703515  * u - 0.5805986066674976801 * v;
		 b = luminance + 2.03211091743119266 * u;*/
		}
	}
}