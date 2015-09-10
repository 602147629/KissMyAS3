package justFly.view {
	import justFly.event.BattleStateEvent;
	import net.ricogaming.slot.PrehlstoricPark.View_NG;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	
	public class BattleMainViewMediator extends Mediator {
		
		[Inject]
		public var view:View_NG;
		
		override public function initialize():void {
			super.initialize();
			
			this.addContextListener(BattleStateEvent.BATTLE_ENTER, onBattleEnter, BattleStateEvent);
		}
		
		private function onBattleEnter(e:BattleStateEvent):void {
			this.eventDispatcher.dispatchEvent(new BattleStateEvent(BattleStateEvent.BATTLE_FINISH));
		}
	
	}

}