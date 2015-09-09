package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class ServerRacebill extends Window
    {
        private var _lab:Label;
        private var cam:CanvasUI;
        private var _datlist:DataGridUI;
        private var _timerr:Timer;
        private var _cdStart:int;
        private var _sometime:int = 30;
        private var _updatetime:int = 0;
        private var _mysocer:uint;
        private var _jionorin:uint = 0;
        private var _alertnum:int;
        private var _flag:Boolean = false;
        private var _lb:Label;
        private var _rightwo:Boolean = false;
        private var _iftwo:Boolean = false;

        public function ServerRacebill(param1:DisplayObjectContainer = null)
        {
            super(param1);
            resize(300, 350);
            this.initpanel();
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_CARENA_SC1TOP, this.getlistbill);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_CARENA_SC1, this.requitsocer);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_CARENA_WAIT, this.readyenter);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_CARENA_ENTER, this.backenter);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_CARENA_SC2TOP, this.getlist2bill);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_CARENA2_LASTTIME, this.ready2enter);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_CARENA2_ENTER, this.backenter);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_CARENA3_LASTTIME, this.ready3enter);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_CARENA_ENTER3, this.backerr3);
            return;
        }// end function

        private function initpanel() : void
        {
            var _loc_1:* = new Shape();
            _loc_1.graphics.lineStyle(1, 12281894);
            _loc_1.graphics.moveTo(50, 55);
            _loc_1.graphics.lineTo(285, 55);
            this.addChild(_loc_1);
            this._lab = new Label(this, 200, 30, Config.language("ServerRacebill", 1));
            this._lab.html = true;
            this._lab.textColor = 16730112;
            this._lb = new Label(this, 10, 320);
            var _loc_2:* = [{datafield:"list", label:Config.language("ServerRacebill", 2), len:70}, {datafield:"score", label:Config.language("ServerRacebill", 3), len:80}, {datafield:"name", label:Config.language("ServerRacebill", 4), len:125}];
            this._datlist = new DataGridUI(_loc_2, this, 10, 65, 275, 245);
            return;
        }// end function

        public function openracebill(param1:int)
        {
            if (param1 == 1 || param1 == 2)
            {
                this.open();
                this.senddate(param1);
                if (param1 == 1)
                {
                    this.title = Config.language("ServerRacebill", 5);
                    this._lb.text = Config.language("ServerRacebill", 6);
                }
                else
                {
                    this.title = Config.language("ServerRacebill", 7);
                    this._lb.text = Config.language("ServerRacebill", 8);
                }
            }
            else if (param1 == 3 || param1 == 4)
            {
                Config.ui._serverinteracebill.open();
                Config.ui._serverinteracebill.sendtoplist();
            }
            else
            {
                Config.message(Config.language("ServerRacebill", 9));
            }
            return;
        }// end function

        private function getlistbill(event:SocketEvent) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = undefined;
            var _loc_2:* = new Array();
            var _loc_3:* = false;
            var _loc_4:* = event.data;
            this._updatetime = _loc_4.readUnsignedInt();
            var _loc_5:* = _loc_4.readUnsignedInt();
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_7 = new Object();
                _loc_7.list = _loc_4.readUnsignedInt();
                _loc_7.playerid = _loc_4.readUnsignedInt();
                _loc_8 = _loc_4.readUnsignedShort();
                _loc_7.name = _loc_4.readUTFBytes(_loc_8);
                _loc_7.score = _loc_4.readUnsignedInt();
                _loc_2.push(_loc_7);
                if (_loc_7.playerid == Config.player.id)
                {
                    _loc_3 = true;
                }
                _loc_6++;
            }
            if (this._iftwo)
            {
                this.rightwo = _loc_3;
            }
            else
            {
                this._datlist.dataProvider = _loc_2;
            }
            return;
        }// end function

        private function requitsocer(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.mysocer = _loc_2.readUnsignedInt();
            return;
        }// end function

        private function readyenter(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.jionorin = 1;
            this._sometime = 30;
            this._cdStart = getTimer();
            this._timerr = new Timer(1000);
            this._timerr.addEventListener(TimerEvent.TIMER, this.timerfun);
            this._flag = true;
            this._timerr.start();
            AlertUI.remove(this._alertnum);
            this._alertnum = AlertUI.alert(Config.language("ServerRacebill", 10), Config.language("ServerRacebill", 11, 30), [Config.language("ServerRacebill", 12)], [this.sendenter], 1);
            return;
        }// end function

        private function ready2enter(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.jionorin = 1;
            this._sometime = 30;
            this._cdStart = getTimer();
            this._timerr = new Timer(1000);
            this._timerr.addEventListener(TimerEvent.TIMER, this.timerfun);
            this._flag = true;
            this._timerr.start();
            AlertUI.remove(this._alertnum);
            this._alertnum = AlertUI.alert(Config.language("ServerRacebill", 10), Config.language("ServerRacebill", 11, 30), [Config.language("ServerRacebill", 12)], [this.sendenter], 2);
            return;
        }// end function

        private function ready3enter(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readUnsignedByte();
            if (_loc_2.readUnsignedByte() == 0)
            {
                this.jionorin = 1;
                this._sometime = _loc_4;
                this._cdStart = getTimer();
                this._timerr = new Timer(1000);
                this._timerr.addEventListener(TimerEvent.TIMER, this.timerfun);
                this._flag = true;
                this._timerr.start();
                AlertUI.remove(this._alertnum);
                this._alertnum = AlertUI.alert(Config.language("ServerRacebill", 10), Config.language("ServerRacebill", 11, 120), [Config.language("ServerRacebill", 12)], [this.sendenter], 3);
            }
            else if (_loc_5 == 1)
            {
                this.jionorin = 5;
            }
            trace("B2C_CARENA3_LASTTIME", _loc_4, _loc_5);
            return;
        }// end function

        private function timerfun(event:TimerEvent)
        {
            var _loc_2:* = Number(Math.max(0, this._sometime - int((getTimer() - this._cdStart) / 1000)));
            if (this._flag)
            {
                AlertUI.msg = Config.language("ServerRacebill", 11, _loc_2);
            }
            if (_loc_2 <= 0)
            {
                if (this._flag)
                {
                    AlertUI.remove(this._alertnum);
                    this._alertnum = AlertUI.alert(Config.language("ServerRacebill", 10), Config.language("ServerRacebill", 13), [Config.language("ServerRacebill", 14)]);
                }
                this._flag = false;
                if (Config.map._type != 24)
                {
                    this.jionorin = 0;
                }
                this._timerr.stop();
                this._timerr.removeEventListener(TimerEvent.TIMER, this.timerfun);
            }
            return;
        }// end function

        public function sendenter(param1) : void
        {
            AlertUI.remove(this._alertnum);
            this._flag = false;
            var _loc_2:* = new DataSet();
            if (param1 == 1)
            {
                _loc_2.addHead(CONST_ENUM.C2G_CARENA_ENTER);
            }
            else if (param1 == 2)
            {
                _loc_2.addHead(CONST_ENUM.C2B_CARENA2_ENTER);
            }
            else if (param1 == 3)
            {
                _loc_2.addHead(CONST_ENUM.C2G_CARENA_ENTER3);
            }
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backenter(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedByte();
            if (_loc_3 == 0)
            {
                this._flag = false;
                this.jionorin = 3;
                this._timerr.stop();
                this._timerr.removeEventListener(TimerEvent.TIMER, this.timerfun);
                Config.message(Config.language("ServerRacebill", 15));
            }
            else if (_loc_3 == 1)
            {
                Config.message(Config.language("ServerRacebill", 16));
            }
            else if (_loc_3 == 2)
            {
                Config.message(Config.language("ServerRacebill", 17));
            }
            else if (_loc_3 == 3)
            {
                Config.message(Config.language("ServerRacebill", 18));
            }
            else if (_loc_3 == 4)
            {
                Config.message(Config.language("ServerRacebill", 19));
            }
            else if (_loc_3 == 5)
            {
                Config.message(Config.language("ServerRacebill", 20));
            }
            else
            {
                Config.message(Config.language("ServerRacebill", 24, _loc_3));
            }
            return;
        }// end function

        private function senddate(param1:int) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_CARENA_SC1);
            _loc_2.add8(param1);
            ClientSocket.send(_loc_2);
            var _loc_3:* = new DataSet();
            if (param1 == 1)
            {
                _loc_3.addHead(CONST_ENUM.C2B_CARENA_SC1TOP);
            }
            else if (param1 == 2)
            {
                _loc_3.addHead(CONST_ENUM.C2B_CARENA_SC2TOP);
            }
            _loc_3.add32(this._updatetime);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        public function send20list() : void
        {
            var _loc_1:* = null;
            if (!this._iftwo)
            {
                this._iftwo = true;
                _loc_1 = new DataSet();
                _loc_1.addHead(CONST_ENUM.C2B_CARENA_SC1TOP);
                _loc_1.add32(1);
                ClientSocket.send(_loc_1);
            }
            return;
        }// end function

        public function set mysocer(param1:uint)
        {
            this._mysocer = param1;
            if (this._lab.parent != null)
            {
                this._lab.text = "<b>" + Config.language("ServerRacebill", 21, this._mysocer) + "</b>";
            }
            return;
        }// end function

        public function get mysocer() : uint
        {
            return this._mysocer;
        }// end function

        public function set jionorin(param1:uint) : void
        {
            this._jionorin = param1;
            Config.ui._activePanel.setbtn18(param1);
            return;
        }// end function

        public function get jionorin() : uint
        {
            return this._jionorin;
        }// end function

        public function set rightwo(param1:Boolean) : void
        {
            this._rightwo = param1;
            Config.ui._activePanel.setwobtn18(param1);
            return;
        }// end function

        public function get rightwo() : Boolean
        {
            return this._rightwo;
        }// end function

        private function getlist2bill(event:SocketEvent) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            var _loc_9:* = undefined;
            var _loc_10:* = null;
            var _loc_2:* = new Array();
            var _loc_3:* = event.data;
            this._updatetime = _loc_3.readUnsignedInt();
            var _loc_4:* = _loc_3.readUnsignedInt();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = new Object();
                _loc_6.list = _loc_3.readUnsignedInt();
                _loc_6.playerid = _loc_3.readUnsignedInt();
                _loc_7 = _loc_3.readUnsignedShort();
                _loc_8 = _loc_3.readUTFBytes(_loc_7);
                _loc_9 = _loc_3.readUnsignedShort();
                _loc_10 = _loc_3.readUTFBytes(_loc_9);
                _loc_6.score = _loc_3.readUnsignedInt();
                _loc_6.name = _loc_8 + "." + _loc_10;
                _loc_2.push(_loc_6);
                _loc_5++;
            }
            this._datlist.dataProvider = _loc_2;
            return;
        }// end function

        private function backerr3(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 0)
            {
                this._flag = false;
                this.jionorin = 3;
                this._timerr.stop();
                this._timerr.removeEventListener(TimerEvent.TIMER, this.timerfun);
                Config.message(Config.language("ServerRacebill", 15));
            }
            else if (_loc_3 == 1)
            {
                Config.message(Config.language("ServerRacebill", 16));
            }
            else if (_loc_3 == 2)
            {
                Config.message(Config.language("ServerRacebill", 17));
            }
            else if (_loc_3 == 3)
            {
                Config.message(Config.language("ServerRacebill", 18));
            }
            else if (_loc_3 == 4)
            {
                Config.message(Config.language("ServerRacebill", 19));
            }
            else if (_loc_3 == 5)
            {
                Config.message(Config.language("ServerRacebill", 20));
            }
            else if (_loc_3 == 6)
            {
                Config.message(Config.language("ServerRacebill", 22));
            }
            else if (_loc_3 == 7)
            {
                Config.message(Config.language("ServerRacebill", 23));
            }
            return;
        }// end function

    }
}
