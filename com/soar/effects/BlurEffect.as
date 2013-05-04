package com.soar.effects {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class BlurEffect {
		private var bitmap:Bitmap = new Bitmap();
		private var container:DisplayObject;
		
		public function BlurEffect(container:DisplayObject):void {
			this.container = container;
			init();
		}
		
		private function init():BitmapData {
			var BackgroundBD:BitmapData = new BitmapData(this.container.width, this.container.height, true, 0xFF000000);
			var stageBackground:BitmapData = new BitmapData(this.container.width, this.container.height);
			stageBackground.draw(this.container);
			var rect:Rectangle = new Rectangle(0, 0, this.container.width, this.container.height);
			var point:Point = new Point(0, 0);
			var multiplier:uint = 130;
			
			BackgroundBD.merge(stageBackground, rect, point, multiplier, multiplier, multiplier, multiplier);
			BackgroundBD.applyFilter(BackgroundBD, rect, point, new BlurFilter(10, 10));
			this.container = null;
			return BackgroundBD;
		}
	
	}
}