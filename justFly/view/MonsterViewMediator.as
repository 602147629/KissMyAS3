package justFly.view {
	import com.junkbyte.console.Cc;
	import com.traceFight.PlayerData2;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import justFly.event.BattleStateEvent;
	import justFly.view.bar.HPGBar;
	import justFly.view.bar.TimerBar;
	import net.ricogaming.slot.BustyBabies.View_NG;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	
	public class MonsterViewMediator extends Mediator {
		
		[Inject]
		public var view:View_NG;
		
		private var _monsterAmount:int = 0;
		private var _moster_vct:Vector.<PlayerData2> = new Vector.<PlayerData2>();
		private var _hero:PlayerData2;
		
		private var _intervalID:uint;
		
		private var _TB_vct:Vector.<TimerBar> = new Vector.<TimerBar>();
		
		private var _heroHPBar:HPGBar;
		
		override public function initialize():void {
			super.initialize();
			
			this.addContextListener(BattleStateEvent.CREATE_MONSTER, onCreateMonsterHandler, BattleStateEvent);
			this.addContextListener(BattleStateEvent.BATTLE_FIGHT, onBattleFightHandler, BattleStateEvent);
			this.addContextListener(BattleStateEvent.BATTLE_NEXT_ROUND, onNextRoundHandler, BattleStateEvent);
		}
		
		private function onCreateMonsterHandler(e:BattleStateEvent):void {
			this._monsterAmount = (Math.random() * 4) + 3;
			this.createEnemy(this._monsterAmount);
		}
		
		private function createEnemy(amount:int):void {
			Cc.log("createEnemy : " + amount);
			var i:int = 0;
			
			for (i = 0; i < amount; i++) {
				var tmp:PlayerData2 = new PlayerData2();
				tmp.IDNum = ("怪物 : " + i);
				tmp.STRNum = 200 * (i + 1.2);
				tmp.AGINum = 30 * (i + 1.2);
				tmp.VITNum = 20 * (i + 1.2);
				tmp.DEXNum = 70 * (i + 1.2);
				tmp.SpeedNum = 140 +( i*10+10);
				this._moster_vct.push(tmp);
				
				this._TB_vct[i] = new TimerBar();
				this._TB_vct[i].name = tmp.IDNum;
				this._TB_vct[i].aspd = tmp.ASPDNum;
			}
			
			this._hero = new PlayerData2();
			this._hero.IDNum = "英雄";
			this._hero.STRNum = 400;
			this._hero.AGINum = 60;
			this._hero.VITNum = 10;
			this._hero.DEXNum = 50;
			this._hero.SpeedNum = 150;
			
			var heroTimeBar:TimerBar = new TimerBar();
			heroTimeBar.name = this._hero.IDNum;
			heroTimeBar.aspd = this._hero.ASPDNum;
			this._TB_vct.push(heroTimeBar);
			
			var tbCount:int = this._TB_vct.length;
			for (i = 0; i < tbCount; i++) {
				this._TB_vct[i].y = (100 + (40 * i));
				this.view.addChild(this._TB_vct[i]);
			}
			
			this._heroHPBar = new HPGBar(this.view , 200 , 20 , "" , 10 , 400);
			this._heroHPBar.setProgress(this._hero.HPMIN , this._hero.HPMAX);
			this.eventDispatcher.dispatchEvent(new BattleStateEvent(BattleStateEvent.BATTLE_READY));
			
		}
		
		private function onBattleFightHandler(e:BattleStateEvent):void {
			this.startATime();
		}
		
		private function startATime():void {
			Cc.log(" ========= startATime ========= ");
			var tbCount:int = this._TB_vct.length;
			
			for (var i:int = 0; i < tbCount; i++) {
				this._TB_vct[i].drawStart();
				this._TB_vct[i].addEventListener(BattleStateEvent.ATTACK_TIME_UP, onAttackFight);
			}
		}
		
		private function onFight(e:BattleStateEvent):void {
			this._intervalID = setTimeout( this.pasueATime , 100);
		}
		
		private var _theSameQueue:Vector.<PlayerData2> = new Vector.<PlayerData2>();
		
		public function pasueATime():void {
			clearTimeout(this._intervalID);
			Cc.log(" ========= pasueATime ========= ");
			var tbCount:int = this._TB_vct.length;
			
			for (var i:int = 0; i < tbCount; i++) {
				this._TB_vct[i].drawStop();
				this._TB_vct[i].removeEventListener(BattleStateEvent.ATTACK_TIME_UP, onFight);
			}
		}
		
		private function onAttackFight(e:BattleStateEvent):void {
			var tag:int = parseInt((e.model[0] as String).slice(e.model[0].length - 1, e.model[0].length));
			Cc.log("onAttackFight : " + e.model[0] );
			
			switch (e.model[0]) {
			case "英雄": 
				var target:int = Math.random() * this._moster_vct.length;
				this._moster_vct[target].DmgIn(this._hero.AtkNum, this._hero.AtkPlusNum, this._hero._WeaponPercentNum, this._hero.ElementNum, false);
				Cc.log(this._hero.IDNum + "向" + this._moster_vct[target].IDNum + "攻擊" + "," + "造成" + this._moster_vct[target].MaxDmgNum + "點傷害!!" + " 怪物 [ " + tag + " ] 剩餘 HP : " + this._moster_vct[target].HPMIN);
				break;
			default: 
				this._hero.DmgIn(this._moster_vct[tag].AtkNum, this._moster_vct[tag].AtkPlusNum, this._moster_vct[tag]._WeaponPercentNum, this._moster_vct[tag].ElementNum, false);
				Cc.log(this._moster_vct[tag].IDNum + "向" + this._hero.IDNum + "攻擊" + "," + "造成" + this._hero.MaxDmgNum + "點傷害!!" + " 英雄剩餘 HP  : " + this._hero.HPMIN);
				if (this._hero.HPMIN <= 0 ) {
					Cc.log(this, " =============================================== ");
					Cc.log(this, " || 英雄 死亡 ----------------------- ");
					Cc.log(this, " =============================================== ");
				}else {
					this._heroHPBar.setProgress(this._hero.HPMIN , this._hero.HPMAX);
					Cc.log("_heroHPBar : " + this._hero.HPMIN)
				}
				
			}
			
			
		}
		
		private function onNextRoundHandler(e:BattleStateEvent):void {
			this.startATime();
		}
	
	}

}