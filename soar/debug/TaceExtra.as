package {
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @copy   ：Copyright (c) 2008, SOAR Digital Incorporated. All rights reserved.
	 * @author ：g8sam
	 * @since   ：2012/12/20 下午 06:13
	 * @version：1.0.12
	 */
	public class TaceExtra extends Sprite {
		private var debug:Boolean = true;
		
		private function TaceExtra(... args):void {
			if (!debug)
				return;
			
			var tracemsg:String = "";
			
			for each (var obj:Object in args) {
				tracemsg = tracemsg.concat(obj + ", ");
			}
			
			tracemsg = tracemsg.substr(0, tracemsg.length - 2);
			trace(tracemsg);
		}
	}
}