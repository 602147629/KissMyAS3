package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class PKraceinfoPanel extends Window
    {
        private var mainpanel:Sprite;
        private var datalistP:DataGridUI;
        private var datalist:DataGridUI;
        private var topbtn:ButtonBar;
        private var labself:Label;
        private var labtime:Label;
        private var timerr:Timer;
        private var fristFight:int;
        private var countdown:Number;
        private var _cdStamp:Number;

        public function PKraceinfoPanel(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            super(param1, param2, param3);
            resize(350, 400);
            this.initpanel();
            this.initsocket();
            return;
        }// end function

        private function initsocket()
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PK_ACTIVITY_SCHEDULE_INFO, this.backgradeinfo);
            return;
        }// end function

        override public function close()
        {
            this.removetime();
            super.close();
            return;
        }// end function

        private function initpanel()
        {
            this.title = Config.language("PKraceinfoPanel", 1);
            var _loc_1:* = new Sprite();
            _loc_1.graphics.beginFill(16777215, 0.4);
            _loc_1.graphics.drawRect(10, 30, 330, 82);
            this.addChild(_loc_1);
            this.mainpanel = new Sprite();
            this.addChild(this.mainpanel);
            var _loc_2:* = new Label(this, 20, 85, Config.language("PKraceinfoPanel", 2));
            this.labself = new Label(this, 210, 85);
            this.labtime = new Label(this, 20, 35);
            var _loc_3:* = [{datafield:"name", label:Config.language("PKraceinfoPanel", 4), len:80}, {datafield:"level", label:Config.language("PKraceinfoPanel", 5), len:50}, {datafield:"jobname", label:Config.language("PKraceinfoPanel", 6), len:50}];
            this.datalistP = new DataGridUI(_loc_3, this, 145, 60, 180, 60);
            this.topbtn = new ButtonBar(this, 15, 120, 0);
            this.topbtn.addTab(Config.language("PKraceinfoPanel", 8), this.infograde);
            this.topbtn.addTab(Config.language("PKraceinfoPanel", 9), this.infograde);
            this.topbtn.addTab(Config.language("PKraceinfoPanel", 10), this.infograde);
            this.topbtn.addTab(Config.language("PKraceinfoPanel", 11), this.infograde);
            this.topbtn.addTab(Config.language("PKraceinfoPanel", 19), this.infograde);
            this.topbtn.selectpage = 0;
            var _loc_4:* = [{datafield:"name", label:Config.language("PKraceinfoPanel", 4), len:100}, {datafield:"level", label:Config.language("PKraceinfoPanel", 5), len:60}, {datafield:"jobname", label:Config.language("PKraceinfoPanel", 6), len:60}, {datafield:"online", label:Config.language("PKraceinfoPanel", 7), len:100}];
            this.datalist = new DataGridUI(_loc_4, this, 15, 150, 320, 220);
            this.timerr = new Timer(1000);
            return;
        }// end function

        private function infograde(event:MouseEvent)
        {
            this.removeallchild(this.mainpanel);
            trace(this.topbtn.selectpage);
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_PK_ACTIVITY_SCHEDULE_INFO);
            if (this.topbtn.selectpage == 0)
            {
                _loc_2.add8(1);
            }
            else if (this.topbtn.selectpage == 1)
            {
                _loc_2.add8(2);
            }
            else if (this.topbtn.selectpage == 2)
            {
                _loc_2.add8(3);
            }
            else if (this.topbtn.selectpage == 3)
            {
                _loc_2.add8(4);
            }
            else if (this.topbtn.selectpage == 4)
            {
                _loc_2.add8(5);
            }
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function backgradeinfo(event:SocketEvent)
        {
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = undefined;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = undefined;
            if (!this._opening)
            {
                this.open();
            }
            var _loc_2:* = [];
            var _loc_3:* = [];
            var _loc_4:* = event.data;
            this.fristFight = _loc_4.readByte();
            this.countdown = _loc_4.readUnsignedInt();
            this._cdStamp = getTimer();
            if (this.fristFight == 1)
            {
                this.labtime.text = Config.language("PKraceinfoPanel", 17, this.countdown);
            }
            else if (this.fristFight == 2)
            {
                this.timerr.addEventListener(TimerEvent.TIMER, this.cdgo);
                this.timerr.start();
            }
            var _loc_5:* = _loc_4.readByte();
            if (_loc_4.readByte() == 0)
            {
                this.labself.text = Config.language("PKraceinfoPanel", 12);
            }
            else if (_loc_5 == 1)
            {
                this.labself.text = Config.language("PKraceinfoPanel", 13);
            }
            else if (_loc_5 == 2)
            {
                this.labself.text = Config.language("PKraceinfoPanel", 14);
            }
            else if (_loc_5 == 3)
            {
                this.labself.text = Config.language("PKraceinfoPanel", 15);
            }
            else if (_loc_5 == 4)
            {
                this.labself.text = "";
                _loc_9 = new Object();
                _loc_10 = _loc_4.readUnsignedShort();
                _loc_9.name = _loc_4.readUTFBytes(_loc_10);
                _loc_9.level = _loc_4.readUnsignedShort();
                _loc_11 = _loc_4.readByte();
                _loc_9.jobname = Config._jobTitleMap[_loc_11];
                _loc_2.push(_loc_9);
            }
            else
            {
                this.labself.text = Config.language("PKraceinfoPanel", 16);
            }
            this.datalistP.dataProvider = _loc_2;
            if (this.datalistP.dataProvider.length <= 0)
            {
                this.datalistP.noinforvisib();
            }
            var _loc_6:* = _loc_4.readByte();
            if (_loc_4.readByte() >= 1 && _loc_6 <= 5)
            {
                this.topbtn.selectpage = _loc_6 - 1;
            }
            var _loc_7:* = _loc_4.readUnsignedInt();
            var _loc_8:* = 0;
            while (_loc_8 < _loc_7)
            {
                
                _loc_12 = new Object();
                _loc_13 = _loc_4.readUnsignedShort();
                _loc_12.name = _loc_4.readUTFBytes(_loc_13);
                _loc_12.level = _loc_4.readUnsignedShort();
                _loc_14 = _loc_4.readByte();
                _loc_12.jobname = Config._jobTitleMap[_loc_14];
                _loc_12.online = "";
                _loc_3.push(_loc_12);
                _loc_8 = _loc_8 + 1;
            }
            this.datalist.dataProvider = _loc_3;
            return;
        }// end function

        public function sendInfo()
        {
            var _loc_1:* = 0;
            if (Config.player.level < 50)
            {
                _loc_1 = 1;
            }
            else if (Config.player.level < 70)
            {
                _loc_1 = int(Config.player.level / 10) - 3;
            }
            else if (Config.player.level < 90)
            {
                _loc_1 = 4;
            }
            else
            {
                _loc_1 = 5;
            }
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_PK_ACTIVITY_SCHEDULE_INFO);
            _loc_2.add8(_loc_1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function removeallchild(param1:Sprite)
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        private function cdgo(event:TimerEvent)
        {
            var _loc_2:* = String(Math.max(0, this.countdown - int((getTimer() - this._cdStamp) / 1000)));
            if (this.fristFight == 2)
            {
                this.labtime.text = Config.language("PKraceinfoPanel", 18, Config.timeShow(_loc_2));
            }
            if (_loc_2 <= 0)
            {
                this.removetime();
            }
            return;
        }// end function

        private function removetime()
        {
            this.labtime.text = "";
            if (this.timerr != null)
            {
                this.timerr.stop();
                this.timerr.removeEventListener(TimerEvent.TIMER, this.cdgo);
            }
            return;
        }// end function

    }
}
