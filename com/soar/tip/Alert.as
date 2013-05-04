package com.soar.tip {
	import com.soar.ui.PushButton;
	import com.soar.ui.Style;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/5/6 下午 02:56
	 * @version	：1.0.12
	 */
	
	public class Alert extends Sprite {
		private var msg:String;
		private var msg_fmt:TextFormat;
		private var bmp:Bitmap;
		private var bmpD:BitmapData;
		private var msg_Tf:TextField;
		private var enterBtn:PushButton;
		private var obj:DisplayObjectContainer;
		
		private var msgBox:Sprite;
		
		public function Alert( ) {
		}
		
		//beginGradientFill
		private var fillType:String = GradientType.LINEAR;
		private var alphas:Array = [1, 1 , 1 ,1 ,  1];
		private var ratios:Array = [ 0, 4 , 41,42 ,255];
		private var colors:Array = [0x787878 , 0x484848 , 0x252525 , 0x959699, 0x515359]
		private var matrix:Matrix = new Matrix();
		private var spreadMethod:String = "reflect";
		private var interpolationMethod:String = "LINEAR_RGB";
		private var focalPointRatio:Number = 1;
		private var ellipse:int = 10;
		
		private var messageTitleStr:String = "Message";
		private var mesage_tf:TextField = new TextField();
		private var message_fmt:TextFormat;
		
		private function message():void {
			msgBox = new Sprite();
			msgBox.graphics.lineStyle(1, 0x333333);
			matrix.createGradientBox(420, 180, 90 / 180 * Math.PI, 0, 0);
			msgBox.graphics.beginGradientFill( fillType , colors , alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
			//讓drawRoundRect抗鋸齒的最簡單的方法：讓x和y坐標為小數：
			msgBox.graphics.drawRoundRect(0.5, 0.5, 420, 180, ellipse, ellipse);
			msgBox.graphics.moveTo(0 , 30);
			msgBox.graphics.lineTo(420 , 30);
			addChild(msgBox);
			msgBox.x = (990 - 420) * 0.5;
			msgBox.y = (600 - 180) * 0.5;
			//msgBox.alpha = 0.8;
			
			var shadow:DropShadowFilter = new DropShadowFilter();
			shadow.distance = 1;
			shadow.angle = 16;
			msgBox.filters = [shadow];
			
			message_fmt = new TextFormat("微軟正黑體", 20, 0xdddddd, true, null, null, null, null, "center");
			message_fmt.letterSpacing = 2;
			mesage_tf.defaultTextFormat = message_fmt;
			mesage_tf.selectable = false;
			mesage_tf.mouseEnabled = false;
			mesage_tf.autoSize = TextFieldAutoSize.CENTER;
			mesage_tf.antiAliasType = AntiAliasType.ADVANCED;
			mesage_tf.text = messageTitleStr;
			mesage_tf.x = (990-mesage_tf.width)*0.5;
			mesage_tf.y = msgBox.y;
			mesage_tf.filters = [shadow];
			addChild(mesage_tf);
			
		}
		public function show( _parent:DisplayObjectContainer = null  , _msg:String = null):void {
			this.obj = _parent;
			this.obj.addChild(this);
			this.msg = _msg;
			
			message();
			
			bmpD = new BitmapData( obj.width , obj.height , false , 0x000000);
			bmp = new Bitmap(bmpD);
			bmp.alpha = 0.6;
			this.addChild(bmp);
			
			msg_Tf = new TextField();
			msg_fmt = new TextFormat("微軟正黑體", 20, 0xcc0000, true, null, null, null, null, "center");
			msg_fmt.letterSpacing = 2;
			msg_Tf.defaultTextFormat = msg_fmt;
			msg_Tf.selectable = false;
			msg_Tf.mouseEnabled = false;
			msg_Tf.autoSize = TextFieldAutoSize.CENTER;
			msg_Tf.antiAliasType = AntiAliasType.ADVANCED;
			msg_Tf.text = msg;
			msg_Tf.width = 400;
			addChild(msg_Tf);
			msg_Tf.x = (990 - msg_Tf.width) * 0.5;
			msg_Tf.y = (600 - msg_Tf.height) * 0.5-10;
			
			enterBtn = new PushButton(this  , 70 , 26 , "確定" , 0, 0 , closeShowHandler );
			addChild(enterBtn);
			enterBtn.x = (990 - enterBtn.width) * 0.5;
			enterBtn.y = (600 - enterBtn.height) * 0.5 +46;
		}
		
		private function closeShowHandler(e:MouseEvent ):void {
			removeEventListener( MouseEvent.CLICK , closeShowHandler);
			
			removeChild(enterBtn);
			
			enterBtn = null;
			
			removeChild(msg_Tf);
			msg_Tf = null;
			msg_fmt = null;
			msg = null;
			
			bmpD.dispose();
			bmpD = null;
			
			removeChild(bmp);
			bmp = null;
			
			this.obj = null;
			
			removeChild(mesage_tf);
			mesage_tf = null;
			message_fmt = null;
			msgBox.filters = null;
			removeChild(msgBox);
			msgBox = null;
		}
		
	}

}