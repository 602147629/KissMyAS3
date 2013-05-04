package com.soar.ui {
	import com.soar.ui.Component;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/18 下午 04:01
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
			setSize(100, 10);
		}
		
		override protected function addChildren():void {
			_back = new Sprite();
			_back.filters = [getShadow(2, true)];
			addChild(_back);
			
			_bar = new Sprite();
			_bar.x = 1;
			_bar.y = 1;
			_bar.filters = [getShadow(1)];
			addChild(_bar);
		}
		
		protected function update():void {
			_bar.scaleX = _value / _max;
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void {
			_back.graphics.clear();
			_back.graphics.beginFill(Style.BACKGROUND);
			_back.graphics.drawRect(0, 0, _width, _height);
			_back.graphics.endFill();
			
			_bar.graphics.clear();
			_bar.graphics.beginFill(Style.PROGRESS_BAR);
			_bar.graphics.drawRect(0, 0, _width - 2, _height - 2);
			_bar.graphics.endFill();
			update();
		}
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Gets / sets the maximum value of the ProgressBar.
		 */
		public function set maximum(m:Number):void {
			_max = m;
			_value = Math.min(_value, _max);
			update();
		}
		
		public function get maximum():Number {
			return _max;
		}
		
		/**
		 * Gets / sets the current value of the ProgressBar.
		 */
		public function set value(v:Number):void {
			_value = Math.min(v, _max);
			update();
		}
		
		public function get value():Number {
			return _value;
		}
	}
}