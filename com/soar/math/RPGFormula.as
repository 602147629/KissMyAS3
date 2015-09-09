package com.soar.math {

	/**
	 * ... RPG 公式規則
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class RPGFormula{
		private var Hit:int = 0;		//命中
		
		private static var instance:RPGFormula;
		public static function getInstance():RPGFormula {return (instance ||= new RPGFormula);}
		public function RPGFormula() {if (instance) {throw new Error("Use RPGFormula.getInstance()");}}
		
		/**
		 * FLEE公式	: 迴避率 = 20 + 迴避力(Flee) - 敵人命中力(Hit) ％(最高95％)
		 * @param	:
		 */
		
		 /**
		  * 命中率	:	自Hit + 80 - 敵Flee＝命中率(％)
		  * @param	:
		  */
		private function getHitRate(hit:int):int {
			var HitRate:int;
			
			var mos_flee:int = 50;
			HitRate = hit + 80 - mos_flee;
			trace("HitRate : " + HitRate);
			return HitRate;
		}
	}

}