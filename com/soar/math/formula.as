package com.soar.math {
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @param	：公式規則
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class formula extends Sprite {
		private var Hit:int = 0;		//命中
		
		public function formula():void {
		
		}
		
		/**
		 * FLEE公式	: 迴避率 = 20 + 迴避力(Flee) - 敵人命中力(Hit) ％(最高95％)
		 * @param	:
		 */
		
		 /**
		  * 命中率公式	:	自Hit + 80 - 敵Flee＝命中率(％)
		  * @param	:
		  */
		private function HitRate():void {
			var HitRate:int;
			var Hit:int = 40;
			var mos_flee:int = 50;
			HitRate = Hit + 80 - mos_flee;
			trace("HitRate : " + HitRate);
		}
	}

}