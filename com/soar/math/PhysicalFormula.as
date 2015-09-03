package com.soar.math {
	
	/**
	 * ... 物理公式
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/5/10 下午 01:32
	 * @version	：1.0.12
	 */
	
	public class PhysicalFormula {
		
		public function PhysicalFormula() {
		}
		
		//自由落體公式，g為重力加速度，v為落體速度，h為落體高度，k為損耗係數
		public function Freefall():void {
			v += g;
			spball.y += v;
			trace( "spball : " + spball );
			
			if (spball.y > h) {
				spball.y = h;
				v *= -1 * k;
			}
		}
		
	}

}