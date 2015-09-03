package com.soar.math{
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class MathCalculate {
		/** 黃金比例 */
		public static var GoldenRatio:Number = 1.6180339887498948482045868343656381177203091798057628621354486227052604628189024497072072041893911374;
		
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