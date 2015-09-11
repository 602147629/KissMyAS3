package com.soar.display.coolDown {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	/**
	 * ... 扇形 冷卻時間
	 * @copy        ：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author     ：g8sam « Just do it ™ »
	 * @since       ：2015/9/5 下午 12:03
	 * @version    ：1.0.2.150905_α(Alpha)
	 */
	
	/**
	 * 使用手冊 : 
	 * 
	 * coolDown = new CoolDown(btn);
	 * coolDown.color = 0x0; -- mask的顏色
	 * coolDown.alpha = 0.3; -- mask的alpha
	 * coolDown.start(10000); -- mask的總共時間
	 * coolDown.addEventListener(Event.COMPLETE, completeHandler);
	 */

	public class CoolDownSector extends Sprite {
		
		private const startFrom:Number = -90 / 180 * Math.PI;
		private var _running:Boolean = false;
		private var _color:uint;
		
		private var halfW:Number;       // 半個寬
		private var halfH:Number;       // 半個高
		
		private var radianList:Array;   // 存放4個角的弧度
		private var pointXList:Array;   // 存放4個角的X坐標
		private var pointYList:Array;   // 存放4個角的Y坐標
		
		private var beginTime:Number;   // 開始的時間
		private var totalTime:Number;   // 總時間
		
		private var maskShape:Shape;
		private var bitmap:Bitmap;
		
		public function CoolDownSector(display:DisplayObject) {
			this.mouseChildren = this.mouseEnabled = false;
			if (display) setTarget(display);
		}
		
		/**
		 * 是否在轉動
		 */
		public function get running():Boolean { return _running; }
		
		public function get color():uint { return _color; }

		public function set color(value:uint):void {
			if (_color != value) {
				_color = value;
				if (bitmap) {
					var r:Number = (value & 0xFF0000) >>> 16;
					var g:Number = (value & 0x00FF00) >>> 8;
					var b:Number = value & 0x0000FF;
					bitmap.transform.colorTransform = new ColorTransform(0, 0, 0, 1, r, g, b);
				}
			}
		}
		
		/**
		 * 銷毀自己
		 */
		public function dispose():void {
			try {
				bitmap.bitmapData.dispose();
				bitmap.bitmapData = null;
			} catch (e:Error) {}
			
			if (maskShape && maskShape.hasEventListener(Event.ENTER_FRAME)) {
				maskShape.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				maskShape.graphics.clear();
			}
		}
		
		/**
		 * 添加到目標上層
		 * 轉動結束後觸發complete事件
		 */
		public function setTarget(display:DisplayObject):void {
			
			if (!maskShape) maskShape = new Shape();
			addChild(maskShape);
			
			if (!bitmap) bitmap = new Bitmap();
			if (bitmap.bitmapData) bitmap.bitmapData.dispose();
			
			var rect:Rectangle = display.getBounds(display.parent);
			halfW = rect.width * 0.5;
			halfH = rect.height * 0.5;
			pointXList = [-halfW, -halfW, halfW, halfW];
			pointYList = [-halfH, halfH, halfH, -halfH];
			radianList = [Math.atan2(-halfH, -halfW) + Math.PI * 2, Math.atan2(halfH, -halfW), Math.atan2(halfH, halfW), Math.atan2(-halfH, halfW), startFrom];
			
			var bitmapData:BitmapData = new BitmapData(rect.width, rect.height, true, 0x0);
			var stageP:Point = display.parent.localToGlobal(new Point(rect.x, rect.y));
			
			bitmapData.lock();
			for (var i:int = 0; i < rect.width; i++) {
				for (var j:int = 0; j < rect.height; j++) {
					if (display.hitTestPoint(stageP.x + i, stageP.y + j, true))
						bitmapData.setPixel32(i, j, 0xFF000000);
				}
			}
			
			bitmapData.unlock();
			bitmap.bitmapData = bitmapData;
			bitmap.x = -halfW;
			bitmap.y = -halfH;
			addChild(bitmap);
			
			 // 扇形遮罩 是否顯示已完成的部分原圖
			bitmap.mask = maskShape;
			
			this.x = rect.x + halfW;
			this.y = rect.y + halfH;
			
			display.parent.addChildAt(this, display.parent.getChildIndex(display) + 1);
		}
		
		/**
		 * 開始轉
		 * @param   totalTime   轉一圈所用的時間(單位:毫秒)
		 */
		public function start(totalTime:Number):void {
			if (maskShape) {
				this.totalTime = totalTime;
				beginTime = getTimer();
				_running = true;
				
				maskShape.graphics.beginFill(0);
				maskShape.graphics.drawRect(-halfW, -halfW, halfW * 2, halfH * 2);
				maskShape.graphics.endFill();
				
				if (!maskShape.hasEventListener(Event.ENTER_FRAME))
					maskShape.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}
		
		private function enterFrameHandler(e:Event):void {
			var postTime:Number = getTimer() - beginTime;
			maskShape.graphics.clear();
			
			// 時間到了
			if (postTime >= totalTime) {
				maskShape.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				_running = false;
				dispatchEvent(new Event(Event.COMPLETE));
			} else{
				// 時間還沒到
				maskShape.graphics.beginFill(0);
				maskShape.graphics.lineTo(0, -halfH);
				
				var currRadian:Number = 2 * Math.PI * (postTime / totalTime) + startFrom;
				var px:Number, py:Number;
				for (var i:int = 0; i < 5; i++) {
					var radian:Number = radianList[i];
					if (currRadian < radian) {
						maskShape.graphics.lineTo(pointXList[i], pointYList[i]);
					} else {
						if (1 == i || 3 == i) {
							px = 1 == i ? -halfW : halfW;
							py = Math.tan(currRadian) * px;
						} else {
							py = 2 == i ? halfH : -halfH;
							px = py / Math.tan(currRadian);
						}
						maskShape.graphics.lineTo(px, py);
						break;
					}
				}
				
				maskShape.graphics.lineTo(0, 0);
				maskShape.graphics.endFill();
			}
		}
	
	}

}