package com.soar.tip {
	import com.soar.events.GeneralEvent;
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
	 * 警告視窗
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
		
		/** 	視窗標題	**/
		private var messageTitleStr:String = "";
		private var mesage_tf:TextField ;
		private var message_fmt:TextFormat;
		
		/** 	彈出視窗大小	**/
		private var _msgW:int;
		private var _msgH:int;
		
		/** 	場景大小 	**/
		private var _alertWidth:int;
		private var _alertHeight:int;
		
		/** 是否派發事件	**/
		private var _isEvent:Boolean = false;
		
		private static var _alert:Alert;
		
		public function Alert( ) {
		}
		
		public static function getInstance():Alert {
			if ( _alert == null) _alert = new Alert();
			return _alert;
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////
		//	Public Method
		//////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 設定場景大小
		 * @param	width	:	int
		 * @param	height	:	int
		 */
		public function setAlertSize( width:int , height:int ):void {
			this._alertWidth = width;
			this._alertHeight = height;
		}
		
		/**
		 * 設定彈出窗大小
		 * @param	width	:	int
		 * @param	height	:	int
		 */
		public function setMsgSize(width:int , height:int ):void {
			this._msgW = width;
			this._msgH = height;
		}
		
		/**
		 * 設定視窗標題
		 * @param	str
		 */
		public function setMsgTitle( str:String ):void {
			this.messageTitleStr = str;
		}
		
		/**
		 * 顯示警告視窗
		 * @param	_parent	上層容器
		 * @param	_msg		顯示文字內容
		 * @param	isEvent		事件開啟並開起按鈕
		 * @param	_width		警告窗體寬
		 * @param	_height	警告窗體高
		 */
		public function show( _parent:DisplayObjectContainer = null  , _msg:String = null , isEvent:Boolean = false , _width:int = 0 , _height:int = 0 ):void {
			this.obj = _parent;
			this.obj.addChild(this);
			this.msg = _msg;
			this._isEvent = isEvent;
			
			if (_width != 0  && _height != 0) {
				this._msgW = _width;
				this._msgH = _height;
			} 
			
			this.message( _msgW , _msgH );
			
			this.bmpD = new BitmapData( _alertWidth , _alertHeight , false , 0x000000);
			this.bmp = new Bitmap(this.bmpD);
			this.bmp.alpha = 0.6;
			this.addChild(this.bmp);
			
			this.msg_Tf = new TextField();
			this.msg_fmt = new TextFormat("微軟正黑體", 20, 0xcc0000, true, null, null, null, null, "center");
			this.msg_fmt.letterSpacing = 2;
			this.msg_Tf.defaultTextFormat = msg_fmt;
			this.msg_Tf.selectable = false;
			this.msg_Tf.mouseEnabled = false;
			this.msg_Tf.autoSize = TextFieldAutoSize.CENTER;
			this.msg_Tf.antiAliasType = AntiAliasType.ADVANCED;
			this.msg_Tf.text = this.msg;
			this.msg_Tf.width = 400;
			this.addChild(this.msg_Tf);
			this.msg_Tf.x = (_alertWidth - this.msg_Tf.width) * 0.5;
			this.msg_Tf.y = (_alertHeight - this.msg_Tf.height) * 0.5-10;
			
			if (this._isEvent) {
				this.enterBtn = new PushButton(this  , 70 , 26 , "确定" , 0, 0 , this.closeShowHandler );
				this.addChild(this.enterBtn);
				this.enterBtn.x = (_alertWidth - this.enterBtn.width) * 0.5;
				this.enterBtn.y = (_alertHeight - this.enterBtn.height) * 0.5 +46;
				this.enterBtn.addEventListener( MouseEvent.CLICK , this.closeShowHandler);
			}
			
		}
		
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////
		//	Private Method
		//////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function message( _width:int , _height:int ):void {
			this.msgBox = new Sprite();
			this.msgBox.graphics.lineStyle(1, 0x333333);
			this.matrix.createGradientBox(_width, _height, 90 / 180 * Math.PI, 0, 0);
			this.msgBox.graphics.beginGradientFill( fillType , colors , alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
			//讓drawRoundRect抗鋸齒的最簡單的方法：讓x和y坐標為小數：
			this.msgBox.graphics.drawRoundRect(0.5, 0.5, _width, _height, ellipse, ellipse);
			this.msgBox.graphics.moveTo(0 , 30);
			this.msgBox.graphics.lineTo(_width , 30);
			this.addChild(msgBox);
			this.msgBox.x = (_alertWidth - _width) * 0.5;
			this.msgBox.y = (_alertHeight - _height) * 0.5;
			//msgBox.alpha = 0.8;
			
			var shadow:DropShadowFilter = new DropShadowFilter();
			shadow.distance = 1;
			shadow.angle = 16;
			this.msgBox.filters = [shadow];
			
			this.mesage_tf = new TextField();
			this.message_fmt = new TextFormat("微軟正黑體", 20, 0xdddddd, true, null, null, null, null, "center");
			this.message_fmt.letterSpacing = 2;
			this.mesage_tf.defaultTextFormat = this.message_fmt;
			this.mesage_tf.selectable = false;
			this.mesage_tf.mouseEnabled = false;
			this.mesage_tf.autoSize = TextFieldAutoSize.CENTER;
			this.mesage_tf.antiAliasType = AntiAliasType.ADVANCED;
			
			if (this.messageTitleStr != "") {
				this.mesage_tf.text = this.messageTitleStr;
				this.mesage_tf.x = (_alertWidth - this.mesage_tf.width)*0.5;
				this.mesage_tf.y = this.msgBox.y;
				this.mesage_tf.filters = [shadow];
				this.addChild(this.mesage_tf);
			}
		}
		
		/**	自己銷毀 **/
		private function closeShowHandler(e:MouseEvent ):void {
			if( this._isEvent ) {
				this.dispatchEvent( new GeneralEvent("ALERT_ENTER_EVENT" ));
			}
			
			this.kill();
		}
		
		private function kill():void {
			if (this.enterBtn) {
				this.enterBtn.removeEventListener( MouseEvent.CLICK , this.closeShowHandler);
				this.removeChild(this.enterBtn);
				this.enterBtn = null;
			}
			
			this.removeChild(this.msg_Tf);
			this.bmpD.dispose();
			this.bmpD = null;
			this.removeChild(this.bmp);
			this.removeChild(this.mesage_tf);
			this.removeChild(this.msgBox);
			
			this.msg_Tf = null;
			this.msg_fmt = null;
			this.msg = null;
			
			this.bmp = null;
			this.mesage_tf = null;
			this.message_fmt = null;
			this.msgBox.filters = null;
			this.msgBox = null;
			
			this.obj.removeChild(this);
			this.obj = null;
		}
		
	}

}