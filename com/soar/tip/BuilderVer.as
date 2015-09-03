package com.soar.tip {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.filters.DropShadowFilter;
	import flash.system.Capabilities;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * 建造版本編號
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/5/2 下午 02:19
	 * @version	：1.0.12
	 */
	
	public class BuilderVer extends Sprite {
		private var _stage:Stage;
		
		private var ver_tf:TextField;
		private var playerVersion:TextField;
		private var osVersion:TextField;
		private var ver_fmt:TextFormat;
		private var StrokeDropFilter:DropShadowFilter;
		
		private static var instance:BuilderVer;
		public static function getInstance():BuilderVer {return (instance ||= new BuilderVer);}
		public function BuilderVer() { if (instance) { throw new Error("Use BuilderVer.getInstance()"); }}
		
		public function init():void {
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.tabChildren = false;
			this.tabEnabled = false;
			
			this.ver_fmt = new TextFormat("Arial", 8, 0xe1e88c);
			this.ver_fmt.letterSpacing = 1.6180339887498948482045868343656381177203091798057628621354486227052604628189024497072072041893911374;
			
			this.ver_tf = new TextField();
			this.ver_tf.defaultTextFormat = this.ver_fmt;
			this.ver_tf.selectable = false;
			this.ver_tf.mouseEnabled = false;
			this.ver_tf.tabEnabled = false;
			
			this.ver_tf.autoSize = TextFieldAutoSize.LEFT;
			this.ver_tf.antiAliasType = AntiAliasType.ADVANCED;
			
			//描邊效果
			StrokeDropFilter = new DropShadowFilter(1, 45, 0x000000, 1, 2, 2, 10, 1, false, false);
		}
		
		/**
		 * 輸出版本號
		 * @param	parent	:	上層容器
		 * @param	_msg	:	版本號
		 * @param	posX	: 	X座標
		 * @param	posY	:	Y座標
		 */
		public function echo( stage:Stage , _msg:String = "未輸入版本號!" ):void {
			this._stage = stage;
			this._stage.addChild(this);
			
			this.ver_tf.text = "V." + _msg;
			this.ver_tf.filters = [StrokeDropFilter];
			this.addChild(this.ver_tf);
			
			this.ver_tf.x = this._stage.stageWidth - this.ver_tf.width;
			this.ver_tf.y = this._stage.stageHeight - this.ver_tf.height;
		}
		
		/**
		 * 查看本地FlashPlayer版本
		 */
		public function echoPlayerVersion():void {
			this.playerVersion = new TextField();
			this.playerVersion.defaultTextFormat = ver_fmt;
			this.playerVersion.text = Capabilities.version;
		}
		
		/**
		 * 查看本地作業系統
		 */
		public function echoLocalOS():void {
			this.osVersion = new TextField();
			this.osVersion.defaultTextFormat = ver_fmt;
           this. osVersion.text = Capabilities.os;
		}
		
		
		private function draw():void {
			var bmpD:BitmapData = new BitmapData( ver_tf.width , ver_tf.height , true , 0x000000 );
			bmpD.draw(ver_tf);
			this.graphics.beginBitmapFill(bmpD);
			this.graphics.drawRect( 0 , 0 , bmpD.width , bmpD.height);
			this.cacheAsBitmap = true;
		}
		
	}

}