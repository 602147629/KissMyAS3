package justFly.controller {
	import flash.events.IEventDispatcher;
	import justFly.event.BattleStateEvent;
	import robotlegs.bender.bundles.mvcs.Command;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	
	public class BattleStateCommand extends Command {
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		[Inject]
		public var event:BattleStateEvent;
		
		public function BattleStateCommand() {
			super();
		}
		
		override public function execute():void {
			super.execute();
			
			switch (event.type) {
				case BattleStateEvent.BATTLE_ENTER:
					eventDispatcher.dispatchEvent(new BattleStateEvent(BattleStateEvent.CREATE_MONSTER));
					break;
				case BattleStateEvent.BATTLE_READY:
					eventDispatcher.dispatchEvent(new BattleStateEvent(BattleStateEvent.BATTLE_FIGHT));
					break;
			}
		}
	
	}

}