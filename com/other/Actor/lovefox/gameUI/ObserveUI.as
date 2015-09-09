package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import lovefox.socket.*;

    public class ObserveUI extends Window
    {
        private var _startYIT:InputText;
        private var _startMIT:InputText;
        private var _startDIT:InputText;
        private var _endYIT:InputText;
        private var _endMIT:InputText;
        private var _endDIT:InputText;
        private var _idIT:InputText;
        private var _recordList:List;
        private var _playBar:ProgressBar;
        private var _preWindow:Window;
        public static var instance:ObserveUI;

        public function ObserveUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            super(param1, param2, param3);
            instance = this;
            this.initUI();
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.B2C_OBSERVE_WATCH, this.handleWatch);
            return;
        }// end function

        private function handleWatch(event:SocketEvent)
        {
            var _loc_4:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            var _loc_5:* = [];
            var _loc_6:* = 0;
            while (_loc_6 < _loc_3)
            {
                
                _loc_7 = _loc_2.readUnsignedInt();
                _loc_4 = _loc_2.readUnsignedShort();
                _loc_8 = _loc_2.readUTFBytes(_loc_4);
                _loc_4 = _loc_2.readUnsignedShort();
                _loc_9 = _loc_2.readUTFBytes(_loc_4);
                trace(_loc_7, _loc_8, _loc_9);
                _loc_10 = new Date(_loc_7 * 1000);
                if (_loc_8 != "map")
                {
                    _loc_11 = Observe._codeWindowMap[_loc_8];
                    _loc_5.push({label:(_loc_10.getMonth() + 1) + "月" + _loc_10.getDate() + "日 " + _loc_10.getHours() + ":" + _loc_10.getMinutes() + "--" + _loc_11.title, time:_loc_7, win:_loc_11, opCode:_loc_9});
                }
                else
                {
                    _loc_5.push({label:(_loc_10.getMonth() + 1) + "月" + _loc_10.getDate() + "日 " + _loc_10.getHours() + ":" + _loc_10.getMinutes() + "--跳转地图:" + _loc_9, time:_loc_7});
                }
                _loc_6++;
            }
            this._recordList.itemArray = _loc_5;
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_1:* = null;
            resize(200, 400);
            _loc_1 = new Label(this, 5, 25, "起始");
            this._startYIT = new InputText(this, 35, 25, "");
            this._startYIT._tf.restrict = "0-9";
            this._startYIT._tf.maxChars = 4;
            this._startYIT.width = 40;
            _loc_1 = new Label(this, 80, 25, "年");
            this._startMIT = new InputText(this, 100, 25, "");
            this._startMIT._tf.restrict = "0-9";
            this._startMIT._tf.maxChars = 2;
            this._startMIT.width = 30;
            _loc_1 = new Label(this, 130, 25, "月");
            this._startDIT = new InputText(this, 150, 25, "");
            this._startDIT._tf.restrict = "0-9";
            this._startDIT._tf.maxChars = 2;
            this._startDIT.width = 30;
            _loc_1 = new Label(this, 180, 25, "日");
            _loc_1 = new Label(this, 5, 50, "结束");
            this._endYIT = new InputText(this, 35, 50, "");
            this._endYIT._tf.restrict = "0-9";
            this._endYIT._tf.maxChars = 4;
            this._endYIT.width = 40;
            _loc_1 = new Label(this, 80, 50, "年");
            this._endMIT = new InputText(this, 100, 50, "");
            this._endMIT._tf.restrict = "0-9";
            this._endMIT._tf.maxChars = 2;
            this._endMIT.width = 30;
            _loc_1 = new Label(this, 130, 50, "月");
            this._endDIT = new InputText(this, 150, 50, "");
            this._endDIT._tf.restrict = "0-9";
            this._endDIT._tf.maxChars = 2;
            this._endDIT.width = 30;
            _loc_1 = new Label(this, 180, 50, "日");
            var _loc_2:* = Config.now;
            var _loc_4:* = String(_loc_2.getFullYear());
            this._endYIT.text = String(_loc_2.getFullYear());
            this._startYIT.text = _loc_4;
            var _loc_4:* = String((_loc_2.getMonth() + 1));
            this._endMIT.text = String((_loc_2.getMonth() + 1));
            this._startMIT.text = _loc_4;
            var _loc_4:* = String(_loc_2.getDate());
            this._endDIT.text = String(_loc_2.getDate());
            this._startDIT.text = _loc_4;
            this._idIT = new InputText(this, 5, 75, "");
            this._idIT._tf.restrict = "0-9";
            this._idIT.text = "";
            var _loc_3:* = new PushButton(this, 110, 75, "查询", this.handleSearch);
            _loc_3.width = 80;
            this._recordList = new List(this, 5, 100);
            this._recordList.autoHeight = false;
            this._recordList.setSize(190, 400 - 115);
            this._recordList.enableMouse = true;
            this._recordList.addEventListener("dblClick", this.handleListDblClick);
            this._playBar = new ProgressBar(this, 5, 500 - 115);
            this._playBar.setSize(190, 10);
            return;
        }// end function

        private function handleListDblClick(event:Event) : void
        {
            if (event.target == this._recordList && this._recordList.selectedItem.win != null && this._recordList.selectedItem != null)
            {
                Config.startLoop(this.delayPlay);
            }
            return;
        }// end function

        private function delayPlay(param1)
        {
            Config.stopLoop(this.delayPlay);
            if (this._preWindow != null)
            {
                this._preWindow.stopPlayOb();
            }
            this._preWindow = this._recordList.selectedItem.win;
            this._preWindow.open();
            this._preWindow.playOb(this._recordList.selectedItem.opCode);
            this._playBar.maximum = this._preWindow.getObTotalFrame();
            this._playBar.value = 0;
            Config.startLoop(this.playBarLoop);
            return;
        }// end function

        private function playBarLoop(param1)
        {
            var _loc_2:* = this._playBar;
            var _loc_3:* = this._playBar.value + 1;
            _loc_2.value = _loc_3;
            if (this._playBar.value >= this._playBar.maximum)
            {
                Config.stopLoop(this.playBarLoop);
            }
            return;
        }// end function

        private function handleSearch(event:MouseEvent) : void
        {
            if (this._idIT.text == "")
            {
                return;
            }
            var _loc_2:* = new Date();
            _loc_2.setFullYear(int(this._startYIT.text), (int(this._startMIT.text) - 1), int(this._startDIT.text));
            _loc_2.setHours(0, 0, 0, 0);
            var _loc_3:* = new Date();
            _loc_3.setFullYear(int(this._startYIT.text), (int(this._startMIT.text) - 1), (int(this._startDIT.text) + 1));
            _loc_3.setHours(0, 0, 0, 0);
            var _loc_4:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.C2B_OBSERVE_WATCH);
            _loc_4.add32(int(this._idIT.text));
            _loc_4.add32(_loc_2.getTime() / 1000);
            _loc_4.add32(_loc_3.getTime() / 1000);
            ClientSocket.send(_loc_4);
            return;
        }// end function

    }
}
