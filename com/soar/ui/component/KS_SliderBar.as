package com.soar.ui.component {
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/8/9 下午 04:03
	 * @version	：1.0.12
	 */
	
	public class KS_SliderBar extends Sprite {
		private var _horizon:Sprite;
		private var _circleBtn:Sprite;
		private var _txt:KS_TextField = new KS_TextField(9, 0xFFFFFF, false);
		
		//beginGradientFill
		private var _fillType:String = GradientType.LINEAR;
		private var _alphas:Array = [1, 1];
		private var _btnGradient:Array = [0xfefefe, 0xcccccc];
		private var _ratios:Array = [75, 255];
		private var _matrix:Matrix = new Matrix();
		private var _spreadMethod:String = "reflect";
		private var _interpolationMethod:String = "LINEAR_RGB";
		private var _focalPointRatio:Number = 1;
		
		protected var _max:Number = 255;
		protected var _min:Number = -255;
		
		private var _stage:Stage;
		
		public function KS_SliderBar(stage:Stage) {
			this._stage = stage;
			this.UI_BarBG();
			this.UI_CircleBtn();
			this._txt.text = "0";
			this.addChild(this._txt);
			this._txt.x = 44;
			this._txt.y = -21;
		}
		
		private function UI_BarBG():void {
			this._horizon = new Sprite();
			this._horizon.graphics.beginFill(0x666666, 1);
			this._horizon.graphics.drawRoundRect(0, -1, 100, 3, 10, 10);
			this._horizon.filters = [new DropShadowFilter(2, 45, 0x000000, 1, 2, 2, 0.3, 1, true)];
			this.addChild(this._horizon);
		}
		
		private function UI_CircleBtn():void {
			this._circleBtn = new Sprite();
			this._circleBtn.graphics.lineStyle(1, 0x999999);
			
			this._matrix.createGradientBox(6, 6, 90 / 180 * Math.PI, 0, 0);
			this._circleBtn.graphics.beginGradientFill(this._fillType, this._btnGradient, this._alphas, this._ratios, this._matrix, this._spreadMethod, this._interpolationMethod, this._focalPointRatio);
			this._circleBtn.graphics.drawCircle(0, 0, 6);
			this.addChild(this._circleBtn);
			this._circleBtn.x = 50;
			
			this._circleBtn.buttonMode = true;
			this._circleBtn.useHandCursor = true;
			this._circleBtn.addEventListener(MouseEvent.MOUSE_DOWN, cirBtnDownHandler);
			this._circleBtn.addEventListener(MouseEvent.MOUSE_OVER, cirBtnOverHandler);
			this._circleBtn.addEventListener(MouseEvent.MOUSE_OUT, cirBtnOutHandler);
		}
		
		private function cirBtnOutHandler(e:MouseEvent):void {
			this._circleBtn.filters = null;
		}
		
		private function cirBtnOverHandler(e:MouseEvent):void {
			var gf:GlowFilter = new GlowFilter(0x009DFF, 1);
			this._circleBtn.filters = [gf];
		}
		
		private function cirBtnMoveHandler(e:MouseEvent):void {
			var value:Number = 0;
			value = this.circleBtn.x / 100 * (this._max - this._min) + this._min;
			this._txt.text = String(this._circleBtn.x);
		}
		
		private function cirBtnUpHandler(e:MouseEvent):void {
			this._stage.removeEventListener(MouseEvent.MOUSE_UP, cirBtnUpHandler);
			this._stage.removeEventListener(MouseEvent.MOUSE_MOVE, cirBtnMoveHandler);
			this._circleBtn.filters = null;
			this._circleBtn.stopDrag();
		}
		
		private function cirBtnDownHandler(e:MouseEvent):void {
			this._stage.addEventListener(MouseEvent.MOUSE_UP, cirBtnUpHandler);
			this._stage.addEventListener(MouseEvent.MOUSE_MOVE, cirBtnMoveHandler);
			this.circleBtn.startDrag(false, new Rectangle(0, 0, 100, 0));
		}
	
	}

}