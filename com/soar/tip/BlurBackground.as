/**

   The MIT License

   Copyright (c) 2008 g8sam « Just do it ™ » ( http://g8sam.site90.net )

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
   THE SOFTWARE.

 **/
package com.soar.tip{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @Example:
	 * BlurBackground.getInstance().setting(this._viewNG , this._notEnough , 800 , 600);
	 * BlurBackground.getInstance().enable();
	 * BlurBackground.getInstance().disable();
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/8/29 下午 05:28
	 * @version	：1.0.12
	 */
	
	public class BlurBackground extends Sprite {
		private var _display:DisplayObject;
		private var _width:int;
		private var _height:int;
		private var _blurBmp:Bitmap;
		private var _topContainer:DisplayObjectContainer;
		private var _isEnable:Boolean;
		
		private static var _blurBackground:BlurBackground;
		public static function getInstance():BlurBackground {return (_blurBackground ||= new BlurBackground);}
		public function BlurBackground():void { }
		
		public function setting(display:DisplayObject , topContainer:DisplayObjectContainer, width:int = 800 , height:int = 600 ):void {
			this._display = display;
			this._width = width;
			this._height = height;
			this._blurBmp = new Bitmap();
			this._topContainer = topContainer;
			this._isEnable = false;
		}
		
		public function enable():void {
			if (this._isEnable) {return;}
			this._display.stage.addChild(this._blurBmp);
			this._display.stage.addChild(this._topContainer);
			this._blurBmp.bitmapData = this.blurEffect();
			this._isEnable = true;
		}
		
		public function disable():void {
			if (!this._isEnable) {return;}
			this._display.stage.removeChild(this._topContainer);
			this._display.stage.removeChild(this._blurBmp);
			this._blurBmp.bitmapData.dispose();
			this._isEnable = false;
		}
		
		private function blurEffect():BitmapData {
			var BackgroundBD:BitmapData = new BitmapData( this._width , this._height , true , 0x000000 );
			var stageBackground:BitmapData = new BitmapData( this._width , this._height , true , 0x000000 );
			stageBackground.draw( this._display.stage);
			
			var rect:Rectangle = new Rectangle(0, 0, this._width, this._height);
			var point:Point = new Point(0, 0);
			var multiplier:uint = 200;
			
			BackgroundBD.merge(stageBackground, rect, point, multiplier, multiplier, multiplier, multiplier);
			BackgroundBD.applyFilter(BackgroundBD, rect, point, new BlurFilter(10, 10 , BitmapFilterQuality.MEDIUM));
			return BackgroundBD;
		}
	
	}
}