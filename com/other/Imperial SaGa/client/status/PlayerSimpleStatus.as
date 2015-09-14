package status
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import icon.*;
    import input.*;
    import item.*;
    import message.*;
    import player.*;
    import resource.*;
    import skill.*;
    import user.*;
    import utility.*;

    public class PlayerSimpleStatus extends Object
    {
        private var _mcBase:MovieClip;
        private var _statusMc:MovieClip;
        private var _label:int;
        private var _bCommanderSkillEnable:Boolean;
        private var _setupedLabelName:String;
        private var _btnArea:ButtonArea;
        private var _detailBtn:ButtonBase;
        private var _cbDetailOpen:Function;
        private var _cbDetailClose:Function;
        private var _bDetailInternal:Boolean;
        private var _personal:PlayerPersonal;
        private var _arrow:StatusArrow;
        private var _rarityIcon:PlayerRarityIcon;
        private var _growthConditionIcon:GrowthConditionIcon;
        private var _numMcRestoreTime:NumericNumberMc;
        private var _previousSP:int = 0;
        private var _timer:Timer;
        private static const _STATUS_DISPLAY_ARROW_WIDTH:int = 29;
        private static const _STATUS_DISPLAY_ARROW_HEIGHT:int = 19;
        public static const LABEL_MAIN:int = 1;
        public static const LABEL_RESTORE_TIME:int = 2;

        public function PlayerSimpleStatus(param1:DisplayObjectContainer, param2:int = 1, param3:PlayerPersonal = null, param4:Point = null, param5:Boolean = true)
        {
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", "CharaInfoBalloon");
            this._statusMc = this._mcBase.charaStatusBalloonMc.charaStatusBalloon;
            this._label = param2;
            this._bCommanderSkillEnable = true;
            this._setupedLabelName = "";
            this._arrow = new StatusArrow(this._mcBase.charaStatusBalloonMc.arrowNull, ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", "CharaStatusArrow", _STATUS_DISPLAY_ARROW_WIDTH, _STATUS_DISPLAY_ARROW_HEIGHT);
            this._rarityIcon = null;
            this._growthConditionIcon = null;
            if (param5)
            {
                this._btnArea = new ButtonArea(this._mcBase);
                ButtonManager.getInstance().addButtonArea(this._btnArea);
            }
            this._detailBtn = null;
            this._cbDetailOpen = null;
            this._cbDetailClose = null;
            this._bDetailInternal = false;
            this.setInUnitIconMc(false);
            this._statusMc.charaDetailBtnMc.visible = false;
            param1.addChild(this._mcBase);
            this._personal = param3;
            if (this._personal)
            {
                this.setStatus(this._personal);
            }
            if (param4)
            {
                this._mcBase.x = param4.x;
                this._mcBase.y = param4.y;
            }
            this._timer = new Timer(1000);
            this._timer.addEventListener(TimerEvent.TIMER, this.checkForUpdate);
            this._timer.start();
            return;
        }// end function

        public function get uniqueId() : int
        {
            return this._personal ? (this._personal.uniqueId) : (Constant.EMPTY_ID);
        }// end function

        public function get statusMc_width() : int
        {
            return this._statusMc.width;
        }// end function

        public function get statusMc_height() : int
        {
            return this._statusMc.height;
        }// end function

        public function get statusMc_pos() : Point
        {
            return new Point(this._statusMc.x, this._statusMc.y);
        }// end function

        public function get baseMc() : MovieClip
        {
            return this._mcBase;
        }// end function

        private function checkForUpdate(event:TimerEvent) : void
        {
            if (this._personal)
            {
                this._personal.updateSp();
                if (this._previousSP != this._personal.sp)
                {
                    this.setStatus(this._personal);
                }
            }
            return;
        }// end function

        public function release() : void
        {
            if (this._timer)
            {
                if (this._timer.hasEventListener(TimerEvent.TIMER))
                {
                    this._timer.removeEventListener(TimerEvent.TIMER, this.checkForUpdate);
                }
                this._timer = null;
            }
            if (this._detailBtn)
            {
                ButtonManager.getInstance().removeButton(this._detailBtn);
            }
            this._detailBtn = null;
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
            this._numMcRestoreTime = null;
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
            if (this._detailBtn)
            {
                this._detailBtn.setDisableFlag(false);
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
            if (this._detailBtn)
            {
                this._detailBtn.setDisableFlag(true);
            }
            return;
        }// end function

        public function isShow() : Boolean
        {
            return this._mcBase.visible;
        }// end function

        public function setStatus(param1:PlayerPersonal) : void
        {
            var _loc_8:* = null;
            this._personal = param1;
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(param1.playerId);
            var _loc_3:* = this._bCommanderSkillEnable && _loc_2.hasCommanderSkill();
            this.setupMcLabel(_loc_3);
            this.setInUnitIconMc(UserDataManager.getInstance().userData.aFormationPlayerUniqueId.indexOf(param1.uniqueId) != -1);
            if (this._rarityIcon == null)
            {
                this._rarityIcon = new PlayerRarityIcon(this._statusMc.setCharaRankMc);
            }
            this._rarityIcon.setRarity(_loc_2.rarity);
            if (this._statusMc.ｃategoryTextMc)
            {
                TextControl.setText(this._statusMc.ｃategoryTextMc.textDt, PlayerManager.getInstance().getPlayerTagName(_loc_2));
            }
            var _loc_4:* = this._personal && this._personal.isEmperor();
            this.setupStatusFixText();
            this._personal.updateSp();
            var _loc_5:* = String(this._personal.getHpAtResting() + "/" + param1.hpMax);
            var _loc_6:* = _loc_4 ? ("-") : (String(param1.lp + "/" + _loc_2.lp));
            var _loc_7:* = String(param1.sp + "/" + param1.spMax);
            this._previousSP = param1.sp;
            TextControl.setText(this._statusMc.charaNameMc.textDt, _loc_2.name);
            TextControl.setText(this._statusMc.charaStatusNum1TextMc.textDt, _loc_5);
            TextControl.setText(this._statusMc.charaStatusNum2TextMc.textDt, _loc_6);
            TextControl.setText(this._statusMc.charaStatusNum3TextMc.textDt, _loc_7);
            TextControl.setText(this._statusMc.charaStatusNum4TextMc.textDt, param1.attackTotal.toString());
            TextControl.setText(this._statusMc.charaStatusNum5TextMc.textDt, param1.defenseTotal.toString());
            TextControl.setText(this._statusMc.charaStatusNum6TextMc.textDt, param1.speedTotal.toString());
            if (param1.battleCount <= 999)
            {
                TextControl.setText(this._statusMc.charaStatusNum7TextMc.textDt, param1.battleCount.toString());
            }
            else
            {
                _loc_8 = new ColorTransform();
                _loc_8.color = 14172738;
                TextControl.setText(this._statusMc.charaStatusNum7TextMc.textDt, "999", true, _loc_8);
            }
            this.setupBonusParameter(param1.isBonusAttack(), param1.bonusAttackTotal, param1.isBonusDefense(), param1.bonusDefenseTotal, param1.isBonusSpeed(), param1.bonusSpeedTotal);
            if (this._growthConditionIcon == null)
            {
                this._growthConditionIcon = new GrowthConditionIcon(this._statusMc.growArrowMc);
            }
            this._growthConditionIcon.setGrowthLabel(param1.getGrowthLabel());
            if (this._label == LABEL_MAIN)
            {
                this.setupEquippedSkill(param1.aSetSkillId);
                this.setupEquippedItem(param1.aSetItemId);
            }
            if (_loc_3)
            {
                this.setupCommanderSkill(_loc_2);
            }
            return;
        }// end function

        public function setStatusByPlayerId(param1:int) : void
        {
            this._personal = null;
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(param1);
            var _loc_3:* = this._bCommanderSkillEnable && _loc_2.hasCommanderSkill();
            this.setupMcLabel(_loc_3);
            this.setInUnitIconMc(false);
            if (this._rarityIcon == null)
            {
                this._rarityIcon = new PlayerRarityIcon(this._statusMc.setCharaRankMc);
            }
            this._rarityIcon.setRarity(_loc_2.rarity);
            if (this._statusMc.ｃategoryTextMc)
            {
                TextControl.setText(this._statusMc.ｃategoryTextMc.textDt, PlayerManager.getInstance().getPlayerTagName(_loc_2));
            }
            var _loc_4:* = false;
            this.setupStatusFixText();
            var _loc_5:* = PlayerPersonal.calcDefaultSp(_loc_2);
            var _loc_6:* = String(_loc_2.hp + "/" + _loc_2.hp);
            var _loc_7:* = String(_loc_2.lp + "/" + _loc_2.lp);
            var _loc_8:* = String(_loc_5 + "/" + _loc_2.sp);
            TextControl.setText(this._statusMc.charaNameMc.textDt, _loc_2.name);
            TextControl.setText(this._statusMc.charaStatusNum1TextMc.textDt, _loc_6);
            TextControl.setText(this._statusMc.charaStatusNum2TextMc.textDt, _loc_7);
            TextControl.setText(this._statusMc.charaStatusNum3TextMc.textDt, _loc_8);
            TextControl.setText(this._statusMc.charaStatusNum4TextMc.textDt, _loc_2.attack.toString());
            TextControl.setText(this._statusMc.charaStatusNum5TextMc.textDt, _loc_2.defense.toString());
            TextControl.setText(this._statusMc.charaStatusNum6TextMc.textDt, _loc_2.speed.toString());
            TextControl.setText(this._statusMc.charaStatusNum7TextMc.textDt, "0");
            this.setupBonusParameter(false, 0, false, 0, false, 0);
            if (this._growthConditionIcon == null)
            {
                this._growthConditionIcon = new GrowthConditionIcon(this._statusMc.growArrowMc);
            }
            this._growthConditionIcon.setGrowthLabel(PlayerPersonal.getGrowthLabel(_loc_2, 0));
            if (this._label == LABEL_MAIN)
            {
                this.setupEquippedSkill(_loc_2.aSetSkillId);
                this.setupEquippedItem([]);
            }
            if (_loc_3)
            {
                this.setupCommanderSkill(_loc_2);
            }
            return;
        }// end function

        private function setInUnitIconMc(param1:Boolean) : void
        {
            if (this._detailBtn == null)
            {
                this._statusMc.inUnitIconMc.visible = param1;
            }
            else
            {
                this._statusMc.inUnitIconMc.visible = false;
            }
            return;
        }// end function

        private function setupStatusFixText() : void
        {
            TextControl.setIdText(this._statusMc.charaStatus1TextMc.textDt, MessageId.COMMON_STATUS_HP);
            TextControl.setIdText(this._statusMc.charaStatus2TextMc.textDt, MessageId.COMMON_STATUS_LP);
            TextControl.setIdText(this._statusMc.charaStatus3TextMc.textDt, MessageId.COMMON_STATUS_SP);
            TextControl.setIdText(this._statusMc.charaStatus4TextMc.textDt, MessageId.COMMON_STATUS_ATTACK);
            TextControl.setIdText(this._statusMc.charaStatus5TextMc.textDt, MessageId.COMMON_STATUS_DEFENSE);
            TextControl.setIdText(this._statusMc.charaStatus6TextMc.textDt, MessageId.COMMON_STATUS_SPEED);
            TextControl.setIdText(this._statusMc.charaStatus7TextMc.textDt, MessageId.COMMON_STATUS_WAR_EXPERIENCE);
            TextControl.setIdText(this._statusMc.charaStatus8TextMc.textDt, MessageId.COMMON_STATUS_GROWTH);
            return;
        }// end function

        private function setupBonusParameter(param1:Boolean, param2:int, param3:Boolean, param4:int, param5:Boolean, param6:int) : void
        {
            TextControl.setBonusText(this._statusMc.statusNumSub4TextMc, param1, param2);
            TextControl.setBonusText(this._statusMc.statusNumSub5TextMc, param3, param4);
            TextControl.setBonusText(this._statusMc.statusNumSub6TextMc, param5, param6);
            TextControl.setText(this._statusMc.statusNumSub1TextMc.textMc.textDt, "");
            TextControl.setText(this._statusMc.statusNumSub2TextMc.textMc.textDt, "");
            TextControl.setText(this._statusMc.statusNumSub3TextMc.textMc.textDt, "");
            this._statusMc.statusNumSub1TextMc.visible = false;
            this._statusMc.statusNumSub2TextMc.visible = false;
            this._statusMc.statusNumSub3TextMc.visible = false;
            return;
        }// end function

        private function setupEquippedSkill(param1:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = [this._statusMc.equippedArts1TextMc, this._statusMc.equippedArts2TextMc, this._statusMc.equippedArts3TextMc];
            var _loc_3:* = 0;
            for each (_loc_4 in _loc_2)
            {
                
                if (param1[_loc_3] != Constant.EMPTY_ID)
                {
                    _loc_5 = SkillManager.getInstance().getSkillInformation(param1[_loc_3]);
                    TextControl.setText(_loc_4.textDt, _loc_5 != null ? (_loc_5.name) : (""));
                }
                else
                {
                    TextControl.setIdText(_loc_4.textDt, MessageId.COMMON_EMPTY);
                }
                _loc_3++;
            }
            return;
        }// end function

        private function setupEquippedItem(param1:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = [this._statusMc.equippedItemTextMc];
            var _loc_3:* = 0;
            for each (_loc_4 in _loc_2)
            {
                
                if (param1.length > _loc_3 && param1[_loc_3] != Constant.EMPTY_ID)
                {
                    _loc_5 = ItemManager.getInstance().getItemInformation(param1[_loc_3]);
                    TextControl.setText(_loc_4.textDt, _loc_5 != null ? (_loc_5.name) : (""));
                }
                else
                {
                    TextControl.setIdText(_loc_4.textDt, MessageId.COMMON_EMPTY);
                }
                _loc_3++;
            }
            return;
        }// end function

        private function setupCommanderSkill(param1:PlayerInformation) : void
        {
            if (this._statusMc.commanderSkillInfoTextMc)
            {
                TextControl.setText(this._statusMc.commanderSkillInfoTextMc.textDt, PlayerManager.getInstance().getCommanderSkillEffectsText(param1));
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

        public function setEnablePlayerDetail(param1:Function = null, param2:Function = null, param3:Boolean = true) : void
        {
            this._statusMc.charaDetailBtnMc.visible = true;
            this.setInUnitIconMc(false);
            if (this._detailBtn == null)
            {
                this._detailBtn = ButtonManager.getInstance().addButton(this._statusMc.charaDetailBtnMc, this.cbDetailBtn);
                this._detailBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
                TextControl.setIdText(this._statusMc.charaDetailBtnMc.textMc.textDt, MessageId.COMMON_PLAYER_DETAIL);
                if (this._btnArea)
                {
                    this._btnArea.addButton(this._detailBtn);
                }
            }
            this._cbDetailOpen = param1;
            this._cbDetailClose = param2;
            this._bDetailInternal = param3;
            return;
        }// end function

        public function setLabel(param1:int) : void
        {
            this._label = param1;
            return;
        }// end function

        private function setupMcLabel(param1:Boolean) : void
        {
            var _loc_2:* = this.getLabelName(param1);
            if (this._setupedLabelName != _loc_2)
            {
                this._setupedLabelName = _loc_2;
                this._statusMc.gotoAndStop(_loc_2);
            }
            return;
        }// end function

        private function getLabelName(param1:Boolean) : String
        {
            var _loc_2:* = "status";
            if (this._label == LABEL_RESTORE_TIME)
            {
                _loc_2 = param1 ? ("restore_commander") : ("restore");
            }
            else
            {
                _loc_2 = param1 ? ("status_commander") : ("status");
            }
            return _loc_2;
        }// end function

        public function setRestoreTime(param1:int) : void
        {
            if (this._numMcRestoreTime == null && this._statusMc.restoreTimeMc)
            {
                this._numMcRestoreTime = new NumericNumberMc(this._statusMc.restoreTimeMc, 0, 0);
            }
            if (this._numMcRestoreTime)
            {
                this._numMcRestoreTime.setNum(param1);
            }
            return;
        }// end function

        public function updateHp() : void
        {
            var _loc_1:* = this._personal.getHpAtResting();
            var _loc_2:* = String(_loc_1 + "/" + this._personal.hpMax);
            TextControl.setText(this._statusMc.charaStatusNum1TextMc.textDt, _loc_2);
            return;
        }// end function

        public function updateSp() : void
        {
            var _loc_1:* = String(this._personal.sp + "/" + this._personal.spMax);
            TextControl.setText(this._statusMc.charaStatusNum3TextMc.textDt, _loc_1);
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

        public function setMouseEventEnable(param1:Boolean) : void
        {
            this._mcBase.mouseEnabled = param1;
            this._mcBase.mouseChildren = param1;
            return;
        }// end function

        private function cbDetailBtn(param1:int) : void
        {
            var _loc_2:* = null;
            if (this._cbDetailOpen != null)
            {
                this._cbDetailOpen(this._personal ? (this._personal.uniqueId) : (Constant.EMPTY_ID));
            }
            if (this._bDetailInternal)
            {
                _loc_2 = StatusManager.getInstance().getOwnItemList(UserDataManager.getInstance().userData.getOwnItem(CommonConstant.ITEM_KIND_ACCESSORIES), UserDataManager.getInstance().userData.aPlayerPersonal, this._personal.uniqueId);
                StatusManager.getInstance().addStatusDetail(PlayerDetailStatus.STATUS_TYPE_NOT_CHANGE_EQUIPMENT, Main.GetProcess(), this.cbDetailClose, this._personal, _loc_2);
            }
            return;
        }// end function

        private function cbDetailClose(param1:int, param2:Boolean = false) : void
        {
            if (this._cbDetailClose != null)
            {
                this._cbDetailClose(param1);
            }
            return;
        }// end function

        public function updateAlpha(param1:Number) : void
        {
            this._mcBase.alpha = param1;
            return;
        }// end function

        public static function loadResource() : void
        {
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            return;
        }// end function

        public static function calcPos(param1:DisplayObjectContainer, param2:DisplayObject) : Point
        {
            var _loc_3:* = new Point();
            _loc_3.x = param2.x;
            _loc_3.y = param2.y;
            _loc_3 = param2.parent.localToGlobal(_loc_3);
            if (param1)
            {
                _loc_3 = param1.globalToLocal(_loc_3);
            }
            return _loc_3;
        }// end function

    }
}
