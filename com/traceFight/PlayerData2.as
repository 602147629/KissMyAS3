package com.traceFight {
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class PlayerData2 {
		
		private var ID:String = "";
		private var LV:int = 1;
		private var STR:int = 1; //strength
		private var AGI:int = 1; //agility
		private var VIT:int = 1; //vitality
		private var DEX:int = 1; //dexterity
		private var INT:int = 1; //intelligence
		private var LUK:int = 1; //luck
		private var _HPMIN:int = 1000;
		private var _HPMAX:int = 1000;
		private var MP:int = 100;
		private var SP:int = 100;
		private var TP:int = 100;
		private var Flee:int = 0;
		private var HIT:int = 0;
		private var Status:Boolean = true; //死亡狀態
		
		//金木水火土
		private var Element:int = 1; //五行加成
		private var ElementPercent:Number = 1.0; //五行加成
		
		//ATK
		private var ATK:int = 1;
		private var MaxAtk:int = 1;
		private var MinAtk:int = 1;
		private var SkillAtk:int = 1; //技能加成
		private var WeaponLv:int = 2; //武器等級
		private var WeaponAtk:Number = 1.5; //武器加成
		private var WeaponPercent:Number = 0.2; //武器趴數
		private var CardAtk:int = 100; //卡片加成
		private var AtkPlus:int = 0; //額外傷害
		private var WeaponExtraNum:int = 7; //武器精煉數
		private var WeaponExtra:Number = 0.1; //武器精煉加成
		
		private var Critical:Boolean = false; //暴擊******
		private var CriDmg:int = 0; //暴擊傷害
		
		//DEF
		private var DEF:int = 100; //defence
		private var MaxDef:Number = 0;
		private var SkillDef:int = 0; //技能加成
		private var EquipDef:int = 0; //裝備加成
		private var CardDef:int = 0; //卡片加成
		private var EquipExtra:int = 4; //裝備精煉數
		private var EquipPercent:Number = 0.5; //裝備趴數
		private var DefPlus:int = 0; //額外減傷
		private var DefFloat:int = 0; //VIT減防浮動
		private var MaxDmg:int = 0; //傷害值
		
		private var Speed:Number = 120; //速度
		private var BaseASPD:Number = 0.01; //基本攻速
		private var Aspd:Number = 0.01; //攻擊間隔
		
		public function PlayerData2():void {}
		
		private function OperationATK():void {
			//基礎ATK
			ATK = STR + (STR * 0.1) * (STR * 0.1) + DEX * 0.5 + LUK * 0.5;
			MaxAtk = (ATK + STR * WeaponLv * 0.3 + 0.9) + WeaponAtk + SkillAtk + CardAtk;
			MinAtk = (ATK + DEX * WeaponLv * 0.2 + 0.8) + WeaponAtk + SkillAtk + CardAtk;
			//武器精煉加成
			WeaponExtra = WeaponExtraNum * 0.7;
			OperationAspd();
		}
		
		private function OperationDEF():void {
			MaxDef = DEF + SkillDef + EquipDef + CardDef;
			//VIT減防浮動
			DefFloat = VIT * 0.5 + VIT * 2 * 1.5;
			//額外減傷
			DefPlus = EquipExtra * 0.7 + DefFloat;
		}
		
		private function OperationAspd():void {
			BaseASPD = 200 - (200 - Speed) * (250 - 40 - 50 / 4) / 250;
			Aspd = (200 - BaseASPD) * 0.02;
		}
		
		private function OperationFLEE():void {
		
		}
		
		private function OperationHIT():void {
		
		}
		
		//被攻擊傷害 - 輸入
		public function DmgIn(_ATK:int, _AtkPlus:int, _WeaponPercent:Number, _Element:int = 0, _Critical:Boolean = false):void {
			//trace("_Element : " + _Element);
			//trace("_WeaponPercent : " + _WeaponPercent);
			//trace("_AtkPlus : " + _AtkPlus);
			//trace("_ATK : " + _ATK);
			if (_HPMIN <= 0) {
				Die();
			} else {
				if (_Element != 0 || Element != _Element) {
					if (_Element == Element + 1 || Element == 1 && _Element == 5) {
						ElementPercent = 1.5;
					} else {
						ElementPercent = 1;
					}
				}
				
				if (!_Critical) {
					MaxDmg = (_ATK * (MaxDef * 0.001) - VIT * 0.8 - DefPlus) * _WeaponPercent * ElementPercent + _AtkPlus;
					_HPMIN -= MaxDmg;
					trace("_HPMIN : " + _HPMIN);
				} else {
					Critical = _Critical;
					//暴擊傷害
					CriDmg = (_ATK - DefPlus) * _WeaponPercent * ElementPercent + _AtkPlus;
					_HPMIN -= CriDmg;
					trace("_HPMIN : " + _HPMIN);
				}
			}
		}
		
		//被攻擊傷害 - 輸出
		public function get DmgOut():int {
			if (!Critical) {
				return MaxDmg;
			} else {
				Critical = false;
				return CriDmg;
			}
		}
		
		//bigen code
		public function set STRNum(_str:int):void {
			STR = _str;
			OperationATK();
		}
		
		public function get STRNum():int {
			return STR;
		}
		
		public function set AGINum(_agi:int):void {
			AGI = _agi;
			OperationFLEE();
		}
		
		public function get AGINum():int {
			return AGI;
		}
		
		public function set VITNum(_vit:int):void {
			VIT = _vit;
			OperationDEF();
		}
		
		public function get VITNum():int {
			return VIT;
		}
		
		public function set DEXNum(_dex:int):void {
			DEX = _dex;
			OperationATK();
		}
		
		public function get DEXNum():int {
			return DEX;
		}
		
		public function set INTNum(_int:int):void {
			INT = _int;
		}
		
		public function get INTNum():int {
			return INT;
		}
		
		public function set LUKNum(_luk:int):void {
			LUK = _luk;
		}
		
		public function get LUKNum():int {
			return LUK;
		}
		
		public function set SpeedNum(_speed:int):void {
			Speed = _speed;
			OperationAspd();
		}
		
		//Fight
		public function get ASPDNum():Number {
			return Aspd;
		}
		
		public function get AtkNum():int {
			return MaxAtk;
		}
		
		public function get AtkPlusNum():int {
			return AtkPlus;
		}
		
		public function get _WeaponPercentNum():Number {
			return WeaponPercent;
		}
		
		public function get ElementNum():int {
			return Element;
		}
		
		public function get MaxDmgNum():int {
			return MaxDmg;
		}
		
		public function set IDNum(_val:String):void {
			ID = _val;
		}
		
		public function get IDNum():String {
			return ID;
		}
		
		public function get HPMIN():int 
		{
			return _HPMIN;
		}
		
		public function set HPMIN(value:int):void 
		{
			_HPMIN = value;
		}
		
		public function get HPMAX():int 
		{
			return _HPMAX;
		}
		
		public function set HPMAX(value:int):void 
		{
			_HPMAX = value;
		}
		
		//死亡
		private function Die():void {
			Status = true;
			trace("死亡 : ");
		}
		//end code
	}
}