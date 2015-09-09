package justFly.view {
	import com.soar.ui.component.PushButton;
	import flash.events.MouseEvent;
	import justFly.event.BattleStateEvent;
	import justFly.event.SystemStateEvent;
	import justFly.view.character.PlayerData;
	import net.ricogaming.slot.PrehlstoricPark.View_NG;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	/**
	 * ...
	 * @author sam
	 */
	public class ViewMainMediator extends Mediator {
		[Inject]
		public var view:View_NG;
		
		[inject]
		private var _contextView:ContextView;
		
		override public function initialize():void {
			super.initialize();
			
			//var Battle:PushButton = new PushButton(this.view, 120, 19, "Battle", 10, 4, onBattleFightHandler);
			//var nextRound:PushButton = new PushButton(this.view, 120, 19, "Next Round ", 10, 34, onNextRoundHandler);
			
			var saveBtn:PushButton = new PushButton(this.view, 120, 19, "Save Record ", 10, 34, onSaveRecordHandler);
		}
		
		private function onNextRoundHandler(e:MouseEvent):void {
			eventDispatcher.dispatchEvent(new BattleStateEvent(BattleStateEvent.BATTLE_NEXT_ROUND));
		}
		
		public function onBattleFightHandler(e:MouseEvent):void {
			eventDispatcher.dispatchEvent(new BattleStateEvent(BattleStateEvent.BATTLE_ENTER));
		}
		
		public function onSaveRecordHandler(e:MouseEvent):void {
			var playerData:PlayerData = new PlayerData();
			playerData.id = 9527;
			playerData.charName = "莫小邪";
			playerData.lv = 54;
			playerData.exp = 522954;
			playerData.money = 98989898;
			
			eventDispatcher.dispatchEvent(new SystemStateEvent(SystemStateEvent.SAVE_RECORD , {playerData:playerData}));
		}
	
	}

}