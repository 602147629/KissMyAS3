package status
{
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import input.*;
    import message.*;
    import player.*;
    import resource.*;
    import skill.*;

    public class SkillStatusBalloonBattle extends Object
    {
        private var _mcBase:MovieClip;
        private var _aStatusMc:Array;
        private var _aStatusNumMc:Array;
        private var _aStatusNumSubMc:Array;
        private var _btnArea:ButtonArea;
        private var _skillInfo:SkillInformation;
        private var _ownSkillData:OwnSkillData;
        private var _windowId:int = 0;
        private var _arrow:StatusArrow;
        private static const PARAM_NUM:int = 3;

        public function SkillStatusBalloonBattle(param1:DisplayObjectContainer, param2:Point = null, param3:Boolean = true)
        {
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", "SkillStatusBalloonBattle");
            var _loc_4:* = this._mcBase.SkillStatusBalloonMc.SkillStatusBalloon;
            this._aStatusMc = [_loc_4.Status1Mc, _loc_4.Status2Mc, _loc_4.Status3Mc];
            this._aStatusNumMc = [_loc_4.StatusNum1Mc, _loc_4.StatusNum2Mc, _loc_4.StatusNum3Mc];
            this._aStatusNumSubMc = [_loc_4.statusNumSub1Mc, _loc_4.statusNumSub2Mc, _loc_4.statusNumSub3Mc];
            this._arrow = new StatusArrow(this._mcBase.SkillStatusBalloonMc.arrowNull, ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", "CharaStatusArrow");
            if (param3)
            {
                this._btnArea = new ButtonArea(this._mcBase);
                ButtonManager.getInstance().addButtonArea(this._btnArea);
            }
            param1.addChild(this._mcBase);
            this._mcBase.visible = false;
            this._skillInfo = null;
            this._ownSkillData = null;
            if (param2)
            {
                this._mcBase.x = param2.x;
                this._mcBase.y = param2.y;
            }
            return;
        }// end function

        public function get skillId() : int
        {
            return this._ownSkillData ? (this._ownSkillData.skillId) : (Constant.EMPTY_ID);
        }// end function

        public function set windowId(param1:int) : void
        {
            this._windowId = param1;
            return;
        }// end function

        public function get windowId() : int
        {
            return this._windowId;
        }// end function

        public function release() : void
        {
            this._skillInfo = null;
            this._ownSkillData = null;
            if (this._btnArea)
            {
                ButtonManager.getInstance().removeButtonArea(this._btnArea);
            }
            this._btnArea = null;
            if (this._arrow)
            {
                this._arrow.release();
            }
            this._arrow = null;
            this._aStatusNumSubMc = null;
            this._aStatusNumMc = null;
            this._aStatusMc = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        public function show() : void
        {
            this._mcBase.visible = true;
            if (this._btnArea)
            {
                this._btnArea.setEnable(true);
            }
            return;
        }// end function

        public function hide() : void
        {
            this._mcBase.visible = false;
            if (this._btnArea)
            {
                this._btnArea.setEnable(false);
            }
            return;
        }// end function

        public function isShow() : Boolean
        {
            return this._mcBase.visible;
        }// end function

        public function setSkillData(param1:int) : void
        {
            this.setStatus(SkillManager.getInstance().getSkillInformation(param1), null);
            return;
        }// end function

        public function setOwnSkillData(param1:OwnSkillData) : void
        {
            this.setStatus(param1 ? (param1.skillInfo) : (null), param1);
            return;
        }// end function

        public function setStatus(param1:SkillInformation, param2:OwnSkillData) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            this._skillInfo = param1;
            this._ownSkillData = param2;
            var _loc_3:* = this._mcBase.SkillStatusBalloonMc.SkillStatusBalloon;
            _loc_3.attributeTypeMc.visible = false;
            _loc_3.weaponTypeMc.visible = false;
            for each (_loc_4 in this._aStatusNumSubMc)
            {
                
                TextControl.setBonusText(_loc_4, false, 0);
            }
            if (this._skillInfo == null)
            {
                TextControl.setText(_loc_3.NameMc.textDt, "");
                for each (_loc_4 in this._aStatusMc)
                {
                    
                    TextControl.setText(_loc_4.textDt, "");
                }
                for each (_loc_4 in this._aStatusNumMc)
                {
                    
                    TextControl.setText(_loc_4.textDt, "");
                }
                TextControl.setText(_loc_3.InfoMc.textDt, "");
            }
            else
            {
                _loc_5 = SkillManager.isMagicSkillInfo(this._skillInfo);
                if (_loc_5)
                {
                    _loc_6 = SkillManager.getInstance().getMagicTypeLabel(this._skillInfo.skillType);
                    if (_loc_6)
                    {
                        _loc_3.attributeTypeMc.visible = true;
                        _loc_3.attributeTypeMc.gotoAndStop(_loc_6);
                    }
                }
                else
                {
                    _loc_7 = SkillManager.getInstance().getWeaponTypeFromSkillType(this._skillInfo.skillType);
                    if (_loc_7 != Constant.EMPTY_ID)
                    {
                        _loc_3.weaponTypeMc.visible = true;
                        _loc_3.weaponTypeMc.gotoAndStop(PlayerManager.getInstance().getWeaponType((_loc_7 - 1)));
                    }
                }
                TextControl.setText(_loc_3.NameMc.textDt, this._skillInfo.name);
                if (this._ownSkillData)
                {
                    this.setParam_OwnSkill(_loc_5, this._ownSkillData);
                }
                else
                {
                    this.setParam_SkillInfo(_loc_5, this._skillInfo);
                }
                TextControl.setText(_loc_3.InfoMc.textDt, this._skillInfo.detailDescription ? (this._skillInfo.detailDescription) : (""));
            }
            return;
        }// end function

        private function setParam_SkillInfo(param1:Boolean, param2:SkillInformation) : void
        {
            this.setParam(param1, param2.power, param2.hit, param2.sp, 0, 0, 0);
            return;
        }// end function

        private function setParam_OwnSkill(param1:Boolean, param2:OwnSkillData) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (param2.skillInfo)
            {
                _loc_3 = param2.powerTotal - param2.skillInfo.power;
                _loc_4 = param2.hitTotalShowVal - param2.skillInfo.hitShowVal;
                _loc_5 = param2.spTotal - param2.skillInfo.sp;
            }
            this.setParam(param1, param2.powerTotal, param2.hitTotal, param2.spTotal, _loc_3, _loc_4, _loc_5);
            return;
        }// end function

        private function setParam(param1:Boolean, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : void
        {
            var _loc_8:* = param2 != 0;
            var _loc_9:* = param1 == false && _loc_8;
            var _loc_10:* = true;
            var _loc_11:* = 0;
            if (_loc_8)
            {
                TextControl.setIdText(this._aStatusMc[_loc_11].textDt, MessageId.COMMON_SKILL_STATUS_POWER);
                TextControl.setText(this._aStatusNumMc[_loc_11].textDt, param2.toString());
                TextControl.setBonusText(this._aStatusNumSubMc[_loc_11], param5 != 0, param5);
                _loc_11++;
            }
            if (_loc_9)
            {
                TextControl.setIdText(this._aStatusMc[_loc_11].textDt, MessageId.COMMON_SKILL_STATUS_HIT);
                TextControl.setText(this._aStatusNumMc[_loc_11].textDt, TextControl.createHitValText(param3));
                TextControl.setBonusText(this._aStatusNumSubMc[_loc_11], param6 != 0, param6);
                _loc_11++;
            }
            if (_loc_10)
            {
                TextControl.setIdText(this._aStatusMc[_loc_11].textDt, MessageId.COMMON_SKILL_STATUS_SP);
                TextControl.setText(this._aStatusNumMc[_loc_11].textDt, param4.toString());
                TextControl.setReverseBonusText(this._aStatusNumSubMc[_loc_11], param7 != 0, param7);
                _loc_11++;
            }
            while (_loc_11 < PARAM_NUM)
            {
                
                TextControl.setText(this._aStatusMc[_loc_11].textDt, "");
                TextControl.setText(this._aStatusNumMc[_loc_11].textDt, "");
                _loc_11++;
            }
            return;
        }// end function

        public function setParent(param1:DisplayObjectContainer) : void
        {
            if (this._mcBase.parent != param1)
            {
                if (this._mcBase.parent)
                {
                    this._mcBase.parent.removeChild(this._mcBase);
                }
                if (param1)
                {
                    param1.addChild(this._mcBase);
                }
            }
            return;
        }// end function

        public function setPosition(param1:Point) : void
        {
            if (this._mcBase)
            {
                this._mcBase.x = param1.x;
                this._mcBase.y = param1.y;
            }
            return;
        }// end function

        public function setArrowTargetPosition(param1:Point) : void
        {
            this._arrow.setArrowTargetPosition(param1);
            return;
        }// end function

        public function isHitTest() : Boolean
        {
            if (!this._mcBase.visible)
            {
                return false;
            }
            var _loc_1:* = InputManager.getInstance().corsor;
            return this._mcBase.hitTestPoint(_loc_1.x, _loc_1.y);
        }// end function

        public static function loadResource() : void
        {
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            return;
        }// end function

    }
}
