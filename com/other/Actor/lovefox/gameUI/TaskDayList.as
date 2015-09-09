package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class TaskDayList extends Window
    {
        private var listcanvas:SimpleTree;
        public var tasklistarr:Array;
        private var freshList:Array;
        private var freshCanvas:SimpleTree;
        private var refreshBtn:PushButton;
        private var getListBtn:PushButton;
        private var replaceBtn:PushButton;
        private var lenlabel:Label;

        public function TaskDayList(param1:DisplayObjectContainer = null)
        {
            this.freshList = [];
            super(param1);
            this.initpanel();
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_2:* = null;
            resize(556, 360);
            this.title = Config.language("TaskDayList", 1);
            var _loc_1:* = new Shape();
            this.addChild(_loc_1);
            _loc_1.graphics.beginFill(12564362, 0.4);
            _loc_1.graphics.drawRoundRect(215 + 58 + 9, 50, 205 + 58 - 5, 267, 3);
            _loc_1.graphics.endFill();
            this.lenlabel = new Label(this, 20, 50);
            this.lenlabel.html = true;
            _loc_2 = new Label(this, 20, 25, Config.language("TaskDayList", 2));
            _loc_2 = new Label(this, 220 + 65, 25, Config.language("TaskDayList", 22));
            this.listcanvas = new SimpleTree(this, 10, 55, 190 + 70, 285);
            this.listcanvas.expandItem = true;
            this.listcanvas.addEventListener(SimpleTreeEvent.SELECT_ID, this.gettreeevent);
            this.freshCanvas = new SimpleTree(this, 220 + 58, 55, 190 + 70, 285);
            this.freshCanvas.expandItem = true;
            this.freshCanvas.addEventListener(SimpleTreeEvent.SELECT_ID, this.gettreeevent);
            this.refreshBtn = new PushButton(this, 330 + 116, 25, Config.language("TaskDayList", 3), this.handleFresh);
            this.refreshBtn.width = 80;
            this.getListBtn = new PushButton(this, 70 + 29, 325, Config.language("TaskDayList", 4), this.checkget);
            this.getListBtn.width = 80;
            this.replaceBtn = new PushButton(this, 260 + 116, 325, Config.language("TaskDayList", 23), this.checkRefresh);
            this.replaceBtn.width = 100;
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_QUEST_LIST_DAILYTEMP, this.listDaily);
            return;
        }// end function

        override public function testGuide()
        {
            if (GuideUI.testId(143))
            {
                GuideUI.doId(143, this.listcanvas, [this.getListBtn]);
            }
            else if (GuideUI.testId(148))
            {
                if (Config.ui._charUI.getOneItemType(8, 1) != null)
                {
                    GuideUI.doId(148, this.refreshBtn);
                }
            }
            return;
        }// end function

        public function showList(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            this.tasklistarr = param1;
            this.listcanvas.clearTree();
            this.listcanvas.addNode(Config.language("TaskDayList", 5), true);
            if (this.tasklistarr.length == 0)
            {
                if (Config.ui._taskpanel.taskIsDwon(551))
                {
                    this.lenlabel.text = Config.language("TaskDayList", 6);
                }
                else
                {
                    this.lenlabel.text = Config.language("TaskDayList", 20);
                }
            }
            else
            {
                this.lenlabel.text = " ";
            }
            var _loc_2:* = 0;
            while (_loc_2 < this.tasklistarr.length)
            {
                
                _loc_3 = Config._taskMap[this.tasklistarr[_loc_2].id].title;
                _loc_4 = 0;
                _loc_5 = "";
                switch(this.tasklistarr[_loc_2].quality)
                {
                    case 0:
                    {
                        _loc_4 = 6710886;
                        _loc_5 = Config.language("TaskDayList", 7);
                        break;
                    }
                    case 1:
                    {
                        _loc_4 = 39168;
                        _loc_5 = Config.language("TaskDayList", 8);
                        break;
                    }
                    case 2:
                    {
                        _loc_4 = 16737792;
                        _loc_5 = Config.language("TaskDayList", 9);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this.listcanvas.additems([{str:_loc_5, len:55, id:this.tasklistarr[_loc_2].id}, {str:_loc_3, len:120}], Config.language("TaskDayList", 5), _loc_4, false);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function showRefreshList() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            this.freshCanvas.clearTree();
            this.freshCanvas.addNode(Config.language("TaskDayList", 5), true);
            var _loc_1:* = 0;
            while (_loc_1 < this.freshList.length)
            {
                
                _loc_2 = Config._taskMap[this.freshList[_loc_1].id].title;
                _loc_3 = 0;
                _loc_4 = "";
                switch(this.freshList[_loc_1].quality)
                {
                    case 0:
                    {
                        _loc_3 = 6710886;
                        _loc_4 = Config.language("TaskDayList", 7);
                        break;
                    }
                    case 1:
                    {
                        _loc_3 = 39168;
                        _loc_4 = Config.language("TaskDayList", 8);
                        break;
                    }
                    case 2:
                    {
                        _loc_3 = 16737792;
                        _loc_4 = Config.language("TaskDayList", 9);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this.freshCanvas.additems([{str:_loc_4, len:55, id:this.freshList[_loc_1].id}, {str:_loc_2, len:120}], Config.language("TaskDayList", 5), _loc_3, false);
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function gettreeevent(event:SimpleTreeEvent) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this.tasklistarr.length)
            {
                
                if (this.tasklistarr[_loc_2].id == event.id)
                {
                    Config.ui._taskpanel.opentaskinfor3(this.tasklistarr[_loc_2]);
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function handleFresh(event:MouseEvent = null) : void
        {
            if (this.tasklistarr.length > 0)
            {
                if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                {
                    AlertUI.alert(Config.language("TaskDayList", 10), Config.language("TaskDayList", 27), [Config.language("TaskDayList", 16), Config.language("TaskDayList", 17)], [this.sendDayFresh, null]);
                }
                else
                {
                    AlertUI.alert(Config.language("TaskDayList", 10), Config.language("TaskDayList", 11), [Config.language("TaskDayList", 16), Config.language("TaskDayList", 17)], [this.sendDayFresh, null]);
                }
            }
            else
            {
                Config.message(Config.language("TaskDayList", 18));
            }
            return;
        }// end function

        public function sendDayFresh(event:MouseEvent = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_QUEST_DAILYFRESH);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function checkget(event:MouseEvent) : void
        {
            var _loc_2:* = true;
            var _loc_3:* = Config.ui._taskpanel.tasklistarr;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                if (Config._taskMap[_loc_3[_loc_4].id].type == 2)
                {
                    _loc_2 = false;
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            if (!_loc_2 && this.tasklistarr.length != 0)
            {
                AlertUI.alert(Config.language("TaskDayList", 10), Config.language("TaskDayList", 19), [Config.language("TaskDayList", 16), Config.language("TaskDayList", 17)], [this.getAllDay, null]);
                GuideUI.testDoId(147);
            }
            else
            {
                this.getAllDay();
            }
            return;
        }// end function

        private function getAllDay(event:MouseEvent = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_QUEST_DAILYACCEPT);
            _loc_2.add32(Npc._npcId);
            ClientSocket.send(_loc_2);
            this.close();
            if (this.tasklistarr.length > 0)
            {
                Config.message(Config.language("TaskDayList", 21));
            }
            return;
        }// end function

        private function listDaily(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.freshList = [];
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_5.id = _loc_2.readUnsignedInt();
                _loc_5.quality = _loc_2.readByte();
                this.freshList.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            this.showRefreshList();
            return;
        }// end function

        private function checkRefresh(event:MouseEvent) : void
        {
            if (this.tasklistarr.length > 0)
            {
                if (this.freshList.length > 0)
                {
                    AlertUI.alert(Config.language("TaskDayList", 10), Config.language("TaskDayList", 24), [Config.language("TaskDayList", 16), Config.language("TaskDayList", 17)], [this.refresh, null]);
                }
                else
                {
                    Config.message(Config.language("TaskDayList", 25));
                }
            }
            else
            {
                Config.message(Config.language("TaskDayList", 26));
            }
            return;
        }// end function

        private function refresh(event:MouseEvent = null) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_QUEST_DAILYSELECT);
            ClientSocket.send(_loc_2);
            return;
        }// end function

    }
}
