package com.soar.display.graphic {
	
	import com.adobe.images.JPGEncoder;
	import com.soar.utils.decode.Base64;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	public class GetGraphic {
		private static var imageStr:String = "";
		
		public static function GetCircleStr(radius1:int, radius2:int, radius3:int):String {
			var cr_spt:BitmapData = new DrawCircle(radius1, radius2, radius3).getGrasp();
			toEncoder(cr_spt);
			return imageStr;
		}
		
		public static function GetColumnStr(oneH:int, twoH:int, threeH:int):String {
			var cr_spt:BitmapData = new DrawColumn(oneH, twoH, threeH).getGrasp();
			toEncoder(cr_spt);
			return imageStr;
		}
		
		public static function toEncoder(bmpd:BitmapData):void {
			var encoder:JPGEncoder = new JPGEncoder(100);
			var bytes:ByteArray = encoder.encode(bmpd);
			imageStr = Base64.encode(bytes);
		}
	}
}