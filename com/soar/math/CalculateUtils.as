package soar.math {
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @copy		 : Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		 : g8sam « Just do it ™ »
	 * @since		 : 2014/12/20 上午 11:37
	 * @version	 : 1.0.12
	 */
	public class CalculateUtils {
		private var _view:MovieClip;
		//private var _btnMgr:ButtonMgr;
		
		private var _tmpNumStr:String = "";
		
		private var _txtResult:TextField;
		private var _txtPool:TextField;
		
		public function CalculateUtils(view:MovieClip) {
			this._view = view;
			this.addChild(this._view);
			this._view.x = 533;
			this._view.y = 345;
			
			this._btnMgr = new ButtonMgr(this._view);
			this._txtPool = view["txt_Pool"];
			this._txtResult = view["txt_Result"];
			this._txtPool.text = "";
			this._txtResult.text = "0";
			
			this.visible = false;
		}
		
		/** 計算機開關 */
		public function isCheckCalculate():void {
			this.visible = this.visible ? false : true;
			this._view.visible ? this.addEvent() : this.delEvent();
		}
		
		private function addEvent():void {
			this._btnMgr.addEvent();
			EventFactory.getInstance().addEvent(this._btnMgr, "ButtonDone", onButtonDone);
		}
		
		private function delEvent():void {
			this._btnMgr.delEvent();
			EventFactory.getInstance().delEventFn(this._btnMgr, "ButtonDone", onButtonDone);
		}
		
		private function onButtonDone(e:IEvent):void {
			var btnName:String = e.data[0];
			
			switch (btnName) {
				case "0": 
				case "1": 
				case "2": 
				case "3": 
				case "4": 
				case "5": 
				case "6": 
				case "7": 
				case "8": 
				case "9": 
					this._txtPool.appendText(btnName);
					this._tmpNumStr += btnName;
					this._txtResult.text = this._tmpNumStr;
					break;
				case "Dot": 
					if (this._txtPool.text.substr(-1).search(/[\d]/) > -1) {
						var checkDot:String = this._txtPool.text;
						checkDot += ".";
						if (checkDot.search(/\.\d+\./) > -1) {
							return;
						}
						
						this._txtPool.appendText(".");
						this._txtResult.appendText(".");
						this._tmpNumStr += ".";
					} else {
						this._txtPool.text = this._txtPool.text.replace(/\b[\+\-\*\/]$/, ".");
					}
					break;
				case "Addition": 
					checkOperation("+");
					break;
				case "Substraction": 
					checkOperation("-");
					break;
				case "Multiplication": 
					checkOperation("*");
					break;
				case "Division": 
					checkOperation("/");
					break;
				case "Equal": 
					this.exam(this._txtPool.text);
					this._txtPool.text = "";
					break;
				case "Del": 
					this._txtPool.text = this._txtPool.text.slice(0, this._txtPool.text.length - 1);
					this._tmpNumStr = "";
					
					if (this._txtPool.text.length <= 0) {
						this._txtResult.text = "0";
					} else {
						this.exam(this._txtPool.text);
					}
					break;
				case "Clear": 
					this._tmpNumStr = "";
					this._txtPool.text = "";
					this._txtResult.text = "0";
					break;
			}
		}
		
		// 檢查運算時條件
		private function checkOperation(symbol:String):void {
			if (this._txtPool.text.substr(-1).search(/[\d\.]/) > -1) {
				this.exam(this._txtPool.text);
				this._txtPool.appendText(symbol);
			} else {
				if (this._txtPool.text == "") {
					this._txtPool.text = this._txtResult.text + "+";
					this.exam(this._txtPool.text);
				}
				this._txtPool.text = this._txtPool.text.replace(/\b[\+\-\*\/]$/, symbol);
			}
			this._tmpNumStr = "";
		}
		
		// 字串加總
		private function exam(NumStr:String):void {
			var str:String = NumStr;
			var curTotal:String = "0";
			var tempTotal:String = "0";
			var symbol:String = "";
			
			var dot:Boolean = false;
			var dotUsed:Boolean = false;
			
			for (var i:int = 0; i < str.length; i++) {
				var temp:String = str.charAt(i);
				
				if (temp != "+" && temp != "-" && temp != "*" && temp != "/") {
					if (temp == ".") {
						dot = true;
						dotUsed = false;
					} else {
						if (dot == true) {
							if (dotUsed == false) {
								dotUsed = true;
								tempTotal = tempTotal.toString() + "." + temp.toString();
							} else {
								tempTotal = tempTotal.toString() + temp.toString();
							}
						} else {
							tempTotal = String(Number(tempTotal) * 10 + Number(temp));
						}
					}
				} else {
					dot = false;
					if (symbol != "") {
						curTotal = this.calculate(curTotal, tempTotal, symbol);
						tempTotal = "0";
					} else {
						curTotal = tempTotal;
						tempTotal = "0";
					}
					symbol = temp;
				}
			}
			
			if (tempTotal != "0") {
				curTotal = this.calculate(curTotal, tempTotal, symbol);
			}
			
			if (this._txtPool.text.search(/[\+\-\*\/]/) > -1) {
				this._txtResult.text = curTotal.toString();
			} else {
				this._txtResult.text = this._txtPool.text;
			}
			
			this._tmpNumStr = "";
			//trace("curTotal : " + curTotal);
		}
		
		//結算
		private function calculate(curTotal:String, tempTotal:String, symbol:String):String {
			var digitAry:Array = floatCau(curTotal);
			curTotal = digitAry[1];
			
			var digitAry2:Array = floatCau(tempTotal);
			tempTotal = digitAry2[1];
			
			if (digitAry[0] > digitAry2[0]) {
				var dif:int = digitAry[0] - digitAry2[0];
				tempTotal = String(Number(tempTotal) * Math.pow(10, dif));
				digitAry2[0] = digitAry[0];
			} else {
				dif = digitAry2[0] - digitAry[0];
				curTotal = String(Number(curTotal) * Math.pow(10, dif));
				digitAry[0] = digitAry2[0];
			}
			
			var length:int;
			/*curTotal *= 10000;
			 tempTotal *= 10000;*/
			
			if (symbol == "+") {
				curTotal = String(Number(curTotal) + Number(tempTotal));
				length = digitAry[0];
			}
			if (symbol == "*") {
				curTotal = String(Number(curTotal) * Number(tempTotal));
				length = digitAry[0] + digitAry2[0];
			}
			if (symbol == "-") {
				curTotal = String(Number(curTotal) - Number(tempTotal));
				length = digitAry[0];
			}
			if (symbol == "/") {
				curTotal = String(Number(curTotal) / Number(tempTotal));
				length = 0;
			}
			
			var series:int = 1;
			for (var i:int = 0; i < length; i++) {
				series *= 10;
			}
			curTotal = String(Number(curTotal) / series);
			//curTotal = curTotal /10000 / 10000
			
			return curTotal;
		}
		
		//浮點運算
		private function floatCau(curTotal:String):Array {
			var arr:Array = curTotal.split(".");
			var length:int = 0;
			var series:int = 1;
			
			if (arr.length > 1) {
				length = arr[1].length;
			}
			
			for (var i:int = 0; i < length; i++) {
				series *= 10;
			}
			
			curTotal = String(Math.round(Number(curTotal) * series));
			return [length, curTotal];
		}
	
	}

}