package justFly.controller {
	import justFly.event.SystemStateEvent;
	import justFly.model.GameSharedObject;
	import justFly.view.character.PlayerData;
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.framework.api.ILogger;
	
	/**
	 * ...
	 * @author sam
	 */
	public class GameRecordCommand extends Command {
		
		[Inject]
		public var logger:ILogger;
		
		[Inject]
		public var event:SystemStateEvent;
		
		[Inject]
		public var gso:GameSharedObject;
		
		override public function execute():void {
			super.execute();
			
			switch(event.type) {
				case SystemStateEvent.SAVE_RECORD:
					this.gso.saveData(event.model.playerData);
					break;
				case SystemStateEvent.LOAD_RECORD:
					this.gso.loadData();
					break;
			}
		}
		
	}

}