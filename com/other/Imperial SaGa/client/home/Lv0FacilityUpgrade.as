package home
{
    import flash.display.*;
    import message.*;
    import network.*;
    import notice.*;
    import popup.*;
    import resource.*;
    import user.*;

    public class Lv0FacilityUpgrade extends Object
    {
        private const _PHASE_POPUP:int = 1;
        private const _PHASE_POPUP_YES:int = 2;
        private const _PHASE_POPUP_NO:int = 3;
        private const _PHASE_FACILITY_COMPETION:int = 4;
        private const _PHASE_END:int = 5;
        private var _phase:int;
        private var _baseMc:MovieClip;
        private const _OFF_MOUSE:String = "offMouse";
        private var _facilityInfo:InstitutionInfo;
        public var _viewFlag:Boolean = false;
        private var _cbClosePopup:Function;

        public function Lv0FacilityUpgrade(param1:MovieClip)
        {
            this._baseMc = param1;
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Popup.swf");
            this._facilityInfo = new InstitutionInfo();
            return;
        }// end function

        public function release() : void
        {
            super.release();
            this._baseMc = null;
            return;
        }// end function

        private function selectPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case this._PHASE_POPUP:
                {
                    this.phasePopUp();
                    break;
                }
                case this._PHASE_POPUP_YES:
                {
                    this.phasePopUpYes();
                    break;
                }
                case this._PHASE_POPUP_NO:
                {
                    this.phasePopUpNo();
                    break;
                }
                case this._PHASE_END:
                {
                    this.phaseEnd();
                    this._viewFlag = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function LvCheck(param1:int, param2:Function = null) : void
        {
            this._viewFlag = true;
            this._cbClosePopup = param2;
            this._facilityInfo = UserDataManager.getInstance().userData.getInstitutionInfo(param1);
            this.selectPhase(this._PHASE_POPUP);
            return;
        }// end function

        public function phasePopUp() : void
        {
            this.popUp();
            return;
        }// end function

        public function phasePopUpYes() : void
        {
            this.selectPhase(this._PHASE_END);
            return;
        }// end function

        public function phasePopUpNo() : void
        {
            switch(this._facilityInfo.id)
            {
                case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                {
                    this._baseMc.menuIconBtn_SkillInitiateMc.gotoAndStop(this._OFF_MOUSE);
                    break;
                }
                case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                {
                    this._baseMc.menuIconBtn_MagicDevelopMc.gotoAndStop(this._OFF_MOUSE);
                    break;
                }
                case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                {
                    this._baseMc.menuIconBtn_TrainingMc.gotoAndStop(this._OFF_MOUSE);
                    break;
                }
                case CommonConstant.FACILITY_ID_BARRACKS:
                {
                    this._baseMc.menuIconBtn_BarracksMc.gotoAndStop(this._OFF_MOUSE);
                    break;
                }
                case CommonConstant.FACILITY_ID_MAKE_EQUIP:
                {
                    this._baseMc.menuIconBtn_MakeEquipMc.gotoAndStop(this._OFF_MOUSE);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.selectPhase(this._PHASE_END);
            return;
        }// end function

        public function phaseEnd() : void
        {
            if (this._cbClosePopup != null)
            {
                this._cbClosePopup();
            }
            return;
        }// end function

        private function popUp() : void
        {
            var unlockLv:* = UserDataManager.getInstance().getUnlockFacilityEmperorLv(this._facilityInfo.id);
            if (UserDataManager.getInstance().getEmperorLv() < unlockLv)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.FACILITY_UPGRADE_UNLOCKLV, unlockLv), function () : void
            {
                selectPhase(_PHASE_POPUP_NO);
                return;
            }// end function
            );
                return;
            }
            CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NAVI, MessageManager.getInstance().getMessage(MessageId.FACILITY_UPGRADE), function (param1:Boolean) : void
            {
                switch(_facilityInfo.id)
                {
                    case CommonConstant.FACILITY_ID_BARRACKS:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                    {
                        break;
                    }
                    case CommonConstant.FACILITY_ID_MAKE_EQUIP:
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
            , MessageManager.getInstance().getMessage(MessageId.FACILITY_UPGRADE_START), MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_RETURN), false);
            return;
        }// end function

        private function ConnectUpgrade(param1:NetResult) : void
        {
            var res:* = param1;
            if (res.resultCode != NetId.RESULT_OK)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CONNECT_ERROR_BACK_HOME), function () : void
            {
                return;
            }// end function
            );
                return;
            }
            var id:* = res.data.institution.id;
            var info:* = UserDataManager.getInstance().userData.getInstitutionInfo(id);
            info.setFacilityInfo(res.data.institution);
            NoticeManager.getInstance().addMiniNoticeByObject(res.data.institutionNotice);
            return;
        }// end function

    }
}
