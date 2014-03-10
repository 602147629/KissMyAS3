package com.soar.style {
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/4/26 上午 10:07
	 * @version	：1.0.12
	 */
	
	public class ColorTransform_IDE {
		
		public function ColorTransform_IDE() {}
		
		/**
		 * 亮度 
		 * @param	luminance 	: (-100 ~ 100)/100%
		 * @return	ColorTransform
		 */
		public static function Luminance(luminance:Number):ColorTransform {
			var multiplier:Number = 1 - Math.abs(luminance);
			var offset:Number = luminance > 0 ? luminance * 255 : 0;
			var CT:ColorTransform = new ColorTransform(multiplier, multiplier, multiplier, 1, offset, offset, offset);
			return CT;
		}
		
		/**
		 * 色調
		 * @param	tone 	: (0 ~ 1)
		 * @param	red		: 紅(0 ~ 255)
		 * @param	green	: 綠(0 ~ 255)
		 * @param	blue		: 藍(0 ~ 255)
		 * @return	ColorTransform
		 */
		public static function Tone(tone:Number, red:int, green:int, blue:int):ColorTransform {
			var multiplier:Number = 1 - tone;
			var redOffset:Number = tone * red;
			var greenOffset:Number = tone * green;
			var blueOffset:Number = tone * blue;
			
			var CT:ColorTransform = new ColorTransform(multiplier, multiplier, multiplier, 1, redOffset, greenOffset, blueOffset);
			return CT;
		}
		
		// 進階 :  , 紅 , 綠 , 藍
		/**
		 * 進階
		 * @param	alphaMultiplier		: Alpha (0 ~ 100)
		 * @param	alphaOffset			: Alpha offset (-255 ~ 255)
		 * @param	redMultiplier		: 紅 (0 ~ 100)
		 * @param	redOffset				: 紅 offset (-255 ~ 255)
		 * @param	greenMultiplier	: 綠 (0 ~ 100)
		 * @param	greenOffset			: 綠 offset (-255 ~ 255)
		 * @param	blueMultiplier		: 藍 (0 ~ 100)
		 * @param	blueOffset			: 藍 offset (-255 ~ 255)
		 * @return	ColorTransform
		 */
		public static function Advanced(alphaMultiplier:Number, alphaOffset:Number, redMultiplier:Number, redOffset:Number, greenMultiplier:Number, greenOffset:Number , blueMultiplier:Number, blueOffset:Number):ColorTransform {
			var CT:ColorTransform = new ColorTransform(redMultiplier, greenMultiplier, blueMultiplier, alphaMultiplier, redOffset, greenOffset, blueOffset, alphaOffset);
			return CT;
		}
		
		/**
		 * 灰色滤镜
		 */
		public static const GRAY_FILTERS:Array = [new ColorMatrixFilter([0.25, 0.25, 0.25, 0, 0, 0.25, 0.25, 0.25, 0, 0, 0.25, 0.25, 0.25, 0, 0, 0, 0, 0, 1, 0])];
		
		/**
		 * 轉灰階
		 * @param	bmp : BitmapData
		 * @return	BitmapData
		 */
		public static function setGlaxy(bmp:BitmapData):BitmapData {
			var pt:Point = new Point(0, 0);
			var _channelBmd:BitmapData = new BitmapData(bmp.width, bmp.height, true, 0x00000000);
			_channelBmd.fillRect(bmp.rect, 0xff000000);
			_channelBmd.copyChannel(bmp, bmp.rect, pt, 16, 1);
			_channelBmd.copyChannel(bmp, bmp.rect, pt, 16, 2);
			_channelBmd.copyChannel(bmp, bmp.rect, pt, 16, 4);
			return _channelBmd;
		}
		
		private var _pixelBmd:BitmapData;
		//手工把ARGB顏色中的Alpha分離出來，將它們組成RGB顏色
		public function pixelBmd( _bmd:BitmapData , $argb:uint ):void {
			_pixelBmd = new BitmapData(_bmd.width, _bmd.height, false);
			
			for (var i:int = 0; i < _bmd.height; i++) {
				var __str:String = '';
				
				for (var j:int = 0; j < _bmd.width; j++) {
					var __pixel:int = _bmd.getPixel32(j, i);
					//分離ARGB顏色中的alpha值，alpha處於32位的最前面8位
					var __alpha:int = $argb >> 24 & 0xFF;
					var __argbstr:String = __alpha == 0 ? '00' : __alpha.toString(16);
					__str += __argbstr + ' ';
					//利用alpha的值合併成RGB顏色值，因為不需要透明，因此24位即可
					__pixel = __alpha << 16 | __alpha << 8 | __alpha;
					_pixelBmd.setPixel(j, i, __pixel);
				}
				
				//如果你的屏幕足夠寬，可以看到一個字符畫，內容你猜猜？
				trace(__str);
			}
		}
	
	}

}