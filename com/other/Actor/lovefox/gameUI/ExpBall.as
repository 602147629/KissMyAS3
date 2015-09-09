package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class ExpBall extends Object
    {
        private var mainpanel:Sprite;
        private var _has:int = 0;
        private var _ballopening:Boolean = false;
        private var _expalltime:int = 0;
        private var _expclosetime:int = 0;
        private var _leftexp:int = 0;
        private var _leftpoint:int = 0;
        private var openbtn:PushButton;
        private var _lefttimelabel:Label;
        private var selectnum:int = 0;
        private var _position:int = 0;
        private var radioarr:Array;
        private var ballbuf:Sprite;
        private var balltimer:Timer;
        private var buftipflag:Boolean = false;
        private var balltip:Sprite;
        private var timetip:Label;
        private var exptip:Label;
        private var leftpoint:Label;

        public function ExpBall()
        {
            this.initsocket();
            return;
        }// end function

        private function initsocket() : void
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_EXPBALL_CLOSE, this.expclose);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_EXPBALL_INFO, this.expinfor);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_EXP_LIMIT, this.expout);
            return;
        }// end function

        public function expOpen(param1) : void
        {
            switch(param1)
            {
                case 0:
                {
                    Config.message(Config.language("ExpBall", 10));
                    this.setvalue("open", 1);
                    break;
                }
                case 1:
                {
                    Config.message(Config.language("ExpBall", 11));
                    break;
                }
                case 2:
                {
                    Config.message(Config.language("ExpBall", 12));
                    break;
                }
                case 3:
                {
                    Config.message(Config.language("ExpBall", 13));
                    break;
                }
                case 4:
                {
                    Config.message(Config.language("ExpBall", 14));
                    break;
                }
                case 5:
                {
                    Config.message(Config.language("ExpBall", 15));
                    break;
                }
                case 6:
                {
                    Config.message(Config.language("ExpBall", 16));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function expclose(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readByte();
            switch(_loc_4)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function expinfor(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readUnsignedInt();
            var _loc_5:* = _loc_2.readByte();
            this.setvalue("has", _loc_3);
            this.setvalue("open", _loc_5);
            this.setvalue("leftpoint", _loc_4);
            return;
        }// end function

        public function setvalue(param1:String, param2:int) : void
        {
            switch(param1)
            {
                case "has":
                {
                    this._has = param2;
                    break;
                }
                case "expalltime":
                {
                    this._expalltime = param2;
                    this._lefttimelabel.text = this._expalltime * 0.5 + Config.language("ExpBall", 6);
                    this.balltimer.start();
                    break;
                }
                case "expclosetime":
                {
                    this._expclosetime = param2;
                    if (this._expclosetime != 0)
                    {
                        this.bufshow();
                    }
                    break;
                }
                case "leftexp":
                {
                    this._leftexp = param2;
                    break;
                }
                case "leftpoint":
                {
                    this._leftpoint = param2;
                    Config.ui._playerHead.setEn(int(this._leftpoint / Config._ListExp[Config.player.level].monsterExp));
                    break;
                }
                case "open":
                {
                    if (param2 == 1)
                    {
                        this.bufshow();
                    }
                    else
                    {
                        this.bufclose();
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

        public function get leftexp() : int
        {
            return this._leftexp;
        }// end function

        public function openball(param1:int) : void
        {
            if (this._ballopening)
            {
                this.stopball();
            }
            else
            {
                if (Config.player.level < 20)
                {
                    Config.message(Config.language("ExpBall", 22));
                    return;
                }
                this.startball(param1);
            }
            return;
        }// end function

        private function selecttime(event:MouseEvent, param2:int) : void
        {
            this.selectnum = param2;
            return;
        }// end function

        private function startball(param1:int) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_EXPBALL_OPEN);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function stopball() : void
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_EXPBALL_CLOSE);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        public function getballtip() : String
        {
            var _loc_1:* = "";
            if (this._ballopening)
            {
                _loc_1 = Config.language("ExpBall", 23) + this._leftpoint;
            }
            else
            {
                _loc_1 = Config.language("ExpBall", 24) + this._leftpoint;
            }
            return _loc_1;
        }// end function

        private function timeshow(param1:int) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = int(param1 / 3600);
            var _loc_4:* = int((param1 - _loc_3 * 3600) / 60);
            var _loc_5:* = int(param1 - _loc_3 * 3600 - _loc_4 * 60);
            if (_loc_3 > 0)
            {
                _loc_2 = _loc_2 + (_loc_3 + Config.language("ExpBall", 6));
            }
            if (_loc_4 > 0)
            {
                _loc_2 = _loc_2 + (_loc_4 + Config.language("ExpBall", 25));
            }
            else if (_loc_3 > 0)
            {
                _loc_2 = _loc_2 + (_loc_4 + Config.language("ExpBall", 25));
            }
            _loc_2 = _loc_2 + (_loc_5 + Config.language("ExpBall", 26));
            return _loc_2;
        }// end function

        private function bufshow() : void
        {
            this._ballopening = true;
            Config.ui._playerHead.addBuf(9002, this.ballbuf);
            return;
        }// end function

        private function bufclose() : void
        {
            this._ballopening = false;
            Config.ui._playerHead.delBuf(9002);
            return;
        }// end function

        private function counttime(event:TimerEvent) : void
        {
            trace("counttime");
            if (this._expclosetime > 0)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._expclosetime - 1;
                _loc_2._expclosetime = _loc_3;
                if (this.buftipflag)
                {
                    this.timetip.text = this.timeshow(this._expclosetime);
                    this.exptip.text = Config.language("ExpBall", 21, Config.coinShow(this._leftexp));
                    this.leftpoint.text = Config.language("ExpBall", 21, Config.coinShow(this._leftpoint));
                }
            }
            else
            {
                this.bufclose();
            }
            return;
        }// end function

        private function expout(event:SocketEvent) : void
        {
            var _loc_2:* = event.data;
            Config.message(Config.language("ExpBall", 27));
            return;
        }// end function

    }
}
