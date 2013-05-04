package com.soar.ui {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/18 上午 11:09
	 * @version	：1.0.12
	 */
	
	[Event(name="resize", type="flash.events.Event")]
	[Event(name="draw",type="flash.events.Event")]
	
	public class Component extends Sprite {
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		protected var _enabled:Boolean = true;
		public static const DRAW:String = "draw";
		
		public function Component(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0):void {
			move(xpos, ypos);
			init();
			
			if (parent != null) {
				parent.addChild(this);
			}
		}
		
		/**
		 * Initilizes the component.
		 */
		protected function init():void {
			addChildren();
			invalidate();
		}
		
		protected function addChildren():void {
		}
		
		protected function invalidate():void {
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}
		
		protected function getShadow(dist:Number, knockout:Boolean = false):DropShadowFilter {
			return new DropShadowFilter(dist, 45, Style.DROPSHADOW, 1, dist, dist, .3, 1, knockout);
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		public static function initStage(stage:Stage):void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		public function move(xpos:Number, ypos:Number):void {
			x = Math.round(xpos);
			y = Math.round(ypos);
		}
		
		public function setSize(w:Number, h:Number):void {
			_width = w;
			_height = h;
			dispatchEvent(new Event(Event.RESIZE));
			invalidate();
		}
		
		/**
		 * Abstract draw function.
		 */
		public function draw():void {
			dispatchEvent(new Event(Component.DRAW));
		}
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Called one frame after invalidate is called.
		 */
		protected function onInvalidate(event:Event):void {
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function set width(w:Number):void {
			_width = w;
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get width():Number {
			return _width;
		}
		
		override public function set height(h:Number):void {
			_height = h;
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get height():Number {
			return _height;
		}
		
		override public function set x(value:Number):void {
			super.x = Math.round(value);
		}
		
		override public function set y(value:Number):void {
			super.y = Math.round(value);
		}
		
		public function set enabled(value:Boolean):void {
			_enabled = value;
			mouseEnabled = mouseChildren = _enabled;
			tabEnabled = value;
			alpha = _enabled ? 1.0 : 0.5;
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
	
	}
}