package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class PkraceUI extends Sprite
    {
        private var _exitPB:PushButton;
        private var _timeLB:Label;
        private var countdown:Number;
        private var _preAlertId:Number = 0;
        private var _preAlertId2:Number = 0;
        private var leftSec:Number;
        private var _cdStamp:Number;
        private var _preCd:Number;
        private var status:int;
        private var timerr:Timer;

        public function PkraceUI()
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PK_ACTIVITY_COUNTDOWN, this.handlePkResponse);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PK_ACTIVITY_BEG_ENTER, this.handlePkalert);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_PK_ACTIVITY_RESULT, this.handlePkresult);
            this.init();
            return;
        }// end function

        private function init()
        {
            this._exitPB = new PushButton(this, 0, 0, Config.language("PkraceUI", 1), this.handleExit, null, "table18", "table31");
            this._exitPB.textColor = Style.GOLD_FONT;
            this._exitPB.width = 60;
            this._timeLB = new Label(this, -5, 20);
            this._timeLB.textColor = Style.WHITE_FONT;
            this._timeLB.filters = [new GlowFilter(0, 1, 1.5, 1.5, 5)];
            this.timerr = new Timer(1000, 500);
            return;
        }// end function

        public function enterRace()
        {
            if (this.parent == null)
            {
                Config.ui._radar.addChild(this);
                Config.ui._radar.hidepkraceBtn();
            }
            this._timeLB.text = "";
            return;
        }// end function

        public function exitRace()
        {
            if (this.parent != null)
            {
                this.parent.removeChild(this);
                Config.ui._radar.showpkraceBtn();
            }
            if (this.timerr != null)
            {
                this.timerr.stop();
                this.timerr.removeEventListener(TimerEvent.TIMER, this.cdgo);
            }
            AlertUI.remove(this._preAlertId);
            return;
        }// end function

        private function handlePkResponse(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            this.status = _loc_2.readByte();
            this.countdown = _loc_2.readUnsignedInt();
            var _loc_3:* = _loc_2.readUnsignedInt();
            this._cdStamp = getTimer();
            this._preCd = -100;
            if (this.status == 1)
            {
                this.timerr.stop();
            }
            else if (this.status == 2 || this.status == 3)
            {
                this.timerr.stop();
                this.timerr.removeEventListener(TimerEvent.TIMER, this.cdgo);
                this.timerr.addEventListener(TimerEvent.TIMER, this.cdgo);
                this.timerr.start();
            }
            else if (this.status == 4)
            {
                this.timerr.stop();
                this.timerr.removeEventListener(TimerEvent.TIMER, this.cdgo);
                this.timerr.addEventListener(TimerEvent.TIMER, this.cdgo);
                this.timerr.start();
                this._timeLB.text = "";
                this._preAlertId = AlertUI.alert(Config.language("PkraceUI", 2), Config.language("PkraceUI", 11, 30), [Config.language("PkraceUI", 12)], [this.handleExit]);
            }
            return;
        }// end function

        private function cdgo(event:TimerEvent)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = Number(Math.max(0, this.countdown - int((getTimer() - this._cdStamp) / 1000)));
            if (this._preCd != _loc_2)
            {
                this._preCd = _loc_2;
                if (this.status == 1)
                {
                }
                else if (this.status == 2)
                {
                    Neon.show((_loc_2 - 1));
                    if (_loc_2 <= 0)
                    {
                        this.timerr.stop();
                    }
                }
                else if (this.status == 3)
                {
                    this._timeLB.text = Config.language("PkraceUI", 13) + Config.timeShow(_loc_2);
                    if (_loc_2 <= 0)
                    {
                        this.timerr.stop();
                    }
                }
                else if (this.status == 4)
                {
                    _loc_3 = String(_loc_2);
                    if (_loc_3.length == 1)
                    {
                        _loc_3 = "0" + _loc_2;
                    }
                    AlertUI.msg = Config.language("PkraceUI", 11, _loc_3);
                    if (_loc_2 <= 0)
                    {
                        if (this.timerr != null)
                        {
                            this.timerr.stop();
                            AlertUI.close();
                        }
                    }
                }
                else if (this.status == 0)
                {
                    AlertUI.msg = Config.language("PkraceUI", 3, Config.timeShow(_loc_2));
                    if (_loc_2 <= 0)
                    {
                        if (this.timerr != null)
                        {
                            this.timerr.stop();
                            this.timerr.removeEventListener(TimerEvent.TIMER, this.cdgo);
                            AlertUI.remove(this._preAlertId2);
                            AlertUI.alert(Config.language("PkraceUI", 2), Config.language("PkraceUI", 18), [Config.language("PkraceUI", 7)]);
                        }
                    }
                }
                trace("leftsec+++", _loc_2);
            }
            return;
        }// end function

        private function handleExit(param1 = null)
        {
            if (this.status == 1 || this.status == 2 || this.status == 3)
            {
                AlertUI.alert(Config.language("PkraceUI", 2), Config.language("PkraceUI", 17), [Config.language("PkraceUI", 5), Config.language("PkraceUI", 6)], [this.surexitrace]);
                return;
            }
            this.surexitrace();
            return;
        }// end function

        private function surexitrace(param1 = null)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_PK_ACTIVITY_REQUEST_LEAVE);
            ClientSocket.send(_loc_2);
            if (this.timerr != null)
            {
                this.timerr.stop();
                this.timerr.removeEventListener(TimerEvent.TIMER, this.cdgo);
                AlertUI.close();
            }
            return;
        }// end function

        private function handlePkalert(event:SocketEvent)
        {
            var _loc_5:* = null;
            var _loc_2:* = event.data;
            this.countdown = _loc_2.readUnsignedInt();
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readByte();
            this._cdStamp = getTimer();
            this._preCd = -100;
            if (_loc_4 == 0)
            {
                this.status = 0;
                this.timerr.stop();
                this.timerr.removeEventListener(TimerEvent.TIMER, this.cdgo);
                this.timerr.addEventListener(TimerEvent.TIMER, this.cdgo);
                this.timerr.start();
                _loc_5 = "2:00";
                if (this._preAlertId != 0)
                {
                    AlertUI.remove(this._preAlertId);
                }
                this._preAlertId2 = AlertUI.alert(Config.language("PkraceUI", 2), Config.language("PkraceUI", 3, _loc_5), [Config.language("PkraceUI", 5), Config.language("PkraceUI", 6)], [this.surenter]);
            }
            else if (_loc_4 == 1)
            {
                AlertUI.alert(Config.language("PkraceUI", 2), Config.language("PkraceUI", 4), [Config.language("PkraceUI", 7)]);
            }
            return;
        }// end function

        private function surenter(param1)
        {
            Config.ui._pkrace.sendenterPkmap();
            return;
        }// end function

        private function handlePkresult(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            if (_loc_3 == 0)
            {
                Config.message(Config.language("PkraceUI", 8));
                Billboard.show(Config.language("PkraceUI", 14));
            }
            else if (_loc_3 == 1)
            {
                Config.message(Config.language("PkraceUI", 9));
                Billboard.show(Config.language("PkraceUI", 15));
            }
            else if (_loc_3 == 2)
            {
                Config.message(Config.language("PkraceUI", 10));
                Billboard.show(Config.language("PkraceUI", 16));
            }
            this._timeLB.text = "";
            return;
        }// end function

    }
}
