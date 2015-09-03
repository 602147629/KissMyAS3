package soar.poker.lordland {
	
	/**
	 * ...
	 * @author g8sam « Just do it ™ »
	 */
	public class CardType {
		/** 斗地主有13種合法的牌型可以出：
		 * (1) 單張：前面提到過，大小順序從3(最小)到大怪(最大)；
		 * (2) 一對：兩張大小相同的牌，從3(最小)到2(最大)；
		 * (3) 三張：三張大小相同的牌；
		 * (4) 三張帶一張：三張並帶上任意一張牌，例如6-6-6-8，根據三張的大小來比較，例如9-9-9-3蓋過8-8-8-A；
		 * (5) 三張帶一對：三張並帶上一對，類似撲克中的副路(Full House)，根據三張的大小來比較，例如Q-Q-Q-6-6蓋過10-10-10-K-K；
		 * (6) 順子：至少5張連續大小(從3到A，2和怪不能用)的牌，例如8-9-10-J-Q；
		 * (7) 連對：至少3個連續大小(從3到A，2和怪不能用)的對子，例如10-10-J-J-Q-Q-K-K；
		 * (8) 三張的順子：至少2個連續大小(從3到A)的三張，例如4-4-4-5-5-5；
		 * (9) 三張帶一張的順子：每個三張都帶上額外的一個單張，例如7-7-7-8-8-8-3-6，儘管三張2不能用，但能夠帶上單張2和怪；
		 * (10) 三張帶一對的順子：每個三張都帶上額外的一對，只需要三張是連續的就行，例如8-8-8-9-9-9-4-4-J-J，儘管三張2不能用，但能夠帶上一對2【不能帶一對怪，因為兩張怪的大小不一樣】，這裡要注意，三張帶上的單張和一對不能是混合的，例如3-3-3-4-4-4-6-7-7就是不合法的；
		 * (11) 炸彈：四張大小相同的牌，炸彈能蓋過除火箭外的其他牌型，大的炸彈能蓋過小的炸彈；
		 * (12) 火箭：一對怪，這是最大的組合，能夠蓋過包括炸彈在內的任何牌型；
		 * (13) 四張套路(四帶二)：有兩種牌型，一個四張帶上兩個單張，例如6-6-6-6-8-9，或一個四張帶上兩對，例如J-J-J-J-9-9-Q-Q，四帶二隻根據四張的大小來比較，只能蓋過比自己小的同樣牌型的四帶二【四張帶二張和四張帶二對屬於不同的牌型，不能彼此蓋過】，不能蓋過其他牌型，四帶二能被比自己小的炸彈蓋過。
		 * */
		public static const SINGLE_CARD:String = "一張";
		public static const TWO_PAIR:String = "二張";
		public static const TRIPLET:String = "三張";
		public static const TRIPLET_ATTACHED_CARD:String = "三帶一";
		public static const TRIPLET_ATTACHED_PAIR:String = "三帶二";
		public static const TRIPLET_ATTACHED_STRAIGHT:String = "三張順";
		//public static const FOUR_OF_KIND:String = "四張";
		public static const BOMB:String = "炸彈";
		public static const FOUR_OF_KIND_AND_TWO:String = "四帶二";
		public static const STRAIGHT:String = "順子";
		public static const SEQUENCE_OF_PAIRS:String = "連對";
		public static const ROCKET:String = "火箭";
		
		/** 春天 */
		public static const SPRING:int = 4;
		
		/** 反春 */
		public static const NO_SPRING:int = 5;
		
		public function CardType() {
		
		}
	
	}

}