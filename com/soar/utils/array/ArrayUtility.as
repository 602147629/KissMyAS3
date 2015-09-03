package soar.utils.array {
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @copy		 : Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		 : g8sam « Just do it ™ »
	 * @since		 : 2014/12/20 上午 11:37
	 * @version	 : 1.0.12
	 */
	public class ArrayUtility {
		
		public function ArrayUtility() {
			trace(randomArr([3, 9, 6, 8, 4, 2, 5, 1, 7]));
		}
		
		/** 讓數組中元素隨機排序的最簡方法 */
		public function randSort():int {
			return Math.random () > 0.5 ? 1: -1;
			//shuffledDeck.sort (function suff():int { return Math.random () > .5?1: -1 } );//随机排序
		}
		
		/**
		 * 將隨機出來的數扔到自己數組後面，數組小於200 時效率高。
		 */
		public function randomArr(arr:Array):Array {
			var outputArr:Array = arr.slice();
			var i:int = outputArr.length;
			
			while (i) {
				outputArr.push(outputArr.splice(int(Math.random() * i--), 1)[0]);
			}
			
			return outputArr;
		}
		
		/** 隨機一個數組 */
		public function randomArr(arr:Array):Array {
			var newArr:Array = [];
			while (arr.length > 0) {
				var tempArr:Array = arr.splice((Math.random() * arr.length) >> 0, 1);
				newArr.push(tempArr[0]);
			}
			return newArr;
		}
		
		/** 數組返回隨機不重複數據 */
		public function getRandomFromArray():void {
			var arr:Array = [1, 24, 23, 2];
			while (arr.length > 0) {
				//隨機取出一個值並在數組中刪組
				var rs:int = arr.splice(Math.floor(Math.random() * arr.length), 1)[0];
				trace("rs : " + rs);
			}
		}
		
		/** 隨機獲取指定數組的不重複元素(方法2)*/
		private function randomArr($arr:Array, num:int):Array {
			num = num <= $arr.length ? num : $arr.length;
			return randomList($arr).slice(0, num);
		}
		
		/** 高效地抽離出兩個數組中的相同元素 ( 關聯數組的效率要遠大於一般數組 ) */
		public function ObjectCompare():void {
			var startTime:int = getTimer();
			var commonValue:Array = [];
			var obj:Object = {};
			
			for each (var elem:int in arry1) {
				obj[elem] = true;
			}
			
			for each (elem in arry2) {
				if (obj[elem]) {
					commonValue.push(elem);
					delete obj[elem];
				}
			}
			trace("common count : " + commonValue.length.toString());
			trace("time cost:" + (getTimer() - startTime).toString() + "ms");
		}
		
		/**
		 * [ Array ] - 數組中除去相同的成員
		 * 對於"aa"來講obj["aa"]的值為undefined 而!undefined為true,就會返回該成員，
		 * 然後 將obj["aa"]的值設為true，下一次遇到obj["aa"]時，
		 * obj["aa"]的值為true， !obj["aa"]的值就為false, 就不返回該成員。 很新穎哦
		 */
		public var arr:Array = ["aa", "bb", "cc", "dd", "bb", "cc", "aa", "bb", "gg", "aa", "cc"];
		
		public function formatX(arr:Array):Array {
			var obj:Object = {};
			return arr.filter(function(item:*, index:int, array:Array):Boolean {
					return !obj[item] ? obj[item] = true : false;
				});
		}
		
		/** 刪除數組中重複的對象 */
		public function delRepeatValue():void {
			var arr:Array = ["a", "b", "b", "c", "c", "c", "c", "b", "d", "c", "d", "ee", "b", "c"];
			var z:Array = arr.filter(function(a:*, b:int, c:Array):Boolean {
					return ((z ? z : z = new Array()).indexOf(a) >= 0 ? false : (z.push(a) >= 0));
				}, this);
		}
		
		/** 更好的刪除數組數據的方法 */
		public function delArrayElement():void {
			var item:Object; //這是要刪除的元素
			
			var array:Array = [0, 0, 0, item, 0];
			var index:int = array.indexOf(item);
			
			if (index != -1) {
				array[index] = array[array.length - 1]; //把要刪除的元素和最後一個元素位置對調一下
				array.pop(); //速度比直接用splice快大概85倍
			}
		}
		
		/** 返回兩個指定整型之間的隨機數, 包含兩邊的數 */
		public static function radomBetw(start:int, end:int):int {
			return int(Math.random() * (end - start + 1) + start);
		}
		
		/** 陣列排序不使用sort() */
		private var _array:Array = new Array(45, 23, 18, 10, 6, 8, 67, 98, 30, 50);
		
		public function ArrayTest() {
			for (var i:int = 0; i < _array.length - 1; i++) {
				for (var j:int = 0; j < _array.length - 1 - i; j++) {
					//trace( j )
					if (_array[j + 1] < _array[j]) {
						var temp:Object = _array[j + 1]; //交換陣列元素
						_array[j + 1] = _array[j];
						_array[j] = temp;
					}
				}
			}
			
			for (var k:int = 0; k < _array.length; k++) {
				//----測試排序後的值
				trace(_array[k])
			}
		}
		
		/** 快速產生不重覆亂數
		   假如單純只有用 Array.NUMERIC 模式排序速度是夠快的
		   那要如何利用 Array.NUMERIC 模式排序又能弄亂順序呢?
		   就是改用 sortOn function 來作排序，陣列內的元素改用物件，
		   多一個屬性存放亂數，對亂數欄位作排序就可以了
		 */
		
		/** 產生 0 - 9999 不重複亂數陣列
		 * var ra:Array = genRandomArray(10000);
		 * trace(ra[0].n); // 取出第一個不重複亂數
		 * trace(ra[1].n); // 取出第二個不重複亂數
		 */
		public function genRandomArray(n:int):Array {
			var ary:Array = [];
			while (n)
				ary.push({n: --n, r: Math.random()});
			return ary.sortOn("r", Array.NUMERIC);
		}
		
		/**
		 * 產生 0 到 (n - 1) 不重複亂數陣列
		 * 用隨機插入陣列的方式產生不重覆亂數
		 * 速度比原生的 Array 排序慢一些
		 * var ra:Array = genRandomArray(10000);
		 * trace(ra[0]); // 取出第一個不重複亂數
		 * trace(ra[1]); // 取出第二個不重複亂數
		 */
		public function genRandomArray(n:int):Array {
			var ary:Array = [];
			while (n)
				ary.splice(Math.random() * ary.length, 0, --n);
			return ary;
		}
		
		/**
		 * 產生 0 到 (n - 1) 不重複亂數陣列
		 * 把一堆亂數塞入陣列
		 * 然後同時結合 Array.NUMERIC、Array.RETURNINDEXEDARRAY 模式作排序
		 * 馬上就拿到不重複的亂數陣列了
		 * var ra:Array = genRandomArray(10000);
		 * trace(ra[0]); // 取出第一個不重複亂數
		 * trace(ra[1]); // 取出第二個不重複亂數
		 */
		public function genRandomArray(n:int):Array {
			var ary:Array = [];
			while (n--)
				ary.push(Math.random());
			return ary.sort(Array.NUMERIC | Array.RETURNINDEXEDARRAY);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		/**	[ Array ] - 數組做分頁如下：
		 * 第1頁數據:1,2,3,4,5,6,7,8,9,10
		 * 第2頁數據:11
		 * var arr:Array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
		 * var row = 10; //每頁顯示條數
		 * for (var i:int = 1, page = Math.ceil(arr.length / row); i <= page; i++) {
		 * 		trace("第" + i + "頁數據:" + arr.slice((i - 1) * row, i * row))
		 * }
		 */
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function randerPage():void {
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		/**	[ Array ] - 字符串轉數組
		 * split()可以把String對像拆分為數組，但前提要統一的分割符：
		 * var str:String = "1|2|3|4|5|6";
		 * var ary:Array = str.split("|");
		 */
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function str2Ary():void {
		
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		/**	[ Array ] - 數組轉字符串
		 * Array類裡有一個toString的方法可以直接轉為字符串
		 * 把數組歷一遍在連接起來再保存在字符串對像裡面也可以轉換
		 */
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function ary2Str():void {
		
		}
		
		/** 依大小等級排列順序 */
		public static function sortCard(cards:Vector.<CardInfo>):Vector.<CardInfo> {
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
	}

}