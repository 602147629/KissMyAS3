package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class MoraUI extends Window
    {
        private var _boutHandArray:Array;
        private var _boutHandPlayer:ButtonSlot;
        private var _boutHandCom:ButtonSlot;
        private var _boutHandPlayerCurr:Number;
        private var _boutHandComCurr:Number;
        private var _boutInterval:Number;
        private var _boutCount:Number;
        private var _currentTime:int = 0;
        private var _bouting:Boolean = true;
        private var _nextPB:PushButton;
        private var _preDraw:Boolean = false;
        private var endLabel:Label;
        private var titleLabel:Label;
        private var Label1:Label;

        public function MoraUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            this._boutHandArray = [];
            super(param1, param2, param3);
            title = Config.language("MoraUI", 1);
            this.init();
            return;
        }// end function

        private function init()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = null;
            resize(260, 330);
            _loc_1 = 0;
            while (_loc_1 < 3)
            {
                
                this._boutHandArray[_loc_1] = new ButtonSlot(58);
                this._boutHandArray[_loc_1].x = 27 + _loc_1 * 75;
                this._boutHandArray[_loc_1].setIcon(this.transBout(_loc_1), false, 58, 58);
                this._boutHandArray[_loc_1].y = 242;
                this.addChild(this._boutHandArray[_loc_1]);
                this._boutHandArray[_loc_1].data = _loc_1;
                this._boutHandArray[_loc_1].addEventListener(MouseEvent.CLICK, this.handleBout);
                this._boutHandArray[_loc_1].addEventListener(MouseEvent.ROLL_OVER, this.handleOver);
                this._boutHandArray[_loc_1].addEventListener(MouseEvent.ROLL_OUT, this.handleOut);
                _loc_1 = _loc_1 + 1;
            }
            _loc_3 = new Panel(this, 15, 72);
            _loc_3.color = 13545363;
            _loc_3.width = 230;
            _loc_3.height = 130;
            _loc_3.roundCorner = 7;
            _loc_4 = new Label(this, 30, 86, Config.language("FbDetailUI", 2));
            _loc_4 = new Label(this, 173, 86, Config.language("MoraUI", 2));
            this._boutHandPlayer = new ButtonSlot(58);
            this._boutHandPlayer.setIcon(this.transBout(int(Math.random() * 3)), true, 58, 58);
            this._boutHandPlayer.x = 30;
            this._boutHandPlayer.y = 114;
            this._boutHandPlayer.buttonMode = false;
            this.addChild(this._boutHandPlayer);
            this._boutHandCom = new ButtonSlot(58);
            this._boutHandCom.setIcon(this.transBout(int(Math.random() * 3)), true, 58, 58);
            this._boutHandCom.x = 172;
            this._boutHandCom.y = 114;
            this._boutHandCom.buttonMode = false;
            this.addChild(this._boutHandCom);
            this.Label1 = new Label(this, 30, 213, Config.language("MoraUI", 3));
            this.titleLabel = new Label(this, 74, 42, Config.language("MoraUI", 4, "1"));
            var _loc_5:* = new Label(this, 110, 115, "<b><font size=\'40\' color=\'" + Style.FONT_Red + "\'>" + "vs" + "</font></b>");
            new Label(this, 110, 115, "<b><font size=\'40\' color=\'" + Style.FONT_Red + "\'>" + "vs" + "</font></b>").html = true;
            this.endLabel = new Label(this, 30, 220);
            this._nextPB = new PushButton(this, 80, 285, Config.language("MoraUI", 5), this.handleNext);
            this._nextPB.visible = false;
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_BOUT, this.handleBoutReceive);
            return;
        }// end function

        private function handleNext(param1)
        {
            if (this._currentTime < 10)
            {
                this.setBouting(true);
            }
            else
            {
                this.close();
            }
            return;
        }// end function

        private function handleBoutReceive(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readByte();
            var _loc_4:* = _loc_2.readByte();
            var _loc_5:* = _loc_2.readByte();
            this._boutHandPlayer.setIcon(this.transBout(_loc_3), true, 58, 58);
            this._boutHandCom.setIcon(this.transBout(_loc_4), true, 58, 58);
            this._preDraw = false;
            switch(_loc_5)
            {
                case 0:
                {
                    this.endLabel.text = Config.language("MoraUI", 6).replace(/\\\
n""\\n/g, "\n");
                    this._boutHandPlayer.releaseParticle();
                    this._boutHandCom.releaseParticle();
                    this._boutHandCom.setEffect("mora/win", 67, 32);
                    this._boutHandPlayer.setEffect("mora/lose", 73, 32);
                    this._boutHandCom.setEffect("mora/win", 67, 32);
                    if (this._currentTime < 10)
                    {
                        this._nextPB.label = Config.language("MoraUI", 7);
                    }
                    break;
                }
                case 1:
                {
                    this.endLabel.text = Config.language("MoraUI", 8);
                    this._boutHandPlayer.releaseParticle();
                    this._boutHandCom.releaseParticle();
                    this._boutHandPlayer.setEffect("mora/win", 67, 32);
                    this._boutHandCom.setEffect("mora/lose", 73, 32);
                    if (this._currentTime < 10)
                    {
                        this._nextPB.label = Config.language("MoraUI", 7);
                    }
                    break;
                }
                case 2:
                {
                    this.endLabel.text = Config.language("MoraUI", 9).replace(/\\\
n""\\n/g, "\n");
                    this._boutHandPlayer.releaseParticle();
                    this._boutHandCom.releaseParticle();
                    this._boutHandPlayer.setEffect("mora/draw", 88, 34);
                    this._boutHandCom.setEffect("mora/draw", 88, 34);
                    this._preDraw = true;
                    if (this._currentTime < 10)
                    {
                        this._nextPB.label = Config.language("MoraUI", 10);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_6:* = _loc_2.readUnsignedInt();
            var _loc_7:* = _loc_2.readUnsignedInt();
            if (_loc_6 > 0 && _loc_7 > 0)
            {
                if (_loc_7 > 1)
                {
                    this.endLabel.text = this.endLabel.text + Config.language("MoraUI", 11, Config._itemMap[_loc_6].name, _loc_7).replace(/\\\
n""\\n/g, "\n");
                }
                else
                {
                    this.endLabel.text = this.endLabel.text + Config.language("MoraUI", 12, Config._itemMap[_loc_6].name).replace(/\\\
n""\\n/g, "\n");
                }
            }
            this.setBouting(false);
            return;
        }// end function

        public function set time(param1:int)
        {
            this._currentTime = param1;
            if (this._currentTime < 10)
            {
                if (this._bouting)
                {
                    this.titleLabel.text = Config.language("MoraUI", 4, "" + (this._currentTime + 1));
                }
                else
                {
                    this.titleLabel.text = Config.language("MoraUI", 4, "" + this._currentTime);
                }
            }
            else
            {
                this._nextPB.label = Config.language("MoraUI", 13);
                this.stopBoutSelect();
                this.titleLabel.text = Config.language("MoraUI", 14);
            }
            return;
        }// end function

        private function setBouting(param1:Boolean)
        {
            var _loc_2:* = undefined;
            this._bouting = param1;
            if (this._currentTime < 10)
            {
                if (this._bouting || this._preDraw)
                {
                    this.titleLabel.text = Config.language("MoraUI", 4, "" + (this._currentTime + 1));
                }
                else
                {
                    this.titleLabel.text = Config.language("MoraUI", 4, "" + this._currentTime);
                }
            }
            if (this._bouting)
            {
                _loc_2 = 0;
                while (_loc_2 < 3)
                {
                    
                    this._boutHandArray[_loc_2].visible = true;
                    _loc_2 = _loc_2 + 1;
                }
                this.endLabel.visible = false;
                this._nextPB.visible = false;
                this.Label1.visible = true;
                if (this._currentTime < 10)
                {
                    this.startBoutSelect();
                }
            }
            else
            {
                _loc_2 = 0;
                while (_loc_2 < 3)
                {
                    
                    this._boutHandArray[_loc_2].visible = false;
                    _loc_2 = _loc_2 + 1;
                }
                this.endLabel.visible = true;
                this._nextPB.visible = true;
                this.Label1.visible = false;
                this.stopBoutSelect();
            }
            return;
        }// end function

        private function transBout(param1)
        {
            if (param1 == 0)
            {
                return "mora/bout0";
            }
            if (param1 == 1)
            {
                return "mora/bout1";
            }
            if (param1 == 2)
            {
                return "mora/bout2";
            }
            return;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open(event);
            if (this._bouting && this._currentTime < 10)
            {
                this.startBoutSelect();
            }
            return;
        }// end function

        override public function close()
        {
            super.close();
            this.stopBoutSelect();
            return;
        }// end function

        private function handleBout(event:Event)
        {
            var _loc_2:* = null;
            if (this._currentTime < 10)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_BOUT);
                _loc_2.add8(event.currentTarget.data);
                ClientSocket.send(_loc_2);
            }
            return;
        }// end function

        private function startBoutSelect()
        {
            this._boutInterval = 6;
            this._boutCount = this._boutInterval;
            this._boutHandPlayerCurr = Math.floor(Math.random() * 3);
            this._boutHandComCurr = Math.floor(Math.random() * 3);
            this.boutSelectLoop();
            this._boutHandPlayer.clearEffect();
            this._boutHandCom.clearEffect();
            Config.startLoop(this.boutSelectLoop);
            return;
        }// end function

        private function stopBoutSelect()
        {
            Config.stopLoop(this.boutSelectLoop);
            return;
        }// end function

        private function boutSelectLoop(param1 = null)
        {
            var _loc_2:* = undefined;
            if (this._boutCount <= 0)
            {
                if (this._boutInterval > 2)
                {
                    this._boutInterval = this._boutInterval - 2;
                }
                this._boutCount = this._boutInterval;
                _loc_2 = Math.floor(Math.random() * 3);
                do
                {
                    
                    _loc_2 = Math.floor(Math.random() * 3);
                }while (_loc_2 == this._boutHandPlayerCurr)
                this._boutHandPlayerCurr = _loc_2;
                this._boutHandPlayer.setIcon(this.transBout(this._boutHandPlayerCurr), true, 58, 58);
                _loc_2 = Math.floor(Math.random() * 3);
                do
                {
                    
                    _loc_2 = Math.floor(Math.random() * 3);
                }while (_loc_2 == this._boutHandComCurr)
                this._boutHandComCurr = _loc_2;
                this._boutHandCom.setIcon(this.transBout(this._boutHandComCurr), true, 58, 58);
            }
            else
            {
                var _loc_3:* = this;
                var _loc_4:* = this._boutCount - 1;
                _loc_3._boutCount = _loc_4;
            }
            return;
        }// end function

        private function clear()
        {
            this.stopBoutSelect();
            return;
        }// end function

        private function handleOver(event:Event) : void
        {
            event.currentTarget.setColorBorder(Style.FONT_3int_Orange, Style.FONT_3int_Orange - 50);
            return;
        }// end function

        private function handleOut(event:Event) : void
        {
            event.currentTarget.setColorBorder(null);
            return;
        }// end function

    }
}
