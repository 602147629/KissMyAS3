package com.soar.air.sql {
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class SQLUtils {
		private var sqlconn:SQLConnection;
		private var sqlStatement:SQLStatement;
		private var file:File;
		
		private var openConnectionHander:Function; //SqlEvent
		private var errorHandler:Function; //SQLErrorEvent
		private var resultHandler:Function; //sqlEvent,sqlResult
		
		public function SQLUtils(file:File, reusltHand:Function, errorHand:Function = null, openConnectionHand:Function = null) {
			this.file = file;
			this.openConnectionHander = openConnectionHand;
			this.errorHandler = errorHand;
			this.resultHandler = reusltHand;
			
			sqlconn = new SQLConnection();
			sqlStatement = new SQLStatement();
			sqlStatement.sqlConnection = sqlconn;
			sqlconn.addEventListener(SQLEvent.OPEN, function(event:SQLEvent):void {
					addlistener();
					if (openConnectionHander) {
						openConnectionHander(event);
					}
				}
				
				);
			sqlconn.addEventListener(SQLErrorEvent.ERROR, function(event:SQLEvent):void {
					if (errorHandler) {
						errorHandler(event);
					}
				});
			sqlconn.open(file);
		
		}
		
		private function addlistener():void {
			sqlStatement.addEventListener(SQLEvent.RESULT, function(result:SQLEvent):void {
					resultHandler.apply(null, [sqlStatement.getResult()]);
				});
			sqlStatement.addEventListener(SQLErrorEvent.ERROR, function(error:SQLEvent) {
					if (errorHandler) {
						errorHandler(error);
					}
				});
		}
		
		//操作
		public function deal(sql:String):void {
			sqlStatement.text = sql;
			if (!sqlStatement.executing) {
				sqlconn.begin();
				sqlStatement.execute();
				sqlconn.commit();
			}
		}
		
		
	
	}

}