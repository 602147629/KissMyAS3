package {
	import Basic.GeneralEvent;
	import fl.controls.DataGrid;
	import fl.controls.dataGridClasses.DataGridColumn;
	import fl.data.DataProvider;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import room.PBtn;
	import room.RBtn;
	/**
	 * ...
	 * @author g8sam
	 * @date： 2012/6/12 下午 04:26
	 * @date： 2012-06-12
	 */
	public class TipPop extends Sprite {
		private var escTxt_ary:Array = [ "中斷時間 : " , "中斷原因 : " , "2012/12/31 24:59" , "孩子不想做" , "趕時間" , "系統問題" ];
		private var systemMsg_tf:TextField = new TextField();
		private var tfm:TextFormat = new TextFormat( "Verdana" , 24 , 0xCC3333 , true , null , null, null, null, "center");
		private var $pBtn_enter:PBtn;
		private var $pBtn2:PBtn;
		private var $pBtn3:PBtn;
		private var $pBtn4:PBtn;
		
		private var $pBtn6:PBtn ;//列印
		private var $pBtn7:PBtn ;//列印離開
		private var $pBtn8:PBtn;//取消
		private var $pBtn9:PBtn;
		private var $pBtn10:PBtn;
		private var panelBmp:Bitmap = new Bitmap();
		private var firstBmp:Bitmap = new Bitmap();
		private var ex_tf:TextField = new TextField();
		private var btnTxtBmpD_vct:Vector.<BitmapData> = new Vector.<BitmapData>();
		private var btnBmpD_vct:Vector.<BitmapData> = new Vector.<BitmapData>();
		private var msgBigBmp:Bitmap =new Bitmap();
		
		
		
		private var enter_spt:Sprite = new Sprite();
		private var $Rbtn1:RBtn;
		private var $Rbtn2:RBtn;
		private var $Rbtn3:RBtn;
		private var $pBtn_Practice:PBtn;
		private var $pBtn_inGame:PBtn;
		//警覺選擇圖提示
		private var secondBmp:Bitmap = new Bitmap();
		private var nowdate:Date = new Date();
		private var nowDataStr:String = "";
		
		private var radioBtnBmpD_vct:Vector.<BitmapData> = new Vector.<BitmapData>();
		private var escTf_vct:Vector.<TextField> = new Vector.<TextField>();
		
		private var tf_fmt1:TextFormat = new TextFormat( "Verdana" , 28 , 0xCC3333 , true , null , null, null, null, "left");
		private var tf_fmt2:TextFormat = new TextFormat( "Verdana" , 20 , 0xAAAAAA , true , null , null, null, null, "left");
		
		
		
		
		public function TipPop( ):void {
			btnBmpD_vct = Main.sourceLoader.btnBmpD_vct;
			btnTxtBmpD_vct = Main.sourceLoader.btnTxtBmpD_vct;
			panelBmp.bitmapData = Main.sourceLoader.panelBmpd_vct[1];//523*346
			msgBigBmp.bitmapData = Main.sourceLoader.panelBmpd_vct[0];//836*636
			init();
			this.addEventListener( GeneralEvent.BTN_DOWN , btnDownHandle);
		}
		
		//MSG BTN_DOWN
		private function btnDownHandle(e:GeneralEvent):void {
			switch(e.eventName) {
				case "確定"://選水果動物實確定
					Main.$TipPop.Disable_Msg(0);
					break;
				case "取消":
					Main.$TipPop.Disable_Msg(8);
					break;
				case "確定統計":
					Main.$TipPop.Disable_Msg(3);
					Main.sourceLoader.Globby( true);
					Main.sourceLoader.rightCountInit();
					switch( GameInfo.getGameStage()) {
						case 2:
						case 3:
							Main.sourceLoader.targetBmpCheck(false);
							break;
					}
					break;
			}
		}
		
		//初始
		private function init():void {
			tfm.letterSpacing = 2;
			with(systemMsg_tf){
				defaultTextFormat = tfm;
				wordWrap = true;
				mouseEnabled = false;
				selectable = false;
				width = 300;
				height = 40;
				x = (1024 - width) * 0.5;
				y = (768 - height) * 0.5;
				text = "請選擇一種圖片!!";
			}
			systemMsg_tf.autoSize = TextFieldAutoSize.LEFT;
			//blurBg
			Background.addChild(bitmap);
			addChild(Background);
			
			addChild(panelBmp);
			panelBmp.x = (1024 - panelBmp.width) * 0.5;
			panelBmp.y = (768 - panelBmp.height) * 0.5;
			
			addChild(systemMsg_tf);
			showSysMsgEnter();
			this.addChild(firstBmp);
			firstBmp.visible = false;
		}
		
		//explain
		private function explainInit():void {
			var tmp_tfm:TextFormat = new TextFormat("Verdana" , 32 , 0xffaa33 , null , null , null, null, null, "left");
			tmp_tfm.letterSpacing = 2;
			with (ex_tf) {
				defaultTextFormat = tmp_tfm;
				multiline = true;
				wordWrap = true;
				selectable = false;
				mouseEnabled = false;
				width = 760;
				height = 600;
				x = 140;
				y =120;
				text = "";
			}
			addChild(ex_tf);
			ex_tf.visible = false;
		}
		
		public function appendExTxt( str:String ):void {
			ex_tf.visible = true;
			ex_tf.text = str;
		}
		
		private function exTxtMsgDel():void {
			ex_tf.text = "";
			ex_tf.visible = false;
		}
		
		private  function showSysMsgEnter():void {
			panelBmp.visible = true;
			systemMsg_tf.visible = true;
			$pBtn_enter = new PBtn();
			$pBtn_enter.visible = false;
			$pBtn_enter.setBtnTxt( btnTxtBmpD_vct[0]);
			$pBtn_enter.setBtnName( "確定" );
			$pBtn_enter.x = (1024 - $pBtn_enter.width) * 0.5;
			$pBtn_enter.y = 450;
			addChild($pBtn_enter);
		}
		
		private function btnEnt2():void {
			$pBtn2 = new PBtn();
			$pBtn2.setBtnTxt( btnTxtBmpD_vct[0]);
			$pBtn2.setBtnName( "確定2" );
			$pBtn2.x = (1024 - $pBtn2.width) * 0.5;
			$pBtn2.y = 476;
			addChild($pBtn2);
		}
		
		private function btnEnt3():void {
			$pBtn3 = new PBtn();
			$pBtn3.setBtnTxt( btnTxtBmpD_vct[0] );
			$pBtn3.setBtnName( "確定統計" );
			$pBtn3.x = (1024 - $pBtn3.width) * 0.5;
			$pBtn3.y = 480;
			addChild($pBtn3);
		}
		
		private function btnent3Del():void {
			if ( $pBtn3 != null) {
				removeChild($pBtn3);
			}
		}

		private function PracticeMsg():void {
			this.graphics.beginFill( 0x000000 , 0.7);
			this.graphics.drawRect(0 , 0 , 1024, 768);
			addChild(msgBigBmp);
			msgBigBmp.x = (1024 - msgBigBmp.width) * 0.5;
			msgBigBmp.y = (768 - msgBigBmp.height) * 0.5;
			msgBigBmp.visible = true;
			
			$pBtn_Practice = new PBtn();
			with ($pBtn_Practice) {
				setBtnTxt(btnTxtBmpD_vct[1]);
				setBtnName( "練習");
				x = (1024 - 190 * 2) / 3 +46;//(螢幕寬 - 按鈕數*按鈕寬 / 按鈕數+1 ) 
				y = 600;
			}
			addChild($pBtn_Practice);
			
			
			$pBtn_inGame = new PBtn();
			with ($pBtn_inGame) {
				setBtnTxt(btnTxtBmpD_vct[2]);
				setBtnName( "進入");
				x =  ((1024 - 190 * 2) / 3)*2+190-46;
				y = 600;
			}
			addChild($pBtn_inGame);
			
		}
		
		private function PracticeMsgDel():void {
			this.graphics.clear();
			msgBigBmp.visible = false;
			$pBtn_Practice.visible = false;
			$pBtn_inGame.visible = false;
		}
		
		//關閉
		public function Disable_Msg( mods:int ):void {
			switch(mods) {
				case 0 :// 進入測試
					$pBtn_enter.visible = false;
					systemMsg_tf.visible = false;
					panelBmp.visible = false;
					Background.visible = false;
					break;
				case 1 ://練習/進入
					if ( $pBtn9 != null ) {
						$pBtn9.visible = false;
					}
					if ( $pBtn10 != null) {
						$pBtn10.visible = false;
					}
					systemMsg_tf.visible = false;
					panelBmp.visible = false;
					Background.visible = false;
					PracticeMsgDel();
					exTxtMsgDel();
					break;
				case 2://選擇遊戲使用圖片
					if ( $pBtn2 != null ) {
						$pBtn2.visible = false;
					}
					
					if ( $pBtn8 != null ) {
						$pBtn8.visible = false;
					}
					
					systemMsg_tf.visible = false;
					panelBmp.visible = false;
					Background.visible = false;
					if ( firstBmp != null ) {
						firstBmp.visible = false;
					}
					break;
				case 3:
					btnent3Del();
					systemMsg_tf.visible = false;
					panelBmp.visible = false;
					Background.visible = false;
					break;
				case 7://游戲結束- 練習模式
					$pBtn_inGame.visible = false;
					systemMsg_tf.visible = false;
					systemMsg_tf.y = (768 - systemMsg_tf.height) * 0.5;
					panelBmp.visible = false;
					Background.visible = false;
					break;
				case 8://取消
					if ( $pBtn2 != null ) {
						$pBtn2.visible = false;
					}
					if ( $pBtn8 != null ) {
						$pBtn8.visible = false;
					}
					systemMsg_tf.visible = false;
					panelBmp.visible = false;
					Background.visible = false;
					firstBmp.visible = false;
					break;
			}
		}
		
		//開啟
		public function Enable_Msg( mods:int ):void {
			switch(mods) {
				case 0 :// 進入測試
					$pBtn_enter.visible = true;
					systemMsg_tf.visible = true;
					panelBmp.visible = true;
					Background.visible = true;
					break;
				case 1 ://練習/進入
					PracticeMsg();
					explainInit();
					break;
				case 2: //選擇遊戲使用圖片
					$pBtn2.visible = true;
					systemMsg_tf.visible = true;
					systemMsg_tf.y = (768 - systemMsg_tf.height) * 0.5;
					panelBmp.visible = true;
					Background.visible = true;
					firstBmp.visible = true;
					break;
				case 3://游戲結束計
					//btnEnt3();
					btnEnt89();
					systemMsg_tf.visible = true;
					systemMsg_tf.y = (768 - systemMsg_tf.height) * 0.5;
					panelBmp.visible = true;
					Background.visible = true;
					break;
				case 31://游戲結束計
					btnEnt3();
					//btnEnt89();
					systemMsg_tf.visible = true;
					systemMsg_tf.y = (768 - systemMsg_tf.height) * 0.5;
					panelBmp.visible = true;
					Background.visible = true;
					break;
				case 7://游戲結束- 練習模式
					$pBtn_inGame.visible = true;
					$pBtn_inGame.x = 454;
					$pBtn_inGame.y = 500;
					systemMsg_tf.visible = true;
					systemMsg_tf.y = (768 - systemMsg_tf.height) * 0.5;
					panelBmp.visible = true;
					Background.visible = true;
					break;
				case 9://秀中斷時為填寫原因
					systemMsg_tf.visible = true;
					systemMsg_tf.y = 550;
					systemMsg_tf.text = "請選擇一個原因 !!";
					break;
			}
		}
		
		private function btnEnt89():void {
			$pBtn9 = new PBtn();
			$pBtn9.setBtnTxt( btnTxtBmpD_vct[7] );
			$pBtn9.setBtnName( "繼續練習" );
			$pBtn9.x = 300 ;
			$pBtn9.y = 460;
			addChild($pBtn9);
			$pBtn10 = new PBtn();
			$pBtn10.setBtnTxt( btnTxtBmpD_vct[8] );
			$pBtn10.setBtnName( "進入測試" );
			$pBtn10.x = 530;
			$pBtn10.y = 460;
			addChild($pBtn10);
		}
		
		public function initDataDrid(impulseDataGridFrom:DataGrid, width:int, x:int, y:int, ...args):DataGrid{
			if (impulseDataGridFrom == null){
				impulseDataGridFrom = new DataGrid();
				var arr:Array = (args.length == 1 && !isNaN(args[0])) ? new Array(args[0]) : args;
				for each (var str:String in arr){
					var col:DataGridColumn = new DataGridColumn(str);
					impulseDataGridFrom.addColumn(col);
				}
				impulseDataGridFrom.width = width;
				impulseDataGridFrom.move(x, y);
				return impulseDataGridFrom;
			}
			return impulseDataGridFrom;
		}
		
		public function initDataProvider(dp:DataProvider):DataProvider{
			if (dp != null){
				dp.removeAll();
				return dp;
			}
			return dp = new DataProvider();
		}
		
		private function addpBtn4():void { 
			$pBtn4 = new PBtn();
			$pBtn4.setBtnTxt( btnTxtBmpD_vct[0] );
			$pBtn4.setBtnName( "確定離開" );
			$pBtn4.x = (1024 - $pBtn4.width) * 0.5;
			$pBtn4.y = 600;
			addChild($pBtn4);
		}
		
		public function setBmp( pic:BitmapData ):void {
			firstBmp.bitmapData = pic;
			with (firstBmp) {
				x = (1024 - firstBmp.width) * 0.5;
				y = (768 - firstBmp.height) * 0.5 ;
			}
			btnEnt2();
			$pBtn2.x =  (1024 - 190 * 2) / 3 + 83;
			$pBtn2.y = 476;
			
			$pBtn8 = new PBtn();
			$pBtn8.setBtnTxt( btnTxtBmpD_vct[6]);
			$pBtn8.setBtnName( "取消" );
			addChild($pBtn8);
			$pBtn8.y = 476;
			$pBtn8.x = (1024 - 190 * 2) / 3 +136+190;
			
			
			Enable_Msg(2);
			systemMsg_tf.setTextFormat(tfm);
			systemMsg_tf.text =  "你選擇的圖片" ;
			
			systemMsg_tf.x = (1024 - systemMsg_tf.width) * 0.5;
			systemMsg_tf.y = 240;
		}
		
		/**
		 * 設置系統文字
		 * @param	String
		 */
		public function setSysTxt( str:String ):void {
			systemMsg_tf.text = str;
		}
		
		private function closeSysMsgEnter():void {
			panelBmp.visible = false;
			$pBtn_enter.visible = false;
			systemMsg_tf.visible = false;
		}
		
		
		//問題可能在這裡，創建位圖的時候用100不透明，merge後無法顯示組件，用透明的話又達不到模糊效果。
		private var bitmap:Bitmap = new Bitmap();
		private var Background:Sprite = new Sprite();
		
		public  function draw(obj:*):void {
			var BackgroundBD:BitmapData = new BitmapData(1024, 768, true, 0xFF000000);
			var stageBackground:BitmapData = new BitmapData(1024, 768);
			stageBackground.draw(obj);
			var rect:Rectangle = new Rectangle(0, 0, 1024, 768);
			var point:Point = new Point(0, 0);
			var multiplier:uint = 130;
			
			BackgroundBD.merge(stageBackground, rect, point, multiplier, multiplier, multiplier,multiplier);
			BackgroundBD.applyFilter(BackgroundBD, rect, point, new BlurFilter(10, 10));
			bitmap.bitmapData = BackgroundBD;
		}
		
		public function clearBg():void {
			bitmap.bitmapData = null;
		}
		
	}
}
