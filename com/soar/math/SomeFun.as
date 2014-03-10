package com.soar.math {
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/4/23 上午 10:53
	 * @version	：1.0.12
	 */
	
	public class SomeFun {
		
		public function SomeFun() {
		
		}
		
		//九九乘法表
		public function nineXnineList():void {
			var a:Array = new Array();
			var temp:String = "";
			
			for (var i:int = 1; i <= 9; i++) {
				for (var j:int = 1; j <= i; j++) {
					a[j - 1] = i + "*" + j + "=" + i * j;
					temp += i + "*" + j + "=" + i * j + "  ";
				}
				trace(a);
			}
			
			/*	Output
			 * 1*1=1
			   2*1=2,2*2=4
			   3*1=3,3*2=6,3*3=9
			   4*1=4,4*2=8,4*3=12,4*4=16
			   5*1=5,5*2=10,5*3=15,5*4=20,5*5=25
			   6*1=6,6*2=12,6*3=18,6*4=24,6*5=30,6*6=36
			   7*1=7,7*2=14,7*3=21,7*4=28,7*5=35,7*6=42,7*7=49
			   8*1=8,8*2=16,8*3=24,8*4=32,8*5=40,8*6=48,8*7=56,8*8=64
			   9*1=9,9*2=18,9*3=27,9*4=36,9*5=45,9*6=54,9*7=63,9*8=72,9*9=81
			 * */
		}
	
	}

}