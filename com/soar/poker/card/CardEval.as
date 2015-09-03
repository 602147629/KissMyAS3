package soar.poker.card {
	
	/**
	 * 鬥地主發牌
	 * @author g8sam « Just do it ™ »
	 */
	public class CardEval {
		
		public function CardEval() {
		}
		
		public function addCardsList(cards:Array):Vector.<CardInfo> {
			var len:int = cards.length;
			var playerCards:Vector.<CardInfo> = new Vector.<CardInfo>(len);
			
			for (var i:int = 0; i < len; i++) {
				playerCards[i] = new CardInfo();
				playerCards[i].id = cards[i]; //sever 定義牌組VO
				
				var str:String = cards[i].toString(); //牌型( 313 方塊13 )
				var flower:String = str.slice(0, 1); //花色
				var num:String = str.slice(1, 3); //數字
				var cardNum:int; //牌的影格數字值
				
				switch (flower) {																//素材影格順序
					case "2": cardNum = this.parseToNum(num);break;			//2XX 黑桃
					case "1": cardNum = this.parseToNum(num) + 13;break;	//1XX 紅心
					case "4": cardNum = this.parseToNum(num) + 26;break;	//4XX 方塊
					case "3": cardNum = this.parseToNum(num) + 39;break;	//3XX 梅花
					default: //trace("王牌 : " + cards[i]);
						if (cards[i] == 500) {cardNum = 52;}
						if (cards[i] == 501) {cardNum = 53;}
				}
				
				playerCards[i].grade = this.getGrade(cardNum);
				playerCards[i].tagFrame = cardNum + 2;// 影格 0base 第一格是牌背 所以+2
			}
			
			return this.sortCard(playerCards);
		}
		
		// 轉換牌組數字
		private function parseToNum(id:String):int {
			var num:int;
			switch (id) {
				case "03": num = 2;break;
				case "04": num = 3;break;
				case "05": num = 4;break;
				case "06": num = 5;break;
				case "07": num = 6;break;
				case "08": num = 7;break;
				case "09": num = 8;break;
				case "10": num = 9;break;
				case "11": num = 10;break;
				case "12": num = 11;break;
				case "13": num = 12;break;
				case "14": num = 0;break;
				case "15": num = 1;break;
			}
			return num;
		}
		
		/**
		 * 檢測牌的類型
		 * @param myCards 出的牌
		 * @return 如果遵守規則，返回牌的類型，否則，返回null。
		 */
		public function checkCardType(dealCard:Vector.<CardInfo>):String {
			var cardType:String = null;
			
			if (dealCard != null) {
				if (JudgeCards.isSingleCard(dealCard)) { // 單張
					cardType = CardType.SINGLE_CARD;
				} else if (JudgeCards.isDuiWang(dealCard)) { // 火箭
					cardType = CardType.ROCKET;
				} else if (JudgeCards.isDoubleCard(dealCard)) { // 對子
					cardType = CardType.TWO_PAIR;
				} else if (JudgeCards.isZhaDan(dealCard)) { // 炸彈
					cardType = CardType.BOMB;
				} else if (JudgeCards.isTripletAttachedPair(dealCard)) { // 3帶2
					cardType = CardType.TRIPLET_ATTACHED_PAIR;
				} else if (JudgeCards.isSanDaiYi(dealCard) != -1) { // 3帶1
					cardType = CardType.TRIPLET_ATTACHED_CARD;
				} else if (JudgeCards.isSanBuDai(dealCard)) { // 3不帶
					cardType = CardType.TRIPLET;
				} else if (JudgeCards.isShunZi(dealCard)) { // 順子
					cardType = CardType.STRAIGHT;
				} else if (JudgeCards.isLianDui(dealCard)) { // 連對
					cardType = CardType.SEQUENCE_OF_PAIRS;
				} else if (JudgeCards.isSiDaiEr(dealCard)) { // 4帶2
					cardType = CardType.FOUR_OF_KIND_AND_TWO;
				} else if (JudgeCards.isFeiJi(dealCard)) { // 飛機
					//cardType = CardType.FOUR_OF_KIND;
				}
			}
			return cardType;
		}
		
		/** 依大小等級排列順序 */
		public function sortCard(cards:Vector.<CardInfo>):Vector.<CardInfo> {
			var newSort:Vector.<CardInfo>;
			var card:CardInfo;
			for (var i:int = 0; i < cards.length; i++) {
				for (var j:int = i + 1; j < cards.length; j++) {
					if (cards[i].grade < cards[j].grade) {
						card = cards[i];
						cards[i] = cards[j];
						cards[j] = card;
					}
				}
			}
			return cards;
		}
		
		/** 根據牌的id，獲得一張牌的等級*/
		public function getGrade(id:int):int {
			var grade:int = 0;
			
			// 2個王必須放在前邊判斷
			if (id == 53) {
				grade = 16;
			} else if (id == 52) {
				grade = 17;
			} else {
				var modResult:int = id % 13;
				switch (modResult) {
					case 0: grade = 13;break;
					case 1: grade = 14;break;
					case 2: case 3: case 4: case 5: case 6: case 7: case 8: case 9: case 10: case 11: case 12: 
						grade = modResult;
						break;
				}
			}
			return grade;
		}
		
		/*
		//洗牌
		public function shuffle(cards:Array):void {
			var shuffledDeck:Array = cards.slice();
			var len:int = shuffledDeck.length;
			
			while (len) {
				shuffledDeck.push(shuffledDeck.splice(int(Math.random() * len--), 1)[0]);
			}
			
			//trace("隨機排序後數組：" + shuffledDeck);
			this._allCards = shuffledDeck;
			this.dealCard(shuffledDeck);

			//shuffledDeck.sort (function suff():int { return Math.random () > .5?1: -1 } );//隨機排序
		}

		//發牌
		public function dealCard(cards:Array):void {
			var i:int = 0;
			
			for (i = 0; i < 17; i++) {
				this._card1st.push(this.getCard(i * 3));
				this._card2nd.push(this.getCard(i * 3 + 1));
				this._card3rd.push(this.getCard(i * 3 + 2));
			}
			
			this._lordCard[0] = this.getCard(51);
			this._lordCard[1] = this.getCard(52);
			this._lordCard[2] = this.getCard(53);
			
			this.addPlayerCards(this._card1st);
		}

		public function addPlayerCards(cards:Array):void {
			for (var i:int = 0; i < cards.length; i++) {
				this._playerCards[i] = new CardInfo();
				this._playerCards[i].grade = JudgeCards.getGrade(cards[i]);
				this._playerCards[i].value = JudgeCards.numToType(cards[i])
				this._playerCards[i].tagFrame = cards[i] + 2;
				this._playerCards[i].type = JudgeCards.numToType(cards[i]) + JudgeCards.getCardType(cards[i]);
			}
			
			this._playerCards = JudgeCards.sortCard(this._playerCards);
			for (i = 0; i < this._playerCards.length; i++) {
				this._card1st[i] = this._playerCards[i].tagFrame;
				this._sortCards[i] = this._playerCards[i].grade;
			}
		}

		//取牌
		private function getCard(index:int):int {
			return this._allCards[index];
		}*/
	}

}