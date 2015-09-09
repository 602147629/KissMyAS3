package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class LandGravePanel extends Window
    {
        private var landList:Object;
        private var landSourceList:Array;
        private var landListPanel:Window;
        private var landListData:DataGridUI;
        private var LandInfoPanel:Window;
        private var LandInfoData:DataGridUI;
        private var TimeSp:Sprite;
        private var TimeLabel:Label;
        private var LandTimer:Timer;
        private var timeFlag:int = 0;

        public function LandGravePanel(param1:DisplayObjectContainer = null)
        {
            this.landList = {};
            this.landSourceList = [];
            super(param1);
            this.initpanel();
            this.initSocket();
            return;
        }// end function

        private function initSocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_TEERITORY_OWNERLIST, this.BackLandList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TERRITORY_SCLIST, this.BackLandSource);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TERRITORY_LIFE, this.BackLandLife);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_TERRITORY_WIN, this.BackLandWin);
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_1:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            var _loc_9:* = null;
            for (_loc_1 in Config._territoryMap)
            {
                
                this.landList[_loc_1] = {};
                for (_loc_7 in Config._territoryMap[_loc_1])
                {
                    
                    this.landList[_loc_1][_loc_7] = Config._territoryMap[_loc_1][_loc_7];
                }
                this.landList[_loc_1].gildId = 0;
                this.landList[_loc_1].gildName = Config.language("LandGravePanel", 1);
            }
            resize(280, 300);
            this.title = Config.language("LandGravePanel", 2);
            var _loc_2:* = new Label(this, 10, 30, Config.language("LandGravePanel", 3));
            _loc_2.html = true;
            var _loc_3:* = 90;
            for (_loc_4 in Config._territoryMap)
            {
                
                _loc_8 = new Label(this, 10, _loc_3, _loc_4 + " " + Config._territoryMap[_loc_4].name);
                _loc_9 = new PushButton(this, 200, _loc_3, Config.language("LandGravePanel", 4), Config.create(this.centerLand, Config._territoryMap[_loc_4].id));
                _loc_9.width = 60;
                _loc_9.setTable("table18", "table31");
                _loc_9.textColor = Style.GOLD_FONT;
                _loc_9.color = 16777215;
                _loc_3 = _loc_3 + 40;
            }
            var _loc_10:* = new Window(Config.ui._layer1);
            this.landListPanel = new Window(Config.ui._layer1);
            Config.ui._windowStack.push(_loc_10);
            this.landListPanel.title = Config.language("LandGravePanel", 5);
            this.landListPanel.resize(490, 180);
            _loc_5 = [{datafield:"name", label:Config.language("LandGravePanel", 6), len:120}, {datafield:"level", label:Config.language("LandGravePanel", 7), len:120}, {datafield:"gildName", label:Config.language("LandGravePanel", 8), len:120}, {datafield:"exp", label:Config.language("LandGravePanel", 9), len:100}];
            this.landListData = new DataGridUI(_loc_5, this.landListPanel, 10, 25, 460, 150);
            var _loc_10:* = new Window(Config.ui._layer1);
            this.LandInfoPanel = new Window(Config.ui._layer1);
            Config.ui._windowStack.push(_loc_10);
            this.LandInfoPanel.title = Config.language("LandGravePanel", 10);
            this.LandInfoPanel.resize(440, 230);
            _loc_6 = [{datafield:"i", label:Config.language("LandGravePanel", 11), len:30}, {datafield:"gildName", label:Config.language("LandGravePanel", 12), len:120}, {datafield:"kill", label:Config.language("LandGravePanel", 13), len:50}, {datafield:"showNum", label:Config.language("LandGravePanel", 14), len:120}, {datafield:"source", label:Config.language("LandGravePanel", 15), len:100}];
            this.LandInfoData = new DataGridUI(_loc_6, this.LandInfoPanel, 10, 25, 420, 200);
            this.TimeSp = new Sprite();
            this.TimeSp.graphics.beginFill(0, 0.3);
            this.TimeSp.graphics.drawRoundRect(0, 0, 100, 25, 4);
            this.TimeSp.graphics.endFill();
            this.TimeLabel = new Label(this.TimeSp, 10, 2);
            this.TimeLabel.textColor = 16777215;
            this.LandTimer = new Timer(1000);
            this.LandTimer.addEventListener(TimerEvent.TIMER, this.checkTime);
            return;
        }// end function

        public function showLandInfo() : void
        {
            var _loc_1:* = null;
            this.LandInfoPanel.switchOpen();
            this.LandInfoPanel.x = Config.ui._activePanel.x + 30;
            this.LandInfoPanel.y = Config.ui._activePanel.y + 20;
            if (this.LandInfoPanel._opening)
            {
                _loc_1 = new DataSet();
                _loc_1.addHead(CONST_ENUM.C2G_TERRITORY_SCLIST);
                ClientSocket.send(_loc_1);
            }
            return;
        }// end function

        private function centerLand(event:MouseEvent, param2:int) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_TERRITORY_ENTER);
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function BackLandList(event:SocketEvent) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_2:* = [];
            for (_loc_3 in this.landList)
            {
                
                this.landList[_loc_3].gildId = 0;
                this.landList[_loc_3].gildName = Config.language("LandGravePanel", 1);
                _loc_2.push(this.landList[_loc_3]);
            }
            _loc_4 = event.data;
            _loc_5 = _loc_4.readUnsignedByte();
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_7 = {};
                _loc_7.id = _loc_4.readUnsignedByte();
                _loc_7.mapId = _loc_4.readUnsignedInt();
                _loc_7.gildId = _loc_4.readUnsignedInt();
                _loc_8 = _loc_4.readUnsignedShort();
                _loc_7.gildName = _loc_4.readUTFBytes(_loc_8);
                if (this.landList[_loc_7.id] != null)
                {
                    this.landList[_loc_7.id].gildId = _loc_7.gildId;
                    if (_loc_7.gildId > 0)
                    {
                        this.landList[_loc_7.id].gildName = _loc_7.gildName;
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            this.landListData.dataProvider = _loc_2;
            this.showLandNum();
            this.landQi();
            return;
        }// end function

        private function BackLandSource(event:SocketEvent) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            this.landSourceList.length = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_6 = {};
                _loc_6.gildId = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedShort();
                _loc_6.gildName = _loc_2.readUTFBytes(_loc_7);
                _loc_6.menNum = _loc_2.readUnsignedShort();
                _loc_6.menLifeNum = _loc_2.readUnsignedShort();
                _loc_6.source = _loc_2.readUnsignedShort();
                _loc_6.kill = _loc_2.readUnsignedShort();
                _loc_6.showNum = _loc_6.menLifeNum + " / " + _loc_6.menNum;
                this.landSourceList.push(_loc_6);
                _loc_4 = _loc_4 + 1;
            }
            this.landSourceList.sortOn("source", Array.NUMERIC | Array.DESCENDING);
            var _loc_5:* = 0;
            while (_loc_5 < this.landSourceList.length)
            {
                
                this.landSourceList[_loc_5].i = int((_loc_5 + 1));
                _loc_5 = _loc_5 + 1;
            }
            this.LandInfoData.dataProvider = this.landSourceList;
            return;
        }// end function

        public function sendLandLeft() : void
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_TERRITORY_LEAVE);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        public function openLandListPanel() : void
        {
            this.landListPanel.switchOpen();
            this.landListPanel.x = Config.ui._activePanel.x + 30;
            this.landListPanel.y = Config.ui._activePanel.y + 20;
            if (this.landListPanel._opening)
            {
                this.setnewFreshLand();
            }
            return;
        }// end function

        public function setnewFreshLand() : void
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2B_TEERITORY_OWNERLIST);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        public function showLandNum() : void
        {
            var _loc_2:* = undefined;
            var _loc_1:* = 0;
            for (_loc_2 in this.landList)
            {
                
                if (this.landList[_loc_2].gildId == Config.player._gildid && Config.player._gildid != 0)
                {
                    _loc_1++;
                }
            }
            if (Config.player._gildid != 0)
            {
                Config.ui._gangs.setGildLandNum(_loc_1);
            }
            return;
        }// end function

        public function setLandWarName() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = undefined;
            if (Config.player == null)
            {
                return;
            }
            if (Config.map != null)
            {
                if (Config.map._type == 21)
                {
                    _loc_1 = Unit.getPlayerlist();
                    for (_loc_2 in _loc_1)
                    {
                        
                        if (Config.player.gildid != _loc_1[_loc_2].gildid)
                        {
                            _loc_1[_loc_2].setNameColor(2);
                            continue;
                        }
                        _loc_1[_loc_2].setNameColor(3);
                    }
                }
            }
            return;
        }// end function

        public function landQi() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            for (_loc_2 in this.landList)
            {
                
                _loc_3 = Unit.getNpclist();
                for (_loc_4 in _loc_3)
                {
                    
                    _loc_1 = _loc_3[_loc_4];
                    if (_loc_1 != null && _loc_1._data.id == Config._territoryMap[_loc_2].npc)
                    {
                        _loc_1.title = this.landList[_loc_2].gildName;
                        if (this.landList[_loc_2].gildId > 0)
                        {
                            _loc_1.setNameColor(1);
                            if (Config.player.gildid == this.landList[_loc_2].gildId)
                            {
                                _loc_1._stateBar.titleColor = 3295734;
                            }
                            else
                            {
                                _loc_1._stateBar.titleColor = 11344686;
                            }
                            continue;
                        }
                        _loc_1.setNameColor(0);
                        _loc_1._stateBar.titleColor = 16777215;
                    }
                }
            }
            return;
        }// end function

        private function BackLandLife(event:SocketEvent) : void
        {
            var _loc_2:* = event.data.readUnsignedInt();
            var _loc_3:* = event.data.readUnsignedByte();
            var _loc_4:* = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_2);
            if (Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, _loc_2) != null)
            {
                _loc_4.LandLife = _loc_3;
            }
            return;
        }// end function

        public function addLandWar(param1:Radar) : void
        {
            param1.addChild(this.TimeSp);
            this.TimeSp.x = -260;
            this.TimeSp.y = 55;
            var _loc_2:* = Config.now;
            _loc_2.setHours(int(Config._activMap[12].openTime.split("–")[1].split(":")[0]), int(Config._activMap[12].openTime.split("–")[1].split(":")[1]), 0, 0);
            this.timeFlag = int(_loc_2.getTime() / 1000);
            if (!this.LandTimer.running)
            {
                this.LandTimer.start();
            }
            return;
        }// end function

        public function removeLandWar() : void
        {
            if (this.TimeSp.parent != null)
            {
                this.TimeSp.parent.removeChild(this.TimeSp);
            }
            this.LandTimer.stop();
            return;
        }// end function

        private function checkTime(event:TimerEvent) : void
        {
            this.TimeLabel.text = Config.language("LandGravePanel", 16, Config.timePoint(this.timeFlag));
            if (int(Config.now.getTime() / 1000) > this.timeFlag)
            {
                this.LandTimer.stop();
            }
            return;
        }// end function

        private function BackLandWin(event:SocketEvent) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            this.landSourceList.length = 0;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_6 = {};
                _loc_6.gildId = _loc_2.readUnsignedInt();
                _loc_7 = _loc_2.readUnsignedShort();
                _loc_6.gildName = _loc_2.readUTFBytes(_loc_7);
                _loc_6.menNum = _loc_2.readUnsignedShort();
                _loc_6.menLifeNum = _loc_2.readUnsignedShort();
                _loc_6.source = _loc_2.readUnsignedShort();
                _loc_6.kill = _loc_2.readUnsignedShort();
                _loc_6.showNum = _loc_6.menLifeNum + " / " + _loc_6.menNum;
                this.landSourceList.push(_loc_6);
                _loc_4 = _loc_4 + 1;
            }
            this.landSourceList.sortOn("source", Array.NUMERIC | Array.DESCENDING);
            var _loc_5:* = 0;
            while (_loc_5 < this.landSourceList.length)
            {
                
                this.landSourceList[_loc_5].i = int((_loc_5 + 1));
                _loc_5 = _loc_5 + 1;
            }
            this.LandInfoData.dataProvider = this.landSourceList;
            this.LandInfoPanel.open();
            this.LandInfoPanel.x = Config.ui._activePanel.x + 30;
            this.LandInfoPanel.y = Config.ui._activePanel.y + 20;
            return;
        }// end function

        public function showLandgildId() : Array
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = [];
            for (_loc_2 in this.landList)
            {
                
                if (this.landList[_loc_2].gildId == Config.player._gildid && Config.player._gildid != 0)
                {
                    _loc_3 = [];
                    _loc_3 = this.landList[_loc_2].level.split("-");
                    _loc_4 = _loc_3[0].substring(2, _loc_3[0].length);
                    _loc_5 = _loc_3[1].substring(2, _loc_3[1].length);
                    _loc_1.push({_gild:this.landList[_loc_2].gildId, _landLvmin:_loc_4, _landLvmax:_loc_5});
                }
            }
            return _loc_1;
        }// end function

    }
}
