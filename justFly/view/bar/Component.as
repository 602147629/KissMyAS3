package justFly.view.bar {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	
	[Event(name="resize", type="flash.events.Event")]
	[Event(name = "draw", type = "flash.events.Event")]
	
	public class Component extends Sprite {
		protected var _width:Number;
		protected var _height:Number;
		public static const DRAW:String = "draw";
		protected var _enabled:Boolean = true;
		
		public function Component(parent:DisplayObjectContainer = null, width:Number = 0, height:Number = 0, label:String = "", xpos:Number = 0, ypos:Number = 0) {
			super();
			
			this.move(xpos, ypos);
			this.setSize(width, height);
			this.init();
			
			if (parent != null) {
				parent.addChild(this);
			}
		}
		
		public function move(xpos:Number, ypos:Number):void {
			this.x = Math.round(xpos);
			this.y = Math.round(ypos);
		}
		
		public function setSize(w:Number, h:Number):void {
			this._width = w;
			this._height = h;
			this.dispatchEvent(new Event(Event.RESIZE));
			this.invalidate();
		}
		
		protected function init():void {
			this.addChildren();
			this.invalidate();
		}
		
		protected function addChildren():void {}
		
		public function draw():void {
			this.dispatchEvent(new Event(Component.DRAW));
		}
		
		public function invalidate():void {
			this.addEventListener(Event.ENTER_FRAME, onInvalidate);
		}
		
		public function onInvalidate(event:Event):void {
			this.removeEventListener(Event.ENTER_FRAME, onInvalidate);
			this.draw();
		}
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		// getter / setters
		//
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		protected function getShadow(dist:Number, knockout:Boolean = false):DropShadowFilter{
			return new DropShadowFilter(dist, 45, 0x000000, 1, dist, dist, .3, 1, knockout);
		}
		
		override public function set width(w:Number):void {
			this._width = w;
			this.invalidate();
			this.dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get width():Number {
			return this._width;
		}
		
		override public function set height(h:Number):void {
			this._height = h;
			this.invalidate();
			this.dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get height():Number {
			return this._height;
		}
		
		override public function set x(value:Number):void {
			super.x = Math.round(value);
		}
		
		override public function set y(value:Number):void {
			super.y = Math.round(value);
		}
		
		public function set enabled(value:Boolean):void{
			this._enabled = value;
			this.mouseEnabled = this.mouseChildren = this._enabled;
            this.tabEnabled = value;
			this.alpha = this._enabled ? 1.0 : 0.5;
		}
		
		public function get enabled():Boolean{
			return this._enabled;
		}
	}

}