package justFly.view {
	import com.junkbyte.console.Cc;
	import com.soar.tip.Alert;
	import com.soar.ui.component.PushButton;
	import flash.events.MouseEvent;
	import justFly.event.BattleStateEvent;
	import justFly.event.SystemStateEvent;
	import justFly.view.character.lvUp.LvUp;
	import justFly.view.character.PlayerData;
	import net.ricogaming.slot.PrehlstoricPark.View_NG;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	
	public class MainViewMediator extends Mediator {
		
		[Inject]
		public var view:View_NG;
		
		[inject]
		private var _contextView:ContextView;
		
		override public function initialize():void {
			super.initialize();
			
			var loadBtn:PushButton = new PushButton(this.view, 120, 19, "Load Record ", 10, 0, onLoadRecordHandler);
			var saveBtn:PushButton = new PushButton(this.view, 120, 19, "Save Record ", 10, 30, onSaveRecordHandler);
			var battle:PushButton = new PushButton(this.view, 120, 19, "Battle", 10, 60, onBattleFightHandler);
		}
		
		private function onBattleFightHandler(e:MouseEvent):void {
			Cc.logch(" LV : " , LvUp.getInstance().getUpLv(5 , 5000 , 100));
			eventDispatcher.dispatchEvent(new BattleStateEvent(BattleStateEvent.BATTLE_ENTER));
		}
		
		private function onSaveRecordHandler(e:MouseEvent):void {
			eventDispatcher.dispatchEvent(new SystemStateEvent(SystemStateEvent.SAVE_RECORD));
		}
		
		private function onLoadRecordHandler(e:MouseEvent):void {
			eventDispatcher.dispatchEvent(new SystemStateEvent(SystemStateEvent.LOAD_RECORD) );
		}
	
	}

}