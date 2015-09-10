package justFly.view.character {
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	 [Event(name = "upATK", type = "flash.events.Event")]
	 
	public class CharacterData extends Sprite {
		
		private var _ID:String = "";
		
		private var _Level:int = 1;
		
		private var _Experience:Number; // 經驗值
		private var _ExpMax:Number;
		private var _ExpMin:Number;
		
		private var _STR:int = 1; //strength
		private var _AGI:int = 1; //agility
		private var _VIT:int = 1; //vitality
		private var _DEX:int = 1; //dexterity
		private var _INT:int = 1; //intelligence
		private var _LUK:int = 1; //lucky
		
		private var _ATK:int = 0;
		private var _ATK_Buffer:int = 0;
		private var _addATK:int = 0;
		
		private var _HP:int = 1000;
		private var _MP:int = 100;
		private var _SP:int = 100;
		private var _TP:int = 100;
		private var _FLEE:int = 0;
		private var _HIT:int = 0;
		private var _ASPD:Number = 100;
		
		// Defense  防御
		// Victory 戰勝
		public function CharacterData() {}
		
		public function get ID():String {return this._ID;}
		public function set ID(value:String):void { this._ID = value; }
		
		public function get Level():int {return this._Level;}
		public function set Level(value:int):void { this._Level = value; }
		
		
		/**
		 * 力量相關公式
		 * 
		 * 基本攻擊力計算
		 * STR+(STR/10)²+DEX/5+LUK/5
		 * 
		 * 最小加算攻擊力=DEX效果
		 * DEX效果=Dex X(80+武器LV X20)/100 
		 * 即使計算後DEX>ATK，最小攻擊力也不會比最大攻擊力還要高
		 * 
		 * 假設DEX100，武器(ATK120)。
		 * 依據公式，DEX效果=100 X(80+4X20)/100=160
		 * 但是最小攻擊力卻不會因此而提升到160，而是武器的ATK也就是125
		 */
		public function get STR():int {return this._STR;}
		public function set STR(value:int):void {
			this._STR = value;
		}
		
		public function addAtk(value:int):void {
			this._addATK = value;
			this.upATK();
		}
		
		public function upATK():void {
			this._ATK += this._addATK;
		}
		
		public function get AGI():int {return _AGI;}
		public function set AGI(value:int):void {
			this._AGI = value;
		}
		
		/**
		 * 體質相關公式
		 * VIT每上升1，HP+2，DEF+1
		 * VIT每上升1時，所受到的傷害會減少0.8
		 * VIT每+1，使用恢復道具的回覆量增+1%
		 * 減算魔防 = (vit/2) + int
		 * 
		 * HP恢復公式
		 * HP/200(最低1)+VIT/5
		 * 
		 * VIT減算物理防禦力公式
		 * ‧最小減算物理防禦力=(VIT*0.5)+(VIT*0.3)
		 * ‧最大減算物理防禦力=(VIT*0.5)+(VIT/150)-1
		 * (當最大物理防禦力小於最小物理防禦力時，2個數值相等)
		 * 總和上述資料，VIT與STR一樣要點最好點以10為倍數為基礎
		 * 如果是要點VIT來減少受到狀態等傷害的話，建議最好是點至60(不含加成)在依照各職業的職業做搭配
		 */
		public function get VIT():int {
			return _VIT;
		}
		
		public function set VIT(value:int):void {
			_VIT = value;
		}
		
		
		
		
		/**
		 * 敏捷相關公式
		 * 
		 * AGI每提升一時 FLEE(迴避率)上升1
		 * ASPD計算公式：武器的基本攻速+(200-武器基本攻速)*(AGI+DEX/4)/250
		 * ★攻速部分計算出來絕對不是整數，小數點後面2位數也影響每分鐘的攻擊次數
		 */
		public function get DEX():int {
			return _DEX;
		}
		
		public function set DEX(value:int):void {
			_DEX = value;
		}
		
		public function get INT():int {
			return _INT;
		}
		
		public function set INT(value:int):void {
			_INT = value;
		}
		
		/**
		 * 幸運相關計算
		 * 每LUK+1，CRL(會心一擊率)+0.3
		 * 完全迴避率=1+LUK/10
		 * 增加物理攻擊力，LUK+5，ATK+1
		 * 獵人老鷹出擊率：(LUK/10)x(職業等級/10)x2%
		 * LUK最好為3與10的共同倍數為最佳
		 * 例如：30，60，90
		 */
		public function get LUK():int {
			return _LUK;
		}
		
		public function set LUK(value:int):void {
			_LUK = value;
		}
		
		public function get HP():int {
			return _HP;
		}
		
		public function set HP(value:int):void {
			_HP = value;
		}
		
		public function get MP():int {
			return _MP;
		}
		
		public function set MP(value:int):void {
			_MP = value;
		}
		
		public function get SP():int {
			return _SP;
		}
		
		public function set SP(value:int):void {
			_SP = value;
		}
		
		public function get TP():int {
			return _TP;
		}
		
		public function set TP(value:int):void {
			_TP = value;
		}
		
		public function get FLEE():int {
			return _FLEE;
		}
		
		public function set FLEE(value:int):void {
			_FLEE = value;
		}
		
		public function get HIT():int {
			return _HIT;
		}
		
		public function set HIT(value:int):void {
			_HIT = value;
		}
		
		/**
		 * 物理攻擊力 
		 * baseatk = str + [str/10]^2 + [dex/5] + [luk/5]
		 * minatk = baseatk + [dex*體型修正]
		 * maxatk = baseatk + [武器atk*體型修正]
		 * mindmg = [minatk * 怪乘算def - 怪減算def + 精鍊] + 熟練
		 * maxdmg = [maxatk * 怪乘算def - 怪減算def + 精鍊] + 熟練
		 * cridmg = maxatk + 精鍊 + 熟練
		 * [弓]
		 * baseatk = dex + [dex/10]^2 + [str/5] + [luk/5]
		 * minatk = baseatk + [武器atk*體型修正*dex/100]
		 * maxatk = baseatk + [武器atk*體型修正] + [箭atk*體型修正]
		 */
		public function get ATK():int {
			return _ATK;
		}
		
		public function set ATK(value:int):void {
			_ATK = value;
		}
		
		/**
		 * ASPD 公式
		 * 
		 * ASPD1 = 基本ASPD+(Agi*10.09+Dex*11/60)^0.5*(1-(基本ASPD-144)/50)
		 * ASPD2 = 200-(200-ASPD1)*(1-攻速提升1) [ASPD2=200-(200-ASPD1) * (1-攻速提升一/100)]
		 * ASPD  = 195-(195-ASPD2)*(1-攻速提升2)+攻速提升3
		 * ASPD有效位數到小數點一位，一轉、(進階)二轉上限190、三轉上限193。
		 */
		public function get ASPD():Number {
			return _ASPD;
		}
		
		public function set ASPD(value:Number):void {
			_ASPD = value;
		}
		
		
	
	}

}