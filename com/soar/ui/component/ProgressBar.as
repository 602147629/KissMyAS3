package com.soar.ui.component {
	import com.soar.ui.component.Component;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class ProgressBar extends Component {
		protected var _back:Sprite;
		protected var _bar:Sprite;
		protected var _value:Number = 0;
		protected var _max:Number = 1;
		
		public function ProgressBar(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0):void {
			super(parent, xpos, ypos);
		}
		
		override protected function init():void {
			super.init();
			this.setSize(100, 10);
		}
		
		override protected function addChildren():void {
			this._back = new Sprite();
			this._back.filters = [getShadow(2, true)];
			this.addChild(this._back);
			
			this._bar = new Sprite();
			this._bar.x = 1;
			this._bar.y = 1;
			this._bar.filters = [getShadow(1)];
			this.addChild(this._bar);
		}
		
		protected function update():void {
			this._bar.scaleX = this._value / this._max;
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////
		// public methods
		//////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void {
			this._back.graphics.clear();
			this._back.graphics.beginFill(Style.BACKGROUND);
			this._back.graphics.drawRect(0, 0, this._width, this._height);
			this._back.graphics.endFill();
			
			this._bar.graphics.clear();
			this._bar.graphics.beginFill(Style.PROGRESS_BAR);
			this._bar.graphics.drawRect(0, 0, this._width - 2, this._height - 2);
			this._bar.graphics.endFill();
			this.update();
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////
		//		event handlers
		//////////////////////////////////////////////////////////////////////////////////////////
		
		
		//////////////////////////////////////////////////////////////////////////////////////////
		//		getter/setters
		//////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Gets / sets the maximum value of the ProgressBar.
		 */
		public function set maximum(m:Number):void {
			this._max = m;
			this._value = Math.min(this._value, this._max);
			this.update();
		}
		
		public function get maximum():Number {
			return this._max;
		}
		
		/**
		 * Gets / sets the current value of the ProgressBar.
		 */
		public function set value(v:Number):void {
			this._value = Math.min(v, this._max);
			this.update();
		}
		
		public function get value():Number {
			return _value;
		}
	}
}