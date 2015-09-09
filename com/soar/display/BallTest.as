package com.soar.display {
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class BallTest extends Sprite {
		private var _ball:Ball;
		
		private var dx:Number;
		private var dy:Number;
		private var endX:Number;
		private var endY:Number;
		private var t:Number;
		
		public function BallTest() {
			this._ball = new Ball
			this.addChild(this._ball);
			this._ball.x = Math.random() * 500 + 100;
			this._ball.y = -10;
			this.addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(e:Event):void {
			this.movie(this._ball);
		}
		
		private function movie(object:Ball):void {
			if (object.x > 0 && object.y > 0 && object.x < 550 && object.y < 400) { //如果對象的坐標處於500*400大小的舞台中執行
				yidong(object); //運行對像移動函數
			} else { //對像坐標超出舞台後重新定義一個處於舞台內的坐標，並且移到該處
				tt();
				this.chushizhi(object);
				trace(endX);
				this.yidong(object);
			}
		}
		
		private function fanhui(x1:Number, x2:Number, y1:Number, y2:Number):Number {
			var Sqrt:Number = Math.sqrt(x1 + x2 + y1 + y2);
			return Sqrt;
		}
		
		private function chushizhi(obja:Ball) {
			this.endX = Math.random() * 550; //定義的X坐標
			this.endY = Math.random() * 400; //定義的X坐標
			var d:Number = this.fanhui(endX, endY, obja.x, obja.y); //獲取返回後的平方根
			this.dx = (this.endX - obja.x) / d * t; //定義對像要移動的X坐標
			this.dy = (this.endY - obja.y) / d * t; //定義對像要移動的Y坐標
		}
		
		private function tt() { //定義移動的速度
			this.t = Math.random() * 2;
		}
		
		private function yidong(objb:Ball) { //對像移動
			objb.x = objb.x + this.dx;
			objb.y = objb.y + this.dy;
		}
	
	}

}