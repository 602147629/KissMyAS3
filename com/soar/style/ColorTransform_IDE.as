package com.soar.style {
	import flash.geom.ColorTransform;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/4/26 上午 10:07
	 * @version	：1.0.12
	 */
	
	public class ColorTransform_IDE {
		
		public function ColorTransform_IDE() {
		
		}
		
		// 亮度(-100 ~ 100)/100%
		public static function Luminance(luminance:Number):ColorTransform {
			var multiplier:Number = 1 - Math.abs(luminance);
			var offset:Number = luminance > 0 ? luminance * 255 : 0;
			var CT:ColorTransform = new ColorTransform(multiplier, multiplier, multiplier, 1, offset, offset, offset);
			return CT;
		}
		
		// 色調值(0 ~ 1) , 紅(0 ~ 255),綠(0 ~ 255),藍(0 ~ 255)
		public static function Tone( tone:Number , red:int , green:int , blue:int ):ColorTransform {
			var multiplier:Number = 1 - tone;
			var redOffset:Number = tone * red;
			var greenOffset:Number = tone * green;
			var blueOffset:Number = tone * blue;
			
			var CT:ColorTransform = new ColorTransform(multiplier, multiplier, multiplier, 1, redOffset, greenOffset, blueOffset);
			return CT;
		}
		
		// 進階 : Alpha(0 ~ 100) , 紅 , 綠 , 藍
		public static function Advanced( 	alphaMultiplier:Number , alphaOffset:Number , 
															redMultiplier:Number , redOffset:Number ,
															greenMultiplier:Number , greenOffset , 
															blueMultiplier:Number , blueOffset:Number
															):ColorTransform {
			var CT:ColorTransform = new ColorTransform(redMultiplier, greenMultiplier, blueMultiplier, alphaMultiplier, redOffset, greenOffset, blueOffset, alphaOffset);
			return CT;
		}
		
	
	}

}