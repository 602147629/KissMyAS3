package notice
{
    import cooperateCode.*;
    import flash.display.*;
    import message.*;
    import popup.*;
    import user.*;

    public class SimpleNoticeWindow extends Object
    {
        private var _parent:Sprite;
        private var _noticeInfo:SimpleNoticeInfo;
        private var _noticeType:int;
        private var _bAddLvUpNotice:Boolean;
        private var _aPopupData:Array;
        private var _index:int;
        private var _mainPopup:SimpleNoticePopup;
        private var _afterMsg:int;
        private var _aRemuneration:Array;
        private var _remunerationWindow:RemunerationNoticeWindow;
        private var _aCodeInfo:Array;
        private var _nextProcessId:int;
        private var _bEnd:Boolean;
        private var _bProcess:Boolean;
        private static const AFTER_MESSAGE_QUEST_LOGOUT:int = 1;

        public function SimpleNoticeWindow(param1:Sprite, param2:SimpleNoticeInfo, param3:Boolean, param4:Array)
        {
            this._parent = param1;
            this._noticeInfo = param2;
            this._noticeType = param2.type;
            this._bAddLvUpNotice = param3;
            this._aRemuneration = param4;
            this._remunerationWindow = null;
            this._nextProcessId = ProcessMain.PROCESS_TITLE;
            this.init();
            this._bEnd = false;
            this._bProcess = false;
            this.createNext();
            return;
        }// end function

        public function release() : void
        {
            this._aCodeInfo = null;
            if (this._remunerationWindow)
            {
                this._remunerationWindow.release();
                this._remunerationWindow = null;
            }
            this._aRemuneration = null;
            this._noticeInfo = null;
            this._parent = null;
            return;
        }// end function

        public function bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function get noticeUniqueId() : int
        {
            return this._noticeInfo.uniqueId;
        }// end function

        public function get noticeType() : int
        {
            return this._noticeType;
        }// end function

        public function get nextProcessId() : int
        {
            return this._nextProcessId;
        }// end function

        public function get bProcess() : Boolean
        {
            return this._bProcess;
        }// end function

        private function init() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            this._aPopupData = [];
            this._index = 0;
            this._mainPopup = null;
            this._afterMsg = 0;
            this._aCodeInfo = null;
            if (this._noticeType == CommonConstant.NOTICE_QUEST_LOGOUT)
            {
                this.addMessage(MessageManager.getInstance().getMessage(MessageId.NOTICE_TITLE_QUEST_LOGOUT), MessageManager.getInstance().getMessage(MessageId.NOTICE_QUEST_LOGOUT));
                this._afterMsg = AFTER_MESSAGE_QUEST_LOGOUT;
            }
            if (this._noticeType == CommonConstant.NOTICE_LV_UP)
            {
                this.addMessage(MessageManager.getInstance().getMessage(MessageId.NOTICE_TITLE_LV_UP), MessageManager.getInstance().getMessage(MessageId.NOTICE_LV_UP));
            }
            if (this._noticeType == CommonConstant.NOTICE_LV_UP_FACILITY)
            {
                this.addLvUpMessage();
                this.addMessage(MessageManager.getInstance().getMessage(MessageId.NOTICE_TITLE_LV_UP), MessageManager.getInstance().getMessage(MessageId.NOTICE_LV_UP_FACILITY));
            }
            if (this._noticeType == CommonConstant.NOTICE_LV_UP_FORMATION)
            {
                this.addLvUpMessage();
                this.addMessage(MessageManager.getInstance().getMessage(MessageId.NOTICE_TITLE_LV_UP), MessageManager.getInstance().getMessage(MessageId.NOTICE_LV_UP_FORMATION));
            }
            if (this._noticeType == CommonConstant.NOTICE_LV_UP_COMMANDER)
            {
                this.addLvUpMessage();
                this.addMessage(MessageManager.getInstance().getMessage(MessageId.NOTICE_TITLE_LV_UP), MessageManager.getInstance().getMessage(MessageId.NOTICE_LV_UP_COMMANDER));
            }
            if (this._noticeType == CommonConstant.NOTICE_LV_UP_REMUNERATION)
            {
                this.addLvUpMessage();
                this.addMessage(MessageManager.getInstance().getMessage(MessageId.NOTICE_TITLE_LV_UP), MessageManager.getInstance().getMessage(MessageId.NOTICE_LV_UP_REMUNERATION));
            }
            if (this._noticeType == CommonConstant.NOTICE_FACILITY_BARRACKS)
            {
                this.addMessage(MessageManager.getInstance().getMessage(MessageId.NOTICE_TITLE_BARRACKS), MessageManager.getInstance().getMessage(MessageId.NOTICE_FACILITY_BARRACKS));
            }
            if (this._noticeType == CommonConstant.NOTICE_FACILITY_TRAINING_TRAINING)
            {
                this.addMessage(MessageManager.getInstance().getMessage(MessageId.NOTICE_TITLE_TRANING), MessageManager.getInstance().getMessage(MessageId.NOTICE_FACILITY_TRANING), MessageManager.getInstance().getMessage(MessageId.FACILITY_TRANING));
                this._nextProcessId = ProcessMain.PROCESS_TRAINING_ROOM;
            }
            if (this._noticeType == CommonConstant.NOTICE_FACILITY_TRAINING_KUMITE)
            {
                this.addMessage(MessageManager.getInstance().getMessage(MessageId.NOTICE_TITLE_TRANING_SKILL), MessageManager.getInstance().getMessage(MessageId.NOTICE_FACILITY_TRANING_SKILL), MessageManager.getInstance().getMessage(MessageId.FACILITY_TRANING));
                this._nextProcessId = ProcessMain.PROCESS_TRAINING_ROOM;
            }
            if (this._noticeType == CommonConstant.NOTICE_FACILITY_MAGIC_DEVELOP)
            {
                this.addMessage(MessageManager.getInstance().getMessage(MessageId.NOTICE_TITLE_MAGIC_DEVELOP), MessageManager.getInstance().getMessage(MessageId.NOTICE_FACILITY_MAGIC_DEVELOP), MessageManager.getInstance().getMessage(MessageId.FACILITY_MAGIC_DEVELOP));
                this._nextProcessId = ProcessMain.PROCESS_MAGIC_DEVELOP;
            }
            if (this._noticeType == CommonConstant.NOTICE_FACILITY_MAGIC_DEVELOP_DEVELOP)
            {
                this.addMessage(MessageManager.getInstance().getMessage(MessageId.NOTICE_TITLE_MAGIC_DEVELOP_DEVELOP), MessageManager.getInstance().getMessage(MessageId.NOTICE_FACILITY_MAGIC_DEVELOP_DEVELOP), MessageManager.getInstance().getMessage(MessageId.FACILITY_MAGIC_DEVELOP));
                this._nextProcessId = ProcessMain.PROCESS_MAGIC_DEVELOP;
            }
            if (this._noticeType == CommonConstant.NOTICE_PAYMENT_EVENT)
            {
                this.addMessage(MessageManager.getInstance().getMessage(MessageId.NOTICE_TITLE_PAYMENT_EVENT), MessageManager.getInstance().getMessage(MessageId.NOTICE_PAYMENT_EVENT_MESSAGE_01));
            }
            if (this._noticeType == CommonConstant.NOTICE_COOPERATE_SERIAL)
            {
                _loc_1 = new CooperateCodeInformation();
                _loc_1.setData(0, this._noticeInfo.commonNum, this._noticeInfo.epochTime, this._noticeInfo.commonString);
                this._aCodeInfo = [_loc_1];
            }
            if (this._noticeType == CommonConstant.NOTICE_CYCLE_CHANGE)
            {
                _loc_2 = MessageManager.getInstance().getMessage(MessageId.NOTICE_CYCLE_CHANGE);
                _loc_3 = UserDataManager.getInstance().userData.cycle - 1;
                this.addMessage(MessageManager.getInstance().getMessage(MessageId.NOTICE_TITLE_CYCLE_CHANGE), _loc_2.replace("%d", _loc_3));
            }
            if (this._noticeType == NoticeConstant.NOTICE_TYPE_MAINTENANCE)
            {
                this.addMessage("", MessageManager.getInstance().getMessage(MessageId.NOTICE_MAINTENANCE));
            }
            if (this._noticeType == NoticeConstant.NOTICE_TYPE_MULTIPLEX_LOGIN)
            {
                this.addMessage("", MessageManager.getInstance().getMessage(MessageId.NOTICE_MULTIPLEX_LOGIN));
            }
            return;
        }// end function

        private function addMessage(param1:String, param2:String, param3:String = "") : void
        {
            this._aPopupData.push(new SimpleNoticePopupData(param1, param2, param3));
            return;
        }// end function

        private function addLvUpMessage() : void
        {
            if (this._bAddLvUpNotice)
            {
                this.addMessage(MessageManager.getInstance().getMessage(MessageId.NOTICE_TITLE_LV_UP), MessageManager.getInstance().getMessage(MessageId.NOTICE_LV_UP));
                this._bAddLvUpNotice = false;
            }
            return;
        }// end function

        private function createNext() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._index < this._aPopupData.length)
            {
                this.createMainPopup();
            }
            else if (this._afterMsg == AFTER_MESSAGE_QUEST_LOGOUT)
            {
                this._afterMsg = 0;
                _loc_1 = MessageManager.getInstance().getMessage(MessageId.NOTICE_QUEST_LOGOUT2);
                _loc_2 = MessageManager.getInstance().getMessage(MessageId.NOTICE_QUEST_LOGOUT2_LIST);
                CommonPopup.getInstance().openNoticePopup(CommonPopup.POPUP_TYPE_NORMAL, _loc_1, _loc_2, this.cbEnd, MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_CONFIRM), true);
            }
            else if (this._aRemuneration && this._aRemuneration.length > 0)
            {
                _loc_3 = this._aRemuneration;
                this._aRemuneration = null;
                this._remunerationWindow = new RemunerationNoticeWindow(this._noticeType, _loc_3, this.cbEnd);
            }
            else if (this._aCodeInfo && this._aCodeInfo.length > 0)
            {
                _loc_4 = this._aCodeInfo;
                this._aCodeInfo = null;
                _loc_5 = MessageManager.getInstance().getMessage(MessageId.BENEFIT_INFORMATION_TITLE);
                CommonPopup.getInstance().openCooperateCodePopup(CommonPopup.POPUP_TYPE_NAVI, _loc_5, _loc_4, this.cbEnd);
            }
            else
            {
                this._bEnd = true;
            }
            return;
        }// end function

        private function createMainPopup() : void
        {
            if (this._mainPopup)
            {
                this._mainPopup.release();
            }
            this._mainPopup = null;
            var _loc_1:* = this._aPopupData[this._index];
            var _loc_2:* = this;
            var _loc_3:* = this._index + 1;
            _loc_2._index = _loc_3;
            this._mainPopup = new SimpleNoticePopup(this._parent, this._noticeType, _loc_1, this.cbMainPopClose);
            return;
        }// end function

        private function cbMainPopClose() : void
        {
            if (this._mainPopup.bProcess)
            {
                this._bEnd = true;
                this._bProcess = true;
            }
            else
            {
                this.cbEnd();
            }
            return;
        }// end function

        private function cbEnd() : void
        {
            this.createNext();
            return;
        }// end function

    }
}

import cooperateCode.*;

import flash.display.*;

import message.*;

import popup.*;

import user.*;

class SimpleNoticePopup extends Object
{
    private var _baseMc:MovieClip;
    private var _isoMain:InStayOut;
    private var _noticeType:int;
    private var _cbClose:Function;
    private var _processBtn:ButtonBase;
    private var _closeBtn:ButtonBase;
    private var _bEnd:Boolean;
    private var _bProcess:Boolean;

    function SimpleNoticePopup(param1:Sprite, param2:int, param3:SimpleNoticePopupData, param4:Function)
    {
        this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Home.swf", "InfoPopup");
        this._isoMain = new InStayOut(this._baseMc);
        this._noticeType = param2;
        this._cbClose = param4;
        this.createWindow(param3);
        this._bEnd = false;
        this._bProcess = false;
        param1.addChild(this._baseMc);
        this._isoMain.setIn();
        return;
    }// end function

    public function get noticeType() : int
    {
        return this._noticeType;
    }// end function

    public function get bProcess() : Boolean
    {
        return this._bProcess;
    }// end function

    public function release() : void
    {
        if (this._closeBtn)
        {
            ButtonManager.getInstance().removeButton(this._closeBtn);
            this._closeBtn.release();
        }
        this._closeBtn = null;
        if (this._processBtn)
        {
            ButtonManager.getInstance().removeButton(this._processBtn);
            this._processBtn.release();
        }
        this._processBtn = null;
        if (this._isoMain)
        {
            this._isoMain.release();
        }
        this._isoMain = null;
        if (this._baseMc)
        {
            this._baseMc.parent.removeChild(this._baseMc);
        }
        this._baseMc = null;
        this._cbClose = null;
        return;
    }// end function

    private function createWindow(param1:SimpleNoticePopupData) : void
    {
        var _loc_2:* = param1 ? (param1.title) : ("");
        var _loc_3:* = param1 ? (param1.message) : ("");
        var _loc_4:* = param1 ? (param1.processMsg) : ("");
        this._closeBtn = ButtonManager.getInstance().addButton(this._baseMc.closeBtnMc, this.cbCloseButton);
        this._closeBtn.enterSeId = ButtonBase.SE_CANCEL_ID;
        TextControl.setIdText(this._closeBtn.getMoveClip().textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
        this._baseMc.infoPopupBGMc.gotoAndStop("endReport");
        this._baseMc.infoPopupNaviCharaMc.gotoAndStop("endReport");
        if (this._noticeType == NoticeConstant.NOTICE_TYPE_MAINTENANCE || this._noticeType == NoticeConstant.NOTICE_TYPE_MULTIPLEX_LOGIN)
        {
            this._baseMc.infoPopupBGMc.gotoAndStop("otherReport");
            this._baseMc.infoPopupNaviCharaMc.gotoAndStop("otherReport");
            this._closeBtn.setDisableFlag(true);
            this._closeBtn.getMoveClip().visible = false;
        }
        var _loc_5:* = ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH);
        if (ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH) != null)
        {
            this._baseMc.infoPopupNaviCharaMc.naviCharaNull.addChild(_loc_5);
            _loc_5.x = _loc_5.x - _loc_5.width / 2;
            _loc_5.y = _loc_5.y - _loc_5.height;
        }
        else
        {
            DebugLog.print("ナビキャラクターの設定に失敗");
        }
        TextControl.setText(this._baseMc.infoPopupBGMc.infoTitleMc.textDt, _loc_2);
        TextControl.setText(this._baseMc.infoPopupNaviCharaMc.infoBalloonTextMc.textDt, _loc_3);
        if (_loc_4 != "")
        {
            this._processBtn = ButtonManager.getInstance().addButton(this._baseMc.infoPopupNaviCharaMc.transitionBtnMc, this.cbProcessButton);
            this._processBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setText(this._processBtn.getMoveClip().textMc.textDt, _loc_4);
        }
        else
        {
            this._baseMc.infoPopupNaviCharaMc.transitionBtnMc.visible = false;
        }
        return;
    }// end function

    private function disableButton(param1:Boolean) : void
    {
        if (this._processBtn)
        {
            this._processBtn.setDisableFlag(param1);
        }
        if (this._closeBtn)
        {
            this._closeBtn.setDisableFlag(param1);
        }
        return;
    }// end function

    private function cbProcessButton(param1:int) : void
    {
        if (this._bEnd)
        {
            return;
        }
        if (this._isoMain.bOpened)
        {
            this._bEnd = true;
            this._bProcess = true;
            this.disableButton(true);
            this._isoMain.setOut(this.cbOut);
        }
        return;
    }// end function

    private function cbCloseButton(param1:int) : void
    {
        if (this._bEnd)
        {
            return;
        }
        if (this._isoMain.bOpened)
        {
            this._bEnd = true;
            this.disableButton(true);
            this._isoMain.setOut(this.cbOut);
        }
        return;
    }// end function

    private function cbOut() : void
    {
        if (this._cbClose != null)
        {
            this._cbClose();
        }
        this.release();
        return;
    }// end function

}


import cooperateCode.*;

import flash.display.*;

import message.*;

import popup.*;

import user.*;

class SimpleNoticePopupData extends Object
{
    private var _title:String;
    private var _message:String;
    private var _processMsg:String;

    function SimpleNoticePopupData(param1:String, param2:String, param3:String = "")
    {
        this._title = param1;
        this._message = param2;
        this._processMsg = param3;
        return;
    }// end function

    public function get title() : String
    {
        return this._title;
    }// end function

    public function get message() : String
    {
        return this._message;
    }// end function

    public function get processMsg() : String
    {
        return this._processMsg;
    }// end function

}

