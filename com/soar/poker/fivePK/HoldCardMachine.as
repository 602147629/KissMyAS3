package soar.poker.fivePK {
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author g8sam « Just do it ™ »
	 */
	public class HoldCardMachine extends Sprite {
		private var _poker:Array;
		private var _pokerShadow:Array;
		private var _points:Array = [];
		private var _suits:Array = [];
		private var _isholds:Array = [];
		private var _dataPoints:Array = [];
		private var _jokerCount:int;
		
		/** 正同花大順 */
		private var _isRoyalFlush:Boolean = false;
		/** 五條 */
		private var _isFiveOfAKind:Boolean = false;
		/** 同花順 */
		private var _isStraightFlush:Boolean = false;
		/** 鐵支 */
		private var _isFourOfAKind:Boolean = false;
		/** 葫蘆 */
		private var _isFullHouse:Boolean = false;
		/** 同花 */
		private var _isFlush:Boolean = false;
		private var _isListenFlush:Boolean = false;
		/** 順子 */
		private var _isStraight:Boolean = false;
		private var _isListenStraight:Boolean = false;
		/** 三條 */
		private var _isThreeOfAKind:Boolean = false;
		private var _isThreeOfAKindOne:Boolean = false;
		private var _isThreeOfAKindTwo:Boolean = false;
		private var _isThreeOfAKindThree:Boolean = false;
		/** 兩對 */
		private var _isPairTwo:Boolean = false;
		/** 一對 */
		private var _isPairOne:Boolean = false;
		/** 最大順子 **/
		private var _isHighStright:Boolean = false;
		
		private var _isBigOne:Boolean = false;
		
		private var _isPairOneJackOrBetter:Boolean = false;
		private var _isPairTwoJackOrBetter:Boolean = false;
		private var _hasJoker:Boolean = false;
		
		private var _hand:String = "";
		
		private var _hasPairCount:int; //有幾對
		private var _machPoint:Array; //相同牌型點數
		
		private var _flush:Array = new Array();
		private var _highStraight:Array = new Array();
		private var _straight:Array = new Array();
		private var _fiveOfKind:Array = [1, 1, 1, 1, 1];
		private var _fourOfKind:Array = new Array();
		private var _fullHouse:Array = [1, 1, 1, 1, 1];
		private var _threeOfKind:Array = new Array();
		private var _twoPair:Array = new Array();
		private var _oneBigPair:Array = new Array();
		private var _single:Array = new Array();
		
		private static var _holdCardMachine:HoldCardMachine
		
		public function HoldCardMachine() {
			//this.init();
		}
		
		public function setDefault():void {
			this._points = [];
			this._suits = [];
			this._isholds = [];
			this._dataPoints = [];
			
			this._isRoyalFlush = false;
			this._isFiveOfAKind = false;
			this._isStraightFlush = false;
			this._isFourOfAKind = false;
			this._isFullHouse = false;
			this._isFlush = false;
			this._isStraight = false;
			this._isThreeOfAKind = false;
			this._isThreeOfAKindOne = false;
			this._isThreeOfAKindTwo = false;
			this._isThreeOfAKindThree = false;
			this._isPairTwo = false;
			this._isPairOne = false;
			this._isHighStright = false;
			this._isBigOne = false;
			
			this._isPairOneJackOrBetter = false;
			this._isPairTwoJackOrBetter = false;
			
			this._hasJoker = false;
			this._isListenFlush = false;
			this._isListenStraight = false;
			this._hand = "";
			this._points = [];
			this._suits = [];
			this._dataPoints = [];
			this._jokerCount = 0;
			this._flush = [0, 0, 0, 0, 0];
			this._highStraight = [0, 0, 0, 0, 0];
			this._straight = [0, 0, 0, 0, 0];
			this._fourOfKind = [0, 0, 0, 0, 0];
			this._fiveOfKind = [1, 1, 1, 1, 1];
			this._threeOfKind = [0, 0, 0, 0, 0];
			this._twoPair = [0, 0, 0, 0, 0];
			this._fullHouse = [1, 1, 1, 1, 1];
			this._oneBigPair = [0, 0, 0, 0, 0];
			this._single = [0, 0, 0, 0, 0];
			this._isPairOne = this._isPairTwo = this._isPairOneJackOrBetter = this._isPairTwoJackOrBetter = false;
		}
		
		public function init():void {
			this.setDefault();
		/*
		   this.poker = ["3d" , "4c" , "5h" , "9s" , "2d"];
		   this.poker = ["3d" , "3c" , "5h" , "9s" , "3d"];
		   this.poker = ["3d" , "1j" , "5h" , "2s" , "3h"];
		   this.poker = ["Td" , "Qc" , "Ah" , "1j" , "Jd"];
		   this.poker = ["3h" , "4h" , "5h" , "9s" , "2h"];
		   this.poker = ["4d" , "4c" , "5h" , "1j" , "5d"];
		   this.poker = ["4c" , "4h" , "5c" , "1j" , "6d"];
		   this.poker = ["4c" , "4h" , "5h" , "5s" , "6d"];
		   this.poker = ["Qc" , "4h" , "2j" , "5s" , "6d"];
		   this.poker = ["Qc" , "4h" , "2j" , "5s" , "9d"];
		   this.poker = ["5c" , "5h" , "2j" , "5s" , "9d"];
		   this.poker = ["5c" , "5h" , "2j" , "5s" , "5d"];
		   this.poker = ["2c" , "3h" , "1j" , "7s" , "9d"];
		 this.poker = ["2c" , "3h" , "Kh" , "7s" , "9d"];*/
		}
		
		public static function getInstance():HoldCardMachine {
			if (_holdCardMachine == null) {
				_holdCardMachine = new HoldCardMachine();
			}
			return _holdCardMachine;
		}
		
		public function get isHolds():Array {
			return this._isholds;
		}
		
		public function set poker(poker:Array):void {
			this.setDefault();
			this._poker = poker;
			this._pokerShadow = this._poker.concat();
			this.change(this._poker);
			this.judgment();
		}
		
		private function judgment():void {
			this._hasJoker = this._points[0] == 1 ? true : false;
			
			var holdEquation:HoldEquation = HoldEquation.getInstance();
			
			var charge:Array = holdEquation.testFlush(this._suits, this._points, this._jokerCount);
			this._isFlush = charge[0];
			this._flush = charge[1].concat();
			
			charge = holdEquation.testHighStright(this._points, this._jokerCount);
			this._isHighStright = charge[0];
			this._highStraight = charge[1].concat();
			
			charge = holdEquation.testStraight(this._points, this._jokerCount);
			this._isStraight = charge[0];
			this._straight = charge[1].concat();
			
			// this._isStraight = this.testStraight();//是不是聽或中順
			
			this._isFiveOfAKind = holdEquation.testFiveOfKine(this._points, this._jokerCount); //是不是武調
			
			charge = holdEquation.testFourOfKine(this._points, this._jokerCount);
			this._isFourOfAKind = charge[0];
			this._fourOfKind = charge[1].concat();
			
			charge = holdEquation.testThreeOfKine(this._points, this._jokerCount);
			this._isThreeOfAKind = charge[0];
			this._threeOfKind = charge[1].concat();
			
			this._isFullHouse = holdEquation.testFullHouse(this._points, this._jokerCount); //是不是葫蘆
			
			charge = holdEquation.testTwoPair(this._points, this._jokerCount);
			this._isPairTwo = charge[0];
			this._twoPair = charge[1].concat();
			
			charge = holdEquation.testOneBigPair(this._points, this._jokerCount);
			this._isPairOne = charge[0];
			this._oneBigPair = charge[1].concat();
			
			charge = holdEquation.testOneBig(this._points, this._jokerCount);
			this._isBigOne = charge[0];
			this._single = charge[1].concat();
			/*
			   trace( "_isPairOne : " + _isPairOne );
			   trace( "_isPairTwo : " + _isPairTwo );
			   trace( "_isPairOneJackOrBetter : " + _isPairOneJackOrBetter );
			   trace( "_isPairTwoJackOrBetter : " + _isPairTwoJackOrBetter );
			 */
			
			var isROYALFLUSH:Boolean = true;
			//如果是同花 且 大順   且要HOLD的位置一樣  判定為桐花大順
			if (this._isFlush && this._isHighStright) {
				for (var i:int = 0; i < 5; i++) {
					if (this._flush[i] != this._highStraight[i]) {
						isROYALFLUSH = false;
						break;
					}
				}
			} else
				isROYALFLUSH = false
			
			var isSTRAIGHTFLUSH:Boolean = true;
			
			if (this._isStraight && this._isFlush) {
				for (i = 0; i < 5; i++) {
					if (this._flush[i] != this._straight[i]) {
						isSTRAIGHTFLUSH = false
						break;
						;
					}
				}
			} else
				isSTRAIGHTFLUSH = false;
			
			var holdCard:Array = new Array();
			if (isROYALFLUSH) {
				this._hand = "ROYALFLUSH"
				holdCard = this._flush.concat();
			} else if (this._isFiveOfAKind) {
				this._hand = "FIVEOFAKIND";
				holdCard = this._fiveOfKind.concat();
			} else if (isSTRAIGHTFLUSH) {
				this._hand = "STRAIGHTFLUSH";
				holdCard = this._flush.concat();
			} else if (this._isFourOfAKind) {
				this._hand = "FOUROFAKIND";
				holdCard = this._fourOfKind.concat();
			} else if (this._isFullHouse) {
				this._hand = "FULLHOUSE";
				holdCard = this._fullHouse.concat();
			} else if (this._isFlush) {
				if (this._isThreeOfAKind) {
					this._hand = "THREEOFAKIND";
					holdCard = this._threeOfKind.concat();
				} else if (this._isPairTwo) {
					this._hand = "TWOPAIR";
					holdCard = this._twoPair.concat();
				} else {
					this._hand = "FLUSH";
					holdCard = this._flush.concat();
				}
			} else if (this._isStraight) {
				if (this._isThreeOfAKind) {
					this._hand = "THREEOFAKIND";
					holdCard = this._threeOfKind.concat();
				} else if (this._isPairTwo) {
					this._hand = "TWOPAIR";
					holdCard = this._twoPair.concat();
				} else {
					this._hand = "STRAIGHT";
					holdCard = this._straight.concat();
				}
			} else if (_isThreeOfAKind) {
				this._hand = "THREEOFAKIND";
				holdCard = this._threeOfKind.concat();
			} else if (this._isPairTwo) {
				this._hand = "TWOPAIR";
				holdCard = this._twoPair.concat();
			} else if (this._isPairOne) {
				this._hand = "PAIR";
				holdCard = this._oneBigPair.concat();
			} else if (this._isBigOne) {
				this._hand = "SINGLE";
				holdCard = this._single.concat();
			} else {
				this._hand = "NOTHING"
				holdCard = [0, 0, 0, 0, 0];
			}
			
			//trace("Poker =================== " + this._poker + " ============ " + this._hand + " ++++++++ " + holdCard);
			
			this.checkHold(this._poker, holdCard);
		}
		
		/** 轉換排組 為數字做為排序判斷**/
		private function change(poker:Array):void {
			//trace( " >>>>>>>>>>>>  [ HoldCardMachine ] <<<<<<<<<<<<<<< " );
			// trace( " poker : " + poker );
			
			var point:String;
			var suit:String;
			var cardPoint:int;
			var cardSuit:int;
			
			for (var i:int = 0; i < 5; i++) {
				point = poker[i].slice(0, 1);
				
				suit = poker[i].slice(1, 2);
				
				switch (point) {
					case "T": cardPoint = 10;break;
					case "J": cardPoint = 11;break;
					case "Q": cardPoint = 12;break;
					case "K": cardPoint = 13;break;
					case "A": cardPoint = 14;break;
					default: 
						if ((point == "1" && suit == "j") || (point == "2" && suit == "j")) {
							cardPoint = 1;
							this._jokerCount++;
							break;
						}
						cardPoint = parseInt(point);
				}
				
				this._points[i] = cardPoint;
				
				switch (suit) {
					case "s": cardSuit = 0;break;
					case "h": cardSuit = 1;break;
					case "d": cardSuit = 2;break;
					case "c": cardSuit = 3;break;
					case "j": cardSuit = 4;break;
				}
				this._suits[i] = cardSuit;
			}
			
			this._dataPoints = this._points.concat();
			
			var temp:String;
			for (i = 0; i < 5; i++) {
				for (var j:int = i + 1; j < 5; j++) {
					if (this._points[i] > this._points[j]) {
						
						temp = this._pokerShadow[i];
						this._pokerShadow[i] = this._pokerShadow[j];
						this._pokerShadow[j] = temp;
						
						temp = this._suits[i];
						this._suits[i] = this._suits[j];
						this._suits[j] = int(temp);
						
						temp = this._points[i];
						this._points[i] = this._points[j];
						this._points[j] = int(temp);
					}
				}
			}
			
			/*
			this._points.sort(Array.NUMERIC); //進行數值排序，3 會在 10 之前
			this._suits.sort(Array.NUMERIC);
			*/
		}
		
		private function checkHold(poker:Array, hold:Array):void {
			this._isholds = [0, 0, 0, 0, 0];
			var tmpPt:String;
			var tmpSuit:String;
			
			for (var i:int = 0; i < 5; i++) {
				if (hold[i] == 1) {
					tmpPt = _pokerShadow[i].slice(0, 1);
					tmpSuit = _pokerShadow[i].slice(1, 2);
					for (var k:int = 0; k < 5; k++) {
						if (this._poker[k].slice(0, 1) == tmpPt && this._poker[k].slice(1, 2) == tmpSuit) {
							this._isholds[k] = 1;
							
						}
					}
				}
			}
			//trace("Hold  =================== " + this._isholds );
		}
	}

}