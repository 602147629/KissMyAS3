package justFly.view.master {
	import com.junkbyte.console.Cc;
	import flash.text.TextFormat;
	import justFly.event.SystemStateEvent;
	import justFly.view.bar.GBar;
	import justFly.view.bar.Label;
	import justFly.view.character.lvUp.LvUp;
	import justFly.view.character.PlayerData;
	import net.ricogaming.slot.BustyBabies.View_NG;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * ...
	 * @author sam
	 */
	public class MasterMediator extends Mediator {
		
		[Inject]
		public var view:View_NG;
		
		private var _expBar:GBar;
		
		private var _masterInfo:MasterInformation;
		
		private var _energyBar:GBar;
		
		private var _lvLabel:Label;
		private var _goldLabel:Label;
		private var _moneyLabel:Label;
		
		override public function initialize():void {
			super.initialize();
			
			this._expBar = new GBar(this.view, 140, 13, "0 / 0", 140, 40);
			this._expBar.color = 0x339922;
			this._expBar.ellipse = 10;
			this._expBar.label.textField.defaultTextFormat = new TextFormat("Verdana", 9, 16777215);
			
			this._energyBar = new GBar(this.view, 90, 13, "0 / 0" , 290, 40);
			this._energyBar.color = 0x3366FF;
			this._energyBar.ellipse = 10;
			this._energyBar.label.textField.defaultTextFormat = new TextFormat("Verdana", 9, 16777215);
			
			this._lvLabel = new Label(this.view , 100 , 20 , "LV : 0" , 140 , 26 );
			this._goldLabel = new Label(this.view , 100 , 20 , "Gold : 0 ", 390 , 20 );
			this._moneyLabel = new Label(this.view , 100 , 20 , "Money : 0 " , 390 , 36 );
			
			this.addContextListener(SystemStateEvent.UPDATA_PLAYER_INFO, onUpdataPlayerInfo, SystemStateEvent);
		}
		
		private function onUpdataPlayerInfo(e:SystemStateEvent):void {
			this._masterInfo = e.model.masterInfo;
			Cc.logch(this, " =============================================== ");
			Cc.logch(this, " || 更新人物資訊  ");
			Cc.logch(this, " =============================================== ");
			Cc.logch(this , " || Master ID     	: " , this._masterInfo.uniqueId);
			Cc.logch(this , " || CharName   	: " , this._masterInfo.charName);
			Cc.logch(this , " || Lv                	: " , this._masterInfo.lv);
			Cc.logch(this , " || Exp              	: " , this._masterInfo.exp);
			Cc.logch(this , " || NextExp     	: " , this._masterInfo.nextLvExp);
			Cc.logch(this , " || Money         	: " , this._masterInfo.money);
			Cc.logch(this , " || GoldNum      	: " , this._masterInfo.goldNum);
			Cc.logch(this , " || MinEnergy    	: " , this._masterInfo.minEnergy);
			Cc.logch(this , " || MaxEnergy   	: " , this._masterInfo.maxEnergy);
			Cc.logch(this, " =============================================== ");
			
			this._expBar.setProgress(this._masterInfo.exp, this._masterInfo.nextLvExp);
			this._energyBar.setProgress(this._masterInfo.minEnergy, this._masterInfo.maxEnergy);
			this._lvLabel.text = "LV : " + this._masterInfo.lv.toString();
			this._goldLabel.text = "Gold :" + this._masterInfo.goldNum.toString();
			this._moneyLabel.text = "Money : " + this._masterInfo.money.toString();
			
			var lv:int = LvUp.getInstance().getUpLv(this._masterInfo.lv , 20 , this._masterInfo.exp);
			Cc.logch(this , " || LV UP   	: " , lv);
		}
	
	}

}