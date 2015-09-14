package home
{
    import flash.display.*;
    import message.*;
    import network.*;
    import notice.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import user.*;

    public class HomeFacilityUpGradeCount extends Object
    {
        private const _PHASE_SET:int = 1;
        private const _PHASE_COMMUNICATION:int = 2;
        private const _PHASE_START:int = 3;
        private const _PHASE_FACILITY_COMPETION:int = 4;
        private const _PHASE_END:int = 5;
        private var _phase:int;
        private const _ICON_CHANGE:String = "iconChange";
        private const _END:String = "end";
        private var _lv:String;
        private var _baseMc:MovieClip;
        private var _gradeUpMc:MovieClip;
        public var _viewFlag:Boolean = false;
        private var _facilityId:int;
        private var _bFacilityUpGradeEnd:Boolean;

        public function HomeFacilityUpGradeCount(param1:MovieClip, param2:int)
        {
            this._baseMc = param1;
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Popup.swf");
            this._bFacilityUpGradeEnd = false;
            this._facilityId = param2;
            this._phase = this._PHASE_SET;
            return;
        }// end function

        public function returnId() : int
        {
            return this._facilityId;
        }// end function

        public function End() : Boolean
        {
            return this._bFacilityUpGradeEnd;
        }// end function

        public function release() : void
        {
            this._baseMc = null;
            this._gradeUpMc = null;
            return;
        }// end function

        private function selectPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case this._PHASE_START:
                {
                    this.phaseStart();
                    break;
                }
                case this._PHASE_COMMUNICATION:
                {
                    this.phaseCommunication();
                    break;
                }
                case this._PHASE_FACILITY_COMPETION:
                {
                    this.phaseCompletion();
                    break;
                }
                case this._PHASE_END:
                {
                    this.phaseEnd();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_SET:
                {
                    this.controlSet();
                    break;
                }
                case this._PHASE_START:
                {
                    this.controlStart();
                    break;
                }
                case this._PHASE_FACILITY_COMPETION:
                {
                    this.controlCompletion();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function controlSet() : void
        {
            this.selectPhase(this._PHASE_COMMUNICATION);
            return;
        }// end function

        public function phaseCommunication() : void
        {
            this.promptlyUpgrade();
            return;
        }// end function

        private function promptlyUpgrade() : void
        {
            switch(this._facilityId)
            {
                case CommonConstant.FACILITY_ID_BARRACKS:
                {
                    NetManager.getInstance().request(new NetTaskBarracksUpgradeEnd(0, 0, this.cbConnectUpgradeEnd));
                    this._gradeUpMc = this._baseMc.menuIconBtn_BarracksMc;
                    break;
                }
                case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                {
                    NetManager.getInstance().request(new NetTaskSkillInitiateUpgradeEnd(0, 0, this.cbConnectUpgradeEnd));
                    this._gradeUpMc = this._baseMc.menuIconBtn_SkillInitiateMc;
                    break;
                }
                case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                {
                    NetManager.getInstance().request(new NetTaskMagicDevelopUpgradeEnd(0, 0, this.cbConnectUpgradeEnd));
                    this._gradeUpMc = this._baseMc.menuIconBtn_MagicDevelopMc;
                    break;
                }
                case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                {
                    NetManager.getInstance().request(new NetTaskTrainingRoomUpgradeEnd(0, 0, this.cbConnectUpgradeEnd));
                    this._gradeUpMc = this._baseMc.menuIconBtn_TrainingMc;
                    break;
                }
                case CommonConstant.FACILITY_ID_MAKE_EQUIP:
                {
                    NetManager.getInstance().request(new NetTaskMakeEquipUpgradeEnd(0, 0, this.cbConnectUpgradeEnd));
                    this._gradeUpMc = this._baseMc.menuIconBtn_MakeEquipMc;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function cbConnectUpgradeEnd(param1:NetResult) : void
        {
            var res:* = param1;
            if (res.resultCode != NetId.RESULT_OK)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CONNECT_ERROR_BACK_HOME), function () : void
            {
                selectPhase(_PHASE_END);
                return;
            }// end function
            );
                return;
            }
            var info:* = UserDataManager.getInstance().userData.getInstitutionInfo(this._facilityId);
            info.setFacilityInfo(res.data.institution);
            NoticeManager.getInstance().crearSimpleNoticeById(res.data.institutionNoticeId);
            this.selectPhase(this._PHASE_START);
            return;
        }// end function

        public function phaseStart() : void
        {
            this.upGraseSet(this._gradeUpMc);
            this._lv = this.getIconLabel();
            return;
        }// end function

        public function controlStart() : void
        {
            this.upGradeProcessing(this._gradeUpMc);
            return;
        }// end function

        public function phaseCompletion() : void
        {
            this.CompletionPopUp();
            return;
        }// end function

        public function controlCompletion() : void
        {
            return;
        }// end function

        public function phaseEnd() : void
        {
            this._bFacilityUpGradeEnd = true;
            return;
        }// end function

        private function CompletionPopUp() : void
        {
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(this.getCompletionMessageId()), function () : void
            {
                selectPhase(_PHASE_END);
                return;
            }// end function
            , MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_CONFIRM));
            return;
        }// end function

        private function upGraseSet(param1:MovieClip) : void
        {
            param1.gotoAndPlay("gradeUp");
            param1.eff_GradeUpMc.gotoAndPlay("start");
            param1.eff_GradeUpMc.menuIconMc.kentikuNow.visible = false;
            return;
        }// end function

        private function upGradeProcessing(param1:MovieClip) : void
        {
            if (param1.eff_GradeUpMc.isPlaying && param1.eff_GradeUpMc.currentFrameLabel == "se1001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_GRADEUP_GATHER);
            }
            if (param1.eff_GradeUpMc.isPlaying && param1.eff_GradeUpMc.currentFrame == 45)
            {
                SoundManager.getInstance().playSe(SoundId.SE_BRANCH);
            }
            switch(param1.eff_GradeUpMc.currentLabel)
            {
                case this._ICON_CHANGE:
                {
                    param1.eff_GradeUpMc.menuIconMc.gotoAndStop(this._lv);
                    break;
                }
                case this._END:
                {
                    param1.menuIconMc.gotoAndStop(this._lv);
                    param1.gotoAndPlay("offMouse");
                    this.selectPhase(this._PHASE_FACILITY_COMPETION);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function getIconLabel() : String
        {
            var _loc_1:* = this.getInstitutionInfo();
            if (_loc_1.grade == 0)
            {
                return "lv1";
            }
            var _loc_2:* = UserFacilityLv.getFacilityLv(_loc_1.grade);
            return "lv" + _loc_2;
        }// end function

        public function getCompletionMessageId() : int
        {
            var _loc_1:* = this.getInstitutionInfo();
            return _loc_1.grade == 1 ? (MessageId.FACILITY_UPGRADE_END) : (MessageId.FACILITY_BALOON_FACILITY_END_UPGLADE);
        }// end function

        private function getInstitutionInfo() : InstitutionInfo
        {
            return UserDataManager.getInstance().userData.getInstitutionInfo(this._facilityId);
        }// end function

    }
}
