package  
{
	/**
	 * ...
	 * @author g8sam « Just do it ™ »
	 */
	public class NineNineTable 
	{
		
		public function NineNineTable() 
		{
			var table:Array = [];
			var list:Array = [];
			
			for (var i:int = 1; i < 10 ; i ++ ) {
				table[i] = [];
				for (var k:int = 1; k < 10; k ++ ) {
					//trace(i + " X " +k +"=" + (i * k));
					table[i][k] = (i.toString() + " X " +k.toString() +" = " + (i * k).toString());
				}
			}
			
			//trace(table);
			//trace(table[3]);
		}
		
	}

}