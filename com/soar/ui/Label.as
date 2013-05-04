package com.soar.ui {
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/18 上午 11:44
	 * @version	：1.0.12
	 */
	[Event(name="resize", type="flash.events.Event")]
	public class Label extends Component {
		protected var _autoSize:Boolean = true;
		protected var _text:String = "";
		protected var _tf:TextField;
		protected var t_tf:TextField;
		
		public function Label(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, text:String = ""):void {
			this.text = text;
			super(parent, xpos, ypos);
		}
		
		override protected function init():void {
			super.init();
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		override protected function addChildren():void {
			_height = 18;
			_tf = new TextField();
			_tf.height = _height;
			_tf.embedFonts = Style.embedFonts;
			_tf.selectable = false;
			_tf.mouseEnabled = false;
			_tf.defaultTextFormat = new TextFormat(Style.fontName, Style.fontSize, Style.LABEL_TEXT);
			_tf.text = _text;
			addChild(_tf);
			draw();
		}
		
		///////////////////////////////////
		// public methods	
		///////////////////////////////////
		
		override public function draw():void {
			super.draw();
			_tf.text = _text;
			if (_autoSize) {
				_tf.autoSize = TextFieldAutoSize.LEFT;
				_width = _tf.width;
				dispatchEvent(new Event(Event.RESIZE));
			} else {
				_tf.autoSize = TextFieldAutoSize.NONE;
				_tf.width = _width;
			}
			_height = _tf.height = 18;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set text(t:String):void {
			_text = t;
			
			if (_text == null)
				_text = "";
			
			invalidate();
		}
		
		public function get text():String {
			return _text;
		}
		
		public function get textField():TextField {
			return _tf;
		}
	}
}