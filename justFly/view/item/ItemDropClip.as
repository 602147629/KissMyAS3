package justFly.view.item {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ItemDropClip extends Sprite {
		private var _bmp:Bitmap;
		
		public function ItemDropClip(display:DisplayObjectContainer) {
			var bmpd:BitmapData = new BitmapData(display.width, display.height, true, 0x000000);
			bmpd.draw(display);
			
			_bmp = new Bitmap();
			_bmp.bitmapData = bmpd;
			this.addChild(_bmp);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void {
			this.startDrag();
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			this.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		private function mouseMoveHandler(e:MouseEvent):void {
			e.updateAfterEvent();
		}
		
		private function onMouseUp(e:MouseEvent):void {
			this.stopDrag();
			this.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			this.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
	
	}

}