package com.lab.tip {
	import com.soar.events.GeneralEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.greensock.TweenLite;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class PopPanelTool extends Sprite {
		private var popPanel:Bitmap = new Bitmap();
		private var closeBlock:Sprite = new Sprite();
		private var pTxtBMP:Bitmap = new Bitmap();
		private var popPanel_vct:Vector.<BitmapData> = new Vector.<BitmapData>();
		private var NUM:int;
		
		public function PopPanelTool( _popPanel_vct:Vector.<BitmapData> ):void {
			this.popPanel_vct = _popPanel_vct;
			this.viewShow();
		}
		
		private function viewShow():void {
			this.popPanel.bitmapData =  this.popPanel_vct[0];
			this.addChild(popPanel);
			this.closeBlock.addChild( new Bitmap(this.popPanel_vct[1]) );
			this.addChild( this.closeBlock );
			this.closeBlock.x = 163; this.closeBlock.y = 5;
			this.closeBlock.buttonMode = true;
			this.closeBlock.addEventListener("mouseOver", this.closeAct);
			this.closeBlock.addEventListener("mouseOut", this.closeAct);
			this.closeBlock.addEventListener("click", this.closeAct);
			
			this.addChild(this.pTxtBMP); 
		}
		
		private function closeAct( e:Event):void {
			switch(e.type) {
				case "mouseOver":
					TweenLite.to(this.closeBlock, 0.3, { colorTransform: { tint:0xffffff }, glowFilter: { color:0xFFFFFF, alpha:0.5, blurX:10, blurY:10 }} );
					break;
				case "click":
					this.dispatchEvent ( new GeneralEvent("popCloseX"));
					break;
				default:
					TweenLite.to(this.closeBlock, 0.3, { colorTransform: { tint:0  }, glowFilter: { color:0, alpha:0, blurX:0, blurY:0}} );
			}
		}
		
		public function setPanelTxt( _NUM:int):void {
			this.pTxtBMP.bitmapData = this.popPanel_vct[_NUM + 1];
			this.pTxtBMP.x = (this.popPanel.width - this.pTxtBMP.width) * 0.5;
			this.pTxtBMP.y = 18;
		}
		
	}

}