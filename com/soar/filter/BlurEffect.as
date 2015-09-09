package com.soar.filter {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...	背景模糊
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class BlurEffect {
		
		public function BlurEffect():void {}
		
		/**
		 * 顯示物件變模糊
		 * @return	BitmapData
		 */
		public function getBlurImg( container:DisplayObject ):BitmapData {
			var BackgroundBD:BitmapData = new BitmapData(container.width, container.height, true, 0xFF000000);
			var stageBackground:BitmapData = new BitmapData(container.width, container.height);
			stageBackground.draw(container);
			var rect:Rectangle = new Rectangle(0, 0, container.width, container.height);
			var point:Point = new Point(0, 0);
			var multiplier:uint = 130;
			
			BackgroundBD.merge(stageBackground, rect, point, multiplier, multiplier, multiplier, multiplier);
			BackgroundBD.applyFilter(BackgroundBD, rect, point, new BlurFilter(10, 10 , BitmapFilterQuality.HIGH));
			return BackgroundBD;
		}
		
	}
}