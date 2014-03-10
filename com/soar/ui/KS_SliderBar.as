package com.soar.ui {
	import adobe.utils.CustomActions;
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
		private var horizon:Sprite;
		private var circleBtn:Sprite;
		private var txt:KS_TextField = new KS_TextField(9 , 0xFFFFFF , false );
		
		//beginGradientFill
		private var fillType:String = GradientType.LINEAR;
		private var alphas:Array = [1, 1];
		private var btnGradient:Array = [ 0xfefefe, 0xcccccc];
		private var ratios:Array = [75, 255];
		private var matrix:Matrix = new Matrix();
		private var spreadMethod:String = "reflect";
		private var interpolationMethod:String = "LINEAR_RGB";
		private var focalPointRatio:Number = 1;
		
		private var _stage:Stage;
		
		public function KS_SliderBar( stage:Stage) {
			_stage = stage;
			UI_BarBG();
			UI_CircleBtn();
			this.txt.text = "0";
			this.addChild(this.txt);
			this.txt.x = 44;
			this.txt.y = -21;
		}
		
		private function UI_BarBG():void {
			this.horizon = new Sprite();
			this.horizon.graphics.beginFill(0x666666 , 1);
			this.horizon.graphics.drawRoundRect( 0, -1 , 100 , 3 , 10 , 10);
			this.horizon.filters = [new DropShadowFilter( 2, 45, 0x000000, 1, 2 , 2 , 0.3, 1, true)];
			this.addChild( this.horizon);
			
		}
		
		private function UI_CircleBtn():void {
			this.circleBtn = new Sprite();
			this.circleBtn.graphics.lineStyle(1 , 0x999999);
			
			matrix.createGradientBox(6, 6, 90 / 180 * Math.PI, 0, 0);
			this.circleBtn.graphics.beginGradientFill(fillType, btnGradient, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
			this.circleBtn.graphics.drawCircle( 0  , 0 , 6);
			this.addChild( this.circleBtn);
			this.circleBtn.x = 50;
			
			this.circleBtn.buttonMode = true;
			this.circleBtn.useHandCursor = true;
			this.circleBtn.addEventListener(MouseEvent.MOUSE_DOWN , cirBtnDownHandler );
			this.circleBtn.addEventListener(MouseEvent.MOUSE_OVER , cirBtnOverHandler );
			this.circleBtn.addEventListener(MouseEvent.MOUSE_OUT , cirBtnOutHandler );
		}
		
		private function cirBtnOutHandler(e:MouseEvent):void {
			this.circleBtn.filters = null;
		}
		
		private function cirBtnOverHandler(e:MouseEvent):void {
			var gf:GlowFilter = new GlowFilter( 0x009DFF , 1);
			this.circleBtn.filters = [gf];
		}
		
		protected var _max:Number = 255;
		protected var _min:Number = -255;
		
		private function cirBtnMoveHandler(e:MouseEvent):void {
			var _value:Number = 0;
			_value = this.circleBtn.x / 100 * (_max - _min) + _min;
			trace( "_value : " + _value );
			this.txt.text = String(this.circleBtn.x);
		}
		
		private function cirBtnUpHandler(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, cirBtnUpHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, cirBtnMoveHandler);
			this.circleBtn.filters = null;
			this.circleBtn.stopDrag();
		}
		
		private function cirBtnDownHandler(e:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, cirBtnUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, cirBtnMoveHandler);
			this.circleBtn.startDrag(false, new Rectangle(0, 0, 100, 0));
		}
		
		
		
	}

}