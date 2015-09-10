package justFly.controller {
	import com.junkbyte.console.Cc;
	import flash.events.IEventDispatcher;
	import justFly.event.SystemStateEvent;
	import justFly.model.GameModel;
	import justFly.model.GameSharedObject;
	import justFly.view.character.PlayerData;
	import justFly.view.util.JustFightUtil;
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.framework.api.ILogger;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	public class GameRecordCommand extends Command {
		
		[Inject]
		public var logger:ILogger;
		
		[Inject]
		public var event:SystemStateEvent;
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		[Inject]
		public var gso:GameSharedObject;
		
		[Inject]
		public var model:GameModel;
		
		override public function execute():void {
			super.execute();
			
			Cc.logch(this, " =============================================== ");
			Cc.logch(this , " || SystemStateEvent : " + event.type );
			Cc.logch(this, " =============================================== ");
			
			switch(event.type) {
				case SystemStateEvent.SAVE_RECORD:
					Cc.logch(this, " =============================================== ");
					Cc.logch(this, " || 儲存遊戲進度  ");
					Cc.logch(this, " =============================================== ");
					this.gso.saveData( this.model.playerData);
					break;
					
				case SystemStateEvent.LOAD_RECORD:
					Cc.logch(this, " =============================================== ");
					Cc.logch(this, " || 讀取遊戲進度  ");
					Cc.logch(this, " =============================================== ");
					this.gso.checkKey()? this.gso.create():this.gso.newPlayer();
					this.model.playerData = this.gso.playerData;
					this.gso.saveData( this.model.playerData);
					this.eventDispatcher.dispatchEvent(new SystemStateEvent(SystemStateEvent.UPDATA_PLAYER_INFO , ({playerData:this.model.playerData})));
					break;
			}
		}
		
	}

}