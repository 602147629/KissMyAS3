package com.soar.math{
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class MathCalculate {
		
		public function MathCalculate():void {
			//EntryPoint...
		}
		
		/**
		 * 隨機範圍
		 * @param	minNum
		 * @param	maxNum
		 * @return
		 */
		public function randomRange(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
	
	}
}