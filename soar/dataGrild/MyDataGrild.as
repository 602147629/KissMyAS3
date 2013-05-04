package Basic{
	import fl.controls.DataGrid;
	import fl.controls.dataGridClasses.DataGridColumn;
	import fl.data.DataProvider;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author g8sam
	 * @date： 2012/6/29 下午 03:33
	 */
	public class MyDataGrild{
		private var dataGrild:DataGrid;
		private var dp:DataProvider;
		
		public function MyDataGrild(...args):void {
			this.dataGrild = new DataGrid();
			setDataInfoFrom(args);
			this.dp = initDataProvider(dp);
		}
		
		private function setDataInfoFrom( args:Array ):void {
			for each (var str:String in args){
				var col:DataGridColumn = new DataGridColumn(str);
				dataGrild.addColumn(col);
			}
		}
		
		private function initDataProvider(dp:DataProvider):DataProvider {
			var provider:DataProvider;
			if (dp != null){
				dp.removeAll();
				provider = dp;
			}
			provider = new DataProvider();
			return provider;
		}
		
		public function addDataItems(...items):void{
			if (this.dp == null){
				return;
			}
			this.dp.addItems(items);
		}
		
		public function addDataItem(item:Object):void{
			if (this.dp == null){
				return;
			}
			this.dp.addItem(item);
		}
		
		public function getGridView( container:Sprite, width:int=0 , height:int=0 , x:int=0 , y:int=0 ):void {
			dataGrild.width = width;
			dataGrild.move( x , y);
			dataGrild.dataProvider = dp;
			if ( height == 0 ) {
				dataGrild.rowCount = dataGrild.length;
			}else {
				dataGrild.height = height;
			}
			container.addChild(dataGrild);
		}
		
		public function delGridView( container:Sprite ):void {
			container.removeChild(dataGrild);
		}
	}
}