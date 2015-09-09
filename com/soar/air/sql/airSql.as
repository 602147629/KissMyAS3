package soar.air.sql {
	import com.far.sql.SQLUtils;
	
	import flash.data.SQLResult;
	import flash.display.Sprite;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class airSql {
		private var sqlutil:SQLUtils;
		private var createsql:String = "create table if not exists employees ( id integer primary key autoincrement, firstname text, lastname text, position text )";
		private var insertsql:String = "insert into employees(firstname,lastname,position) values('b','b','c')";
		private var selectsql:String = "select * from employees";
		private var delsql:String = "delete    from employees where firstname='a'";
		
		public function air() {
			sqlutil = new SQLUtils(File.applicationDirectory.resolvePath("xiaoguo.db"), reusltHandler);
			sqlutil.deal(selectsql);
		}
		
		private function reusltHandler(result:SQLResult):void {
			//trace(result.data);
			var ar:Array = result.data;
			for (var i:int = 0; i < ar.length; i++) {
				trace(ar[i].firstname + "," + ar[i].lastname + "," + ar[i].position);
			}
		}
	}

}