package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.net.*;
    import flash.text.*;

    public class KitBardWindow extends Panel
    {
        private var _title:String;
        private var _titleTxt:TextField;
        private var _infoTxt:TextField;
        private var _timeTxt:TextField;
        private var _loader:Loader;
        private var _openable:Boolean = false;
        private var _nowTimer:Number;
        private var _nowTime:Number;
        private var _timeTimer:Number;

        public function KitBardWindow(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            super(param1, param2, param3);
            this._title = Config.language("KitBardWindow", 1);
            this.initUI();
            return;
        }// end function

        public function reload()
        {
            var _loc_1:* = new URLVariables();
            _loc_1.server = Config.serverName;
            _loc_1.name = Player.name;
            _loc_1.account = Config.account;
            var _loc_2:* = new URLRequest(Config.bardURL + "bard_dj_info.php");
            _loc_2.data = _loc_1;
            _loc_2.method = URLRequestMethod.POST;
            var _loc_3:* = new URLLoader();
            _loc_3.addEventListener(Event.COMPLETE, this.handleMoreRcv0);
            _loc_3.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleMoreError);
            _loc_3.addEventListener(IOErrorEvent.IO_ERROR, this.handleMoreError);
            _loc_3.load(_loc_2);
            return;
        }// end function

        private function handleMoreRcv0(param1)
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = URLLoader(param1.target);
            _loc_2.removeEventListener(Event.COMPLETE, this.handleMoreRcv0);
            _loc_2.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleMoreError);
            _loc_2.removeEventListener(IOErrorEvent.IO_ERROR, this.handleMoreError);
            var _loc_3:* = XML(_loc_2.data);
            if (String(_loc_3.rs) == "0")
            {
                _loc_4 = new Date(Number(_loc_3.time) * 1000);
                if (String(_loc_4.minutes).length == 1)
                {
                    _loc_5 = _loc_4.hours + ":0" + _loc_4.minutes;
                }
                else
                {
                    _loc_5 = _loc_4.hours + ":" + _loc_4.minutes;
                }
                this._infoTxt.textColor = 11344686;
                this._infoTxt.htmlText = Config.language("KitBardWindow", 2, _loc_5);
                this._openable = true;
            }
            else
            {
                this._infoTxt.textColor = Style.WINDOW_FONT;
                if (String(_loc_3.rs) == "-1")
                {
                    this._infoTxt.textColor = Style.WINDOW_FONT;
                    this._infoTxt.htmlText = Config.language("KitBardWindow", 3);
                }
                else if (String(_loc_3.rs) == "3")
                {
                    this._infoTxt.textColor = Style.WINDOW_FONT;
                    this._infoTxt.htmlText = Config.language("KitBardWindow", 4);
                }
                else if (String(_loc_3.rs) == "1")
                {
                    _loc_4 = new Date(Number(_loc_3.time) * 1000);
                    if (String(_loc_4.minutes).length == 1)
                    {
                        _loc_5 = _loc_4.hours + ":0" + _loc_4.minutes;
                    }
                    else
                    {
                        _loc_5 = _loc_4.hours + ":" + _loc_4.minutes;
                    }
                    this._infoTxt.textColor = 3295734;
                    this._infoTxt.htmlText = Config.language("KitBardWindow", 5, _loc_5);
                }
                else if (String(_loc_3.rs) == "2")
                {
                    _loc_4 = new Date(Number(_loc_3.time) * 1000);
                    if (String(_loc_4.minutes).length == 1)
                    {
                        _loc_5 = _loc_4.hours + ":0" + _loc_4.minutes;
                    }
                    else
                    {
                        _loc_5 = _loc_4.hours + ":" + _loc_4.minutes;
                    }
                    this._infoTxt.textColor = 3295734;
                    this._infoTxt.htmlText = Config.language("KitBardWindow", 6, _loc_5);
                }
                this._openable = false;
            }
            this._nowTimer = getTimer();
            this._nowTime = Number(_loc_3.now);
            this.timeGo();
            clearInterval(this._timeTimer);
            this._timeTimer = setInterval(this.timeGo, 500);
            return;
        }// end function

        private function timeGo()
        {
            var _loc_1:* = int((getTimer() - this._nowTimer) / 1000) + this._nowTime;
            var _loc_2:* = (int(_loc_1 / 3600) - Config.timezoneOffset) % 24;
            var _loc_3:* = int(_loc_1 / 60) % 60;
            var _loc_4:* = _loc_1 % 60;
            this._timeTxt.text = _loc_2 + ":" + this.toTime(_loc_3) + ":" + this.toTime(_loc_4);
            return;
        }// end function

        private function toTime(param1)
        {
            var _loc_2:* = String(param1);
            if (_loc_2.length == 1)
            {
                _loc_2 = "0" + _loc_2;
            }
            return _loc_2;
        }// end function

        private function handleMoreError(param1)
        {
            var _loc_2:* = URLLoader(param1.target);
            _loc_2.removeEventListener(Event.COMPLETE, this.handleMoreRcv0);
            _loc_2.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleMoreError);
            _loc_2.removeEventListener(IOErrorEvent.IO_ERROR, this.handleMoreError);
            return;
        }// end function

        private function initUI()
        {
            this.buttonMode = true;
            this.roundCorner = 7;
            this.borderColor = 8410936;
            var _loc_1:* = 16709562;
            this.bgColor = 16709562;
            this.color = _loc_1;
            setSize(120, 80);
            this._titleTxt = Config.getSimpleTextField();
            this._titleTxt.autoSize = TextFieldAutoSize.CENTER;
            this._titleTxt.x = 60;
            this._titleTxt.textColor = Style.WINDOW_FONT;
            this._titleTxt.text = this._title;
            this.addChild(this._titleTxt);
            this._infoTxt = Config.getSimpleTextField();
            this._infoTxt.autoSize = TextFieldAutoSize.CENTER;
            this._infoTxt.multiline = true;
            this._infoTxt.x = 60;
            this._infoTxt.y = 20;
            this._infoTxt.textColor = Style.WINDOW_FONT;
            this.addChild(this._infoTxt);
            this._timeTxt = Config.getSimpleTextField();
            this._timeTxt.autoSize = TextFieldAutoSize.CENTER;
            this._timeTxt.x = 60;
            this._timeTxt.y = 60;
            this._timeTxt.textColor = Style.WINDOW_FONT;
            this.addChild(this._timeTxt);
            this.addEventListener(MouseEvent.CLICK, this.handleClick);
            this.addEventListener(MouseEvent.ROLL_OVER, this.handleLabelRollOver);
            this.addEventListener(MouseEvent.ROLL_OUT, this.handleLabelRollOut);
            return;
        }// end function

        private function handleClick(param1)
        {
            if (this._openable)
            {
                KitBardUI.open();
                ComboBox(parent).innerClose();
            }
            return;
        }// end function

        private function handleLabelRollOver(param1)
        {
            this.color = Style.SELECTED_ITEM;
            return;
        }// end function

        private function handleLabelRollOut(param1)
        {
            this.color = 16709562;
            return;
        }// end function

        public function close()
        {
            clearInterval(this._timeTimer);
            if (parent != null)
            {
                parent.removeChild(this);
            }
            return;
        }// end function

    }
}
