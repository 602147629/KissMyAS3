package justFly.view.bar {
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	public class Label extends Component {
		protected var _autoSize:Boolean = true;
		protected var _text:String;
		protected var _tf:TextField  = new TextField();
		
		public function Label(parent:DisplayObjectContainer = null, width:Number = 0, height:Number = 0, label:String = "", xpos:Number = 0, ypos:Number = 0) {
			this.text = label;
			super(parent, width , height , label , xpos, ypos);
		}
		
		override protected function init():void {
			super.init();
			this.mouseEnabled = this.mouseChildren = false;
		}
		
		override protected function addChildren():void {
			this._height = 18;
			
			this._tf.height = this._height;
			this._tf.embedFonts = false;
			this._tf.selectable = false;
			this._tf.mouseEnabled = false;
			this._tf.defaultTextFormat = new TextFormat("Verdana", 12, 16777215);
			this._tf.text = this._text;
			this.addChild(this._tf);
			this.draw();
		}
		
		///////////////////////////////////
		// public methods	
		///////////////////////////////////
		
		override public function draw():void {
			super.draw();
			
			this._tf.text = this._text;
			
			if (this._autoSize) {
				this._tf.autoSize = TextFieldAutoSize.LEFT;
				this._width = this._tf.width;
			} else {
				this._tf.autoSize = TextFieldAutoSize.NONE;
				this._tf.width = this._width;
			}
			
			this._height = this._tf.height = 18;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		public function set autoSize(b:Boolean):void{
			this._autoSize = b;
		}
		
		public function get autoSize():Boolean{
			return this._autoSize;
		}
		
		public function set text(t:String):void {
			this._text = t;
			
			if (this._text == null)
				this._text = "";
			
			this.draw();
		}
		
		public function get text():String {
			return this._text;
		}
		
		public function get textField():TextField {
			return this._tf;
		}
	
	}

}