package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class RecomPanel extends Window
    {
        public var main:Sprite;
        private var recom:ButtonBar;
        private var recomListcanvas:SimpleTree;
        private var recomInfor:TaskInforSp;
        private var recomtop:ToggleButtonBarUI;
        private var recomCav:AccordionContain;
        private var cavobj:Object;
        private var activsp:TaskActivInfor;
        private var activtop:ToggleButtonBarUI;
        private var tipflag:Boolean = true;
        private var _recomArr:Array;
        private var bitarr:Array;
        private var newRecomPanel:Sprite;
        private var scoreText:Label;
        private var starShape:Shape;
        private var lanText:Label;
        private var t1:Label;
        private var t2:Label;
        private var t3:Label;
        private var t4:Label;
        private var btn1:PushButton;
        private var btn2:PushButton;
        private var btn3:PushButton;
        private var btn4:PushButton;
        private var btn5:PushButton;
        private var newRecomCanvas:CanvasUI;
        private var inforObj:Object;
        public var containObj:Object;
        private var con1:Label;
        private var con2:Label;
        private var check1:CheckBox;
        private var check2:CheckBox;
        private var slot1:CloneSlot;
        private var slot2:CloneSlot;
        private var slot3:CloneSlot;
        private var slot4:CloneSlot;
        private var _alertId:uint;
        private var levelFlag:Boolean = true;
        private var _onlineActiveDGI:DataGridUI;
        public var _onlineActives:Object;
        private var _onlineActivePBs:Object;
        private var _onlineActiveCheckTimer:Number;
        private var _todaySpr:Sprite;
        private var _strDescriptArr:Array;
        private var _strNameArr:Array;
        private var _canvsActive:CanvasUI;
        private var labeldesc:TextField;
        public static var guideBtn:PushButton;

        public function RecomPanel(param1:DisplayObjectContainer = null)
        {
            this.cavobj = {};
            this._recomArr = new Array();
            this.bitarr = [];
            this.inforObj = {};
            this.containObj = {};
            this._onlineActives = {};
            this._onlineActivePBs = {};
            super(param1);
            this.initpanel();
            this.initsocket();
            this.initrecom();
            this.initSocket();
            this.initsecpage(null, 0);
            return;
        }// end function

        private function initSocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_NEWRECOM_LIST, this.comListFuc);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_NEWRECOM_UPDATE, this.comUpdate);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_DBACTIVITY, this.onlineActiveUpdate);
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_10:* = undefined;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            resize(620, 360);
            this.title = Config.language("RecomPanel", 1);
            this.main = new Sprite();
            this.addChild(this.main);
            this.newRecomPanel = new Sprite();
            var _loc_1:* = new Shape();
            this.newRecomPanel.addChild(_loc_1);
            _loc_1.graphics.beginFill(6710886, 0.2);
            _loc_1.graphics.drawRoundRect(10, 110, 380 + 40, 240, 1);
            _loc_1.graphics.drawRoundRect(395 + 40, 110, 175, 240, 1);
            _loc_1.graphics.endFill();
            var _loc_2:* = new Bitmap();
            this.newRecomPanel.addChild(_loc_2);
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                _loc_2.bitmapData = Config.findsysUI("headui/qq15", 104, 60);
            }
            else
            {
                _loc_2.bitmapData = Config.findsysUI("headui/recom", 130, 60);
            }
            _loc_2.x = 10;
            _loc_2.y = 50;
            var _loc_3:* = new Label(this.newRecomPanel, 160, 60, Config.language("RecomPanel", 2));
            this.scoreText = new Label(this.newRecomPanel, 240, 50);
            this.scoreText.html = true;
            this.starShape = new Shape();
            this.newRecomPanel.addChild(this.starShape);
            this.starShape.x = 290;
            this.starShape.y = 55 + 3;
            this.lanText = new Label(this.newRecomPanel, 160, 85);
            this.newRecomCanvas = new CanvasUI(this.newRecomPanel, 10, 115, 380 + 40, 230);
            var _loc_4:* = new Label(this.newRecomPanel, 400 + 40, 115, Config.language("RecomPanel", 3));
            var _loc_5:* = 0;
            while (_loc_5 < 4)
            {
                
                this["slot" + int((_loc_5 + 1))] = new CloneSlot(1, 32);
                this["slot" + int((_loc_5 + 1))].x = 405 + 40;
                this["slot" + int((_loc_5 + 1))].y = 140 + 50 * _loc_5;
                this.newRecomPanel.addChild(this["slot" + int((_loc_5 + 1))]);
                this["slot" + int((_loc_5 + 1))].addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                this["slot" + int((_loc_5 + 1))].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_16 = new Label(this.newRecomPanel, 445 + 40, 137 + 50 * _loc_5);
                if (_loc_5 == 0)
                {
                    _loc_16.text = Config.language("RecomPanel", 4);
                }
                else if (_loc_5 == 1)
                {
                    _loc_16.text = Config.language("RecomPanel", 5);
                }
                else if (_loc_5 == 2)
                {
                    _loc_16.text = Config.language("RecomPanel", 6);
                }
                else
                {
                    _loc_16.text = Config.language("RecomPanel", 7);
                }
                this["btn" + int((_loc_5 + 1))] = new PushButton(this.newRecomPanel, 445 + 40, 157 + 50 * _loc_5, "", Config.create(this.getBao, int((_loc_5 + 1))));
                this["btn" + int((_loc_5 + 1))].width = 60;
                this["t" + int((_loc_5 + 1))] = new Label(this.newRecomPanel, 445 + 40, 160 + 50 * _loc_5, Config.language("RecomPanel", 8));
                this["t" + int((_loc_5 + 1))].textColor = 11344686;
                _loc_5 = _loc_5 + 1;
            }
            var _loc_6:* = new Label(this.newRecomPanel, 400 + 40, 330, Config.language("RecomPanel", 9));
            this.btn5 = new PushButton(this.newRecomPanel, 500 + 50, 325, Config.language("RecomPanel", 10), Config.create(this.getBao, 5));
            this.btn5.width = 50;
            this.con1 = new Label(null, 30, 0);
            this.newRecomCanvas.addChildUI(this.con1);
            this.con1.html = true;
            var _loc_7:* = new LabelUI(null, 310, 3, Config.language("RecomPanel", 11));
            this.newRecomCanvas.addChildUI(_loc_7);
            var _loc_8:* = new LabelUI(null, 255, 3, Config.language("RecomPanel", 12));
            this.newRecomCanvas.addChildUI(_loc_8);
            this.check1 = new CheckBox(null, 15, 30, "                                  ", Config.create(this.showHideItem, 1));
            this.check1.iconStyle = 1;
            this.newRecomCanvas.addChildUI(this.check1);
            var _loc_9:* = 20;
            for (_loc_10 in Config._newRecom)
            {
                
                if (Config._newRecom[_loc_10].state == 1)
                {
                    _loc_17 = {};
                    _loc_17.t1 = new Label(null, 10, _loc_9);
                    _loc_17.t1.textColor = 26519;
                    this.newRecomCanvas.addChildUI(_loc_17.t1);
                    _loc_17.t2 = new ClickLabel(null, 30, _loc_9, Config._newRecom[_loc_10].name, Config.create(this.newRecomDo, int(Config._newRecom[_loc_10].id)));
                    _loc_17.t2.tip = Config.language("RecomPanel", 13, int(Config._newRecom[_loc_10].point) / 10 * Config._newRecom[_loc_10].maxtimes);
                    this.newRecomCanvas.addChildUI(_loc_17.t2);
                    _loc_17.t3 = new Label(null, 260, _loc_9);
                    this.newRecomCanvas.addChildUI(_loc_17.t3);
                    _loc_17.t4 = new Label(null, 320, _loc_9);
                    this.newRecomCanvas.addChildUI(_loc_17.t4);
                    _loc_18 = new PushButton(null, 360, _loc_9, Config.language("RecomPanel", 53), Config.create(this.newRecomDo, int(Config._newRecom[_loc_10].id)), null, "table18", "table31");
                    _loc_18.width = 40;
                    _loc_18.setTable("table18", "table31");
                    _loc_18.textColor = Style.GOLD_FONT;
                    _loc_18.overshow = true;
                    _loc_17.jionbtn = _loc_18;
                    this.newRecomCanvas.addChildUI(_loc_18);
                    this.containObj[Config._newRecom[_loc_10].id] = _loc_17;
                    _loc_9 = _loc_9 + 20;
                }
            }
            this.con2 = new Label(null, 30, 170);
            this.newRecomCanvas.addChildUI(this.con2);
            this.con2.html = true;
            this.check2 = new CheckBox(null, 15, 170, "                                  ", Config.create(this.showHideItem, 2));
            this.check2.iconStyle = 1;
            this.newRecomCanvas.addChildUI(this.check2);
            _loc_11 = [{datafield:"name", label:Config.language("RecomPanel", 36), len:90}, {datafield:"level", label:Config.language("RecomPanel", 37), len:100}, {datafield:"award", label:Config.language("RecomPanel", 38), len:100}, {datafield:"time", label:Config.language("RecomPanel", 39), len:180}, {datafield:"op", label:Config.language("RecomPanel", 47), childmc:"enterpb", len:100}];
            this._onlineActiveDGI = new DataGridUI(_loc_11, null, 10, 60, 600, 330, 30);
            this.freshOnlineActiveDGI();
            this._todaySpr = new Sprite();
            _loc_12 = new Sprite();
            _loc_13 = new Sprite();
            _loc_12.graphics.beginFill(16777215, 0.4);
            _loc_12.graphics.drawRoundRect(20, 60, 580, 120, 5);
            _loc_12.graphics.endFill();
            _loc_13.graphics.beginFill(16777215, 0.4);
            _loc_13.graphics.drawRoundRect(20, 190, 580, 150, 5);
            _loc_13.graphics.endFill();
            this._todaySpr.addChild(_loc_12);
            this._todaySpr.addChild(_loc_13);
            _loc_14 = new Label(this._todaySpr, 30, 70);
            _loc_14.html = true;
            _loc_14.text = Config.language("RecomPanel", 40);
            _loc_15 = new Label(this._todaySpr, 30, 200);
            _loc_15.html = true;
            _loc_15.text = Config.language("RecomPanel", 41);
            this._canvsActive = new CanvasUI(this._todaySpr, 30, 100, 520, 75);
            this.labeldesc = Config.getSimpleTextField();
            this.labeldesc.wordWrap = true;
            this.labeldesc.x = 40;
            this.labeldesc.y = 230;
            this.labeldesc.width = 540;
            this._todaySpr.addChild(this.labeldesc);
            return;
        }// end function

        private function checkOnlineActive()
        {
            var _loc_2:* = undefined;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_1:* = Config.now.getTime() / 1000;
            for (_loc_2 in this._onlineActivePBs)
            {
                
                if (this._onlineActivePBs[_loc_2] != null)
                {
                    if (isNaN(Number(Config._operatingActivityMap[_loc_2].levelLimit)) || Player.level >= Config._operatingActivityMap[_loc_2].levelLimit)
                    {
                        if (this._onlineActives[_loc_2] != null)
                        {
                            _loc_3 = this._onlineActives[_loc_2].startTime;
                            _loc_4 = this._onlineActives[_loc_2].endTime;
                            if (_loc_1 >= _loc_3 && _loc_1 <= _loc_4)
                            {
                                this._onlineActivePBs[_loc_2].enabled = true;
                            }
                            else
                            {
                                this._onlineActivePBs[_loc_2].enabled = false;
                            }
                        }
                        else
                        {
                            this._onlineActivePBs[_loc_2].enabled = false;
                        }
                        continue;
                    }
                    this._onlineActivePBs[_loc_2].enabled = false;
                }
            }
            return;
        }// end function

        private function freshOnlineActiveDGI()
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = undefined;
            var _loc_1:* = [];
            for (_loc_2 in Config._operatingActivityMap)
            {
                
                _loc_1.push({id:_loc_2, data:Config._operatingActivityMap[_loc_2]});
            }
            _loc_1.sortOn("id", Array.NUMERIC);
            _loc_3 = [];
            _loc_2 = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_4 = _loc_1[_loc_2].id;
                _loc_5 = _loc_1[_loc_2].data;
                if (this._onlineActivePBs[_loc_4] == null)
                {
                    this._onlineActivePBs[_loc_4] = new PushButton(null, 0, 3, Config.language("RecomPanel", 42), this.handleOpenAnswer);
                    this._onlineActivePBs[_loc_4].width = 90;
                    this._onlineActivePBs[_loc_4].data = _loc_4;
                }
                _loc_6 = "-";
                if (this._onlineActives[_loc_4] != null)
                {
                    _loc_7 = new Date(this._onlineActives[_loc_4].startTime * 1000);
                    _loc_8 = new Date(this._onlineActives[_loc_4].endTime * 1000);
                    _loc_9 = "" + _loc_7.getMinutes();
                    if (_loc_9.length == 1)
                    {
                        _loc_9 = "0" + _loc_9;
                    }
                    _loc_10 = "" + _loc_8.getMinutes();
                    if (_loc_10.length == 1)
                    {
                        _loc_10 = "0" + _loc_10;
                    }
                    _loc_6 = Config.language("RecomPanel", 43, (_loc_7.getMonth() + 1), _loc_7.getDate(), _loc_7.getHours(), _loc_9, _loc_8.getHours(), _loc_10);
                }
                _loc_3.push({name:_loc_5.name, level:_loc_5.levelLimit, award:_loc_5.award, time:_loc_6, enterpb:this._onlineActivePBs[_loc_4]});
                _loc_2 = _loc_2 + 1;
            }
            this._onlineActiveDGI.dataProvider = _loc_3;
            this.checkOnlineActive();
            return;
        }// end function

        private function onlineActiveUpdate(event:SocketEvent)
        {
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            var _loc_10:* = undefined;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            if (_loc_3 == 0)
            {
                this._onlineActives = {};
            }
            var _loc_4:* = _loc_2.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedInt();
                _loc_8 = _loc_2.readUnsignedInt();
                _loc_9 = [];
                _loc_10 = 0;
                while (_loc_10 < 10)
                {
                    
                    _loc_9.push(_loc_2.readUnsignedInt());
                    _loc_10 = _loc_10 + 1;
                }
                this._onlineActives[_loc_6] = {id:_loc_6, startTime:_loc_7, endTime:_loc_8, vars:_loc_9};
                _loc_5 = _loc_5 + 1;
            }
            this.freshOnlineActiveDGI();
            return;
        }// end function

        private function handleOpenAnswer(param1)
        {
            var _loc_2:* = PushButton(param1.currentTarget);
            if (_loc_2.data == 4001)
            {
                Config.ui._answerUI.open();
            }
            else if (_loc_2.data == 3001)
            {
                Config.ui._cclUI.open();
            }
            else if (_loc_2.data == 2002)
            {
                Config.ui._moraUI.open();
            }
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_RECOMMEND_LIST, this.getRecomList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_RECOMMEND_COMPLETE, this.addtaskRecomList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_ACTIVITY_NOTICE, this.getodayactivelist);
            return;
        }// end function

        public function reShowRecom() : void
        {
            if (this.stage != null && this.recom.selectpage == 0)
            {
                this.newRecomShow();
            }
            this.levelOpen();
            this.recomShow();
            return;
        }// end function

        public function levelOpen() : void
        {
            if (Config.player == null)
            {
                return;
            }
            if (this.stage == null && Config.player.level == 20 && this.levelFlag)
            {
                this.initsecpage(null, 0);
                this.newRecomShow();
                this.open();
            }
            return;
        }// end function

        private function initrecom() : void
        {
            var _loc_1:* = null;
            this.recom = new ButtonBar(this, 15, 25);
            this.recom.addTab(Config.language("RecomPanel", 14), Config.create(this.initsecpage, 0), 76);
            this.recom.addTab(Config.language("TaskPanel", 1), Config.create(this.initsecpage, 1), 76);
            if (!Config._switchMobage)
            {
                this.recom.addTab(Config.language("RecomPanel", 44), Config.create(this.initsecpage, 2), 76);
                this.recom.addTab(Config.language("RecomPanel", 45), Config.create(this.initsecpage, 3), 76);
            }
            this.recomCav = new AccordionContain(this.main, 10, 60, 600, 290);
            this.recomCav.addEventListener(AccTreeEvent.ACCORDCONTAIN_OPEN, this.accOpenRec);
            _loc_1 = [{datafield:"name", label:Config.language("TaskPanel", 3), len:120}, {datafield:"count", label:Config.language("TaskPanel", 4), len:80}, {datafield:"award", label:Config.language("TaskPanel", 5), len:150}, {datafield:"infor", label:Config.language("TaskPanel", 6), len:210}];
            this.recomtop = new ToggleButtonBarUI(_loc_1);
            this.activsp = new TaskActivInfor();
            _loc_1 = [{datafield:"name", label:Config.language("TaskPanel", 20), len:120}, {datafield:"level", label:Config.language("TaskPanel", 21), len:65}, {datafield:"award", label:Config.language("TaskPanel", 22), len:150}, {datafield:"time", label:Config.language("TaskPanel", 23), len:120}, {datafield:"npc", label:"NPC", len:105}];
            this.activtop = new ToggleButtonBarUI(_loc_1);
            return;
        }// end function

        public function initsecpage(event:MouseEvent = null, param2:int = 0) : void
        {
            if (this.recomInfor != null)
            {
                if (this.recomInfor.parent != null)
                {
                    this.recomInfor.parent.removeChild(this.recomInfor);
                }
            }
            if (this.activsp != null)
            {
                if (this.activsp.parent != null)
                {
                    this.activsp.parent.removeChild(this.activsp);
                }
            }
            this.removeallchild(this.main);
            if (param2 == 0)
            {
                this.main.addChild(this.newRecomPanel);
                this.recom.selectpage = 0;
            }
            else if (param2 == 1)
            {
                if (this.activtop != null)
                {
                    if (this.activtop.parent != null)
                    {
                        this.activtop.parent.removeChild(this.activtop);
                    }
                }
                this.recom.selectpage = 1;
                this.recomShow();
            }
            else if (param2 == 2)
            {
                this.main.addChild(this._onlineActiveDGI);
            }
            else if (param2 == 3)
            {
                this.initodayactive();
            }
            return;
        }// end function

        override public function switchOpen() : void
        {
            super.switchOpen();
            this.initsecpage(null, 0);
            return;
        }// end function

        override public function close()
        {
            super.close();
            clearInterval(this._onlineActiveCheckTimer);
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            clearInterval(this._onlineActiveCheckTimer);
            this._onlineActiveCheckTimer = setInterval(this.checkOnlineActive, 1000);
            return;
        }// end function

        override public function testGuide()
        {
            GuideUI.testDoId(142, this.containObj[3].t2);
            GuideUI.testDoId(198, this.containObj[2].t2);
            return;
        }// end function

        private function getRecomList(event:SocketEvent) : void
        {
            var _loc_5:* = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            this._recomArr = [];
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                this._recomArr.push(_loc_2.readUnsignedInt());
                _loc_5 = _loc_2.readUnsignedInt();
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        private function sendRecom(param1, param2:int, param3:Boolean) : void
        {
            var _loc_4:* = null;
            if (param3)
            {
                _loc_4 = new DataSet();
                _loc_4.addHead(CONST_ENUM.C2G_RECOMMEND_COMPLETE);
                _loc_4.add32(param2);
                ClientSocket.send(_loc_4);
            }
            else
            {
                Config.message(Config.language("TaskPanel", 36));
            }
            return;
        }// end function

        public function addtaskRecomList(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            this._recomArr.push(_loc_2.readUnsignedInt());
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.recomShow();
            Config.message(Config.language("TaskPanel", 37));
            return;
        }// end function

        private function recomShow() : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = 0;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = undefined;
            if (Config.player == null)
            {
                return;
            }
            var _loc_1:* = new Object();
            for (_loc_2 in Config._recomList)
            {
                
                if (int(Config._recomList[_loc_2].openStatus) == 1)
                {
                    if (!_loc_1.hasOwnProperty(Config._recomList[_loc_2].playerLevel))
                    {
                        _loc_1[Config._recomList[_loc_2].playerLevel] = {};
                        _loc_1[Config._recomList[_loc_2].playerLevel].lists = {};
                        _loc_1[Config._recomList[_loc_2].playerLevel].open = true;
                        _loc_1[Config._recomList[_loc_2].playerLevel].done = false;
                        _loc_1[Config._recomList[_loc_2].playerLevel].status = true;
                        _loc_1[Config._recomList[_loc_2].playerLevel].num = 0;
                    }
                    _loc_5 = {};
                    _loc_6 = Config._recomList[_loc_2].children();
                    for (_loc_7 in _loc_6)
                    {
                        
                        _loc_5[_loc_6[_loc_7].name()] = _loc_6[_loc_7];
                    }
                    _loc_5.itemdone = false;
                    _loc_8 = String(_loc_5.taskId).split("|");
                    _loc_9 = 0;
                    while (_loc_9 < _loc_8.length)
                    {
                        
                        if (Config.ui._taskpanel.taskRecomList[_loc_8[_loc_9]] != null)
                        {
                            _loc_5.itemdone = true;
                            break;
                        }
                        _loc_9 = _loc_9 + 1;
                    }
                    if (!_loc_5.itemdone)
                    {
                        _loc_1[Config._recomList[_loc_2].playerLevel].status = false;
                    }
                    _loc_1[Config._recomList[_loc_2].playerLevel].lists[Config._recomList[_loc_2].id] = _loc_5;
                    (_loc_1[Config._recomList[_loc_2].playerLevel].num + 1);
                }
            }
            _loc_3 = 0;
            while (_loc_3 < this._recomArr.length)
            {
                
                for (_loc_10 in Config._recomList)
                {
                    
                    if (int(Config._recomList[_loc_10].level) == this._recomArr[_loc_3])
                    {
                        _loc_1[String(Config._recomList[_loc_10].playerLevel)].open = false;
                        _loc_1[String(Config._recomList[_loc_10].playerLevel)].done = true;
                        break;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            for (_loc_4 in this.cavobj)
            {
                
                if (_loc_1.hasOwnProperty(_loc_4))
                {
                    _loc_1[_loc_4].open = this.cavobj[_loc_4];
                }
            }
            if (this.stage != null && this.recom.selectpage == 1)
            {
                this.recomlist(_loc_1);
            }
            this.showComTip(_loc_1);
            return;
        }// end function

        private function showComTip(param1:Object) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = 0;
            var _loc_6:* = null;
            var _loc_2:* = [];
            for (_loc_3 in param1)
            {
                
                _loc_2.push(int(_loc_3));
            }
            _loc_2.sort(Array.NUMERIC);
            _loc_4 = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                if (int(_loc_2[_loc_4]) > Config.player.level)
                {
                    _loc_2.length = _loc_4 + 1;
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            _loc_2.sort(Array.NUMERIC | Array.DESCENDING);
            this.tipflag = true;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_2.length)
            {
                
                if (this.tipflag && this.stage == null && param1[_loc_2[_loc_5]].status && !param1[_loc_2[_loc_5]].done)
                {
                    _loc_6 = new Object();
                    _loc_6.type = 6;
                    _loc_6.fname = "recom";
                    ListTip.addList(_loc_6);
                    this.tipflag = false;
                    break;
                }
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        private function recomlist(param1:Object) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            this.recomCav.removeAllChildren();
            this.main.addChild(this.recomCav);
            var _loc_2:* = [];
            for (_loc_3 in param1)
            {
                
                _loc_2.push(int(_loc_3));
            }
            _loc_2.sort(Array.NUMERIC);
            _loc_4 = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                if (int(_loc_2[_loc_4]) > Config.player.level)
                {
                    _loc_2.length = _loc_4 + 1;
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            _loc_2.sort(Array.NUMERIC | Array.DESCENDING);
            this.tipflag = true;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_2.length)
            {
                
                _loc_6 = 0;
                for (_loc_7 in param1[_loc_2[_loc_5]].lists)
                {
                    
                    _loc_6 = _loc_7;
                    break;
                }
                _loc_8 = new Sprite();
                _loc_9 = 1399056;
                _loc_10 = "";
                if (Config.player.level >= int(_loc_2[_loc_5]))
                {
                    if (param1[_loc_2[_loc_5]].status)
                    {
                        _loc_9 = 1399056;
                        _loc_10 = Config.language("TaskPanel", 38);
                    }
                    else
                    {
                        _loc_9 = 11344686;
                        _loc_10 = Config.language("TaskPanel", 39);
                    }
                }
                else
                {
                    _loc_9 = 6710886;
                    _loc_10 = Config.language("TaskPanel", 40);
                }
                _loc_11 = new Label(_loc_8, 20, 5, "<b>LV: " + _loc_2[_loc_5] + "<b>");
                _loc_11.html = true;
                _loc_11.textColor = _loc_9;
                _loc_11.mouseEnabled = false;
                _loc_11.mouseChildren = false;
                _loc_12 = new Label(_loc_8, 100, 5, _loc_10);
                _loc_12.html = true;
                _loc_12.textColor = _loc_9;
                _loc_12.mouseEnabled = false;
                _loc_12.mouseChildren = false;
                _loc_13 = new Label(_loc_8, 255, 5, Config.language("TaskPanel", 41));
                _loc_14 = [Config.language("TaskInfor", 8), Config.language("TaskInfor", 9), Config.language("TaskInfor", 6), Config.language("TaskInfor", 7), Config.language("TaskInfor", 10)];
                if (param1[_loc_2[_loc_5]].lists[_loc_6].rewardType1 > 0)
                {
                    if (int(param1[_loc_2[_loc_5]].lists[_loc_6].rewardType2) > 0)
                    {
                        _loc_13 = new Label(_loc_8, 290, 5, _loc_14[(param1[_loc_2[_loc_5]].lists[_loc_6].rewardType1 - 1)] + param1[_loc_2[_loc_5]].lists[_loc_6].rewardValue1);
                    }
                    else
                    {
                        _loc_13 = new Label(_loc_8, 380, 5, _loc_14[(param1[_loc_2[_loc_5]].lists[_loc_6].rewardType1 - 1)] + param1[_loc_2[_loc_5]].lists[_loc_6].rewardValue1);
                    }
                }
                else if (param1[_loc_2[_loc_5]].lists[_loc_6].rewardType2 > 0)
                {
                    _loc_19 = new Label(_loc_8, 290, 5, _loc_14[(param1[_loc_2[_loc_5]].lists[_loc_6].rewardType2 - 1)] + param1[_loc_2[_loc_5]].lists[_loc_6].rewardValue2);
                }
                _loc_15 = new PushButton(_loc_8, 445, 5, Config.language("TaskPanel", 42), Config.create(this.sendRecom, param1[_loc_2[_loc_5]].lists[_loc_6].level, param1[_loc_2[_loc_5]].status));
                _loc_15.width = 80;
                if (!param1[_loc_2[_loc_5]].status)
                {
                    _loc_15.enabled = false;
                }
                if (param1[_loc_2[_loc_5]].done)
                {
                    _loc_15.enabled = false;
                    _loc_15.label = Config.language("TaskPanel", 43);
                }
                _loc_16 = new Sprite();
                _loc_17 = 0;
                _loc_18 = 0;
                for (_loc_7 in param1[_loc_2[_loc_5]].lists)
                {
                    
                    _loc_20 = new Label(_loc_16, 5, _loc_17);
                    _loc_20.html = true;
                    _loc_20.mouseEnabled = true;
                    if (param1[_loc_2[_loc_5]].lists[_loc_7].itemdone)
                    {
                        _loc_20.textColor = 1399056;
                        _loc_20.text = DescriptionTranslate.translate("√ " + param1[_loc_2[_loc_5]].lists[_loc_7].target, _loc_20.tf);
                    }
                    else
                    {
                        _loc_20.textColor = 11344686;
                        _loc_20.text = DescriptionTranslate.translate("◆ " + param1[_loc_2[_loc_5]].lists[_loc_7].target, _loc_20.tf);
                    }
                    if (Config.player.level < int(_loc_2[_loc_5]))
                    {
                        _loc_20.textColor = 6710886;
                        _loc_20.text = DescriptionTranslate.translate("※ " + param1[_loc_2[_loc_5]].lists[_loc_7].target);
                        _loc_15.enabled = false;
                    }
                    _loc_17 = _loc_17 + 25;
                    _loc_18 = _loc_7;
                }
                if (String(param1[_loc_2[_loc_5]].lists[_loc_18].targetDescription1) != "undefined")
                {
                    _loc_17 = _loc_17 + 10;
                    _loc_21 = new Label(_loc_16, 5, _loc_17, "— " + param1[_loc_2[_loc_5]].lists[_loc_18].targetDescription1);
                    _loc_21.textColor = 6710886;
                    _loc_21.html = true;
                }
                this.recomCav.addItem(_loc_2[_loc_5], _loc_8, _loc_16, param1[_loc_2[_loc_5]].open);
                _loc_5 = _loc_5 + 1;
            }
            this.recomCav.reSetShow();
            return;
        }// end function

        private function accOpenRec(event:AccTreeEvent) : void
        {
            this.cavobj = event.typeobj;
            return;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_2:* = param1.currentTarget;
            var _loc_3:* = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            if (_loc_2.item != null)
            {
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), false, 0, 200);
            }
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function comListFuc(event:SocketEvent) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = event.data;
            this.inforObj.score = _loc_2.readUnsignedInt();
            this.inforObj.score_yDay = _loc_2.readUnsignedInt();
            this.inforObj.flag = _loc_2.readUnsignedInt();
            this.inforObj.flag_yDay = _loc_2.readUnsignedInt();
            this.inforObj.num = _loc_2.readUnsignedShort();
            this.inforObj.openItem1 = true;
            this.inforObj.openItem2 = true;
            this.inforObj.recomArr = {};
            var _loc_3:* = 0;
            while (_loc_3 < this.inforObj.num)
            {
                
                _loc_4 = {};
                _loc_4.id = _loc_2.readUnsignedInt();
                _loc_4.recomCount = _loc_2.readUnsignedInt();
                _loc_4.recomScore = _loc_2.readUnsignedInt();
                _loc_4.type = int(Config._newRecom[_loc_4.id].type);
                _loc_4.order = int(Config._newRecom[_loc_4.id].order);
                if (int(Config._newRecom[_loc_4.id].maxtimes) <= _loc_4.recomCount)
                {
                    _loc_4.overFlag = 2;
                }
                else
                {
                    _loc_4.overFlag = 1;
                }
                this.inforObj.recomArr[_loc_4.id] = _loc_4;
                _loc_3 = _loc_3 + 1;
            }
            this.newRecomShow();
            return;
        }// end function

        private function comUpdate(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.inforObj.recomArr[_loc_3].recomCount = _loc_2.readUnsignedInt();
            this.inforObj.recomArr[_loc_3].recomScore = _loc_2.readUnsignedInt();
            if (int(Config._newRecom[_loc_3].maxtimes) <= this.inforObj.recomArr[_loc_3].recomCount)
            {
                this.inforObj.recomArr[_loc_3].overFlag = 2;
            }
            else
            {
                this.inforObj.recomArr[_loc_3].overFlag = 1;
            }
            return;
        }// end function

        private function newRecomShow() : void
        {
            var _loc_9:* = undefined;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            if (Config.player.level == 20 && this.levelFlag)
            {
                this.levelFlag = false;
                this._alertId = AlertUI.alert(Config.language("RecomPanel", 15), Config.language("RecomPanel", 16), [Config.language("RecomPanel", 17)]);
            }
            this.scoreText.text = "<font size=\'25\' color=\'#30C74C\'><b>" + int(this.inforObj.score / 10) + "</b></font>";
            var _loc_1:* = int(this.inforObj.score / 100);
            var _loc_2:* = 0;
            while (_loc_2 < 10)
            {
                
                this.starShape.graphics.lineStyle(1, 16737792, 1, false);
                if (_loc_2 < _loc_1)
                {
                    this.starShape.graphics.beginFill(16777164, 1);
                }
                else
                {
                    this.starShape.graphics.beginFill(6710886, 1);
                }
                DrawUtils.star(this.starShape, 22 * _loc_2, 10, 5, 5, 10, 90);
                this.starShape.graphics.endFill();
                _loc_2 = _loc_2 + 1;
            }
            if (_loc_1 < 1)
            {
                this.lanText.text = Config.language("RecomPanel", 18);
                this.t1.visible = true;
                this.t2.visible = true;
                this.t3.visible = true;
                this.t4.visible = true;
            }
            else if (_loc_1 < 7)
            {
                this.lanText.text = Config.language("RecomPanel", 19);
                this.t1.visible = false;
                this.t2.visible = true;
                this.t3.visible = true;
                this.t4.visible = true;
            }
            else if (_loc_1 < 9)
            {
                this.lanText.text = Config.language("RecomPanel", 20);
                this.t1.visible = false;
                this.t2.visible = false;
                this.t3.visible = true;
                this.t4.visible = true;
            }
            else if (_loc_1 < 10)
            {
                this.lanText.text = Config.language("RecomPanel", 21);
                this.t1.visible = false;
                this.t2.visible = false;
                this.t3.visible = false;
                this.t4.visible = true;
            }
            else
            {
                this.lanText.text = Config.language("RecomPanel", 22);
                this.t1.visible = false;
                this.t2.visible = false;
                this.t3.visible = false;
                this.t4.visible = false;
            }
            this.setLingFuc();
            this.baoShow();
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = [];
            var _loc_8:* = [];
            for (_loc_9 in this.inforObj.recomArr)
            {
                
                if (this.inforObj.recomArr[_loc_9].recomScore > 0 && this.containObj[this.inforObj.recomArr[_loc_9].id] != null)
                {
                    if (this.inforObj.recomArr[_loc_9].overFlag == 2)
                    {
                        this.containObj[this.inforObj.recomArr[_loc_9].id].t1.text = "√";
                        this.containObj[this.inforObj.recomArr[_loc_9].id].jionbtn.enabled = false;
                        this.containObj[this.inforObj.recomArr[_loc_9].id].jionbtn.overshow = false;
                        this.containObj[this.inforObj.recomArr[_loc_9].id].jionbtn.label = Config.language("RecomPanel", 54);
                    }
                    else
                    {
                        this.containObj[this.inforObj.recomArr[_loc_9].id].t1.text = " ";
                        this.containObj[this.inforObj.recomArr[_loc_9].id].jionbtn.enabled = true;
                        this.containObj[this.inforObj.recomArr[_loc_9].id].jionbtn.overshow = true;
                        this.containObj[this.inforObj.recomArr[_loc_9].id].jionbtn.label = Config.language("RecomPanel", 53);
                        this.containObj[this.inforObj.recomArr[_loc_9].id].jionbtn.textColor = Style.GOLD_FONT;
                    }
                    this.containObj[this.inforObj.recomArr[_loc_9].id].t2.clickColor([26519, 39423]);
                    this.containObj[this.inforObj.recomArr[_loc_9].id].t3.textColor = 26519;
                    this.containObj[this.inforObj.recomArr[_loc_9].id].t4.textColor = 26519;
                    this.containObj[this.inforObj.recomArr[_loc_9].id].t3.text = this.inforObj.recomArr[_loc_9].recomCount + "/" + Config._newRecom[this.inforObj.recomArr[_loc_9].id].maxtimes;
                    this.containObj[this.inforObj.recomArr[_loc_9].id].t4.text = "+ " + int(this.inforObj.recomArr[_loc_9].recomScore / 10);
                    this.newRecomCanvas.addChildUI(this.containObj[this.inforObj.recomArr[_loc_9].id].t2);
                    this.newRecomCanvas.addChildUI(this.containObj[this.inforObj.recomArr[_loc_9].id].jionbtn);
                    if (this.inforObj.recomArr[_loc_9].type == 1)
                    {
                        _loc_3++;
                    }
                    else
                    {
                        _loc_4++;
                    }
                }
                else if (this.containObj[this.inforObj.recomArr[_loc_9].id] != null)
                {
                    this.containObj[this.inforObj.recomArr[_loc_9].id].t1.text = " ";
                    this.containObj[this.inforObj.recomArr[_loc_9].id].t2.clickColor([4722696, 39423]);
                    this.containObj[this.inforObj.recomArr[_loc_9].id].t3.textColor = 4722696;
                    this.containObj[this.inforObj.recomArr[_loc_9].id].t4.textColor = 4722696;
                    this.containObj[this.inforObj.recomArr[_loc_9].id].t3.text = this.inforObj.recomArr[_loc_9].recomCount + "/" + Config._newRecom[this.inforObj.recomArr[_loc_9].id].maxtimes;
                    this.containObj[this.inforObj.recomArr[_loc_9].id].t4.text = " ";
                    this.newRecomCanvas.addChildUI(this.containObj[this.inforObj.recomArr[_loc_9].id].t2);
                    this.containObj[this.inforObj.recomArr[_loc_9].id].jionbtn.enabled = true;
                    this.containObj[this.inforObj.recomArr[_loc_9].id].jionbtn.overshow = true;
                    this.containObj[this.inforObj.recomArr[_loc_9].id].jionbtn.label = Config.language("RecomPanel", 53);
                    this.containObj[this.inforObj.recomArr[_loc_9].id].jionbtn.textColor = Style.GOLD_FONT;
                    this.newRecomCanvas.addChildUI(this.containObj[this.inforObj.recomArr[_loc_9].id].jionbtn);
                }
                if (this.inforObj.recomArr[_loc_9].type == 1)
                {
                    _loc_5++;
                    _loc_7.push(this.inforObj.recomArr[_loc_9]);
                    continue;
                }
                _loc_6++;
                _loc_8.push(this.inforObj.recomArr[_loc_9]);
            }
            this.con1.text = Config.language("RecomPanel", 23, _loc_3, _loc_5);
            this.con2.text = Config.language("RecomPanel", 24, _loc_4, _loc_6);
            this.check1.selected = this.inforObj.openItem1;
            this.check2.selected = this.inforObj.openItem2;
            _loc_7.sortOn(["overFlag", "order"], [Array.NUMERIC, Array.NUMERIC]);
            _loc_8.sortOn(["overFlag", "order"], [Array.NUMERIC, Array.NUMERIC]);
            this.con1.y = 0;
            this.check1.y = 5;
            _loc_10 = 20;
            _loc_11 = 0;
            while (_loc_11 < _loc_7.length)
            {
                
                if (this.inforObj.openItem1)
                {
                    this.newRecomCanvas.addChildUI(this.containObj[_loc_7[_loc_11].id].t1);
                    this.newRecomCanvas.addChildUI(this.containObj[_loc_7[_loc_11].id].t2);
                    this.newRecomCanvas.addChildUI(this.containObj[_loc_7[_loc_11].id].t3);
                    this.newRecomCanvas.addChildUI(this.containObj[_loc_7[_loc_11].id].t4);
                    this.newRecomCanvas.addChildUI(this.containObj[_loc_7[_loc_11].id].jionbtn);
                    this.containObj[_loc_7[_loc_11].id].t1.y = _loc_10;
                    this.containObj[_loc_7[_loc_11].id].t2.y = _loc_10;
                    this.containObj[_loc_7[_loc_11].id].t3.y = _loc_10;
                    this.containObj[_loc_7[_loc_11].id].t4.y = _loc_10;
                    this.containObj[_loc_7[_loc_11].id].jionbtn.y = _loc_10;
                    _loc_10 = _loc_10 + 20;
                }
                else
                {
                    if (this.containObj[_loc_7[_loc_11].id].t1.parent != null)
                    {
                        this.newRecomCanvas.removeChildUI(this.containObj[_loc_7[_loc_11].id].t1);
                    }
                    if (this.containObj[_loc_7[_loc_11].id].t2.parent != null)
                    {
                        this.newRecomCanvas.removeChildUI(this.containObj[_loc_7[_loc_11].id].t2);
                    }
                    if (this.containObj[_loc_7[_loc_11].id].t3.parent != null)
                    {
                        this.newRecomCanvas.removeChildUI(this.containObj[_loc_7[_loc_11].id].t3);
                    }
                    if (this.containObj[_loc_7[_loc_11].id].t4.parent != null)
                    {
                        this.newRecomCanvas.removeChildUI(this.containObj[_loc_7[_loc_11].id].t4);
                    }
                    if (this.containObj[_loc_7[_loc_11].id].jionbtn.parent != null)
                    {
                        this.newRecomCanvas.removeChildUI(this.containObj[_loc_7[_loc_11].id].jionbtn);
                    }
                }
                _loc_11 = _loc_11 + 1;
            }
            _loc_10 = _loc_10 + 5;
            this.con2.y = _loc_10;
            this.check2.y = _loc_10 + 5;
            _loc_10 = _loc_10 + 20;
            var _loc_12:* = 0;
            while (_loc_12 < _loc_8.length)
            {
                
                if (this.inforObj.openItem2)
                {
                    this.newRecomCanvas.addChildUI(this.containObj[_loc_8[_loc_12].id].t1);
                    this.newRecomCanvas.addChildUI(this.containObj[_loc_8[_loc_12].id].t2);
                    this.newRecomCanvas.addChildUI(this.containObj[_loc_8[_loc_12].id].t3);
                    this.newRecomCanvas.addChildUI(this.containObj[_loc_8[_loc_12].id].t4);
                    this.newRecomCanvas.addChildUI(this.containObj[_loc_8[_loc_12].id].jionbtn);
                    this.containObj[_loc_8[_loc_12].id].t1.y = _loc_10;
                    this.containObj[_loc_8[_loc_12].id].t2.y = _loc_10;
                    this.containObj[_loc_8[_loc_12].id].t3.y = _loc_10;
                    this.containObj[_loc_8[_loc_12].id].t4.y = _loc_10;
                    this.containObj[_loc_8[_loc_12].id].jionbtn.y = _loc_10;
                    _loc_10 = _loc_10 + 20;
                }
                else
                {
                    if (this.containObj[_loc_8[_loc_12].id].t1.parent != null)
                    {
                        this.newRecomCanvas.removeChildUI(this.containObj[_loc_8[_loc_12].id].t1);
                    }
                    if (this.containObj[_loc_8[_loc_12].id].t2.parent != null)
                    {
                        this.newRecomCanvas.removeChildUI(this.containObj[_loc_8[_loc_12].id].t2);
                    }
                    if (this.containObj[_loc_8[_loc_12].id].t3.parent != null)
                    {
                        this.newRecomCanvas.removeChildUI(this.containObj[_loc_8[_loc_12].id].t3);
                    }
                    if (this.containObj[_loc_8[_loc_12].id].t4.parent != null)
                    {
                        this.newRecomCanvas.removeChildUI(this.containObj[_loc_8[_loc_12].id].t4);
                    }
                    if (this.containObj[_loc_8[_loc_12].id].jionbtn.parent != null)
                    {
                        this.newRecomCanvas.removeChildUI(this.containObj[_loc_8[_loc_12].id].jionbtn);
                    }
                }
                _loc_12 = _loc_12 + 1;
            }
            this.newRecomCanvas.reFresh();
            return;
        }// end function

        private function setLingFuc() : void
        {
            this.btn1.visible = false;
            this.btn2.visible = false;
            this.btn3.visible = false;
            this.btn4.visible = false;
            this.btn1.enabled = true;
            this.btn2.enabled = true;
            this.btn3.enabled = true;
            this.btn4.enabled = true;
            this.btn5.enabled = false;
            this.btn5.label = Config.language("RecomPanel", 25);
            var _loc_1:* = "0000" + Number(this.inforObj.flag).toString(2);
            var _loc_2:* = _loc_1.substr(_loc_1.length - 4, 4);
            if (int(_loc_2.substr(3, 1)) == 0)
            {
                if (this.inforObj.score >= 100)
                {
                    this.btn1.visible = true;
                    this.btn1.label = Config.language("RecomPanel", 10);
                }
            }
            else
            {
                this.btn1.visible = true;
                this.btn1.enabled = false;
                this.btn1.label = Config.language("RecomPanel", 26);
            }
            if (int(_loc_2.substr(2, 1)) == 0)
            {
                if (this.inforObj.score >= 700)
                {
                    this.btn2.visible = true;
                    this.btn2.label = Config.language("RecomPanel", 10);
                }
            }
            else
            {
                this.btn2.visible = true;
                this.btn2.enabled = false;
                this.btn2.label = Config.language("RecomPanel", 26);
            }
            if (int(_loc_2.substr(1, 1)) == 0)
            {
                if (this.inforObj.score >= 900)
                {
                    this.btn3.visible = true;
                    this.btn3.label = Config.language("RecomPanel", 10);
                }
            }
            else
            {
                this.btn3.visible = true;
                this.btn3.enabled = false;
                this.btn3.label = Config.language("RecomPanel", 26);
            }
            if (int(_loc_2.substr(0, 1)) == 0)
            {
                if (this.inforObj.score >= 1000)
                {
                    this.btn4.visible = true;
                    this.btn4.label = Config.language("RecomPanel", 10);
                }
            }
            else
            {
                this.btn4.visible = true;
                this.btn4.enabled = false;
                this.btn4.label = Config.language("RecomPanel", 26);
            }
            var _loc_3:* = "0000" + Number(this.inforObj.flag_yDay).toString(2);
            var _loc_4:* = _loc_3.substr(_loc_3.length - 4, 4);
            if (int(_loc_4.substr(3, 1)) == 0 && this.inforObj.score_yDay >= 100)
            {
                this.btn5.label = Config.language("RecomPanel", 10);
                this.btn5.enabled = true;
            }
            if (int(_loc_4.substr(2, 1)) == 0 && this.inforObj.score_yDay >= 700)
            {
                this.btn5.label = Config.language("RecomPanel", 10);
                this.btn5.enabled = true;
            }
            if (int(_loc_4.substr(1, 1)) == 0 && this.inforObj.score_yDay >= 900)
            {
                this.btn5.label = Config.language("RecomPanel", 10);
                this.btn5.enabled = true;
            }
            if (int(_loc_4.substr(0, 1)) == 0 && this.inforObj.score_yDay >= 1000)
            {
                this.btn5.label = Config.language("RecomPanel", 10);
                this.btn5.enabled = true;
            }
            return;
        }// end function

        private function baoShow() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 1;
            while (_loc_1 < 5)
            {
                
                if (this["slot" + _loc_1].item != null)
                {
                    this["slot" + _loc_1].item.destroy();
                }
                _loc_2 = Item.newItem(Config._itemMap[Config._ListExp[Config.player.level]["activeBox" + _loc_1]], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                _loc_2.display();
                this["slot" + _loc_1].item = _loc_2;
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function getBao(event:MouseEvent, param2:int) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_NEWRECOM_GIFT);
            if (param2 == 5)
            {
                _loc_3.add32(1);
            }
            else
            {
                _loc_3.add32(0);
            }
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function newRecomDo(param1, param2:int) : void
        {
            var _loc_3:* = false;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            AlertUI.remove(this._alertId);
            switch(param2)
            {
                case 1:
                {
                    Config.message(Config.language("RecomPanel", 27));
                    break;
                }
                case 2:
                {
                    if (Config.player.level >= 15)
                    {
                        Config.ui._onlineExpn.open();
                    }
                    else
                    {
                        Config.message(Config.language("RecomPanel", 28));
                    }
                    break;
                }
                case 3:
                {
                    _loc_3 = true;
                    _loc_4 = Config.ui._taskpanel.tasklistarr;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4.length)
                    {
                        
                        if (Config._taskMap[_loc_4[_loc_5].id].type == 2)
                        {
                            Config.ui._taskpanel.open();
                            Config.ui._taskpanel.opentaskinfor(_loc_4[_loc_5].id, true);
                            _loc_3 = false;
                            break;
                        }
                        _loc_5 = _loc_5 + 1;
                    }
                    if (_loc_3)
                    {
                        if (Config.ui._taskpanel.taskIsDwon(551))
                        {
                            Config.ui._taskpanel.dayListPanel.open();
                        }
                        else
                        {
                            Config.message(Config.language("RecomPanel", 29));
                        }
                    }
                    break;
                }
                case 4:
                {
                    _loc_3 = true;
                    _loc_4 = Config.ui._taskpanel.tasklistarr;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4.length)
                    {
                        
                        if (Config._taskMap[_loc_4[_loc_5].id].type == 4)
                        {
                            Config.ui._taskpanel.open();
                            Config.ui._taskpanel.opentaskinfor(_loc_4[_loc_5].id, true);
                            _loc_3 = false;
                            break;
                        }
                        _loc_5 = _loc_5 + 1;
                    }
                    if (_loc_3)
                    {
                        if (Config.ui._taskpanel.taskIsDwon(571))
                        {
                            Config.ui._dayGiftPanel.switchOpen();
                        }
                        else
                        {
                            Config.message(Config.language("RecomPanel", 30));
                        }
                    }
                    break;
                }
                case 5:
                {
                    Config.ui._quickUI.showGoldGuide();
                    break;
                }
                case 6:
                {
                    Config.ui._quickUI.showPickGuide();
                    break;
                }
                case 7:
                {
                    Config.ui._zoommap.moveFly(int(Config._ListExp[Config.player.level].eliteMap));
                    break;
                }
                case 8:
                {
                    Config.ui._energyPanel.open();
                    break;
                }
                case 9:
                {
                    Config.ui._zoommap.moveFly(int(Config._ListExp[Config.player.level].eliteMap));
                    break;
                }
                case 10:
                {
                    Config.ui._activePanel.open();
                    break;
                }
                case 11:
                {
                    if (Config.player.level >= 35)
                    {
                        Config.ui._giftDare.open();
                    }
                    else
                    {
                        Config.message(Config.language("RecomPanel", 34));
                    }
                    break;
                }
                case 12:
                {
                    if (Config.player.level >= 20)
                    {
                        Config.ui._fbEntranceUI.open();
                    }
                    else
                    {
                        Config.message(Config.language("RecomPanel", 35));
                    }
                    break;
                }
                case 14:
                {
                    Config.ui._transport.open();
                    break;
                }
                case 15:
                {
                    break;
                }
                case 16:
                {
                    Config.ui._interPkPanel.switchOpen();
                    break;
                }
                case 17:
                {
                    if (Config.player.level >= 40)
                    {
                        Config.ui._toAirPanel.switchOpen();
                    }
                    else
                    {
                        Config.message(Config.language("RecomPanel", 52));
                    }
                    break;
                }
                case 18:
                {
                    if (Config.player.level >= 100)
                    {
                        Config.ui._activePanel.opengiftdare();
                    }
                    else
                    {
                        Config.message(Config.language("RecomPanel", 48));
                    }
                    break;
                }
                case 19:
                {
                    if (Config.player.level >= 96)
                    {
                        Config.ui._activePanel.opengiftdare();
                    }
                    else
                    {
                        Config.message(Config.language("RecomPanel", 49));
                    }
                    break;
                }
                case 20:
                {
                    if (Config.player.level >= 100)
                    {
                        Config.ui._manyplayertoair.switchOpen();
                    }
                    else
                    {
                        Config.message(Config.language("RecomPanel", 50));
                    }
                    break;
                }
                case 21:
                {
                    if (Config.player.level >= 50)
                    {
                        Config.ui._activePanel.opengiftdare();
                    }
                    else
                    {
                        Config.message(Config.language("RecomPanel", 51));
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function set daySc(param1:int) : void
        {
            this.inforObj.score = param1;
            this.newRecomShow();
            return;
        }// end function

        public function set ydaySc(param1:int) : void
        {
            this.inforObj.score_yDay = param1;
            this.setLingFuc();
            return;
        }// end function

        public function set dayType(param1:int) : void
        {
            this.inforObj.flag = param1;
            this.setLingFuc();
            return;
        }// end function

        public function set ydayType(param1:int) : void
        {
            this.inforObj.flag_yDay = param1;
            this.setLingFuc();
            return;
        }// end function

        private function removeallchild(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        private function hangmap(event:MouseEvent, param2:int) : void
        {
            Hang.hangMap(param2);
            return;
        }// end function

        private function showHideItem(event:MouseEvent, param2:int) : void
        {
            if (param2 == 1)
            {
                this.inforObj.openItem1 = !this.inforObj.openItem1;
            }
            else
            {
                this.inforObj.openItem2 = !this.inforObj.openItem2;
            }
            this.newRecomShow();
            return;
        }// end function

        private function getodayactivelist(event:SocketEvent)
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            this._strDescriptArr = [];
            this._strNameArr = [];
            this._canvsActive.removeAllChildren();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2.readByte();
                _loc_6 = _loc_2.readUnsignedShort();
                _loc_7 = _loc_2.readUTFBytes(_loc_6);
                _loc_8 = _loc_2.readUnsignedShort();
                _loc_9 = _loc_2.readUTFBytes(_loc_8);
                this._strNameArr.push(_loc_7);
                this._strDescriptArr.push(_loc_9);
                _loc_10 = new Sprite();
                _loc_10.graphics.beginFill(15061416);
                _loc_10.graphics.drawRoundRect(10, _loc_4 * 25, 510, 20, 5);
                _loc_10.graphics.endFill();
                _loc_10.alpha = 0.5;
                _loc_10.addEventListener(MouseEvent.CLICK, this.spclick);
                _loc_10.addEventListener(MouseEvent.MOUSE_OVER, this.spover);
                _loc_10.addEventListener(MouseEvent.MOUSE_OUT, this.spout);
                _loc_10.name = String(_loc_4);
                _loc_11 = new Label(null, 20, 2 + 25 * _loc_4, Config.language("RecomPanel", 46, (_loc_4 + 1), _loc_7));
                this._canvsActive.addChildUI(_loc_10);
                this._canvsActive.addChildUI(_loc_11);
                _loc_4++;
            }
            if (this._strDescriptArr.length > 0)
            {
                this.labeldesc.htmlText = this._strDescriptArr[0];
            }
            return;
        }// end function

        private function initodayactive() : void
        {
            this.main.addChild(this._todaySpr);
            return;
        }// end function

        private function spclick(event:MouseEvent)
        {
            this.labeldesc.htmlText = this._strDescriptArr[event.currentTarget.name];
            return;
        }// end function

        private function spover(event:MouseEvent)
        {
            event.currentTarget.alpha = 1;
            return;
        }// end function

        private function spout(event:MouseEvent)
        {
            event.currentTarget.alpha = 0.5;
            return;
        }// end function

    }
}
