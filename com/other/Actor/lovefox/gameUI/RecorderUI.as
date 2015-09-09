package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;

    public class RecorderUI extends Sprite
    {
        private var _container:DisplayObjectContainer;
        private var _ssPB:PushButton;
        private var _listCB:ComboBox;
        private var _moreCB:ComboBox;
        private var _moreBardPanel:KitBardWindow;
        private var _moreDayPanel:KitReplayWindow;
        private var _morePkPanel:KitReplayWindow;
        private var _infoTxt:TextField;
        private var _preOpenTime:Object;
        private var _timeleftTimer:Object;
        private var _recording:Boolean = false;

        public function RecorderUI(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            x = param2;
            y = param3;
            this._container = param1;
            this._container.addChild(this);
            this.init();
            return;
        }// end function

        private function handleListOpen(param1)
        {
            this._listCB.itemArray = [];
            var _loc_2:* = new URLVariables();
            _loc_2.name = Player.name;
            _loc_2.server = Config.serverName;
            var _loc_3:* = new URLRequest(Config.replayURL + "replay_list.php");
            _loc_3.data = _loc_2;
            _loc_3.method = URLRequestMethod.POST;
            var _loc_4:* = new URLLoader();
            new URLLoader().addEventListener(Event.COMPLETE, this.handleListRcv);
            _loc_4.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleListError);
            _loc_4.addEventListener(IOErrorEvent.IO_ERROR, this.handleListError);
            _loc_4.load(_loc_3);
            return;
        }// end function

        private function handleListRcv(param1)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_2:* = URLLoader(param1.target);
            _loc_2.removeEventListener(Event.COMPLETE, this.handleListRcv);
            _loc_2.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleListError);
            _loc_2.removeEventListener(IOErrorEvent.IO_ERROR, this.handleListError);
            var _loc_3:* = XML(_loc_2.data);
            if (_loc_3.hasOwnProperty("list") && _loc_3.list.length() > 0)
            {
                _loc_6 = [];
                _loc_5 = 0;
                while (_loc_5 < _loc_3.list.length())
                {
                    
                    _loc_4 = _loc_3.list[_loc_5];
                    _loc_6.push({label:String(_loc_4.title), data:_loc_4});
                    _loc_5 = _loc_5 + 1;
                }
                this._listCB.itemArray = _loc_6;
            }
            else
            {
                AlertUI.alert(Config.language("RecorderUI", 1), "", [Config.language("RecorderUI", 2)]);
            }
            return;
        }// end function

        private function handleListError(param1)
        {
            var _loc_2:* = URLLoader(param1.target);
            _loc_2.removeEventListener(Event.COMPLETE, this.handleListRcv);
            _loc_2.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.handleListError);
            _loc_2.removeEventListener(IOErrorEvent.IO_ERROR, this.handleListError);
            AlertUI.alert(Config.language("RecorderUI", 3), "", [Config.language("RecorderUI", 2)]);
            return;
        }// end function

        private function handleListSelect(param1)
        {
            var _loc_2:* = this._listCB.selectedItem.data;
            AlertUI.alert(String(_loc_2.title), Config.language("RecorderUI", 4), [Config.language("RecorderUI", 5), Config.language("RecorderUI", 6), Config.language("RecorderUI", 7)], [this.openReplay, this.removeReplay, null], this._listCB.selectedItem.data);
            return;
        }// end function

        private function openReplay(param1)
        {
            var _loc_2:* = param1;
            var _loc_3:* = new URLRequest(String(_loc_2.url));
            navigateToURL(_loc_3, "_blank");
            return;
        }// end function

        private function removeReplay(param1)
        {
            var _loc_2:* = param1;
            var _loc_3:* = new URLVariables();
            _loc_3.id = Number(_loc_2.id);
            trace("urlVar.id", _loc_3.id);
            var _loc_4:* = new URLRequest(Config.replayURL + "replay_remove.php");
            new URLRequest(Config.replayURL + "replay_remove.php").data = _loc_3;
            _loc_4.method = URLRequestMethod.POST;
            var _loc_5:* = new URLLoader();
            new URLLoader().addEventListener(Event.COMPLETE, this.handleRemoveRcv);
            _loc_5.addEventListener(IOErrorEvent.IO_ERROR, this.handleRemoveError);
            _loc_5.load(_loc_4);
            return;
        }// end function

        private function handleRemoveRcv(param1)
        {
            var _loc_2:* = URLLoader(param1.target);
            trace("handleRemoveRcv", _loc_2.data);
            if (String(_loc_2.data) == "true")
            {
                AlertUI.alert(Config.language("RecorderUI", 8), "", [Config.language("RecorderUI", 2)]);
            }
            else
            {
                AlertUI.alert(Config.language("RecorderUI", 9), "", [Config.language("RecorderUI", 2)]);
            }
            return;
        }// end function

        private function handleRemoveError(param1)
        {
            AlertUI.alert(Config.language("RecorderUI", 9), "", [Config.language("RecorderUI", 2)]);
            return;
        }// end function

        private function handleMoreSelect(param1)
        {
            if (this._moreCB.selectedItem.data == 0)
            {
                Config.ui._cardUI.open();
            }
            return;
        }// end function

        private function handleMoreOpen(param1)
        {
            this._moreCB.addChild(this._moreBardPanel);
            this._moreCB.addChild(this._moreDayPanel);
            this._moreCB.addChild(this._morePkPanel);
            this._moreBardPanel.reload();
            this._moreDayPanel.reload();
            this._morePkPanel.reload();
            return;
        }// end function

        private function handleMoreClose(param1)
        {
            this._moreDayPanel.close();
            this._morePkPanel.close();
            this._moreBardPanel.close();
            return;
        }// end function

        private function init()
        {
            this._ssPB = new PushButton(this, 0, 0, "●", this.handleSS);
            this._ssPB.textColor = Style.GOLD_FONT;
            this._ssPB.setTable("table18", "table31");
            this._ssPB.width = 24;
            this._ssPB.height = 20;
            this.setTip(this._ssPB, Config.language("RecorderUI", 10));
            this._listCB = new ComboBox(this, 32 - 100 + 24, 0, this.handleListSelect);
            this._listCB.editable = false;
            this._listCB.orientation = ComboBox.DOWN;
            this._listCB.showValue = false;
            this._listCB.list.overshow = true;
            this._listCB.label = "list";
            this._listCB.button.width = 32;
            this._listCB.button.x = 68;
            this._listCB.addEventListener(Event.OPEN, this.handleListOpen);
            this.setTip(this._listCB.button, Config.language("RecorderUI", 11), 2);
            this._moreCB = new ComboBox(this, 24 - 120 + 56, 0, this.handleMoreSelect);
            this._moreCB.editable = false;
            this._moreCB.orientation = ComboBox.DOWN;
            this._moreCB.showValue = false;
            this._moreCB.list.overshow = true;
            this._moreCB.label = "SP";
            this._moreCB.width = 120;
            this._moreCB.button.width = 24;
            this._moreCB.button.x = 120 - 24;
            this._moreCB.itemArray = [{label:Config.language("RecorderUI", 22), data:0}];
            this._moreCB.addEventListener(Event.OPEN, this.handleMoreOpen);
            this._moreCB.addEventListener(Event.CLOSE, this.handleMoreClose);
            this.setTip(this._moreCB.button, Config.language("RecorderUI", 23), 2);
            this._infoTxt = Config.getSimpleTextField();
            this._infoTxt.textColor = 16777215;
            this._infoTxt.y = 0;
            this._infoTxt.x = 70;
            this._infoTxt.filters = [new GlowFilter(0, 1, 3, 3, 10)];
            addChild(this._infoTxt);
            this._moreBardPanel = new KitBardWindow(null, 0, 40);
            this._moreDayPanel = new KitReplayWindow("replay_day_hot.php", Config.language("RecorderUI", 24), null, 0, 120);
            this._morePkPanel = new KitReplayWindow("replay_pk_hot.php", Config.language("RecorderUI", 25), null, 0, 230);
            return;
        }// end function

        private function setTip(param1, param2, param3 = 0)
        {
            param1.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.handleSlotOver, param2, param1, param3));
            param1.addEventListener(MouseEvent.ROLL_OUT, Config.create(this.handleSlotOut));
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleSlotOver(param1, param2, param3, param4 = 0)
        {
            Holder.showInfo(param2, new Rectangle(param3.x + param3.parent.x + param3.parent.parent.x + param3.parent.parent.parent.x, param3.y + param3.parent.y + param3.parent.parent.y + param3.parent.parent.parent.y, param3.width, param3.height), false, param4);
            return;
        }// end function

        public function start()
        {
            if (!this._recording)
            {
                this._recording = true;
                Recorder.start(0);
                this._preOpenTime = getTimer();
                clearInterval(this._timeleftTimer);
                this._timeleftTimer = setInterval(this.timeLeftLoop, 1000);
            }
            this._ssPB.label = "■";
            this._ssPB.textColor = 16724787;
            return;
        }// end function

        private function timeLeftLoop()
        {
            var _loc_1:* = Math.floor((1000 * 60 * 30 - (getTimer() - this._preOpenTime)) / 1000);
            var _loc_2:* = String(Math.floor(_loc_1 / 60));
            while (_loc_2.length < 2)
            {
                
                _loc_2 = "0" + _loc_2;
            }
            var _loc_3:* = String(_loc_1 % 60);
            while (_loc_3.length < 2)
            {
                
                _loc_3 = "0" + _loc_3;
            }
            this._infoTxt.text = _loc_2 + ":" + _loc_3;
            this._infoTxt.x = -this._infoTxt.width - 2;
            if (_loc_1 <= 0)
            {
                this.stop();
            }
            return;
        }// end function

        public function stop()
        {
            var _loc_1:* = undefined;
            clearInterval(this._timeleftTimer);
            this._infoTxt.text = "";
            if (this._recording)
            {
                this._recording = false;
                _loc_1 = Recorder.stop(0);
                AlertUI.alert(Config.language("RecorderUI", 12), Config.language("RecorderUI", 13), [Config.language("RecorderUI", 14), Config.language("RecorderUI", 7)], [this.upload, null], _loc_1, true);
            }
            this._ssPB.label = "●";
            this._ssPB.textColor = Style.GOLD_FONT;
            return;
        }// end function

        private function upload(param1, param2)
        {
            if (!FilterWords.chickwords(param2))
            {
                AlertUI.alert(Config.language("RecorderUI", 15), Config.language("RecorderUI", 16), [Config.language("RecorderUI", 14), Config.language("RecorderUI", 7)], [this.upload, null], param1, true);
                return;
            }
            if (param2 == "")
            {
                param2 = Config.language("RecorderUI", 17);
            }
            var _loc_3:* = new URLRequest(Config.replayURL + "replay_upload.php?name=" + encodeURI(Player.name) + "&title=" + encodeURI(param2) + "&seconds=" + Math.floor(Recorder.getFrame(0) / 30) + "&score=" + Recorder.getScore(0) + "&account=" + Config.account + "&server=" + encodeURI(Config.serverName) + "&type=0");
            _loc_3.data = param1;
            _loc_3.method = URLRequestMethod.POST;
            _loc_3.contentType = "application/octet-stream";
            var _loc_4:* = new URLLoader();
            new URLLoader().addEventListener(Event.COMPLETE, this.completeHandler);
            _loc_4.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
            _loc_4.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.errorHandler);
            _loc_4.load(_loc_3);
            return;
        }// end function

        private function completeHandler(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_2 = URLLoader(event.target);
            if (String(_loc_2.data) == "false")
            {
                AlertUI.alert(Config.language("RecorderUI", 18), String(_loc_2.data), [Config.language("RecorderUI", 2)]);
            }
            else
            {
                _loc_3 = XML(_loc_2.data);
                AlertUI.alert(String(_loc_3.title), Config.language("RecorderUI", 19) + "<u><font color=\'0x0099ff\'><a href=\'" + String(_loc_3.url) + "\' target=\'_blank\'>" + Config.language("RecorderUI", 20) + "</a></font></u>", [Config.language("RecorderUI", 5), Config.language("RecorderUI", 2)], [this.openReplay, this.closeAlert], _loc_3, false, false);
                _loc_4 = Recorder.getCover(0);
                _loc_5 = new URLRequest(Config.replayURL + "replay_upload_thumb.php?id=" + Number(_loc_3.id));
                _loc_5.data = _loc_4;
                _loc_5.method = URLRequestMethod.POST;
                _loc_5.contentType = "application/octet-stream";
                _loc_2 = new URLLoader();
                _loc_2.addEventListener(Event.COMPLETE, this.completeHandlerThumb);
                _loc_2.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandlerThumb);
                _loc_2.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.errorHandlerThumb);
                _loc_2.load(_loc_5);
            }
            Recorder.clearCover(0);
            return;
        }// end function

        private function completeHandlerThumb(param1)
        {
            trace("completeHandlerThumb");
            return;
        }// end function

        private function errorHandlerThumb(param1)
        {
            trace("errorHandlerThumb");
            return;
        }// end function

        private function closeAlert(param1)
        {
            AlertUI.close();
            return;
        }// end function

        private function errorHandler(param1) : void
        {
            trace("上传失败1");
            AlertUI.alert(Config.language("RecorderUI", 18), Config.language("RecorderUI", 21), [Config.language("RecorderUI", 2)]);
            return;
        }// end function

        private function handleSS(param1)
        {
            if (this._recording)
            {
                this.stop();
            }
            else
            {
                this.start();
            }
            return;
        }// end function

    }
}
