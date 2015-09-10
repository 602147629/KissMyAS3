package justFly.view.character {
	import com.junkbyte.console.Cc;
	import com.soar.tip.Alert;
	import com.soar.tip.TipPop;
	import justFly.event.SystemStateEvent;
	import justFly.view.util.TipInforMain;
	import net.ricogaming.slot.PrehlstoricPark.View_NG;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * ... 人物狀態訊息
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	public class PlayerStatusInfoMediator extends Mediator {
		
		[Inject]
		public var view:View_NG;
		
		override public function initialize():void {
			super.initialize();
			this.addContextListener(SystemStateEvent.UPDATA_PLAYER_INFO, onUpdataPlayerInfo, SystemStateEvent);
		}
		
		private function onUpdataPlayerInfo(e:SystemStateEvent):void {
			var playerData:PlayerData = e.model.playerData;
			Cc.logch(this, " =============================================== ");
			Cc.logch(this, " || 更新人物資訊  ");
			Cc.logch(this, " =============================================== ");
			Cc.logch(this , " || Player ID : " , playerData.id);
			Cc.logch(this , " || Player Name : " ,playerData.charName);
			Cc.logch(this , " || Player LV : " , playerData.lv);
			Cc.logch(this , " || Player EXP : " , playerData.exp);
			Cc.logch(this , " || Player Money : " , playerData.money);
			Cc.logch(this , " || Player HP : " ,playerData.hp);
			Cc.logch(this, " =============================================== ");
			
			//Alert.getInstance().setAlertSize(300 , 400);
			//Alert.getInstance().setMsgTitle("PlayerInfo");
			//Alert.getInstance().show(this.view , playerData.charName , true  , 300 , 40 );
			
			TipInforMain.getInstance().show(this.view , playerData.charName  , 240 , 460 , 50 , 50);
		}
	
	}

}