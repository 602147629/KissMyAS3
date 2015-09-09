package lovefox.gameUI
{
    import flash.utils.*;

    public class NoticeUI extends Object
    {
        public static var MAX_STACK:Object = 20;
        public static var MAX_LINE:Object = 30;
        private static var _noticeObj:Object = {};
        private static var _noticeTimerObj:Object = {};

        public function NoticeUI()
        {
            this.init();
            return;
        }// end function

        private function init()
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_GMT_NOTICE_LIST, this.handleNoticeList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_GMT_DELETE_NOTICE, this.handleDeleteNotice);
            return;
        }// end function

        private function handleNoticeList(param1)
        {
            var _loc_2:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            var _loc_16:* = undefined;
            var _loc_17:* = undefined;
            var _loc_18:* = undefined;
            var _loc_19:* = undefined;
            var _loc_20:* = undefined;
            var _loc_21:* = null;
            this.deleteAll();
            var _loc_3:* = param1.data;
            var _loc_4:* = _loc_3.readUnsignedInt();
            trace("handleNoticeList", _loc_4);
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_8 = _loc_3.readUnsignedInt();
                trace("id " + _loc_8);
                this.deleteNotice(_loc_8);
                _loc_6 = _loc_3.readUnsignedShort();
                _loc_9 = _loc_3.readUTFBytes(_loc_6);
                trace(_loc_9);
                _loc_10 = _loc_3.readUnsignedInt();
                trace(_loc_10);
                _loc_11 = _loc_3.readUnsignedInt();
                trace(_loc_11);
                _loc_6 = _loc_3.readUnsignedShort();
                _loc_12 = _loc_3.readUTFBytes(_loc_6);
                trace(_loc_12);
                _loc_13 = _loc_3.readByte();
                trace(_loc_13);
                _loc_6 = _loc_3.readUnsignedShort();
                _loc_14 = _loc_3.readUTFBytes(_loc_6);
                trace(_loc_14);
                _loc_6 = _loc_3.readUnsignedShort();
                _loc_15 = _loc_3.readUTFBytes(_loc_6);
                trace(_loc_15);
                _loc_16 = _loc_3.readUnsignedInt();
                trace(_loc_16);
                _loc_17 = _loc_3.readByte();
                trace(_loc_17);
                _loc_6 = _loc_3.readUnsignedShort();
                _loc_18 = _loc_3.readUTFBytes(_loc_6);
                trace(_loc_18);
                _noticeObj[_loc_8] = {id:_loc_8, title:_loc_9, sTime:_loc_10, eTime:_loc_11, publisher:_loc_12, state:_loc_13, content:_loc_14, picurl:_loc_15, interval:_loc_16, type:_loc_17, lastModify:_loc_18};
                if (Config.debug)
                {
                    _loc_21 = new Date(_loc_10 * 1000);
                    AlertUI.alert(String(_loc_5 + "," + _loc_8 + ":" + _loc_9), String(_loc_21), [Config.language("NoticeUI", 1)]);
                }
                if (_loc_13 == 1)
                {
                    if (_loc_16 > 0)
                    {
                        _loc_19 = Config.now.getTime();
                        if (_loc_19 > _loc_10 * 1000)
                        {
                            _loc_20 = (Config.now.getTime() - _loc_10 * 1000) % (_loc_16 * 1000);
                        }
                        else
                        {
                            _loc_20 = _loc_10 * 1000 - _loc_19;
                        }
                        clearInterval(_noticeTimerObj[_loc_8]);
                        clearTimeout(_noticeTimerObj[_loc_8]);
                        _noticeTimerObj[_loc_8] = setInterval(this.doNotice, _loc_20, _noticeObj[_loc_8], true);
                    }
                    else
                    {
                        _loc_19 = Config.now.getTime();
                        if (_loc_19 > _loc_10 * 1000)
                        {
                            this.doNotice(_noticeObj[_loc_8]);
                        }
                        else
                        {
                            _loc_20 = _loc_10 * 1000 - _loc_19;
                            clearInterval(_noticeTimerObj[_loc_8]);
                            clearTimeout(_noticeTimerObj[_loc_8]);
                            _noticeTimerObj[_loc_8] = setTimeout(this.doNotice, _loc_20, _noticeObj[_loc_8], false, true);
                        }
                    }
                }
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        private function doNotice(param1, param2 = false, param3 = false)
        {
            var _loc_4:* = undefined;
            trace("doNotice", param1.type);
            if (param1.type == 1)
            {
                Billboard.show(param1.title);
            }
            else if (param1.type == 3)
            {
                Config.ui._chatUI.showGMT(param1.content);
            }
            if (param3)
            {
                clearTimeout(_noticeTimerObj[param1.id]);
            }
            else if (param2)
            {
                clearInterval(_noticeTimerObj[param1.id]);
                _noticeTimerObj[param1.id] = setInterval(this.doNotice, param1.interval * 1000, param1);
            }
            return;
        }// end function

        private function deleteNotice(param1)
        {
            clearInterval(_noticeTimerObj[param1]);
            delete _noticeObj[param1];
            return;
        }// end function

        private function deleteAll()
        {
            var _loc_1:* = undefined;
            for (_loc_1 in _noticeObj)
            {
                
                this.deleteNotice(_loc_1);
            }
            return;
        }// end function

        private function handleDeleteNotice(param1)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_6 = _loc_2.readUnsignedInt();
                this.deleteNotice(_loc_6);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

    }
}
