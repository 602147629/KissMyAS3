package soar.utils.regex 
{
	/**
	 * Regular Expression (以下簡稱 REGEX)
	 * @author sam
	 * 	http://www.regexr.com/
	 */
	public class Regexr 
	{
		private var _str:String;
		
		public function Regexr() 
		{
			this._str = 	"abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
								"0123456789 +-.,!@#$%^&*();\/|<>"+
								"12345 -98.7 3.141 .6180 9,000 +42" +
								"555.123.4567	+1-(800)-555-2468" +
								"foo@demo.net	bar.ba@test.co.uk" +
								"www.demo.com	http://foo.co.uk/" +
								"http://regexr.com/foo.html?q=bar";
		}
		
		public function test():void {
			this._str.substr( -1).search(/[\d]/);123456789
		}
		
	}

}