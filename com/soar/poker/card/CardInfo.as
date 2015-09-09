package com.soar.poker.card {
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	public class CardInfo {
		/** 牌ID */
		public var id:int;
		
		/** 牌值LV */
		public var grade:int;
		
		/** 所在影格 */
		public var tagFrame:int;
		
		/** 牌形 */
		public var type:String;
		
		/** 是否被選取 */
		public var isPick:Boolean = false;
		
		public var value:String;
		
		public function CardInfo() {
		/*
		 * regexPair = Pattern.compile(".*(\\w)\\1.*#.*");
		   regexTwoPair = Pattern.compile(".*(\\w)\\1.*(\\w)\\2.*#.*");
		   regexThree = Pattern.compile(".*(\\w)\\1\\1.*#.*");
		   regexFour = Pattern.compile(".*(\\w)\\1{3}.*#.*");
		   regexFullHouse = Pattern.compile("((\\w)\\2\\2(\\w)\\3|(\\w)\\4(\\w)\\5\\5)#.*");
		   regexFlush = Pattern.compile(".*#(\\w)\\1{4}");
		   Royal/straight flush: "(2345A|23456|34567|...|9TJQK|TJQKA)#(\\w)\\1{4}"
		   Four of a kind:       ".*(\\w)\\1{3}.*#.*"
		   Full house:           "((\\w)\\2\\2(\\w)\\3|(\\w)\\4(\\w)\\5\\5)#.*"
		   Flush:                ".*#(\\w)\\1{4}"
		   Straight:             "(2345A|23456|34567|...|9TJQK|TJQKA)#.*"
		   Three of a kind:      ".*(\\w)\\1\\1.*#.*"
		   Two pair:             ".*(\\w)\\1.*(\\w)\\2.*#.*"
		   One pair:             ".*(\\w)\\1.*#.*"
		   High card:            (none)
		 */
		}
	
	}

}