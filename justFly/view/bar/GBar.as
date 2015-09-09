package justFly.view.bar {
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	public class GBar extends Component {
		
		protected var _fBar:Shape = new Shape();
		protected var _border:Shape = new Shape();
		
		protected var _label:Label = new Label();
		protected var _labelText:String = "";
		
		protected var _percent:Number = 1;
		protected var _color:uint = 0;
		
		
		public function GBar(parent:DisplayObjectContainer = null, width:Number = 0, height:Number = 0, label:String = "", xpos:Number = 0, ypos:Number = 0) {
			super(parent, width , height , label , xpos, ypos);
			this.label = label;
		}
		
		override protected function addChildren():void {
			this.addChild(this._fBar);
			this.addChild(this._border);
			this.addChild(this._label);
		}
		
		override public function draw():void {
			super.draw();
			
			this._border.graphics.clear();
			this._border.graphics.lineStyle(0, 0xFFFFFF, 0.5, true);
			this._border.graphics.drawRoundRect(0.5, 0.5, this._width, this._height, 3, 3);
			
			this._fBar.graphics.clear();
			this._fBar.graphics.lineStyle(0, 0, 0, true);
			this._fBar.graphics.beginFill(this._color);
			
			//讓drawRoundRect抗鋸齒的最簡單的方法：讓x和y坐標為小數：
			this._fBar.graphics.drawRoundRect(0.5, 0.5, Math.max(1, this._width * this._percent), this._height, 2, 2);
			this._fBar.graphics.endFill();
				
			this.reLabelPostion();
		}
		
		//重新定義文字位置
		public function reLabelPostion():void {
			this._label.text = this._labelText;
			this._label.draw();
			
			if (this._label.width > this._width - 4) {
				this._label.width = this._width - 4;
			}
			
			this._label.draw();
			this._label.move(this._width / 2 - this._label.width / 2, this._height / 2 - this._label.height / 2);
		}
		
		public function setProgress(min:Number, max:Number):void {
			if (!isNaN(min)&& !isNaN(max) && max > 0) {
				this._percent = Math.max(0, Math.min(1, min / max));
				this._labelText = min + " / " + max;
				this._label.text = this._labelText;
				this.draw();
			}
		}
		
		public function toggleColorTransform(toggle:Boolean):void {
			var ct:ColorTransform = new ColorTransform();
			ct.redMultiplier = ct.greenMultiplier = ct.blueMultiplier = toggle ? 1 : 0.5;
			this.transform.colorTransform = ct;
			//this.filters =  [new ColorMatrixFilter([0.25, 0.25, 0.25, 0, 0, 0.25, 0.25, 0.25, 0, 0, 0.25, 0.25, 0.25, 0, 0, 0, 0, 0, 1, 0])];
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		// getter / setters
		//
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function set label(str:String):void {
			this._labelText = str;
			this.draw();
		}
		
		public function get label():String {
			return this._labelText;
		}
		
		public function get color():uint {
			return this._color;
		}
		
		public function set color(value:uint):void {
			this._color = value;
		}
		
		public function get percent():Number {
			return _percent;
		}
		
		public function set percent(value:Number):void {
			if (!isNaN(value)) {
				this._percent = value;
				this._labelText = "";
				this._label.text = this._labelText;
				this.draw();
			}
		}
		
	}

}