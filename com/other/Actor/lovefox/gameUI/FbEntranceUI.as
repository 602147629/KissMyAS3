package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class FbEntranceUI extends Window
    {
        private var _layer1:Sprite;
        private var _1buttonBar:ButtonBar;
        private var _1pageUp:PushButton;
        private var _1pageDown:PushButton;
        private var _1pageLB:TextField;
        private var _1nextLB:Label;
        private var _1nextId:int = -1;
        private var _1fbWinArray:Array;
        private var _1entry:int = 0;
        private var _1page:int = 0;
        private var _1list0:Array;
        private var _1list1:Array;
        private var _1list2:Array;
        private var _1list3:Array;
        private var _layer2:Sprite;
        private var _2list1:DataGridUI;
        private var _2list1Data:Array;
        private var _2list1SortType:int = -1;
        private var _2list1SortValueMap:Object;
        private var _2waitPB:PushButton;
        private var _2createPB:PushButton;
        private var _2list1TeamId:int = -1;
        private var _layer3:Sprite;
        private var _3list1:DataGridUI;
        public var _3teamPB1:PushButton;
        public var _3teamPB2:PushButton;
        public var _3teamPB3:PushButton;
        private var _3enterPB:PushButton;
        public var _3autoLoginRb:CheckBox;
        public var _3typeaRb:RadioButton;
        public var _3typebRb:RadioButton;
        private var _23list2:DataGridUI;
        private var _23list2Data:Array;
        private var _23list2SortType:int = -1;
        private var _23list2SortValueMap:Object;
        private var _layer01:Sprite;
        private var _01BuyPB:PushButton;
        private var _01TimeLB:Label;
        private var _layer02:Sprite;
        public var _fbTime:int = 0;
        public var _fbPayTime:int = 0;
        public var _fbId:int = 0;
        private var _currentLayer:Sprite;
        private var _fbCdStack:Object;
        private var _bookAlertId:Object;
        public var _inFb:Boolean = false;
        public var _inPlayerList:Boolean = false;
        private var _backToHall2PB:PushButton;
        private var _backToHall3PB:PushButton;

        public function FbEntranceUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            this._1fbWinArray = [];
            this._1list0 = [];
            this._1list1 = [];
            this._1list2 = [];
            this._1list3 = [];
            this._2list1SortValueMap = {};
            this._23list2SortValueMap = {};
            this._fbCdStack = {};
            super(param1, param2, param3);
            resize(580, 345);
            this.initUI();
            return;
        }// end function

        override public function close()
        {
            var _loc_1:* = undefined;
            super.close();
            if (this._inFb)
            {
                if (this._inPlayerList)
                {
                    _loc_1 = Config._fbInfo[this._fbId];
                    Config.ui._radar.setFbButton(Config.language("FbEntranceUI", 1, _loc_1.level, _loc_1.name));
                }
            }
            return;
        }// end function

        public function selectInfo(param1 = null)
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_8:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = undefined;
            var _loc_15:* = null;
            _loc_2 = PagePushButton(this._1buttonBar.tabarr[1]);
            if (Player.level < 60)
            {
                _loc_2.enabled = false;
                _loc_2.label = Config.language("FbEntranceUI", 2);
            }
            else
            {
                _loc_2.enabled = true;
                _loc_2.label = Config.language("FbEntranceUI", 3);
            }
            _loc_2 = PagePushButton(this._1buttonBar.tabarr[2]);
            if (Player.level < 70)
            {
                _loc_2.enabled = false;
                _loc_2.label = Config.language("FbEntranceUI", 62);
            }
            else
            {
                _loc_2.enabled = true;
                _loc_2.label = Config.language("FbEntranceUI", 61);
            }
            _loc_2 = PagePushButton(this._1buttonBar.tabarr[3]);
            if (Player.level < 80)
            {
                _loc_2.enabled = false;
                _loc_2.label = Config.language("FbEntranceUI", 64);
            }
            else
            {
                _loc_2.enabled = true;
                _loc_2.label = Config.language("FbEntranceUI", 63);
            }
            var _loc_6:* = -1;
            var _loc_7:* = 1000;
            if (param1 != null)
            {
                this._1page = param1;
            }
            else
            {
                _loc_10 = [];
                _loc_11 = [];
                _loc_12 = [];
                _loc_13 = [];
                for (_loc_3 in Config._fbInfo)
                {
                    
                    _loc_5 = Config._fbInfo[_loc_3];
                    if (_loc_5.level > Player.level)
                    {
                        if (_loc_5.level < _loc_7)
                        {
                            _loc_7 = _loc_5.level;
                            _loc_6 = _loc_5.id;
                        }
                    }
                    if (_loc_5.level <= Player.level && (_loc_5.task == 0 || Config.ui._taskpanel.getTaskState(_loc_5.task) == 3))
                    {
                        if (_loc_5.cdType == 0)
                        {
                            _loc_10.push({node:_loc_5, level:_loc_5.level, id:_loc_5.id});
                            continue;
                        }
                        if (_loc_5.cdType == 1)
                        {
                            if (_loc_5.level == 60)
                            {
                                _loc_11.push({node:_loc_5, level:_loc_5.level, id:_loc_5.id});
                                continue;
                            }
                            if (_loc_5.level == 70)
                            {
                                _loc_12.push({node:_loc_5, level:_loc_5.level, id:_loc_5.id});
                                continue;
                            }
                            _loc_13.push({node:_loc_5, level:_loc_5.level, id:_loc_5.id});
                        }
                    }
                }
                this._1nextId = _loc_6;
                _loc_10.sortOn(["level", "id"], [Array.NUMERIC | Array.DESCENDING, Array.NUMERIC]);
                _loc_11.sortOn(["level", "id"], [Array.NUMERIC | Array.DESCENDING, Array.NUMERIC]);
                _loc_12.sortOn(["level", "id"], [Array.NUMERIC | Array.DESCENDING, Array.NUMERIC]);
                _loc_13.sortOn(["level", "id"], [Array.NUMERIC | Array.DESCENDING, Array.NUMERIC]);
                this._1list0 = [];
                this._1list1 = [];
                this._1list2 = [];
                this._1list3 = [];
                _loc_3 = 0;
                while (_loc_3 < _loc_10.length)
                {
                    
                    this._1list0.push(_loc_10[_loc_3].node);
                    _loc_3 = _loc_3 + 1;
                }
                _loc_3 = 0;
                while (_loc_3 < _loc_11.length)
                {
                    
                    this._1list1.push(_loc_11[_loc_3].node);
                    _loc_3 = _loc_3 + 1;
                }
                _loc_3 = 0;
                while (_loc_3 < _loc_12.length)
                {
                    
                    this._1list2.push(_loc_12[_loc_3].node);
                    _loc_3 = _loc_3 + 1;
                }
                _loc_3 = 0;
                while (_loc_3 < _loc_13.length)
                {
                    
                    this._1list3.push(_loc_13[_loc_3].node);
                    _loc_3 = _loc_3 + 1;
                }
            }
            if (this._1entry == 0)
            {
                _loc_8 = this._1list0;
                if (this._1nextId == -1)
                {
                    this._1nextLB.text = "";
                }
                else
                {
                    _loc_14 = Config._fbInfo[this._1nextId];
                    this._1nextLB.text = Config.language("FbEntranceUI", 4, _loc_14.level, _loc_14.name);
                }
            }
            else
            {
                if (this._1entry == 1)
                {
                    _loc_8 = this._1list1;
                }
                else if (this._1entry == 2)
                {
                    _loc_8 = this._1list2;
                }
                else if (this._1entry == 3)
                {
                    _loc_8 = this._1list3;
                }
                this._1nextLB.text = "";
            }
            var _loc_9:* = Math.ceil(_loc_8.length / 4);
            if (this._1page >= _loc_9)
            {
                this._1page = _loc_9 - 1;
            }
            if (this._1page < 0)
            {
                this._1page = 0;
            }
            this._1pageLB.text = String((this._1page + 1)) + "/" + _loc_9;
            this._1pageLB.x = 290 - this._1pageLB.width / 2;
            this.clearFbWin();
            _loc_3 = this._1page * 4;
            while (_loc_3 < Math.min(this._1page * 4 + 4, _loc_8.length))
            {
                
                _loc_15 = this._1fbWinArray[_loc_3 - this._1page * 4];
                this.setFbWin(_loc_15, _loc_8[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        private function goShop(param1)
        {
            Config.ui._shopUI.getitemlist(30015);
            return;
        }// end function

        private function initUI()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            this._layer1 = new Sprite();
            this._layer2 = new Sprite();
            this._layer3 = new Sprite();
            this._layer01 = new Sprite();
            _loc_3 = new PushButton(this._layer1, 480, 24, Config.language("FbEntranceUI", 5), this.goShop, null, "table18", "table31");
            _loc_3.width = 60;
            _loc_3.overshow = true;
            _loc_3.textColor = Style.GOLD_FONT;
            this._1buttonBar = new ButtonBar(this._layer1, 10, 25, 571, -7);
            this._1buttonBar.addTab(Config.language("FbEntranceUI", 6), Config.create(this.tabFb, 0), 80);
            this._1buttonBar.addTab(Config.language("FbEntranceUI", 3), Config.create(this.tabFb, 1), 80);
            this._1buttonBar.addTab(Config.language("FbEntranceUI", 61), Config.create(this.tabFb, 2), 80);
            this._1buttonBar.addTab(Config.language("FbEntranceUI", 63), Config.create(this.tabFb, 3), 80);
            this._1nextLB = new Label(this._layer1, 250, 26 + 25, "");
            this._1nextLB.html = true;
            this._1pageUp = new PushButton(this._layer1, 240, 315, "<", Config.create(this.fbPage, 0));
            this._1pageUp.width = 30;
            this._1pageDown = new PushButton(this._layer1, 310, 315, ">", Config.create(this.fbPage, 1));
            this._1pageDown.width = 30;
            this._1pageLB = Config.getSimpleTextField();
            this._1pageLB.defaultTextFormat = new TextFormat(null, 16, Style.WINDOW_FONT, true);
            this._1pageLB.text = "1/3";
            this._1pageLB.x = 290;
            this._1pageLB.y = 315;
            this._layer1.addChild(this._1pageLB);
            _loc_1 = 0;
            while (_loc_1 < 4)
            {
                
                _loc_6 = this.getFbWin();
                _loc_6.x = _loc_1 % 2 * 268 + 26;
                _loc_6.y = int(_loc_1 / 2) * 120 + 76;
                this._1fbWinArray[_loc_1] = _loc_6;
                _loc_1 = _loc_1 + 1;
            }
            this.selectInfo();
            _loc_4 = new Label(this._layer2, 15, 50, Config.language("FbEntranceUI", 10));
            _loc_4 = new Label(this._layer2, 296, 50, Config.language("FbEntranceUI", 11));
            _loc_5 = [{datafield:"leaderName", label:Config.language("FbEntranceUI", 12), len:90}, {datafield:"memberCount", label:Config.language("FbEntranceUI", 13), len:40}, {datafield:"pickMode", label:Config.language("FbEntranceUI", 14), len:70}, {datafield:"op", label:Config.language("FbEntranceUI", 15), childmc:"op", len:72}];
            this._2list1 = new DataGridUI(_loc_5, this._layer2, 15, 76, 272, 223);
            this._2list1.addEventListener(DataGridEvent.ROW_ROLLOVER, this.handleTeamRollOver);
            this._2list1.addEventListener(DataGridEvent.ROW_ROLLOUT, this.handleTeamRollOut);
            this._2list1.addEventListener(DataGridEvent.CLOMN_SORT, this.handleTeamSort);
            this._2list1.selectable = false;
            this._2list1.listShow = true;
            _loc_5 = [{datafield:"name", label:Config.language("FbEntranceUI", 16), len:90}, {datafield:"level", label:Config.language("FbEntranceUI", 17), len:40}, {datafield:"job", label:Config.language("FbEntranceUI", 18), len:70}, {datafield:"op", label:Config.language("FbEntranceUI", 19), childmc:"op", len:72}];
            this._23list2 = new DataGridUI(_loc_5, null, 296, 76, 272, 223);
            this._23list2.selectable = false;
            this._23list2.listShow = true;
            this._23list2.addEventListener(DataGridEvent.CLOMN_SORT, this.handlePlayerSort);
            this._2waitPB = new PushButton(this._layer2, 367, 308, Config.language("FbEntranceUI", 20), this.handleWaitingTeam);
            this._2waitPB.data = 0;
            this._2waitPB.width = 100;
            this._2createPB = new PushButton(this._layer2, 487, 308, Config.language("TeamPanel", 10), this.handleCreateTeam);
            this._2createPB.width = 80;
            this._backToHall2PB = new PushButton(this._layer2, 467, 28, Config.language("FbEntranceUI", 21), this.backToHall2);
            _loc_3 = new PushButton(this._layer2, 367, 28, Config.language("FbEntranceUI", 22), this.handleRefreshList2);
            _loc_3.width = 80;
            _loc_4 = new Label(this._layer3, 15, 50, Config.language("FbEntranceUI", 23));
            _loc_4 = new Label(this._layer3, 296, 50, Config.language("FbEntranceUI", 24));
            _loc_5 = [{datafield:"name", label:Config.language("TeamPanel", 1), len:90}, {datafield:"level", label:Config.language("TeamPanel", 2), len:40}, {datafield:"jobname", label:Config.language("TeamPanel", 3), len:70}, {datafield:"rightstr", label:Config.language("TeamPanel", 4), len:67}];
            this._3list1 = new DataGridUI(_loc_5, this._layer3, 15, 76, 267, 147);
            this._3list1.listShow = true;
            this._3teamPB1 = new PushButton(this._layer3, 18, 244, Config.language("TeamPanel", 7), Config.create(this.teamMemberFuc, true));
            this._3teamPB1.width = 70;
            this._3teamPB2 = new PushButton(this._layer3, 109, 244, Config.language("TeamPanel", 8), Config.create(this.teamMemberFuc, false));
            this._3teamPB2.width = 70;
            this._3teamPB3 = new PushButton(this._layer3, 200, 244, Config.language("TeamPanel", 9), Config.ui._teamUI.sendmemberleft);
            this._3teamPB3.width = 70;
            this._3enterPB = new PushButton(this._layer3, 93, 284, Config.language("FbEntranceUI", 25), this.enterFb, null, "table13", "table14");
            this._3autoLoginRb = new CheckBox(this._layer3, 18, 227, Config.language("TeamPanel", 11), this.autoModeFuc);
            _loc_4 = new Label(this._layer3, 100, 223, Config.language("TeamPanel", 12));
            this._3typeaRb = new RadioButton(this._layer3, 160, 227, Config.language("TeamPanel", 13), true, Config.create(this.pickupModeFuc, 0));
            this._3typeaRb.group = "fb_itemstatus";
            this._3typebRb = new RadioButton(this._layer3, 220, 227, Config.language("TeamPanel", 14), false, Config.create(this.pickupModeFuc, 1));
            this._3typebRb.group = "fb_itemstatus";
            this._backToHall3PB = new PushButton(this._layer3, 460, 28, Config.language("FbEntranceUI", 26), this.backToHall3);
            _loc_3 = new PushButton(this._layer3, 410, 28, Config.language("FbEntranceUI", 27), this.handleRefreshList3);
            _loc_3.width = 40;
            this._layer01 = new Sprite();
            _loc_4 = new Label(this._layer01, 20, 2, Config.language("FbEntranceUI", 28));
            _loc_4.data = Config.language("FbEntranceUI", 29);
            _loc_4.addEventListener(MouseEvent.ROLL_OVER, this.handlePayRollOver);
            _loc_4.addEventListener(MouseEvent.ROLL_OUT, this.handlePayRollOut);
            this._01TimeLB = new Label(this._layer01, 99, 2, "");
            this._01TimeLB.html = true;
            this._01BuyPB = new PushButton(this._layer01, 117 + 16, 0, Config.language("FbEntranceUI", 30), this.payFbTime, null, "table18", "table31");
            this._01BuyPB.width = 60;
            this._01BuyPB.overshow = true;
            this._01BuyPB.textColor = Style.GOLD_FONT;
            this._01BuyPB.addEventListener(MouseEvent.ROLL_OVER, this.handlePayRollOver);
            this._01BuyPB.addEventListener(MouseEvent.ROLL_OUT, this.handlePayRollOut);
            this._layer02 = new Sprite();
            this._layer02.y = 50;
            _loc_4 = new Label(this._layer02, 16 + 16, 2, Config.language("FbEntranceUI", 31));
            _loc_4 = new Label(this._layer02, 400 - 16, 2, Config.language("FbEntranceUI", 32));
            this.tabFb(null, 0);
            this.switchLayer(this._layer1);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_LFG_TEAMSQUERY, this.handleTeamsQuery);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_LFG_PLAYERSQUERY, this.handlePlayersQuery);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_LFG_NOTICE, this.handleNotice);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_INSTANCE_BALLINFO, this.backBallList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_LFG_TEAMINFO, this.handleTeamInfo);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_LFG_ENTERINST, this.handleTeamEnter);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_LFG_INSTCD, this.handleInstCd);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_RAIDCD, this.handleRaidCd);
            this.setBackToHallPB();
            return;
        }// end function

        private function handlePayRollOver(event:MouseEvent)
        {
            var _loc_2:* = Component(event.currentTarget);
            var _loc_3:* = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            if (_loc_2 == this._01BuyPB)
            {
                Holder.showInfo(_loc_2.data, new Rectangle(_loc_3.x, _loc_3.y, _loc_2.width, _loc_2.height), false, 2);
            }
            else
            {
                Holder.showInfo(_loc_2.data, new Rectangle(_loc_3.x - 40, _loc_3.y, _loc_2.width, _loc_2.height), false, 2, 145);
            }
            return;
        }// end function

        private function handlePayRollOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        public function setBackToHallPB()
        {
            var _loc_1:* = true;
            if (Config.ui._teamUI.inTeam(Player._playerId))
            {
                if (Config.player.teamflag)
                {
                    _loc_1 = true;
                }
                else
                {
                    _loc_1 = false;
                }
            }
            else
            {
                _loc_1 = true;
            }
            var _loc_2:* = _loc_1;
            this._backToHall3PB.enabled = _loc_1;
            this._backToHall2PB.enabled = _loc_2;
            return;
        }// end function

        private function handleCreateTeam(param1)
        {
            Config.ui._teamUI.createTeam(param1);
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LFG_TEAMJOIN);
            _loc_2.add32(this._fbId);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function handleInstCd(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedInt();
            return;
        }// end function

        private function handleRaidCd(param1)
        {
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2.readUnsignedInt();
                _loc_6 = _loc_2.readUnsignedInt();
                this._fbCdStack[_loc_5] = _loc_6;
                _loc_7 = 0;
                while (_loc_7 < this._1fbWinArray.length)
                {
                    
                    _loc_8 = this._1fbWinArray[_loc_7];
                    if (_loc_8.data.id == _loc_5)
                    {
                        _loc_8.data.pb.enabled = false;
                        _loc_8.data.pb.label = Config.language("FbEntranceUI", 33);
                    }
                    _loc_7 = _loc_7 + 1;
                }
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        private function handleNotice(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            if (_loc_3 == 0)
            {
                this._inFb = false;
                this.refreshList();
                this.switchLayer(this._layer1);
            }
            else
            {
                this._inFb = true;
                this._fbId = _loc_3;
                if (Config.ui._teamUI.inTeam(Player._playerId))
                {
                    if (!Config.player.teamflag)
                    {
                        Config.ui._radar.setFbButton(Config.language("FbEntranceUI", 34));
                        this.switchLayer(this._layer3);
                        return;
                    }
                    if (!_opening)
                    {
                        Config.ui._radar.setFbButton(Config.language("FbEntranceUI", 34));
                    }
                }
                this.refreshList();
            }
            return;
        }// end function

        private function handleTeamsQuery(param1)
        {
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = null;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = [];
            var _loc_6:* = 0;
            while (_loc_6 < _loc_4)
            {
                
                _loc_7 = _loc_2.readUnsignedInt();
                _loc_8 = _loc_2.readUnsignedInt();
                _loc_9 = _loc_2.readUnsignedShort();
                _loc_10 = _loc_2.readUTFBytes(_loc_9);
                _loc_11 = _loc_2.readUnsignedInt();
                _loc_12 = _loc_2.readUnsignedInt();
                _loc_13 = new ClickLabel(null, 0, 0, Config.language("FbEntranceUI", 35), null, true);
                _loc_13.clickColor([26367, 6837142]);
                _loc_13.data = _loc_8;
                _loc_13.addEventListener(MouseEvent.CLICK, this.reloginTeam);
                _loc_5.push({teamId:_loc_7, leaderName:_loc_10, pickSort:_loc_11, memberSort:_loc_12, pickMode:_loc_11 == 0 ? (Config.language("TeamPanel", 13)) : (Config.language("TeamPanel", 14)), memberCount:_loc_12 + "/" + Config._fbInfo[_loc_3].playerLimit, op:_loc_13});
                _loc_6 = _loc_6 + 1;
            }
            this._2list1Data = _loc_5;
            this.setDP2list1();
            return;
        }// end function

        private function handlePlayersQuery(param1)
        {
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = null;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            this._2waitPB.label = Config.language("FbEntranceUI", 36);
            this._2waitPB.data = 0;
            this._inPlayerList = false;
            var _loc_5:* = [];
            var _loc_6:* = 0;
            while (_loc_6 < _loc_4)
            {
                
                _loc_7 = _loc_2.readUnsignedInt();
                _loc_8 = _loc_2.readUnsignedShort();
                _loc_9 = _loc_2.readUTFBytes(_loc_8);
                _loc_10 = _loc_2.readUnsignedInt();
                _loc_11 = _loc_2.readUnsignedInt();
                if (_loc_7 == Player._playerId)
                {
                    _loc_5.push({id:_loc_7, name:_loc_9, level:_loc_10, jobSort:_loc_11, job:Config._jobTitleMap[_loc_11], textcolor:13369344});
                    this._2waitPB.label = Config.language("FbEntranceUI", 37);
                    this._2waitPB.data = 1;
                    this._inPlayerList = true;
                }
                else
                {
                    _loc_12 = new ClickLabel(null, 0, 0, Config.language("FbEntranceUI", 38), null, true);
                    _loc_12.clickColor([26367, 6837142]);
                    _loc_12.data = _loc_7;
                    _loc_12.addEventListener(MouseEvent.CLICK, this.inviteTeam);
                    _loc_5.push({name:_loc_9, level:_loc_10, jobSort:_loc_11, job:Config._jobTitleMap[_loc_11], op:_loc_12});
                }
                _loc_6 = _loc_6 + 1;
            }
            this._23list2Data = _loc_5;
            this.setDP23list2();
            return;
        }// end function

        private function handleWaitingTeam(param1)
        {
            var _loc_2:* = null;
            if (this._2waitPB.data == 0)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_LFG_PLAYERJOIN);
                _loc_2.add32(this._fbId);
                ClientSocket.send(_loc_2);
                this._2waitPB.label = Config.language("FbEntranceUI", 37);
                this._2waitPB.data = 1;
            }
            else
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_LFG_PLAYERLEAVE);
                ClientSocket.send(_loc_2);
                this._2waitPB.label = Config.language("FbEntranceUI", 36);
                this._2waitPB.data = 0;
            }
            return;
        }// end function

        private function backToHall2(param1)
        {
            var _loc_2:* = null;
            if (!Config.ui._teamUI.inTeam(Player._playerId) && this._2waitPB.data == 1)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_LFG_PLAYERLEAVE);
                ClientSocket.send(_loc_2);
            }
            this.switchLayer(this._layer1);
            return;
        }// end function

        private function backToHall3(param1)
        {
            AlertUI.alert(Config.language("FbEntranceUI", 39), Config.language("FbEntranceUI", 40), [Config.language("FbEntranceUI", 41), Config.language("FbEntranceUI", 42)], [this.subBackToHall3]);
            return;
        }// end function

        private function subBackToHall3(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LFG_TEAMLEAVE);
            ClientSocket.send(_loc_2);
            this.switchLayer(this._layer1);
            return;
        }// end function

        private function setFbWin(param1:Panel, param2)
        {
            this._layer1.addChild(param1);
            var _loc_3:* = "";
            if (param2.cdType == 0)
            {
                _loc_3 = _loc_3 + Config.language("FbEntranceUI", 43, param2.level, param2.name);
                if (param1.data.titleCL.parent != null)
                {
                    param1.data.titleCL.parent.removeChild(param1.data.titleCL);
                }
                param1.data.titleCL.removeEventListener(MouseEvent.CLICK, this.handleTitleClClick);
            }
            else
            {
                if (param1.data.titleCL.parent == null)
                {
                    param1.addChild(param1.data.titleCL);
                }
                param1.data.titleCL.text = Config.language("FbEntranceUI", 44, param2.name);
                param1.data.titleCL.data = param2.id;
                param1.data.titleCL.removeEventListener(MouseEvent.CLICK, this.handleTitleClClick);
                param1.data.titleCL.addEventListener(MouseEvent.CLICK, this.handleTitleClClick);
            }
            _loc_3 = _loc_3 + ("\n" + param2.description + "");
            _loc_3 = _loc_3 + ("\n" + param2.drop + "");
            _loc_3 = _loc_3.replace(/\\\
n""\\n/g, "\n");
            param1.data.infoLB.text = _loc_3;
            param1.data.pb.data = param2.id;
            param1.data.id = param2.id;
            if (this._fbCdStack[param2.id] != null && this._fbCdStack[param2.id] > int(Config.now.getTime() / 1000))
            {
                param1.data.pb.enabled = false;
                param1.data.pb.label = Config.language("FbEntranceUI", 45);
            }
            else
            {
                param1.data.pb.enabled = true;
                param1.data.pb.label = Config.language("FbEntranceUI", 46);
                param1.data.pb.textColor = Style.GOLD_FONT;
            }
            return;
        }// end function

        private function handleTitleClClick(param1)
        {
            var _loc_4:* = undefined;
            var _loc_2:* = param1.currentTarget.data;
            var _loc_3:* = 0;
            while (_loc_3 < Config._book.page.list.length())
            {
                
                _loc_4 = Config._book.page.list[_loc_3];
                if (_loc_4.fbid == _loc_2)
                {
                    AlertUI.remove(this._bookAlertId);
                    this._bookAlertId = AlertUI.alert(_loc_4.title, String(_loc_4.content).replace(/nbsp""nbsp/g, "  ").replace(/\\\
n""\\n/g, "\n"), [Config.language("FbEntranceUI", 59)]);
                    return;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        private function getFbWin()
        {
            var _loc_1:* = new Panel();
            var _loc_2:* = new Bitmap();
            _loc_1.addChild(_loc_2);
            _loc_2.bitmapData = Config.findsysUI("poker/fbbg", 261, 113);
            _loc_1.setSize(261, 113);
            var _loc_3:* = new Label(_loc_1, 3, 3);
            _loc_3.wordWrap = true;
            _loc_3.width = 255;
            var _loc_4:* = new PushButton(_loc_1, 190, 90, Config.language("FbEntranceUI", 46), this.handleEnterFb, null, "table18", "table31");
            new PushButton(_loc_1, 190, 90, Config.language("FbEntranceUI", 46), this.handleEnterFb, null, "table18", "table31").width = 60;
            _loc_4.overshow = true;
            _loc_4.textColor = Style.GOLD_FONT;
            var _loc_5:* = new ClickLabel(null, 3, 3, "", null, true);
            new ClickLabel(null, 3, 3, "", null, true).clickColor([8388736, 8388736]);
            _loc_1.data = {infoLB:_loc_3, pb:_loc_4, titleCL:_loc_5};
            return _loc_1;
        }// end function

        private function handleEnterFb(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = PushButton(param1.currentTarget);
            this._fbId = int(_loc_2.data);
            if (!Config.ui._teamUI.inTeam(Player._playerId))
            {
                this.switchLayer(this._layer2);
                GuideUI.testDoId(238, this._2createPB);
            }
            else if (Config.player.teamflag)
            {
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2G_LFG_TEAMJOIN);
                _loc_3.add32(this._fbId);
                ClientSocket.send(_loc_3);
                this.switchLayer(this._layer3);
                GuideUI.testDoId(239, this._3enterPB);
            }
            return;
        }// end function

        private function clearFbWin()
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < 4)
            {
                
                _loc_2 = this._1fbWinArray[_loc_1];
                if (_loc_2.parent != null)
                {
                    _loc_2.parent.removeChild(_loc_2);
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function tabFb(event:MouseEvent = null, param2:uint = 0) : void
        {
            if (this._1entry != param2)
            {
                this._1entry = param2;
                if (this._1entry == 0)
                {
                    if (this._layer01.parent == null)
                    {
                        this.addChild(this._layer01);
                    }
                    if (this._layer02.parent != null)
                    {
                        this._layer02.parent.removeChild(this._layer02);
                    }
                }
                else
                {
                    if (this._layer02.parent == null)
                    {
                        this.addChild(this._layer02);
                    }
                    if (this._layer01.parent != null)
                    {
                        this._layer01.parent.removeChild(this._layer01);
                    }
                }
                this.selectInfo(0);
            }
            return;
        }// end function

        private function fbPage(event:MouseEvent = null, param2:uint = 0) : void
        {
            if (param2 == 0)
            {
                this.selectInfo((this._1page - 1));
            }
            else
            {
                this.selectInfo((this._1page + 1));
            }
            return;
        }// end function

        private function switchLayer(param1:Sprite)
        {
            var _loc_2:* = undefined;
            if (param1 == this._layer1)
            {
                this._layer01.y = 50;
                if (this._1entry == 0)
                {
                    if (this._layer01.parent == null)
                    {
                        this.addChild(this._layer01);
                    }
                    if (this._layer02.parent != null)
                    {
                        this._layer02.parent.removeChild(this._layer02);
                    }
                }
                else
                {
                    if (this._layer02.parent == null)
                    {
                        this.addChild(this._layer02);
                    }
                    if (this._layer01.parent != null)
                    {
                        this._layer01.parent.removeChild(this._layer01);
                    }
                }
            }
            else
            {
                if (this._1entry == 0)
                {
                    if (this._layer01.parent == null)
                    {
                        this.addChild(this._layer01);
                    }
                }
                else if (this._layer01.parent != null)
                {
                    this._layer01.parent.removeChild(this._layer01);
                }
                if (this._layer02.parent != null)
                {
                    this._layer02.parent.removeChild(this._layer02);
                }
                this._layer01.y = 30;
            }
            this._currentLayer = param1;
            var _loc_3:* = Config._fbInfo[this._fbId];
            if (param1 == this._layer1)
            {
                title = Config.language("FbEntranceUI", 47);
            }
            else if (param1 == this._layer2)
            {
                if (_loc_3 != null)
                {
                    title = Config.language("FbEntranceUI", 48, _loc_3.level, _loc_3.name);
                }
                this.refreshList();
                this._layer2.addChild(this._23list2);
            }
            else if (param1 == this._layer3)
            {
                if (_loc_3 != null)
                {
                    title = Config.language("FbEntranceUI", 48, _loc_3.level, _loc_3.name);
                }
                this.refreshList(true);
                this._3autoLoginRb.selected = Config.ui._teamUI.autoLoginRb.selected;
                this._layer3.addChild(this._23list2);
            }
            var _loc_4:* = 1;
            while (_loc_4 < 4)
            {
                
                _loc_2 = this["_layer" + _loc_4];
                if (_loc_2 == param1)
                {
                    if (_loc_2.parent == null)
                    {
                        addChild(_loc_2);
                    }
                }
                else if (_loc_2.parent != null)
                {
                    _loc_2.parent.removeChild(_loc_2);
                }
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        private function getId(param1, param2)
        {
            if (param1 == 1)
            {
                if (param2 == 1)
                {
                    return 0;
                }
                return 1;
            }
            else if (param1 == 4)
            {
                if (param2 == 1)
                {
                    return 2;
                }
                return 3;
            }
            else if (param1 == 10)
            {
                if (param2 == 1)
                {
                    return 4;
                }
                return 5;
            }
            return;
        }// end function

        private function backBallList(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = [];
            var _loc_4:* = 0;
            while (_loc_4 < 5)
            {
                
                _loc_3[_loc_4] = _loc_2.readByte();
                _loc_4 = _loc_4 + 1;
            }
            this.updateFbTime(_loc_3[0]);
            this.updateFbPayTime(_loc_3[1]);
            return;
        }// end function

        public function updateFbTime(param1)
        {
            this._fbTime = param1;
            this._01TimeLB.text = param1 + "/3";
            return;
        }// end function

        public function updateFbPayTime(param1)
        {
            this._fbPayTime = param1;
            this._01BuyPB.data = Config.language("FbEntranceUI", 49, param1);
            return;
        }// end function

        private function payFbTime(event:MouseEvent) : void
        {
            if (this._fbPayTime > 0)
            {
                AlertUI.alert(Config.language("FbEntranceUI", 50), Config.language("FbEntranceUI", 51, Config._ListExp[Config.player.level].instanceCost, this._fbPayTime), [Config.language("FbEntranceUI", 52), Config.language("FbEntranceUI", 53)], [this.subPayFbTime]);
            }
            return;
        }// end function

        private function subPayFbTime(param1) : void
        {
            this.ballCharge(0);
            return;
        }// end function

        public function ballCharge(param1:int)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_INSTANCE_BALLCHARGE);
            _loc_2.add8(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function checkFbTime() : int
        {
            var _loc_1:* = 0;
            if (this._fbTime > 0)
            {
                return 1;
            }
            if (this._fbPayTime > 0)
            {
                return 2;
            }
            return 0;
        }// end function

        public function enterFb(param1 = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_GOTOINSTANCE);
            _loc_2.add32(this._fbId);
            _loc_2.add32(0);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function teamMemberFuc(event:MouseEvent, param2:Boolean) : void
        {
            if (this._3teamPB1.enabled && param2 || this._3teamPB2.enabled && !param2)
            {
                if (this._3list1.rowIndex != -1)
                {
                    if (param2)
                    {
                        Config.ui._teamUI.sendRemove(Config.ui._teamUI.getTeamArr()[this._3list1.rowIndex].memberid);
                    }
                    else
                    {
                        Config.ui._teamUI.sendLeader(Config.ui._teamUI.getTeamArr()[this._3list1.rowIndex].memberid);
                    }
                }
                else
                {
                    Config.message(Config.language("TeamPanel", 39));
                }
            }
            return;
        }// end function

        private function handleRefreshList2(param1)
        {
            this.refreshList();
            return;
        }// end function

        private function handleRefreshList3(param1)
        {
            this.refreshList(true);
            return;
        }// end function

        private function refreshList(param1 = false)
        {
            var _loc_2:* = null;
            if (this._fbId != 0)
            {
                if (!param1)
                {
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.C2G_LFG_TEAMSQUERY);
                    _loc_2.add32(this._fbId);
                    ClientSocket.send(_loc_2);
                }
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_LFG_PLAYERSQUERY);
                _loc_2.add32(this._fbId);
                ClientSocket.send(_loc_2);
            }
            return;
        }// end function

        public function handleTeamCreate()
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_LFG_TEAMJOIN);
            _loc_1.add32(this._fbId);
            ClientSocket.send(_loc_1);
            if (this._fbId == 0)
            {
                this.switchLayer(this._layer1);
            }
            else
            {
                this.switchLayer(this._layer3);
            }
            this.setBackToHallPB();
            GuideUI.testDoId(240, this._3enterPB);
            return;
        }// end function

        public function refreshTeam()
        {
            var _loc_1:* = Config.ui._teamUI.getTeamArr();
            this._3list1.dataProvider = _loc_1;
            if (_loc_1.length > 0)
            {
                if (this._fbId == 0)
                {
                    this.switchLayer(this._layer1);
                }
                else if (this._inFb)
                {
                    this.switchLayer(this._layer3);
                }
            }
            this.setBackToHallPB();
            return;
        }// end function

        public function quitTeam()
        {
            this._3list1.dataProvider = [];
            this.switchLayer(this._layer1);
            this.setBackToHallPB();
            return;
        }// end function

        private function getTeamInfo(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LFG_TEAMINFO);
            _loc_2.add32(param1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function handleTeamRollOver(param1)
        {
            this._2list1TeamId = param1.rowobj.teamId;
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LFG_TEAMINFO);
            _loc_2.add32(this._2list1TeamId);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function handleTeamRollOut(param1)
        {
            this._2list1TeamId = -1;
            Config.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMoveInfo);
            Holder.closeInfo();
            return;
        }// end function

        private function handlePlayerSort(event:DataGridEvent)
        {
            this._23list2SortType = event.selectIndex;
            if (this._23list2SortValueMap[this._23list2SortType] == null)
            {
                this._23list2SortValueMap[this._23list2SortType] = 0;
            }
            else if (this._23list2SortType < 3)
            {
                this._23list2SortValueMap[this._23list2SortType] = 1 - this._23list2SortValueMap[this._23list2SortType];
            }
            else
            {
                var _loc_2:* = this._23list2SortValueMap;
                var _loc_3:* = this._23list2SortType;
                var _loc_4:* = this._23list2SortValueMap[this._23list2SortType] + 1;
                _loc_2[_loc_3] = _loc_4;
                if (this._23list2SortValueMap[this._23list2SortType] > 2)
                {
                    this._23list2SortValueMap[this._23list2SortType] = 0;
                }
            }
            this.setDP23list2();
            return;
        }// end function

        private function setDP23list2()
        {
            if (this._23list2SortType == 1)
            {
                if (this._23list2SortValueMap[this._23list2SortType] == 0)
                {
                    this._23list2Data.sortOn("level", Array.NUMERIC | Array.DESCENDING);
                }
                else
                {
                    this._23list2Data.sortOn("level", Array.NUMERIC);
                }
            }
            else if (this._23list2SortType == 2)
            {
                this._23list2Data.sort(this.sortOn23list2);
            }
            this._23list2.dataProvider = this._23list2Data;
            return;
        }// end function

        private function sortOn23list2(param1, param2) : Number
        {
            var _loc_3:* = param1.jobSort;
            var _loc_4:* = param2.jobSort;
            if (_loc_3 == _loc_4)
            {
                return 0;
            }
            if (this._23list2SortValueMap[this._23list2SortType] == 0)
            {
                if (_loc_3 == 1)
                {
                    return 1;
                }
                if (_loc_3 < _loc_4)
                {
                    return 1;
                }
                return -1;
            }
            else if (this._23list2SortValueMap[this._23list2SortType] == 1)
            {
                if (_loc_3 == 4)
                {
                    return 1;
                }
                if (_loc_3 > _loc_4)
                {
                    return 1;
                }
                return -1;
            }
            else if (this._23list2SortValueMap[this._23list2SortType] == 2)
            {
                if (_loc_3 == 10)
                {
                    return 1;
                }
                if (_loc_3 < _loc_4)
                {
                    return 1;
                }
                return -1;
            }
            return 0;
        }// end function

        private function handleTeamSort(event:DataGridEvent)
        {
            this._2list1SortType = event.selectIndex;
            if (this._2list1SortValueMap[this._2list1SortType] == null)
            {
                this._2list1SortValueMap[this._2list1SortType] = 0;
            }
            else if (this._2list1SortType < 3)
            {
                this._2list1SortValueMap[this._2list1SortType] = 1 - this._2list1SortValueMap[this._2list1SortType];
            }
            this.setDP2list1();
            return;
        }// end function

        private function setDP2list1()
        {
            if (this._2list1SortType == 1)
            {
                if (this._2list1SortValueMap[this._2list1SortType] == 0)
                {
                    this._2list1Data.sortOn("memberSort", Array.NUMERIC | Array.DESCENDING);
                }
                else
                {
                    this._2list1Data.sortOn("memberSort", Array.NUMERIC);
                }
            }
            else if (this._2list1SortType == 2)
            {
                if (this._2list1SortValueMap[this._2list1SortType] == 0)
                {
                    this._2list1Data.sortOn("pickSort", Array.NUMERIC | Array.DESCENDING);
                }
                else
                {
                    this._2list1Data.sortOn("pickSort", Array.NUMERIC);
                }
            }
            this._2list1.dataProvider = this._2list1Data;
            return;
        }// end function

        private function handleTeamInfo(param1)
        {
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = "";
            var _loc_6:* = 0;
            while (_loc_6 < _loc_4)
            {
                
                _loc_7 = _loc_2.readUnsignedShort();
                _loc_8 = _loc_2.readUTFBytes(_loc_7);
                _loc_9 = _loc_2.readUnsignedInt();
                _loc_10 = _loc_2.readUnsignedInt();
                if (_loc_6 > 0)
                {
                    _loc_5 = _loc_5 + "\n";
                }
                _loc_5 = _loc_5 + (_loc_8 + " " + Config._jobTitleMap[_loc_10] + " Lv:" + _loc_9);
                _loc_6 = _loc_6 + 1;
            }
            if (this._2list1TeamId == _loc_3)
            {
                Holder.showInfo(_loc_5, new Rectangle());
                this.handleMouseMoveInfo();
                Config.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMoveInfo);
                Config.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMoveInfo);
            }
            return;
        }// end function

        private function handleMouseMoveInfo(param1 = null)
        {
            Holder.setInfoPos(Config.stage.mouseX, Config.stage.mouseY, true);
            return;
        }// end function

        private function handleTeamEnter(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedShort();
            var _loc_6:* = _loc_2.readUTFBytes(_loc_5);
            var _loc_7:* = Config._fbInfo[_loc_3];
            AlertUI.alert(Config.language("FbEntranceUI", 54), Config.language("FbEntranceUI", 55, _loc_7.name), [Config.language("FbEntranceUI", 56), Config.language("FbEntranceUI", 57)], [this.enterFb]);
            return;
        }// end function

        private function reloginTeam(param1)
        {
            var _loc_2:* = ClickLabel(param1.currentTarget);
            Config.ui._teamUI.reloginteam(int(_loc_2.data));
            Config.message(Config.language("FbEntranceUI", 58));
            return;
        }// end function

        private function inviteTeam(param1)
        {
            var _loc_2:* = ClickLabel(param1.currentTarget);
            Config.ui._teamUI.inviteTeam(int(_loc_2.data));
            return;
        }// end function

        private function autoModeFuc(event:MouseEvent) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_TEAM_APPROVAL_MODE);
            if (this._3autoLoginRb.selected)
            {
                _loc_2.add8(1);
            }
            else
            {
                _loc_2.add8(0);
            }
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function pickupModeFuc(event:MouseEvent, param2:int) : void
        {
            var _loc_3:* = null;
            if (this._3typeaRb.enabled)
            {
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2G_TEAM_PICKUP_MODE);
                _loc_3.add8(param2);
                ClientSocket.send(_loc_3);
            }
            return;
        }// end function

        override public function testGuide()
        {
            if (GuideUI.testId(237))
            {
                this.tabFb(null, 0);
                GuideUI.testDoId(237, this._1fbWinArray[0].data.pb);
            }
            if (this._fbTime == 0)
            {
                GuideUI.testDoId(246, this._01BuyPB);
            }
            return;
        }// end function

    }
}
