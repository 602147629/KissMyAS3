package justFly.view.bar {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import justFly.event.BattleStateEvent;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	
	public class TimerBar extends Sprite {
		private var _aspd:Number = 0;//Attack Speed
		private var _ATime:Number = 1.0;//Attack Time
		private var _intervalID:uint;
		
		public function TimerBar() {
			this.graphics.beginFill(0x009900, 1);
			this.graphics.lineStyle(1, 0xffffff, 1);
			this.graphics.drawRect(0, 0, 0, 7)
		}
		
		public function draw():void {
			clearTimeout(this._intervalID);
			
			this._ATime = this._aspd + arguments[0];
			this.graphics.beginFill(0x009900, 1);
			this.graphics.lineStyle(1, 0xffffff, 1);
			this.graphics.drawRect(0, 0, this._ATime + this._aspd, 7);
			
			if (arguments[0] < 100) {
				this._intervalID = setTimeout(this.draw, this._ATime + this._aspd, this._ATime + this._aspd);
			} else {
				this.drawFinal();
			}
		}
		
		public function drawStart():void {
			this._intervalID = setTimeout(this.draw, 1000, this._ATime);
		}
		
		public function drawStop():void {
			//trace( "justFly.view.bar.TimerBar.drawStop" );
			this.graphics.clear();
			this.graphics.beginFill(0x009900, 1);
			this.graphics.lineStyle(1, 0xffffff, 1);
			this.graphics.drawRect(0, 0, this._ATime, 7)
		}
		
		public function drawFinal():void {
			trace( "justFly.view.bar.TimerBar.drawFinal : " + this._ATime );
			this.graphics.clear();
			this.graphics.beginFill(0x009900, 0);
			//this.graphics.lineStyle(1, 0xffffff, 1);
			this.graphics.drawRect(0, 0, this._ATime, 7);
			this.dispatchEvent(new BattleStateEvent(BattleStateEvent.ATTACK_TIME_UP, [this.name]));
		}
		
		public function set aspd(val:Number):void {
			this._aspd = val;
		}
	
	}

}