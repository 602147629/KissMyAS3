package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class YabiaoTime extends Sprite
    {
        private var container:Sprite;
        private var shape:Sprite;
        private var enterTime:Label;
        private var timerr:Timer;
        private var loginTime1:int;
        private var loginTime2:int;
        public var gildName:String = "";
        private var _fGild:int = 0;
        public var defList:Array;

        public function YabiaoTime(param1:Sprite)
        {
            this.defList = [];
            this.container = param1;
            this.initpanel();
            return;
        }// end function

        private function initpanel()
        {
            this.shape = new Sprite();
            this.addChild(this.shape);
            this.shape.x = 10;
            this.shape.y = 10;
            this.shape.graphics.beginFill(0, 0.5);
            this.shape.graphics.drawRoundRect(10, 0, 200, 25, 5);
            this.shape.graphics.endFill();
            this.enterTime = new Label(this, 40, 15);
            this.enterTime.html = true;
            this.timerr = new Timer(1000);
            this.timerr.removeEventListener(TimerEvent.TIMER, this.enterremaintime);
            this.timerr.addEventListener(TimerEvent.TIMER, this.enterremaintime);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BDG_INFO, this.defListFuc);
            return;
        }// end function

        public function openscPanel()
        {
            var _loc_1:* = new Date();
            _loc_1.setTime(Config.now.getTime());
            this.loginTime1 = int(_loc_1.getTime() / 1000);
            _loc_1.setHours(21, 2, 0);
            this.loginTime2 = int(_loc_1.getTime() / 1000);
            trace("++", this.loginTime2, Config.now.getTime(), this.loginTime1);
            if (this.parent == null && this.loginTime2 > this.loginTime1)
            {
                this.timerr.start();
                this.container.addChild(this);
            }
            return;
        }// end function

        private function close() : void
        {
            if (this.parent != null)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

        private function enterremaintime(event:TimerEvent)
        {
            var _loc_2:* = 0;
            var _loc_3:* = this;
            var _loc_4:* = this.loginTime1 + 1;
            _loc_3.loginTime1 = _loc_4;
            if (this.loginTime2 - this.loginTime1 > 0)
            {
                _loc_2 = this.loginTime2 - this.loginTime1;
                this.enterTime.text = Config.language("YabiaoTime", 1, _loc_2);
            }
            else
            {
                this.enterTime.text = "";
                this.timerr.stop();
                this.timerr.removeEventListener(TimerEvent.TIMER, this.enterremaintime);
                this.close();
            }
            return;
        }// end function

        public function defFlag(param1:int = -1) : Boolean
        {
            if (param1 == -1)
            {
                param1 = Config.player.gildid;
            }
            var _loc_2:* = false;
            var _loc_3:* = 0;
            while (_loc_3 < this.defList.length)
            {
                
                if (param1 == this.defList[_loc_3] && this.defList[_loc_3] != 0)
                {
                    _loc_2 = true;
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public function setYbiaoName() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            if (Config.player == null)
            {
                return;
            }
            var _loc_1:* = false;
            if (Config.map != null)
            {
                if (Config.mapId > 1000000000)
                {
                    return;
                }
                if (Config.map._type == 13)
                {
                    if (this.defFlag())
                    {
                        _loc_1 = true;
                    }
                    _loc_2 = Unit.getPlayerlist();
                    for (_loc_3 in _loc_2)
                    {
                        
                        if (_loc_1)
                        {
                            if (this.defFlag(_loc_2[_loc_3].gildid))
                            {
                                _loc_2[_loc_3].setNameColor(3);
                            }
                            else
                            {
                                _loc_2[_loc_3].setNameColor(2);
                            }
                            continue;
                        }
                        if (this.defFlag(_loc_2[_loc_3].gildid))
                        {
                            _loc_2[_loc_3].setNameColor(2);
                            continue;
                        }
                        _loc_2[_loc_3].setNameColor(3);
                    }
                }
            }
            return;
        }// end function

        private function defListFuc(event:SocketEvent) : void
        {
            var _loc_3:* = 0;
            this.defList.length = 0;
            var _loc_2:* = 0;
            while (_loc_2 < 3)
            {
                
                _loc_3 = event.data.readUnsignedInt();
                this.defList.push(_loc_3);
                _loc_2 = _loc_2 + 1;
            }
            this.setYbiaoName();
            return;
        }// end function

    }
}
