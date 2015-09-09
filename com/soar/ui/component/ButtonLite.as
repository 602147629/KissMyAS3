package com.soar.ui.component {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import roborant.view.utils.event.GameEvent;
	
	/**
	 * ... 按鈕基本款( 一張圖 )
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class ButtonLite extends Sprite {
		private var _button:MovieClip;
		private var _btnName:String;
		
		public function ButtonLite(view:MovieClip) {
			this._button = view;
			this._button.gotoAndStop(1);
			this._btnName = this._button.name.slice(4, this._button.name.length);
		}
		
		public function set enable(value:Boolean):void {
			value ? this.addEvent() : this.delEvent();
			this._button.filters = [value ? new ColorMatrixFilter() : new ColorMatrixFilter([0.33, 0.33, 0.33, 0, 0,0.33, 0.33, 0.33, 0, 0,0.33, 0.33, 0.33, 0, 0,0, 0, 0, 1, 0])];
		}
		
		override public function set visible(value:Boolean):void {
			this._button.visible = value;
		}
		
		public function addEvent():void {
			this._button.buttonMode = true;
			this._button.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			this._button.addEventListener(MouseEvent.MOUSE_UP, onUp);
			this._button.addEventListener(MouseEvent.ROLL_OVER, onOver);
			this._button.addEventListener(MouseEvent.ROLL_OUT, onOut);
		}
		
		public function delEvent():void {
			this._button.buttonMode = false;
			this._button.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			this._button.removeEventListener(MouseEvent.MOUSE_UP, onUp);
			this._button.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			this._button.removeEventListener(MouseEvent.ROLL_OUT, onOut);
		}
		
		private function onOut(e:MouseEvent):void {
			this._button.filters = [new ColorMatrixFilter]
		}
		
		private function onOver(e:MouseEvent):void {
			this._button.filters = [createContrastFilter(1.3) , createBrightnessFilter(50)];
		}
		
		private function onDown(e:MouseEvent):void {
			this._button.y += 1;
			this.dispatchEvent(new GameEvent("ButtonLiteEvent", [this._btnName]));
		}
		
		private function onUp(e:MouseEvent):void {
			this._button.y -= 1;
		}
		
		private function createContrastFilter(n:Number):ColorMatrixFilter {
			return new ColorMatrixFilter([n, 0, 0, 0, 128 * (1 - n), 0, n, 0, 0, 128 * (1 - n), 0, 0, n, 0, 128 * (1 - n), 0, 0, 0, 1, 0]);
		}
		
		private function createBrightnessFilter(n:Number):ColorMatrixFilter {
			return new ColorMatrixFilter([1, 0, 0, 0, n, 0, 1, 0, 0, n,0, 0, 1, 0, n, 0, 0, 0, 1, 0]);
		}
		
		public function onExit():void {
			this.delEvent();
			this._button = null;
		}
	
	}

}