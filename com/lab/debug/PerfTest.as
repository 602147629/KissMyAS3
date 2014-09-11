package com.lab.debug {
	import flash.display.Sprite;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/5/17 上午 10:33
	 * @version	：1.0.12
	 */
	
	public class PerfTest extends Sprite{
		
		public function PerfTest() {
			// The start time
			var startTime:int = getTimer();
			
			// Test method call goes here
			
			// Traces the test results
			trace("Test concluded in " + String(getTimer() - startTime) + " miliseconds");
		}
		
	}

}