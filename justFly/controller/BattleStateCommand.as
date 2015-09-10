package justFly.controller {
	import com.junkbyte.console.Cc;
	import com.soar.tip.TipPop;
	import flash.events.IEventDispatcher;
	import justFly.event.BattleStateEvent;
	import justFly.event.SystemStateEvent;
	import justFly.model.GameModel;
	import justFly.view.character.lvUp.LvUp;
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
		
		[Inject]
		public var model:GameModel;
		
		public function BattleStateCommand() {
			super();
		}
		
		override public function execute():void {
			super.execute();
			
			Cc.logch(this, " =============================================== ");
			Cc.logch( this , " || BattleStateEvent : " + event.type );
			Cc.logch(this, " =============================================== ");
			
			switch (event.type) {
				case BattleStateEvent.BATTLE_ENTER:
					Cc.logch(this, " =============================================== ");
					Cc.logch(this , " || 進入戰鬥 !! " );
					Cc.logch(this, " =============================================== ");
					//eventDispatcher.dispatchEvent(new BattleStateEvent(BattleStateEvent.CREATE_MONSTER));
					break;
				case BattleStateEvent.BATTLE_READY:
					//eventDispatcher.dispatchEvent(new BattleStateEvent(BattleStateEvent.BATTLE_FIGHT));
					break;
				case BattleStateEvent.BATTLE_FINISH:
					this.model.playerData.exp += int(Math.random() * 1000);
					this.model.playerData.money += int(Math.random() * 1000);
					Cc.logch(this, " =============================================== ");
					Cc.logch(this , " || Victory 戰勝 || " );
					Cc.logch(this, " ------------------------------------------------------------------------------------- ");
					Cc.logch(this , " || EXP : "  , this.model.playerData.exp);
					Cc.logch(this , " || MONEY : " , this.model.playerData.money );
					Cc.logch(this, " =============================================== ");
					eventDispatcher.dispatchEvent(new SystemStateEvent(SystemStateEvent.SAVE_RECORD));
					break;
				case BattleStateEvent.BATTLE_LOSE:
					Cc.logch(this, " =============================================== ");
					Cc.logch(this , " || 戰鬥失敗 !! " );
					Cc.logch(this, " =============================================== ");
					eventDispatcher.dispatchEvent(new SystemStateEvent(SystemStateEvent.SAVE_RECORD));
					break;
			}
		}
	
	}

}