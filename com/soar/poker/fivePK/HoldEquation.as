package com.soar.poker.fivePK {
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class HoldEquation {
		private static var _holdEquation:HoldEquation
		
		public function testFlush(suit:Array, point:Array, jokerCount:int):Array {
			var flush:Array = [0, 0, 0, 0, 0];
			var flushTest:Array = [jokerCount, jokerCount, jokerCount, jokerCount];
			for (var i:int = 0; i < 5; i++) {
				if (suit[i] == 0) {
					flushTest[0]++;
				} else if (suit[i] == 1) {
					flushTest[1]++;
				} else if (suit[i] == 2) {
					flushTest[2]++;
				} else if (suit[i] == 3) {
					flushTest[3]++;
				}
			}
			
			//如果是同花 找出是哪幾張 
			for (i = 0; i < 4; i++) {
				if (flushTest[i] >= 4) {
					for (var j:int = 0; j < 5; j++) {
						if (suit[j] == i || point[j] == 1) {
							flush[j] = 1;
						}
					}
					return [true, flush];
				}
			}
			
			return [false, flush];
		}
		
		public function testHighStright(points:Array, jokerCount:int):Array {
			var reference:Array = [10, 11, 12, 13, 14];
			var highStraight:Array = [0, 0, 0, 0, 0];
			var point:int = jokerCount;
			for (var i:int = 0; i < 5; i++) {
				for (var j:int = 0; j < 5; j++) {
					if (points[i] == reference[j]) {
						point++;
						highStraight[i] = 1;
						reference[j] = -1;
						break;
					} else if (points[i] == 1) {
						highStraight[i] = 1;
						break;
					}
				}
			}
			
			if (point >= 4)
				return [true, highStraight];
			return [false, highStraight];
		}
		
		public function testStraight(points:Array, jokerCount:int):Array {
			var reference:Array;
			var point:int = jokerCount;
			var straight:Array = [0, 0, 0, 0, 0];
			var maxPoint:int = 0;
			var maxStraight:Array = new Array();
			for (var i:int = 1; i <= 14; i++) {
				reference = [i, i + 1, i + 2, i + 3, i + 4];
				straight = [0, 0, 0, 0, 0];
				point = jokerCount;
				if (jokerCount > 0)
					straight[0] = 1;
				for (var j:int = 0; j < 5; j++) {
					for (var k:int = 0; k < 5; k++) {
						if ((points[j] == reference[k] && points[j] != 1) || (points[j] == 14 && reference[k] == 1)) {
							point++;
							straight[j] = 1;
							reference[k] = -1;
							break;
						} else if (points[i] == 1) {
							straight[j] = 1;
							break;
						}
					}
				}
				if (point > maxPoint) {
					maxPoint = point;
					maxStraight = straight.concat();
				}
				
			}
			if (maxPoint >= 4) {
				if (maxPoint == 4) {
					if (jokerCount == 0 && points[4] - points[3] == 1 && maxStraight[4] != 1) {
						maxStraight[0] = 0;
						maxStraight[4] = 1;
					} else if (points[4] - points[3] == 1 && maxStraight[4] != 1) {
						maxStraight[1] = 0;
						maxStraight[4] = 1;
					}
				}
				return [true, maxStraight];
			}
			return [false, straight];
		}
		
		public function testFiveOfKine(points:Array, jokerCount:int):Boolean {
			var point:int = jokerCount;
			for (var i:int = point + 1; i < 5; i++) {
				if (points[point] == points[i])
					continue;
				return false;
			}
			return true;
		}
		
		public function testFourOfKine(points:Array, jokerCount:int):Array {
			var point:int = jokerCount;
			var sameCount:int = 0;
			var fourOfKind:Array = [0, 0, 0, 0, 0];
			for (var i:int = jokerCount; i < 5; i++) {
				sameCount = 0;
				for (var j:int = 0; j < 5; j++) {
					if ((points[i] == points[j] || points[i] == 1 || points[j] == 1) && i != j) {
						sameCount++;
					}
				}
				if (sameCount >= 3)
					break;
			}
			if (sameCount < 3)
				return [false, fourOfKind];
			if (jokerCount != 0) {
				if (points[1] == points[2]) {
					fourOfKind = [1, 1, 1, 1, 0];
				} else {
					fourOfKind = [1, 0, 1, 1, 1];
				}
			} else if (points[0] == points[1]) {
				fourOfKind = [1, 1, 1, 1, 0];
			} else {
				fourOfKind = [0, 1, 1, 1, 1];
			}
			return [true, fourOfKind];
		}
		
		public function testThreeOfKine(points:Array, jokerCount:int):Array {
			var threeOfKind:Array = [0, 0, 0, 0, 0];
			if (jokerCount > 0) {
				for (var i:int = 1; i < 4; i++) {
					if (points[i] == points[i + 1]) {
						threeOfKind[0] = 1;
						threeOfKind[i] = 1;
						threeOfKind[i + 1] = 1;
						return [true, threeOfKind];
					}
				}
			} else {
				if (points[0] == points[1] && points[1] == points[2]) {
					threeOfKind[0] = threeOfKind[1] = threeOfKind[2] = 1;
					return [true, threeOfKind];
				} else if (points[1] == points[2] && points[2] == points[3]) {
					threeOfKind[1] = threeOfKind[2] = threeOfKind[3] = 1;
					return [true, threeOfKind]
				} else if (points[2] == points[3] && points[3] == points[4]) {
					threeOfKind[2] = threeOfKind[3] = threeOfKind[4] = 1;
					return [true, threeOfKind];
				}
			}
			return [false, threeOfKind];
		}
		
		public function testFullHouse(points:Array, jokerCount:int):Boolean {
			if (jokerCount > 0) {
				if (points[1] == points[2] && points[3] == points[4]) {
					return true;
				}
			} else {
				if (points[0] == points[1] && points[1] == points[2] && points[3] == points[4]) {
					return true;
				} else if (points[0] == points[1] && points[2] == points[3] && points[3] == points[4]) {
					return true;
				}
			}
			return false;
		}
		
		////////////////////基本上TWOPAIR BIGPAIR SINGLE都是在沒有大牌之下才會出的牌型，所以下面的判斷式  正確的前提成立在沒有大牌的情形下
		
		public function testTwoPair(points:Array, jokerCount:int):Array {
			var sameCount:int = 0;
			var twoPair:Array = [0, 0, 0, 0, 0];
			for (var i:int = 0; i < 4; i++) {
				if (points[i] == points[i + 1]) {
					twoPair[i] = 1;
					twoPair[i + 1] = 1;
					sameCount++;
				}
			}
			if (sameCount == 2)
				return [true, twoPair];
			return [false, twoPair];
		}
		
		public function testOneBigPair(points:Array, jokerCount:int):Array {
			var oneBigPair:Array = [0, 0, 0, 0, 0];
			for (var i:int = 0; i < 5; i++) {
				if (points[i] > 10 && points[0] == 1) {
					oneBigPair[0] = 1;
					oneBigPair[4] = 1;
					return [true, oneBigPair];
				} else if (points[i] == points[i + 1] && points[i] > 10) {
					oneBigPair[i] = 1;
					oneBigPair[i + 1] = 1;
					return [true, oneBigPair];
				}
			}
			return [false, oneBigPair];
		}
		
		public function testOneBig(points:Array, jokerCount:int):Array {
			var single:Array = [0, 0, 0, 0, 0];
			for (var i:int = 0; i < 5; i++) {
				if (points[i] == 1) {
					single[i] = 1;
					return [true, single];
				} else if (points[i] > 10) {
					single[4] = 1;
					return [true, single];
				}
			}
			return [false, single];
		}
		
		public static function getInstance():HoldEquation {
			if (_holdEquation == null) {
				_holdEquation = new HoldEquation();
			}
			return _holdEquation;
		}
	
	}

}