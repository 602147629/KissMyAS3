package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class WolfActive extends Window
    {
        private var contain:DisplayObjectContainer;
        private var _wolfId:int = 0;
        private var _wolfNum:int = 0;
        private var numbmp:Bitmap;
        private var listdata:DataGridUI;
        private var wolfList:Array;
        private var wolfObj:Object;
        private var mytext:TextAreaUI;
        private var iconsp:Sprite;
        private var _avatarClip:UnitClip;
        private var _timePoint:int = 0;
        private var wolftime:Timer;
        private var timelabel:Label;
        private var killlabel:Label;

        public function WolfActive(param1:DisplayObjectContainer = null, param2:Number = 300, param3:Number = 60)
        {
            this.contain = param1;
            super(param1, param2, param3);
            this.initSocket();
            this.initPanel();
            return;
        }// end function

        private function initSocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_WOLFHUNT_IN, this.handleWolfIn);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_WOLFHUNT_OUT, this.handleWolfOut);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_WOLFHUNT_LIST, this.wolfListFuc);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_WOLFHUNT_SELFBONUS, this.wolfObjFuc);
            return;
        }// end function

        public function npcTalkElite(param1:int, param2:Array, param3:Function = null) : void
        {
            param2.push({label:Config.language("WolfActive", 1), handler:this.sendeLitein, closeflag:true, order:6});
            return;
        }// end function

        public function leftNpcTalkElite(param1:int, param2:Array, param3:Function = null) : void
        {
            param2.push({label:Config.language("WolfActive", 2), handler:this.sendeliteout, closeflag:true});
            return;
        }// end function

        private function initPanel()
        {
            this.title = Config.language("WolfActive", 3);
            resize(390, 370);
            var _loc_1:* = [{datafield:"n", label:Config.language("WolfActive", 4), len:40}, {datafield:"name", label:Config.language("WolfActive", 5), len:80}, {datafield:"integral", label:Config.language("WolfActive", 6), len:80}, {datafield:"exp", label:Config.language("WolfActive", 7), len:80}, {datafield:"money", label:Config.language("WolfActive", 8), len:80}];
            this.listdata = new DataGridUI(_loc_1, this, 10, 30, 360, 300);
            this.wolfList = new Array();
            this.wolfObj = new Object();
            this.mytext = new TextAreaUI(this, 10, 320, 370, 50);
            this.mytext.autoHeight = true;
            this.numbmp = new Bitmap();
            this.iconsp = new Sprite();
            this.iconsp.addChild(this.numbmp);
            this.iconsp.filters = [new GlowFilter()];
            this.iconsp.mouseChildren = false;
            this.iconsp.mouseEnabled = false;
            this.numbmp.x = 30;
            this.numbmp.y = -20;
            this.timelabel = new Label(this.iconsp, 85, -13);
            this.timelabel.textColor = 16777215;
            this.killlabel = new Label(this.iconsp, 120, -13);
            this.killlabel.textColor = 16777215;
            this.wolftime = new Timer(1000);
            this.wolftime.addEventListener(TimerEvent.TIMER, this.showWolfTime);
            return;
        }// end function

        public function sendeLitein(param1 = null) : void
        {
            if (Config.player.level < 15)
            {
                AlertUI.alert(Config.language("WolfActive", 9), Config.language("WolfActive", 10), [Config.language("WolfActive", 11)]);
                return;
            }
            if (!Config.ui._petPanel.petflag)
            {
                Config.message(Config.language("WolfActive", 12));
                return;
            }
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_WOLFHUNT_IN);
            _loc_2.add32(Npc._npcId);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function sendeliteout(param1 = null)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_WOLFHUNT_OUT);
            _loc_2.add32(Npc._npcId);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function handleWolfOut(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            Config.ui._quickUI.closeWolf();
            return;
        }// end function

        private function handleWolfIn(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            this._timePoint = _loc_2.readUnsignedInt();
            this.wolfId = _loc_3;
            this.wolfNum = _loc_4;
            this.contain.addChild(this.iconsp);
            this.iconsp.x = (Config.stage.stageWidth - 100) / 2;
            this.iconsp.y = Config.stage.stageHeight - 100;
            Config.ui._quickUI.openWolf();
            this.wolftime.start();
            return;
        }// end function

        private function wolfListFuc(event:SocketEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            this.wolfList = new Array();
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new Object();
                _loc_5.n = _loc_2.readByte();
                _loc_6 = _loc_2.readUnsignedShort();
                _loc_5.name = _loc_2.readUTFBytes(_loc_6);
                _loc_5.integral = _loc_2.readUnsignedInt();
                _loc_5.level = _loc_2.readUnsignedInt();
                if (_loc_5.integral < 51)
                {
                    _loc_5.exp = 100 * _loc_5.integral;
                }
                else if (_loc_5.integral >= 51 && _loc_5.integral <= 110)
                {
                    _loc_5.exp = Config._ListExp[_loc_5.level].wolfExp * (_loc_5.integral + 200);
                }
                else
                {
                    _loc_5.exp = Config._ListExp[_loc_5.level].wolfExp * 310;
                }
                if (_loc_5.n == 1)
                {
                    _loc_5.money = 100000;
                }
                else if (_loc_5.n == 2 || _loc_5.n == 3)
                {
                    _loc_5.money = 50000;
                }
                else
                {
                    _loc_5.money = 10000;
                }
                this.wolfList.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            this.listdata.dataProvider = this.wolfList;
            this.open();
            if (this.iconsp.parent != null)
            {
                this.iconsp.parent.removeChild(this.iconsp);
            }
            if (this._avatarClip != null)
            {
                this._avatarClip.destroy();
                if (this._avatarClip.parent != null)
                {
                    this._avatarClip.parent.removeChild(this._avatarClip);
                }
                this._avatarClip = null;
            }
            this.wolftime.stop();
            return;
        }// end function

        private function wolfObjFuc(event:SocketEvent) : void
        {
            this.wolfObj = new Object();
            var _loc_2:* = event.data;
            this.wolfObj.n = _loc_2.readUnsignedInt();
            this.wolfObj.integral = _loc_2.readUnsignedInt();
            this.wolfObj.exp = _loc_2.readUnsignedInt();
            this.wolfObj.money = _loc_2.readUnsignedInt();
            this.mytext.text = Config.language("WolfActive", 13, this.wolfObj.integral, this.wolfObj.n, this.wolfObj.exp, this.wolfObj.money);
            return;
        }// end function

        public function get wolfNum() : int
        {
            return this._wolfNum;
        }// end function

        public function set wolfNum(param1:int) : void
        {
            this._wolfNum = param1;
            if (this.numbmp.bitmapData != null)
            {
                this.numbmp.bitmapData.dispose();
            }
            this.numbmp.bitmapData = Text2Bitmap.toBmp(String(param1), 16777215, 32, null, true);
            if (param1 == 0)
            {
                if (this.iconsp.parent != null)
                {
                    this.iconsp.parent.removeChild(this.iconsp);
                }
                if (this._avatarClip != null)
                {
                    this._avatarClip.destroy();
                    if (this._avatarClip.parent != null)
                    {
                        this._avatarClip.parent.removeChild(this._avatarClip);
                    }
                    this._avatarClip = null;
                }
                this.wolftime.stop();
            }
            return;
        }// end function

        public function get wolfId() : int
        {
            return this._wolfId;
        }// end function

        public function set wolfId(param1:int) : void
        {
            if (this._wolfId != param1 && param1 != 0)
            {
                if (this._avatarClip != null)
                {
                    this._avatarClip.destroy();
                    if (this._avatarClip.parent != null)
                    {
                        this._avatarClip.parent.removeChild(this._avatarClip);
                    }
                }
                this._avatarClip = UnitClip.newUnitClip(Config._model[param1]);
                this._avatarClip.changeStateTo("idle");
                this.iconsp.addChild(this._avatarClip);
            }
            this._wolfId = param1;
            return;
        }// end function

        public function reSetXY(param1, param2) : void
        {
            this.iconsp.x = (param1 - 80) / 2;
            this.iconsp.y = param2 - 80;
            return;
        }// end function

        private function showWolfTime(event:TimerEvent) : void
        {
            if (this._timePoint >= Config.now.getTime() / 1000)
            {
                this.timelabel.text = Config.timePoint(this._timePoint, 0);
            }
            else
            {
                this.wolftime.stop();
            }
            return;
        }// end function

        public function updateKill(param1:int) : void
        {
            this.killlabel.text = Config.language("WolfActive", 14, Config.ui._teamUI.getMemberName(param1));
            return;
        }// end function

    }
}
