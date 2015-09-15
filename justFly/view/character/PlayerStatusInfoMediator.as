package justFly.view.character {
	import com.junkbyte.console.Cc;
	import com.soar.tip.Alert;
	import com.soar.tip.TipPop;
	import justFly.event.SystemStateEvent;
	import justFly.utility.TipInforMain;
	import justFly.view.master.MasterInformation;
	import net.ricogaming.slot.BustyBabies.View_NG;
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
		}
		
		private function onUpdataPlayerInfo(e:SystemStateEvent):void {
		}
	
	}

}