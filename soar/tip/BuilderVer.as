package com.soar.tip {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/5/2 下午 02:19
	 * @version	：1.0.12
	 */
	
	public class BuilderVer extends Sprite {
		private var ver_tf:TextField = new TextField();
		private var ver_fmt:TextFormat = new TextFormat("Arial", 9, 0xe9daba);
		
		public function BuilderVer( parent:DisplayObjectContainer = null ) {
			parent.addChild(ver_tf);
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			ver_fmt.letterSpacing = 2;
			ver_tf.defaultTextFormat = ver_fmt;
			ver_tf.selectable = false;
			ver_tf.autoSize = TextFieldAutoSize.LEFT;
			ver_tf.text = "";
		}
		
		public function showVer( msg:String ):void {
			ver_tf.text = "Builder.Ver " + msg;
		}
		
	}

}