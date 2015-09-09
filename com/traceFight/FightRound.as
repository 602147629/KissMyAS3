package com.traceFight {
	import com.soar.events.GeneralEvent;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author g8sam
	 */
	public class FightRound extends Sprite {
		private var whoAttack:int = 0;			//誰攻擊
		private var mosterNum:int = 0;		//怪物數量
		private var ASPDBase_ary:Array = [];
		private var ASPD_ary:Array = [];
		private var moster_vct:Vector.<PlayerData2> = new Vector.<PlayerData2>();
		private var TB_vct:Vector.<TimerBar> = new Vector.<TimerBar>();
		private var i:int = 0;
		
		public function FightRound():void {
			mosterNum = (Math.random() * 4) + 2;
			trace("怪物數量 : " + mosterNum);
			
			TB_vct[0] = new TimerBar();
			TB_vct[0].ATime = SG_Main.Hero.ASPDNum;
			
			for (i = 1; i < mosterNum + 1; i++) {
				var tmp:PlayerData2 = new PlayerData2();
				tmp.IDNum = ("怪物" + i);
				tmp.STRNum = 200;
				tmp.AGINum = 30;
				tmp.VITNum = 20;
				tmp.DEXNum = 70;
				tmp.SpeedNum = 140;
				TB_vct[i] = new TimerBar();
				TB_vct[i].name = tmp.IDNum;
				TB_vct[i].ATime = tmp.ASPDNum;
				moster_vct.push(tmp);
			}
			
			var TB_y:int = 100;
			for (i = 0; i < TB_vct.length; i++) {
				this.addChild(TB_vct[i]);
				TB_vct[i].y = TB_y + 10;
				TB_vct[i].DrawStart();
				TB_vct[i].addEventListener("TimerUP", AttackFight);
			}
		}
		
		private function AttackFight(e:GeneralEvent):void {
			trace("showMSG : ", e.evtData[0], e.evtData[1]);
			
		}
		
		private function whoAttacks(a:Object, b:Object):Array {
               return a.AGI * Math.random() > b.AGI * Math.random() ? [a, b] : [b, a];
          }
		  
		private function Attack(_val:int):void {
			switch (_val) {
			case 1: 
				SG_Main.Hero.DmgIn(moster_vct[0].AtkNum, moster_vct[0].AtkPlusNum, moster_vct[0]._WeaponPercentNum, moster_vct[0].ElementNum, false);
				trace(moster_vct[0].IDNum + "向" + SG_Main.Hero.IDNum + "攻擊" + "," + "造成" + SG_Main.Hero.MaxDmgNum + "點傷害!!");
				break;
			case 2: 
				SG_Main.Hero.DmgIn(moster_vct[1].AtkNum, moster_vct[1].AtkPlusNum, moster_vct[1]._WeaponPercentNum, moster_vct[1].ElementNum, false);
				trace(moster_vct[0].IDNum + "向" + SG_Main.Hero.IDNum + "攻擊" + "," + "造成" + SG_Main.Hero.MaxDmgNum + "點傷害!!");
				break;
			case 3: 
				SG_Main.Hero.DmgIn(moster_vct[2].AtkNum, moster_vct[2].AtkPlusNum, moster_vct[2]._WeaponPercentNum, moster_vct[2].ElementNum, false);
				trace(moster_vct[0].IDNum + "向" + SG_Main.Hero.IDNum + "攻擊" + "," + "造成" + SG_Main.Hero.MaxDmgNum + "點傷害!!");
				break;
			case 4: 
				SG_Main.Hero.DmgIn(moster_vct[3].AtkNum, moster_vct[3].AtkPlusNum, moster_vct[3]._WeaponPercentNum, moster_vct[3].ElementNum, false);
				trace(moster_vct[0].IDNum + "向" + SG_Main.Hero.IDNum + "攻擊" + "," + "造成" + SG_Main.Hero.MaxDmgNum + "點傷害!!");
				break;
			case 5: 
				SG_Main.Hero.DmgIn(moster_vct[4].AtkNum, moster_vct[4].AtkPlusNum, moster_vct[4]._WeaponPercentNum, moster_vct[4].ElementNum, false);
				trace(moster_vct[0].IDNum + "向" + SG_Main.Hero.IDNum + "攻擊" + "," + "造成" + SG_Main.Hero.MaxDmgNum + "點傷害!!");
				break;
			case 0: 
				moster_vct[0].DmgIn(SG_Main.Hero.AtkNum, SG_Main.Hero.AtkPlusNum, SG_Main.Hero._WeaponPercentNum, SG_Main.Hero.ElementNum, false);
				trace(SG_Main.Hero.IDNum + "向" + moster_vct[0].IDNum + "攻擊" + "," + "造成" + moster_vct[0].MaxDmgNum + "點傷害!!");
				break;
			}
		}
	}
}

import com.soar.events.GeneralEvent;
import flash.display.Sprite;
import flash.utils.setTimeout;
import com.soar.events.GeneralEvent;
import flash.display.Sprite;
import flash.utils.setTimeout;

class TimerBar extends Sprite {
	public var AspdTime:Number = 0;
	public var NowArg:Number = 1.0;
	
	public function TimerBar():void {
		this.graphics.beginFill(0x009900, 1);
		this.graphics.lineStyle(1, 0xffffff, 1);
		this.graphics.drawRect(0, 0, 0, 7)
	}
	
	private function draw():void {
		NowArg = AspdTime + arguments[0];
		this.graphics.beginFill(0x009900, 1);
		this.graphics.lineStyle(1, 0xffffff, 1);
		this.graphics.drawRect(0, 0, NowArg + AspdTime, 7);
		
		if (arguments[0] < 100) {
			setTimeout(draw, 100, NowArg + AspdTime);
		} else {
			DrawFinal();
		}
	}
	
	public function set ATime(_val:Number):void {
		AspdTime = _val;
	}
	
	public function DrawStop():void {
		this.graphics.clear();
		this.graphics.beginFill(0x009900, 1);
		this.graphics.lineStyle(1, 0xffffff, 1);
		this.graphics.drawRect(0, 0, NowArg, 7)
	}
	
	public function DrawFinal():void {
		this.graphics.clear();
		this.graphics.beginFill(0x009900, 0);
		this.graphics.lineStyle(1, 0xffffff, 1);
		this.graphics.drawRect(0, 0, NowArg, 7);
		dispatchEvent(new GeneralEvent("TimerUP", [this.name, name]));
	}
	
	public function DrawStart():void {
		setTimeout(draw, 100, NowArg);
	}
}