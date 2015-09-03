package soar.poker.lordland {
	
	/**
	 * ... 判斷牌型
	 * @author g8sam « Just do it ™ »
	 */
	public class JudgeCards {
		
		public function JudgeCards() {
		}
		
		/** 判斷牌是否為單  */
		public static function isSingleCard(dealCard:Vector.<CardInfo>):Boolean {
			var flag:Boolean = false;
			if (dealCard != null && dealCard.length == 1) {
				flag = true;
				trace("單張 : " + dealCard[0].type);
			}
			return flag;
		}
		
		/** 判斷牌是否為對子 */
		public static function isDoubleCard(dealCard:Vector.<CardInfo>):Boolean {
			var flag:Boolean = false;
			
			if (dealCard != null && dealCard.length == 2) {
				var grade1:int = dealCard[0].grade;
				var grade2:int = dealCard[1].grade;
				if (grade1 == grade2) {
					flag = true;
					trace("對子 : " + dealCard[0].type + " | " + dealCard[1].type);
				}
			}
			return flag;
		}
		
		/**
		 * 判斷牌是否為3帶1
		 * @return 如果為3帶1，被帶牌的位置，0或3，否則返回-1。炸彈返回-1。
		 */
		public static function isSanDaiYi(dealCard:Vector.<CardInfo>):int {
			var flag:int = -1;
			// 默認不是3帶1  
			if (dealCard != null && dealCard.length == 4) {
				var grades:Array = [];
				grades[0] = dealCard[0].grade;
				grades[1] = dealCard[1].grade;
				grades[2] = dealCard[2].grade;
				grades[3] = dealCard[3].grade;
				
				// 暫時認為炸彈不為3帶1  
				if ((grades[1] == grades[0]) && (grades[2] == grades[0]) && (grades[3] == grades[0])) {
					return -1;
				} 
				// 3帶1，被帶的牌在牌頭
				else if ((grades[1] == grades[0] && grades[2] == grades[0])) {
					trace("3帶1 1: " + dealCard[0].type + " | " + dealCard[1].type + " | " + dealCard[2].type + " | " + dealCard[3].type);
					return 0;
				} 
				// 3帶1，被帶的牌在牌尾
				else if (grades[1] == grades[3] && grades[2] == grades[3]) {
					trace("3帶1 2: " + dealCard[0].type + " | " + dealCard[1].type + " | " + dealCard[2].type + " | " + dealCard[3].type);
					return 3;
				}
			}
			return flag;
		}
		
		/** 3帶2 */
		public static function isTripletAttachedPair(dealCard:Vector.<CardInfo>):Boolean {
			var flag:Boolean = false;
			
			if (dealCard != null && dealCard.length == 5) {
				var grades:Array = [];
				grades[0] = dealCard[0].grade;
				grades[1] = dealCard[1].grade;
				grades[2] = dealCard[2].grade;
				grades[3] = dealCard[3].grade;
				grades[4] = dealCard[4].grade;
				
				if (grades[0] == grades[1] && grades[3] == grades[4]) {
					if (grades[2] == grades[1] || grades[2] == grades[3]) {
						trace("3帶2 : " + dealCard[0].type + " | " + dealCard[1].type + " | " + dealCard[2].type + " | " + dealCard[3].type + " | " + dealCard[4].type);
						flag = true;
					}
				}
			}
			
			return flag;
		}
		
		/** 判斷牌是否為3不帶 */
		public static function isSanBuDai(dealCard:Vector.<CardInfo>):Boolean {
			var flag:Boolean = false;
			
			if (dealCard != null && dealCard.length == 3) {
				var grade0:int = dealCard[0].grade;
				var grade1:int = dealCard[1].grade;
				var grade2:int = dealCard[2].grade;
				
				if (grade0 == grade1 && grade2 == grade0) {
					flag = true;
					trace("3 張: " + dealCard[0].type + " | " + dealCard[1].type + " | " + dealCard[2].type);
				}
			}
			return flag;
		}
		
		public static function isTripletAttachedStraight(dealCard:Vector.<CardInfo>):Boolean {
			var flag:Boolean = false;
			var len:int = dealCard.length;
			
			if (len < 6 || len % 3 != 0) {
				return false;
			}
			return true;
		}
		
		/** 判斷牌是否為順子 */
		public static function isShunZi(dealCard:Vector.<CardInfo>):Boolean {
			var flag:Boolean = true;
			
			if (dealCard != null) {
				var size:int = dealCard.length;
				// 順子牌的個數在5到12之間  
				if (size < 5 || size > 12) {
					return false;
				}
				
				for (var n:int = 0; n < size - 1; n++) {
					var prev:int = dealCard[n].grade;
					var next:int = dealCard[n + 1].grade;
					// 小王、大王、2不能加入順子  
					if (prev == 17 || prev == 16 || prev == 15 || next == 17 || next == 16 || next == 15) {
						flag = false;
						break;
					} else {
						//if (prev - next != -1) {
						if (prev - next != 1) {
							flag = false;
							break;
						}
					}
				}
			}
			
			trace(flag);
			flag ? trace("順子: " + dealCard[0].type + " | " + dealCard[1].type + " | " + dealCard[2].type + " | " + dealCard[3].type + " | " + dealCard[4].type) : false;
			return flag;
		}
		
		/** 判斷牌是否為炸彈 */
		public static function isZhaDan(dealCard:Vector.<CardInfo>):Boolean {
			var flag:Boolean = false;
			if (dealCard != null && dealCard.length == 4) {
				var grades:Array = [];
				grades[0] = dealCard[0].grade;
				grades[1] = dealCard[1].grade;
				grades[2] = dealCard[2].grade;
				grades[3] = dealCard[3].grade;
				if ((grades[1] == grades[0]) && (grades[2] == grades[0]) && (grades[3] == grades[0])) {
					trace("炸彈: " + dealCard[0].type + " | " + dealCard[1].type + " | " + dealCard[2].type + " | " + dealCard[3].type);
					flag = true;
				}
			}
			return flag;
		}
		
		/** 判斷牌是否為火箭 */
		public static function isDuiWang(dealCard:Vector.<CardInfo>):Boolean {
			var flag:Boolean = false;
			
			if (dealCard != null && dealCard.length == 2) {
				var gradeOne:int = dealCard[0].grade;
				var gradeTwo:int = dealCard[1].grade;
				
				// 只有小王和大王的等級之後才可能是33
				if (gradeOne + gradeTwo == 33) {
					trace("王炸 : " + dealCard[0].type + " | " + dealCard[1].type);
					flag = true;
				}
			}
			return flag;
		}
		
		/**判斷牌是否為連對*/
		public static function isLianDui(dealCard:Vector.<CardInfo>):Boolean {
			var flag:Boolean = true;
			
			if (dealCard == null) {
				flag = false;
				return flag;
			}
			
			var size:int = dealCard.length;
			if (size < 6 || size % 2 != 0) {
				flag = false;
			} else {
				for (var i:int = 0; i < size; i = i + 2) {
					if (dealCard[i].grade != dealCard[i + 1].grade) {
						trace("flag : " + dealCard[i].grade + " | " + dealCard[i + 1].grade);
						flag = false;
						break;
					}
					
					if (i < size - 2) {
						if (dealCard[i].grade - dealCard[i + 2].grade != 1) {
							trace("flag 2 : " + dealCard[i].grade + " | " + dealCard[i + 2].grade);
							flag = false;
							break;
						}
					}
				}
			}
			
			flag ? trace("連對 : " + dealCard[0].type + " | " + dealCard[1].type) : false;
			return flag;
		}
		
		/** 判斷牌是否為飛機 */
		public static function isFeiJi(dealCard:Vector.<CardInfo>):Boolean {
			var flag:Boolean = false;
			
			if (dealCard != null) {
				var size:int = dealCard.length;
				if (size >= 6) {
					if (size % 3 == 0 && size % 4 != 0) {
						flag = isFeiJiBuDai(dealCard);
					} else if (size % 3 != 0 && size % 4 == 0) {
						flag = isFeiJiDai(dealCard);
					} else if (size == 12) {
						flag = isFeiJiBuDai(dealCard) || isFeiJiDai(dealCard);
					}
				}
			}
			return flag;
		}
		
		/** 判斷牌是否為飛機不帶 */
		public static function isFeiJiBuDai(dealCard:Vector.<CardInfo>):Boolean {
			if (dealCard == null) {
				return false;
			}
			
			var size:int = dealCard.length;
			var n:int = size / 3;
			
			var grades:Array = [];
			
			if (size % 3 != 0) {
				return false;
			} else {
				for (var i:int = 0; i < n; i++) {
					if (!isSanBuDai(dealCard.slice(i * 3, i * 3 + 3))) {
						return false;
					} else {
						// 如果連續的3張牌是一樣的，記錄其中一張牌的grade
						grades[i] = dealCard[i * 3].grade;
					}
				}
			}
			
			for (i = 0; i < n - 1; i++) {
				if (grades[i] == 15) { // 不允許出現2
					return false;
				}
				
				if (grades[i + 1] - grades[i] != 1) {
					trace("等級必須連續,如 333444" + (grades[i + 1] - grades[i]));
					return false;
				}
			}
			
			return true;
		}
		
		/** 判斷牌是否為飛機帶 */
		public static function isFeiJiDai(dealCard:Vector.<CardInfo>):Boolean {
			var size:int = dealCard.length;
			var n:int = size / 4; // 此處為「除」，而非取模
			var i:int = 0;
			
			for (i = 0; i + 2 < size; i = i + 3) {
				var grade1:int = dealCard[i].grade;
				var grade2:int = dealCard[i + 1].grade;
				var grade3:int = dealCard[i + 2].grade;
				
				if (grade1 == grade2 && grade3 == grade1) {
					// return isFeiJiBuDai(myCards.subList(i, i + 3 *n));8張牌時，下標越界,subList不能取到最後一個元素
					var cards:Vector.<CardInfo> = new Vector.<CardInfo>;
					for (var j:int = i; j < i + 3 * n; j++) { // 取字串
						cards.push(dealCard[j]);
					}
					return isFeiJiBuDai(cards);
				}
			}
			return false;
		}
		
		/**
		 * 判斷牌是否為4帶2
		 * @return 如果為4帶2，返回true；否則，返回false。
		 */
		public static function isSiDaiEr(dealCard:Vector.<CardInfo>):Boolean {
			var flag:Boolean = false;
			
			if (dealCard != null && dealCard.length == 6) {
				for (var i:int = 0; i < 3; i++) {
					var grade1:int = dealCard[i].grade;
					var grade2:int = dealCard[i + 1].grade;
					var grade3:int = dealCard[i + 2].grade;
					var grade4:int = dealCard[i + 3].grade;
					
					if (grade2 == grade1 && grade3 == grade1 && grade4 == grade1) {
						trace("為4帶2: " + dealCard[0].type + " | " + dealCard[1].type + " | " + dealCard[2].type + " | " + dealCard[3].type);
						flag = true;
					}
				}
			}
			return flag;
		}
	
	}

}