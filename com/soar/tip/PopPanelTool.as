package compoment.base {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.greensock.TweenLite;
	
	/**
	 * ...
	 * @author sam
	 */
	public class PopPanelTool extends Sprite {
		private var popPanel:Bitmap = new Bitmap();
		private var closeBlock:Sprite = new Sprite();
		private var pTxtBMP:Bitmap = new Bitmap();
		private var popPanel_vct:Vector.<BitmapData> = new Vector.<BitmapData>();
		private var NUM:int;
		
		public function PopPanelTool( _popPanel_vct:Vector.<BitmapData> ):void {
			popPanel_vct = _popPanel_vct;
			viewShow();
		}
		
		private function viewShow():void {
			popPanel.bitmapData =  popPanel_vct[0];
			this.addChild(popPanel);
			closeBlock.addChild( new Bitmap(popPanel_vct[1]) );
			this.addChild( closeBlock );
			closeBlock.x = 163; closeBlock.y = 5;
			closeBlock.buttonMode = true;
			closeBlock.addEventListener("mouseOver", closeAct);
			closeBlock.addEventListener("mouseOut", closeAct);
			closeBlock.addEventListener("click", closeAct);
			
			addChild(pTxtBMP); 
		}
		
		private function closeAct( e:Event):void {
			switch(e.type) {
				case "mouseOver":
					TweenLite.to(closeBlock, 0.3, { colorTransform: { tint:0xffffff }, glowFilter: { color:0xFFFFFF, alpha:0.5, blurX:10, blurY:10 }} );
					break;
				case "click":
					this.dispatchEvent ( new GeneralEvent("popCloseX"));
					break;
				default:
					TweenLite.to(closeBlock, 0.3, { colorTransform: { tint:0  }, glowFilter: { color:0, alpha:0, blurX:0, blurY:0}} );
			}
		}
		
		public function setPanelTxt( _NUM:int):void {
			pTxtBMP.bitmapData = popPanel_vct[_NUM + 1];
			pTxtBMP.x = (popPanel.width - pTxtBMP.width) * 0.5;
			pTxtBMP.y = 18;
		}
		
	}

}