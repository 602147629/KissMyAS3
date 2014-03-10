package {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/8/29 下午 05:28
	 * @version	：1.0.12
	 */

	public class BlurBackground extends Sprite {
		private static var _blurBackground:BlurBackground;
		
		public function BlurBackground():void {
			
		}
		
		public static function getInstance():BlurBackground {
			if ( _blurBackground == null) _blurBackground = new BlurBackground();
			return _blurBackground;
		}
		
		public function blurEffect():BitmapData
		{
			var BackgroundBD:BitmapData = new BitmapData(990, 600, true, 0x000000);
			var stageBackground:BitmapData = new BitmapData(990, 600, true, 0x000000);
			stageBackground.draw(this.stage);
			
			var rect:Rectangle = new Rectangle(0, 0, 990, 600);
			var point:Point = new Point(0, 0);
			var multiplier:uint = 200;
			
			BackgroundBD.merge(stageBackground, rect, point, multiplier, multiplier, multiplier, multiplier);
			BackgroundBD.applyFilter(BackgroundBD, rect, point, new BlurFilter(10, 10));
			return BackgroundBD;
		}

	}
}