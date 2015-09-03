package soar.poker {
	import common.EventFactory;
	import common.IEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import libs.display.ChristianColorTransform;
	
	/**
	 * ...
	 * @author Christian
	 */
	public class Poker extends MovieClip {
		private var _poker:MovieClip;
		private var _pokerClass:Class;
		
		private var _oriWidth:Number;
		
		private var _oriHeight:Number;
		
		//private var _pokerNum:String;
		private var _pokerNum:int;
		
		private var _frameCount:Number;
		
		private var _totalFrame:int = 18;
		
		private var _container:MovieClip;
		
		private var _index:int;
		
		public function Poker(container:MovieClip, index:int, lnkPoker:Class) {
			this._container = container;
			this._index = index;
			this._pokerClass = lnkPoker;
			this._poker = new this._pokerClass as MovieClip;
			this._container.addChild(this._poker);
		}
		
		public function addEvent():void {
			this._poker.buttonMode = true;
			EventFactory.getInstance().addEvent(this._poker, MouseEvent.MOUSE_OVER, onPokerOver);
			EventFactory.getInstance().addEvent(this._poker, MouseEvent.MOUSE_OUT, onPokerOut);
			EventFactory.getInstance().addEvent(this._poker, MouseEvent.MOUSE_DOWN, onPokerDown);
		}
		
		public function delEvent():void {
			this._poker.buttonMode = false;
			EventFactory.getInstance().delEventFn(this._poker, MouseEvent.MOUSE_OVER, onPokerOver);
			EventFactory.getInstance().delEventFn(this._poker, MouseEvent.MOUSE_OUT, onPokerOut);
			EventFactory.getInstance().delEventFn(this._poker, MouseEvent.MOUSE_DOWN, onPokerDown);
		}
		
		private function onPokerDown(e:MouseEvent):void {
			ChristianColorTransform.setBright(e.currentTarget as MovieClip, 0);
			this.dispatchEvent(new IEvent("PokerDown", [this._index]));
		}
		
		private function onPokerOut(e:MouseEvent):void {
			ChristianColorTransform.setBright(e.currentTarget as MovieClip, 0);
		}
		
		private function onPokerOver(e:MouseEvent):void {
			ChristianColorTransform.setBright(e.currentTarget as MovieClip, 50);
		}
		
		/**
		 * 顯示牌  牌背為BB
		 * @param	pokerNum
		 */
		public function showPoker(pokerNum:int):void {
			if (this._poker == null) {
				//this._poker = new this._pokerClass as MovieClip;
				this._container.addChild(this._poker);
				this._oriWidth = this._poker.width;
				this._oriHeight = this._poker.height;
			}
			this._pokerNum = pokerNum
			this._poker.gotoAndStop(this._pokerNum);
			this._poker.scaleX = 1;
			this._poker.scaleY = 1;
			this._poker.height = this._oriHeight;
			this._poker.width = this._oriWidth
			this._poker.transform.colorTransform = new ColorTransform(1, 1, 1, 1);
		}
		
		/**
		 * 移除牌
		 */
		public function hidePoker():void {
			if (this._poker == null)
				return;
			
			this._container.removeChild(this._poker);
			this._poker = null;
			EventFactory.getInstance().delEventFn(this._poker, Event.ENTER_FRAME, onFlipToMiddle);
			EventFactory.getInstance().delEventFn(this._poker, Event.ENTER_FRAME, onFlipToEnd);
		}
		
		/**
		 * 翻牌
		 * @param	pokerNum
		 */
		public function flipPoker(pokerNum:int):void {
			//trace( "翻牌 : " + pokerNum );
			if (this._poker == null)
				return;
			this._frameCount = 1;
			this._pokerNum = pokerNum;
			EventFactory.getInstance().addEvent(this._poker, Event.ENTER_FRAME, onFlipToMiddle);
		}
		
		private function onFlipToMiddle(evt:Event):void {
			this._poker.height *= 1.05;
			this._frameCount *= 2.5;
			var dis:Number = this._oriHeight / this._poker.height;
			
			if (this._frameCount >= _totalFrame)
				this._frameCount = _totalFrame
			
			this._poker.scaleX = (_totalFrame - this._frameCount) / _totalFrame;
			this._poker.transform.colorTransform = new ColorTransform(dis, dis, dis, 1);
			if (this._frameCount >= _totalFrame) {
				this._frameCount = 1;
				this._poker.gotoAndStop(this._pokerNum);
				this.dispatchEvent(new IEvent("FlipToMiddle"));
				EventFactory.getInstance().delEventFn(this._poker, Event.ENTER_FRAME, onFlipToMiddle);
				EventFactory.getInstance().addEvent(this._poker, Event.ENTER_FRAME, onFlipToEnd);
			}
		}
		
		private function onFlipToEnd(evt:Event):void {
			this._poker.height *= 0.95;
			this._frameCount *= 2.5;
			var dis:Number = this._oriHeight / this._poker.height;
			
			this._poker.scaleX = this._frameCount / _totalFrame;
			this._poker.transform.colorTransform = new ColorTransform(dis, dis, dis, 1);
			
			if (this._frameCount >= _totalFrame) {
				this.showPoker(this._pokerNum);
				if (this._frameCount >= _totalFrame * 2.5) {
					this.dispatchEvent(new IEvent("FlipEnd", [this._index]));
					EventFactory.getInstance().delEventFn(this._poker, Event.ENTER_FRAME, onFlipToEnd);
				}
			}
		}
		
		public function get poker():MovieClip {
			return this._poker;
		}
		
		public function onExit():void {
			this.delEvent();
			this.hidePoker();
			this._pokerClass = null;
			this._container = null;
		}
	
	}

}