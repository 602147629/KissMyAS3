package magicLaboratory
{
    import asset.*;
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import home.*;
    import message.*;
    import player.*;
    import popup.*;
    import resource.*;
    import skill.*;
    import status.*;
    import user.*;
    import utility.*;

    public class MLearnSkillSelect extends Object
    {
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_WAIT:int = 10;
        private const _PHASE_CLOSE:int = 99;
        private var _rootMc:MovieClip;
        private var _baseMc:MovieClip;
        private var _isoBase:InStayOut;
        private var _aButton:Array;
        private var _btnPage:PageButton;
        private var _fade:Fade;
        private var _skillSimpleStatus:SkillSimpleStatus;
        private var _overSkillId:int;
        private var _checkStatus:MLearnCheckStatus;
        private var _phase:int;
        private var _pageNo:int;
        private var _aItemButton:Array;
        private var _selectSkillId:int;
        private var _aSkillId:Array;
        private var _playerId:int;
        private var _selectedData:MagicLearningData;

        public function MLearnSkillSelect(param1:DisplayObjectContainer, param2:MagicLearningData)
        {
            this._selectedData = param2;
            this._selectSkillId = param2.skillId;
            this._aSkillId = MagicLearnUtility.getLearnableSkillId(param2.uniqueId);
            this._pageNo = 0;
            this._rootMc = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_MagicLaboratory.swf", "MagicListPopupMc");
            this._baseMc = this._rootMc.listPopupMc;
            this._isoBase = new InStayOut(this._baseMc);
            this._aButton = [];
            var _loc_3:* = ButtonManager.getInstance().addButton(this._baseMc.closeBtnMc, this.cbClose);
            _loc_3.enterSeId = ButtonBase.SE_CANCEL_ID;
            this._aButton.push(_loc_3);
            TextControl.setIdText(this._baseMc.closeBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            TextControl.setIdText(this._baseMc.listMc.titleMc.textDt, MessageId.MAGIC_LEARN_CAPTION_MESSAGE_TITLE);
            this.createItemButton();
            this._btnPage = new PageButton(this._baseMc.listMc.pageBtnSetGuidMc, this.cbChangePage, 0, Math.ceil(this._aSkillId.length / this._aItemButton.length));
            this.setPage(0);
            this._fade = new Fade(param1);
            this._fade.maxAlpha = 0.5;
            this._fade.setFadeIn(0);
            this._skillSimpleStatus = new SkillSimpleStatus(this._rootMc);
            this._skillSimpleStatus.hide();
            this._overSkillId = Constant.EMPTY_ID;
            this._checkStatus = null;
            param1.addChild(this._rootMc);
            return;
        }// end function

        public function get selectSkillId() : int
        {
            return this._selectSkillId;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoBase.bClosed;
        }// end function

        private function createItemButton() : void
        {
            var _loc_3:* = null;
            this._aItemButton = [];
            var _loc_1:* = [{base:this._baseMc.listMc.listBtn1Mc, select:this._baseMc.listMc.listBtn1Select}, {base:this._baseMc.listMc.listBtn2Mc, select:this._baseMc.listMc.listBtn2Select}, {base:this._baseMc.listMc.listBtn3Mc, select:this._baseMc.listMc.listBtn3Select}, {base:this._baseMc.listMc.listBtn4Mc, select:this._baseMc.listMc.listBtn4Select}, {base:this._baseMc.listMc.listBtn5Mc, select:this._baseMc.listMc.listBtn5Select}, {base:this._baseMc.listMc.listBtn6Mc, select:this._baseMc.listMc.listBtn6Select}, {base:this._baseMc.listMc.listBtn7Mc, select:this._baseMc.listMc.listBtn7Select}, {base:this._baseMc.listMc.listBtn8Mc, select:this._baseMc.listMc.listBtn8Select}];
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_3 = new MLearnSkillSelectButton(_loc_1[_loc_2].base, _loc_1[_loc_2].select, this.cbSelectSkill);
                _loc_3.setDisable(true);
                this._aItemButton.push(_loc_3);
                _loc_2++;
            }
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._checkStatus)
            {
                this._checkStatus.release();
            }
            this._checkStatus = null;
            if (this._skillSimpleStatus)
            {
                this._skillSimpleStatus.release();
            }
            this._skillSimpleStatus = null;
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            if (this._btnPage != null)
            {
                this._btnPage.release();
            }
            this._btnPage = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aButton = [];
            for each (_loc_2 in this._aItemButton)
            {
                
                _loc_2.release();
            }
            this._aItemButton = [];
            if (this._rootMc.parent)
            {
                this._rootMc.parent.removeChild(this._rootMc);
            }
            this._rootMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_WAIT:
                {
                    this.controlWait();
                    break;
                }
                case this._PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._fade)
            {
                this._fade.control(param1);
            }
            if (this._checkStatus)
            {
                this._checkStatus.control(param1);
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_WAIT:
                    {
                        this.phaseWait();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function openList() : void
        {
            if (this._isoBase.bClosed)
            {
                this.setPhase(this._PHASE_OPEN);
            }
            return;
        }// end function

        public function closeList() : void
        {
            if (this._isoBase.bOpened)
            {
                this.setPhase(this._PHASE_CLOSE);
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            var _loc_2:* = null;
            this._fade.setFadeOut(Constant.FADE_OUT_TIME);
            this._isoBase.setIn();
            var _loc_1:* = 0;
            while (_loc_1 < this._aItemButton.length)
            {
                
                _loc_2 = this._aItemButton[_loc_1];
                _loc_2.setDisable(false);
                _loc_1++;
            }
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoBase.bOpened)
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseWait() : void
        {
            return;
        }// end function

        private function controlWait() : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_1:* = null;
            var _loc_2:* = Constant.EMPTY_ID;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < this._aItemButton.length)
            {
                
                _loc_1 = this._aItemButton[_loc_4];
                if (_loc_1.checkMouseOn())
                {
                    _loc_2 = _loc_1.skillId;
                    _loc_3 = _loc_4;
                    break;
                }
                _loc_4++;
            }
            if (this._overSkillId != _loc_2)
            {
                this._overSkillId = _loc_2;
                if (this._overSkillId != Constant.EMPTY_ID)
                {
                    this._skillSimpleStatus.setSkillData(this._overSkillId);
                    _loc_5 = new Point(this._baseMc.listMc.BalloonAmbitNull.x, this._baseMc.listMc.BalloonAmbitNull.y);
                    _loc_5 = this._baseMc.listMc.localToGlobal(_loc_5);
                    this._baseMc.listMc.localToGlobal(_loc_5).y = _loc_5.y + this.getBalloonOffset(_loc_3);
                    this._skillSimpleStatus.setPosition(_loc_5);
                    _loc_6 = new Point(_loc_1.baseMc.BalloonNull.x, _loc_1.baseMc.BalloonNull.y);
                    _loc_6 = _loc_1.baseMc.localToGlobal(_loc_6);
                    this._skillSimpleStatus.setArrowTargetPosition(_loc_6);
                    this._skillSimpleStatus.show();
                }
                else if (this._skillSimpleStatus.isShow())
                {
                    this._skillSimpleStatus.hide();
                }
            }
            return;
        }// end function

        private function getBalloonOffset(param1:int) : int
        {
            var _loc_2:* = this._aItemButton[0];
            var _loc_3:* = this._aItemButton[param1];
            if (_loc_2 && _loc_3)
            {
                return _loc_3.baseMc.y - _loc_2.baseMc.y;
            }
            return 0;
        }// end function

        private function phaseClose() : void
        {
            var _loc_1:* = null;
            this._fade.setFadeIn(Constant.FADE_IN_TIME);
            this._isoBase.setOut();
            for each (_loc_1 in this._aItemButton)
            {
                
                _loc_1.setDisable(true);
            }
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function cbClose(param1:int) : void
        {
            this.setPhase(this._PHASE_CLOSE);
            return;
        }// end function

        private function cbSelectSkill(param1:int) : void
        {
            var skillId:* = param1;
            this.setButtonEnable(false);
            var skillInfo:* = SkillManager.getInstance().getSkillInformation(skillId);
            var resourceNum:* = MagicLearnUtility.getLearnResourceNum(skillInfo);
            if (UserDataManager.getInstance().userData.magicResource < resourceNum)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, AssetListManager.getInstance().getAssetLackMessage(AssetId.ASSET_MAGIC_DEVELOP), function () : void
            {
                setButtonEnable(true);
                return;
            }// end function
            );
                return;
            }
            var totalSecond:* = MagicLearnUtility.getLearnSecond(skillInfo);
            var sec:* = totalSecond % 60;
            var min:* = totalSecond / 60 % 60;
            var hour:* = totalSecond / 60 / 60;
            var facilityInfo:* = UserDataManager.getInstance().userData.getInstitutionInfo(CommonConstant.FACILITY_ID_MAGIC_DEVELOP);
            var pPersonal:* = UserDataManager.getInstance().userData.getPlayerPersonal(this._selectedData.uniqueId);
            var pInfo:* = PlayerManager.getInstance().getPlayerInformation(pPersonal.playerId);
            CommonPopup.getInstance().openConsumePopup(CommonPopup.POPUP_TYPE_NAVI, AssetId.ASSET_MAGIC_DEVELOP, TextControl.formatIdText(MessageId.MAGIC_LEARN_POPUP_MESSAGE_CONFIRM, pInfo.name, skillInfo.name, resourceNum, hour < 10 ? ("0" + hour.toString()) : (hour), min < 10 ? ("0" + min.toString()) : (min), sec < 10 ? ("0" + sec.toString()) : (sec)), function (param1:Boolean) : void
            {
                if (_checkStatus)
                {
                    _checkStatus.close();
                }
                if (param1)
                {
                    _selectSkillId = skillId;
                    closeList();
                }
                else
                {
                    setButtonEnable(true);
                }
                return;
            }// end function
            );
            if (this._checkStatus)
            {
                this._checkStatus.release();
            }
            this._checkStatus = new MLearnCheckStatus(Main.GetProcess());
            this._checkStatus.setData(pPersonal, skillId, totalSecond, resourceNum);
            this._checkStatus.open();
            return;
        }// end function

        private function cbChangePage(param1:int, param2:int) : void
        {
            this.setPage(param1);
            this._btnPage.update();
            return;
        }// end function

        private function setPage(param1:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            this._pageNo = param1;
            var _loc_2:* = this._pageNo * this._aItemButton.length;
            var _loc_3:* = 0;
            while (_loc_3 < this._aItemButton.length)
            {
                
                _loc_4 = this._aItemButton[_loc_3];
                if (_loc_2 + _loc_3 < this._aSkillId.length)
                {
                    _loc_5 = this._aSkillId[_loc_2 + _loc_3];
                    _loc_4.setSkillId(_loc_5);
                    _loc_4.setDisable(false);
                    _loc_4.setSelect(this._selectSkillId);
                }
                else
                {
                    _loc_4.setSkillId(Constant.EMPTY_ID);
                    _loc_4.setDisable(true);
                }
                _loc_3++;
            }
            this._btnPage.update();
            return;
        }// end function

        private function setButtonEnable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in this._aButton)
            {
                
                _loc_2.setDisableFlag(!param1);
            }
            if (param1)
            {
                this.setPage(this._pageNo);
            }
            else
            {
                for each (_loc_3 in this._aItemButton)
                {
                    
                    _loc_3.setDisable(true);
                }
            }
            this._btnPage.btnEnable(param1);
            return;
        }// end function

    }
}
