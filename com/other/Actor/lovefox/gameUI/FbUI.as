package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class FbUI extends Sprite
    {
        private var _infoTxt1:TextField;
        private var _infoTxt2:TextField;
        private var _exitPB:PushButton;
        private var _currTxt:TextField;
        private var _alertIndex:int = -1;
        public static var _fbing:Boolean = false;

        public function FbUI()
        {
            this.init();
            return;
        }// end function

        private function init()
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this.y = 180;
            this.x = -150;
            _loc_2 = [new GlowFilter(0, 1, 2, 2, 10)];
            _loc_1 = new Label(this, -10, 0, Config.language("FbUI", 1));
            _loc_1.textColor = 16752190;
            _loc_1.filters = _loc_2;
            _loc_1 = new Label(this, -10, 0, "_______________________");
            _loc_1.textColor = 16752190;
            _loc_1.filters = _loc_2;
            this._infoTxt1 = Config.getSimpleTextField();
            this._infoTxt1.y = 25;
            this._infoTxt1.wordWrap = true;
            this._infoTxt1.width = 140;
            this._infoTxt1.textColor = Style.WHITE_FONT;
            this._infoTxt1.filters = _loc_2;
            this._infoTxt2 = Config.getSimpleTextField();
            this._infoTxt2.y = 25;
            this._infoTxt2.textColor = Style.WHITE_FONT;
            this._infoTxt2.filters = _loc_2;
            addChild(this._infoTxt1);
            addChild(this._infoTxt2);
            this._exitPB = new PushButton(this, 70, 100, Config.language("FbUI", 2), this.handleExit);
            this._exitPB.overshow = true;
            this._exitPB.setTable("table18", "table31");
            this._exitPB.textColor = Style.GOLD_FONT;
            this._exitPB.width = 60;
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_INSTANCE_GUIDE, this.handleGuide);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.G2C_INSTANCE_LEAVE, this.handleLeaveRcv);
            return;
        }// end function

        private function handleLeaveRcv(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            if (_loc_3 == 1)
            {
                Config.message(Config.language("FbUI", 7));
            }
            return;
        }// end function

        private function handleExit(param1)
        {
            if (this._alertIndex >= 0)
            {
                AlertUI.remove(this._alertIndex);
            }
            this._alertIndex = AlertUI.alert(Config.language("FbUI", 3), Config.language("FbUI", 4), [Config.language("FbUI", 5), Config.language("FbUI", 6)], [this.subhandleExit]);
            return;
        }// end function

        private function subhandleExit(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LEAVEINSTANCE);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function handleEnter()
        {
            _fbing = true;
            this.open();
            return;
        }// end function

        public function handleLeave()
        {
            _fbing = false;
            this.close();
            return;
        }// end function

        private function handleGuide(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_4:* = _loc_2.readUnsignedShort();
            var _loc_5:* = _loc_2.readUTFBytes(_loc_4);
            var _loc_6:* = String(Config._fbGuideMap[_loc_3].content).replace(/\\\
n""\\n/g, "\n");
            var _loc_7:* = 0;
            if (_loc_6.indexOf("#") == 0)
            {
                _loc_7 = 1;
                _loc_6 = _loc_6.substring(1);
            }
            this._infoTxt1.text = _loc_6;
            if (_loc_5.substring((_loc_5.length - 1)) == ",")
            {
                _loc_5 = _loc_5.substring(0, (_loc_5.length - 1));
            }
            this._infoTxt2.text = _loc_5;
            if (_loc_7 == 0)
            {
                this._infoTxt1.width = 140;
                this._infoTxt2.y = this._infoTxt1.y + this._infoTxt1.height + 2;
                this._infoTxt2.x = this._infoTxt1.x + this._infoTxt1.width - this._infoTxt2.width - 5;
            }
            else
            {
                this._infoTxt1.width = 100;
                this._infoTxt2.y = this._infoTxt1.y;
                this._infoTxt2.x = this._infoTxt1.width + 10;
            }
            this._exitPB.y = Math.max(100, Math.max(this._infoTxt1.y + this._infoTxt1.height + 10, this._infoTxt2.y + this._infoTxt2.height + 10));
            return;
        }// end function

        public function open()
        {
            if (this.parent == null)
            {
                Config.ui._radar.addChild(this);
            }
            Config.ui._taskpanel._tasktips.close(true);
            return;
        }// end function

        public function close()
        {
            if (this.parent != null)
            {
                this.parent.removeChild(this);
            }
            if (Config.ui._taskpanel._tasktips.opening)
            {
                Config.ui._taskpanel._tasktips.open();
            }
            Config.ui._fbDetailUI.close();
            return;
        }// end function

    }
}
