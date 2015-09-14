package status
{
    import PlayerCard.*;
    import battle.*;
    import button.*;
    import character.*;
    import correlation.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import icon.*;
    import input.*;
    import item.*;
    import message.*;
    import network.*;
    import player.*;
    import resource.*;
    import user.*;
    import utility.*;

    public class PlayerDetailStatus extends Object
    {
        private var _type:int;
        private var _phase:int;
        private var _parent:DisplayObjectContainer;
        private var _mcBase:MovieClip;
        private var _mcStatus:MovieClip;
        private var _mcStand:MovieClip;
        private var _bmpBustUp:Bitmap;
        private var _isoMain:InStayOut;
        private var _aButton:Array;
        private var _aChangeButton:Array;
        private var _aRemoveButton:Array;
        private var _correlation:CorrelationMain;
        private var _btnCorrelation:ButtonBase;
        private var _bCorrelation:Boolean;
        private var _aCorrelationCharacter:Array;
        private var _growthCurveLine:Shape;
        private var _growthCurveEndMark:MovieClip;
        private var _btnGrowthReset:ButtonBase;
        private var _aEquipmentBox:Array;
        private var _skillSimpleStatus:SkillSimpleStatus;
        private var _equipSimpleStatus:EquipSimpleStatus;
        private var _skillSelecter:PlayerSkillSelecter;
        private var _viewer:PlayerCardViewer;
        private var _fadeMain:Fade;
        private var _fadeEquipmentPopup:Fade;
        private var _cbClose:Function;
        private var _playerId:int;
        private var _personalPtr:PlayerPersonal;
        private var _aItemData:Array;
        private var _growthReset:GrowsResetConfirmPopup;
        private var _statusResult:PlayerDetailStatusResult;
        private const DRAW_WIDTH:int = 276;
        private const DRAW_HEIGHT:int = 100;
        private const DRAW_X:int = 0;
        private const DRAW_Y:int = 0;
        private const COUNT_MAX:int = 40;
        private const VALUE_RANGE_MAX:int = 400;
        public static const STATUS_TYPE_EQUIPMENT:int = 0;
        public static const STATUS_TYPE_NOT_CHANGE_EQUIPMENT:int = 1;
        public static const STATUS_TYPE_ALBUM:int = 2;
        public static const STATUS_TYPE_HISTORY:int = 3;
        private static const _SKILL_LIST_NUM:int = 3;
        private static const _ITEM_LIST_NUM:int = 1;
        private static const _PHASE_LOADING:int = 0;
        private static const _PHASE_OPEN:int = 1;
        private static const _PHASE_INPUT_WAIT:int = 2;
        private static const _PHASE_CLOSE:int = 3;

        public function PlayerDetailStatus(param1:int, param2:DisplayObjectContainer, param3:Function = null, param4:PlayerPersonal = null, param5:Array = null)
        {
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            this._type = param1;
            switch(this._type)
            {
                case STATUS_TYPE_EQUIPMENT:
                case STATUS_TYPE_NOT_CHANGE_EQUIPMENT:
                case STATUS_TYPE_HISTORY:
                {
                    this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", "StatusWindowMc");
                    this._mcStatus = this._mcBase.mainStatusMc;
                    break;
                }
                case STATUS_TYPE_ALBUM:
                {
                }
                default:
                {
                    this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", "albumStatusMc");
                    this._mcStatus = this._mcBase.albStatusMc;
                    break;
                    break;
                }
            }
            this._parent = param2;
            this._cbClose = param3;
            this._aButton = [];
            this._aChangeButton = [];
            this._aRemoveButton = [];
            this._aEquipmentBox = [];
            this._aCorrelationCharacter = [];
            this._statusResult = new PlayerDetailStatusResult();
            this._bUpdate = false;
            this._bCorrelation = false;
            var _loc_6:* = ButtonManager.getInstance().addButton(this._mcStatus.returnBtnMc ? (this._mcStatus.returnBtnMc) : (this._mcStatus.closeBtnMc), this.cbCloseBtn);
            ButtonManager.getInstance().addButton(this._mcStatus.returnBtnMc ? (this._mcStatus.returnBtnMc) : (this._mcStatus.closeBtnMc), this.cbCloseBtn).enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(_loc_6.getMoveClip().textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            this._aButton.push(_loc_6);
            this._btnCorrelation = ButtonManager.getInstance().addButton(this._mcStatus.detailTubMc.correlationBtnMc, this.cbDiagramDetailBtn);
            this._btnCorrelation.enterSeId = ButtonBase.SE_CURSOR_ID;
            TextControl.setIdText(this._mcStatus.detailTubMc.correlationBtnMc.textMc.textDt, MessageId.PLAYER_DETAIL_BUTTON_CHART_DETAIL);
            this._aButton.push(this._btnCorrelation);
            TextControl.setIdText(this._mcStatus.magnifyBtnMc.textMc.textDt, MessageId.PLAYER_DETAIL_BUTTON_ZOOM);
            var _loc_7:* = ButtonManager.getInstance().addButton(this._mcStatus.magnifyBtnMc, this.cbZoomBtn);
            ButtonManager.getInstance().addButton(this._mcStatus.magnifyBtnMc, this.cbZoomBtn).enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aButton.push(_loc_7);
            if (this._type != STATUS_TYPE_ALBUM)
            {
                _loc_8 = 0;
                while (_loc_8 < _SKILL_LIST_NUM)
                {
                    
                    TextControl.setIdText(this._mcStatus.accessoriesTubMc.getChildByName("skillChange" + (_loc_8 + 1) + "BtnMc").textMc.textDt, MessageId.PLAYER_DETAIL_BUTTON_EQUIPMENT_CHANGE);
                    _loc_9 = ButtonManager.getInstance().addButton(this._mcStatus.accessoriesTubMc.getChildByName("skillChange" + (_loc_8 + 1) + "BtnMc"), this.cbSkillChangeBtn, _loc_8);
                    _loc_9.setDisable(this._type != STATUS_TYPE_EQUIPMENT);
                    _loc_9.enterSeId = ButtonBase.SE_CURSOR_ID;
                    this._aChangeButton.push(_loc_9);
                    TextControl.setIdText(this._mcStatus.accessoriesTubMc.getChildByName("skillRemove" + (_loc_8 + 1) + "BtnMc").textMc.textDt, MessageId.PLAYER_DETAIL_BUTTON_EQUIPMENT_REMOVE);
                    _loc_10 = ButtonManager.getInstance().addButton(this._mcStatus.accessoriesTubMc.getChildByName("skillRemove" + (_loc_8 + 1) + "BtnMc"), this.cbSkillRemoveBtn, _loc_8);
                    _loc_10.setDisable(this._type != STATUS_TYPE_EQUIPMENT);
                    _loc_10.enterSeId = ButtonBase.SE_CURSOR_ID;
                    this._aRemoveButton.push(_loc_10);
                    _loc_8++;
                }
                _loc_8 = 0;
                while (_loc_8 < _ITEM_LIST_NUM)
                {
                    
                    TextControl.setIdText(this._mcStatus.accessoriesTubMc.getChildByName("equippedChange" + (_loc_8 + 1) + "BtnMc").textMc.textDt, MessageId.PLAYER_DETAIL_BUTTON_EQUIPMENT_CHANGE);
                    _loc_11 = ButtonManager.getInstance().addButton(this._mcStatus.accessoriesTubMc.equippedChange1BtnMc, this.cbAcceChangeBtn, _loc_8);
                    _loc_11.setDisable(this._type != STATUS_TYPE_EQUIPMENT);
                    _loc_11.enterSeId = ButtonBase.SE_CURSOR_ID;
                    this._aChangeButton.push(_loc_11);
                    TextControl.setIdText(this._mcStatus.accessoriesTubMc.getChildByName("equippedRemove" + (_loc_8 + 1) + "BtnMc").textMc.textDt, MessageId.PLAYER_DETAIL_BUTTON_EQUIPMENT_REMOVE);
                    _loc_12 = ButtonManager.getInstance().addButton(this._mcStatus.accessoriesTubMc.equippedRemove1BtnMc, this.cbAcceRemoveBtn, _loc_8);
                    _loc_12.setDisable(this._type != STATUS_TYPE_EQUIPMENT);
                    _loc_12.enterSeId = ButtonBase.SE_CURSOR_ID;
                    this._aRemoveButton.push(_loc_12);
                    _loc_8++;
                }
                this._aEquipmentBox.push(new EquipmentTextBox(this._mcStatus.accessoriesTubMc.skillSet1Mc));
                this._aEquipmentBox.push(new EquipmentTextBox(this._mcStatus.accessoriesTubMc.skillSet2Mc));
                this._aEquipmentBox.push(new EquipmentTextBox(this._mcStatus.accessoriesTubMc.skillSet3Mc));
                this._aEquipmentBox.push(new EquipmentTextBox(this._mcStatus.accessoriesTubMc.equippedSet1Mc));
                TextControl.setIdText(this._mcStatus.accessoriesTubMc.equipWakuText1Mc.ArtsNameTextMc.textDt, MessageId.COMMON_EMPTY);
                TextControl.setIdText(this._mcStatus.accessoriesTubMc.equipWakuText2Mc.ArtsNameTextMc.textDt, MessageId.COMMON_EMPTY);
                TextControl.setIdText(this._mcStatus.accessoriesTubMc.equipWakuText3Mc.ArtsNameTextMc.textDt, MessageId.COMMON_EMPTY);
                TextControl.setIdText(this._mcStatus.accessoriesTubMc.equippedItemNonMc.ArtsNameTextMc.textDt, MessageId.COMMON_EMPTY);
                if (this._mcStatus.detailTubMc.ResetBtnMc)
                {
                    this._btnGrowthReset = ButtonManager.getInstance().addButton(this._mcStatus.detailTubMc.ResetBtnMc, this.cbGrowthResetBtn);
                    this._btnGrowthReset.enterSeId = ButtonBase.SE_CURSOR_ID;
                    this._btnGrowthReset.setDisable(true);
                    TextControl.setIdText(this._mcStatus.detailTubMc.ResetBtnMc.textMc.textDt, MessageId.PLAYER_DETAIL_GROWTH_RESET_BUTTON);
                }
            }
            if (this._type != STATUS_TYPE_ALBUM && this._mcStatus.detailTubMc.GraphGrowth)
            {
                this.drawBgLine();
                this._growthCurveLine = new Shape();
                this._mcStatus.detailTubMc.GraphGrowth.addChild(this._growthCurveLine);
                if (this._type != STATUS_TYPE_HISTORY)
                {
                    this._growthCurveEndMark = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", "GraphGrowMarkMc");
                    this._mcStatus.detailTubMc.addChild(this._growthCurveEndMark);
                }
            }
            this._fadeMain = new Fade(this._parent);
            this._fadeMain.maxAlpha = 0.5;
            this._fadeMain.setFadeIn(0);
            if (this._type != STATUS_TYPE_ALBUM)
            {
                this._skillSimpleStatus = new SkillSimpleStatus(this._mcBase);
                this._equipSimpleStatus = new EquipSimpleStatus(this._mcBase);
            }
            else
            {
                this._skillSimpleStatus = null;
                this._equipSimpleStatus = null;
            }
            if (this._type == STATUS_TYPE_EQUIPMENT)
            {
                this._fadeEquipmentPopup = new Fade(this._mcBase);
                this._fadeEquipmentPopup.maxAlpha = 0.5;
                this._fadeEquipmentPopup.setFadeIn(0);
                this._skillSelecter = new PlayerSkillSelecter(this._mcBase, param4, this.cbSkillSelecterClose);
            }
            else
            {
                this._fadeEquipmentPopup = null;
                this._skillSelecter = null;
            }
            this._viewer = null;
            this._growthReset = null;
            TextControl.setIdText(this._mcStatus.detailTubMc.correlationHdTextMc.textDt, MessageId.PLAYER_DETAIL_BUTTON_CORRELATION_CHART);
            TextControl.setIdText(this._mcStatus.detailTubMc.resistName1TextMc.textDt, MessageId.RESIST_TYPE_SWORD);
            TextControl.setIdText(this._mcStatus.detailTubMc.resistName2TextMc.textDt, MessageId.RESIST_TYPE_BLOW);
            TextControl.setIdText(this._mcStatus.detailTubMc.resistName3TextMc.textDt, MessageId.RESIST_TYPE_THRUST);
            TextControl.setIdText(this._mcStatus.detailTubMc.resistName4TextMc.textDt, MessageId.RESIST_TYPE_SHOOT);
            TextControl.setIdText(this._mcStatus.detailTubMc.resistName5TextMc.textDt, MessageId.RESIST_TYPE_HEAT);
            TextControl.setIdText(this._mcStatus.detailTubMc.resistName6TextMc.textDt, MessageId.RESIST_TYPE_COLD);
            TextControl.setIdText(this._mcStatus.detailTubMc.resistName7TextMc.textDt, MessageId.RESIST_TYPE_THUNDER);
            TextControl.setIdText(this._mcStatus.typeTextMc.textDt, MessageId.COMMON_WEAPON_TYPE);
            TextControl.setIdText(this._mcStatus.attributeTextMc.textDt, MessageId.COMMON_MAGIC_TYPE);
            if (this._type != STATUS_TYPE_ALBUM)
            {
                TextControl.setIdText(this._mcStatus.accessoriesTubMc.SkillHeaderTextMc.textDt, MessageId.PLAYER_DETAIL_EQUIPMENT_SKILL);
                TextControl.setIdText(this._mcStatus.accessoriesTubMc.equippedHeaderTextMc.textDt, MessageId.PLAYER_DETAIL_EQUIPMENT_ACCESSORIES);
                TextControl.setIdText(this._mcStatus.detailTubMc.growth1TextMc.textDt, MessageId.PLAYER_DETAIL_STATUS_VALUE);
                TextControl.setIdText(this._mcStatus.detailTubMc.growth2TextMc.textDt, MessageId.PLAYER_DETAIL_USE_COUNT);
                TextControl.setIdText(this._mcStatus.detailTubMc.resultNameTextMc.textDt, MessageId.PLAYER_DETAIL_USE_COUNT);
                TextControl.setIdText(this._mcStatus.detailTubMc.growthTypeHdTextMc.textDt, MessageId.COMMON_STATUS_GROWTH_TYPE);
            }
            this.setStatusByPersonal(param4, param5);
            this._parent.addChild(this._mcBase);
            this._isoMain = new InStayOut(this._mcBase);
            this._mcBase.visible = false;
            this.disableButton(true);
            this._phase = _PHASE_CLOSE;
            return;
        }// end function

        public function getItemData(param1:int) : OwnItemData
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aItemData)
            {
                
                if (_loc_2.itemId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function get statusResult() : PlayerDetailStatusResult
        {
            return this._statusResult;
        }// end function

        private function set _bUpdate(param1:Boolean) : void
        {
            this._statusResult.bUpdate = param1;
            return;
        }// end function

        public function get bUpdate() : Boolean
        {
            return this._statusResult.bUpdate;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain && this._isoMain.bClosed && (this._fadeMain && this._fadeMain.isFadeEnd());
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._fadeMain)
            {
                this._fadeMain.release();
            }
            this._fadeMain = null;
            if (this._fadeEquipmentPopup)
            {
                this._fadeEquipmentPopup.release();
            }
            this._fadeEquipmentPopup = null;
            if (this._growthReset)
            {
                this._growthReset.release();
            }
            this._growthReset = null;
            if (this._viewer)
            {
                this._viewer.release();
            }
            this._viewer = null;
            if (this._skillSelecter)
            {
                this._skillSelecter.release();
            }
            this._skillSelecter = null;
            if (this._skillSimpleStatus)
            {
                this._skillSimpleStatus.release();
            }
            this._skillSimpleStatus = null;
            if (this._equipSimpleStatus)
            {
                this._equipSimpleStatus.release();
            }
            this._equipSimpleStatus = null;
            if (this._correlation)
            {
                this._correlation.release();
            }
            this._correlation = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aButton = null;
            for each (_loc_2 in this._aChangeButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_2);
            }
            this._aChangeButton = null;
            for each (_loc_3 in this._aRemoveButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_3);
            }
            this._aRemoveButton = null;
            if (this._btnGrowthReset)
            {
                ButtonManager.getInstance().removeButton(this._btnGrowthReset);
            }
            this._btnGrowthReset = null;
            for each (_loc_4 in this._aEquipmentBox)
            {
                
                _loc_4.release();
            }
            this._aEquipmentBox = null;
            for each (_loc_5 in this._aCorrelationCharacter)
            {
                
                _loc_5.release();
            }
            this._aCorrelationCharacter = [];
            if (this._mcStand && this._mcStand.parent)
            {
                this._mcStand.parent.removeChild(this._mcStand);
            }
            this._mcStand = null;
            if (this._bmpBustUp && this._bmpBustUp.parent)
            {
                this._bmpBustUp.parent.removeChild(this._bmpBustUp);
            }
            this._bmpBustUp = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            InputManager.getInstance().delMouseCallback(this._mcBase);
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_LOADING:
                {
                    this.initPhaseLoading();
                    break;
                }
                case _PHASE_OPEN:
                {
                    this.initPhaseOpen();
                    break;
                }
                case _PHASE_INPUT_WAIT:
                {
                    this.initPhaseInputWait();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.initPhaseClose();
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
                case _PHASE_LOADING:
                {
                    this.controlPhaseLoading(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._skillSelecter)
            {
                this._skillSelecter.control(param1);
            }
            if (this._viewer)
            {
                this._viewer.control(param1);
            }
            if (this._fadeMain)
            {
                this._fadeMain.control(param1);
            }
            if (this._fadeEquipmentPopup)
            {
                this._fadeEquipmentPopup.control(param1);
            }
            if (this._correlation)
            {
                this._correlation.control(param1);
            }
            return;
        }// end function

        public function initPhaseLoading() : void
        {
            this._fadeMain.setFadeOut(Constant.FADE_OUT_TIME);
            return;
        }// end function

        public function controlPhaseLoading(param1:Number) : void
        {
            if (ResourceManager.getInstance().isLoaded())
            {
                this.setPhase(_PHASE_OPEN);
            }
            return;
        }// end function

        public function initPhaseOpen() : void
        {
            var pInfo:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            this.createBustUp();
            this.setDiagramData(pInfo);
            this._mcBase.visible = true;
            this._isoMain.setIn(function () : void
            {
                setPhase(_PHASE_INPUT_WAIT);
                return;
            }// end function
            );
            return;
        }// end function

        public function initPhaseInputWait() : void
        {
            this.updateGrowthCurve();
            this.disableButton(false);
            InputManager.getInstance().addMouseCallback(this._mcBase, this.cbMouseMove);
            return;
        }// end function

        public function initPhaseClose() : void
        {
            this.disableButton(true);
            if (this._growthCurveLine)
            {
                this._growthCurveLine.graphics.clear();
            }
            if (this._growthCurveEndMark)
            {
                this._growthCurveEndMark.visible = false;
            }
            InputManager.getInstance().delMouseCallback(this._mcBase);
            this._fadeMain.setFadeIn(Constant.FADE_IN_TIME);
            if (this._correlation && this._correlation.isOpen)
            {
                this._correlation.close();
            }
            this._isoMain.setOut(function () : void
            {
                _mcBase.visible = false;
                if (_cbClose != null)
                {
                    if (_personalPtr)
                    {
                        _cbClose(_personalPtr.uniqueId);
                    }
                    else
                    {
                        _cbClose();
                    }
                }
                return;
            }// end function
            );
            return;
        }// end function

        public function open() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            this._bUpdate = false;
            var _loc_1:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_BUSTUP_PATH + _loc_1.bustUpFileName);
            if (_loc_1.diagramFileName != "Dummy")
            {
                ResourceManager.getInstance().loadResource(ResourcePath.CORRELATION_SHEET_PATH + _loc_1.diagramFileName);
            }
            for each (_loc_2 in _loc_1.aDiagramCharaId)
            {
                
                if (_loc_2 == 0)
                {
                    continue;
                }
                _loc_3 = UserDataManager.getInstance().userData.getCorrelationInfo(_loc_2);
                _loc_4 = "";
                if (_loc_3 != null)
                {
                    _loc_4 = _loc_3.swf;
                }
                else
                {
                    _loc_5 = PlayerManager.getInstance().getPlayerInformationByCharacterId(_loc_2);
                    _loc_4 = _loc_5.swf;
                }
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_4);
            }
            PlayerBigCard.loadResource();
            this.setPhase(_PHASE_LOADING);
            return;
        }// end function

        public function close() : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        public function disableButton(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = false;
            for each (_loc_2 in this._aButton)
            {
                
                _loc_2.setDisableFlag(param1);
            }
            for each (_loc_2 in this._aChangeButton)
            {
                
                _loc_2.setDisableFlag(this._type != STATUS_TYPE_EQUIPMENT || param1);
            }
            for each (_loc_2 in this._aRemoveButton)
            {
                
                _loc_2.setDisableFlag(param1);
            }
            if (this._btnCorrelation)
            {
                _loc_3 = param1;
                if (this._bCorrelation == false)
                {
                    _loc_3 = true;
                }
                this._btnCorrelation.setDisable(_loc_3);
            }
            if (!param1)
            {
                this.updateEquipmentButton();
            }
            this.updateGrowthResetButton(!param1);
            return;
        }// end function

        public function setStatusByPersonal(param1:PlayerPersonal, param2:Array) : void
        {
            var _loc_5:* = null;
            this._playerId = Constant.EMPTY_ID;
            this._personalPtr = param1;
            this._aItemData = param2;
            if (this._aItemData == null)
            {
                this._aItemData = [];
            }
            if (this._personalPtr == null)
            {
                return;
            }
            this._playerId = this._personalPtr.playerId;
            var _loc_3:* = UserDataManager.getInstance().userData;
            var _loc_4:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            this._bCorrelation = _loc_4.diagramName != "" && _loc_4.diagramName != "Dummy";
            (this._mcStatus.emperorMarkMc as MovieClip).visible = _loc_3.emperorId == _loc_4.id;
            TextControl.setText(this._mcStatus.characterNameMc.textDt, _loc_4.name);
            TextControl.setIdText(this._mcStatus.status1TextMc.textDt, MessageId.COMMON_STATUS_HP);
            TextControl.setIdText(this._mcStatus.status2TextMc.textDt, MessageId.COMMON_STATUS_LP);
            TextControl.setIdText(this._mcStatus.status3TextMc.textDt, MessageId.COMMON_STATUS_SP);
            TextControl.setIdText(this._mcStatus.status4TextMc.textDt, MessageId.COMMON_STATUS_ATTACK);
            TextControl.setIdText(this._mcStatus.status5TextMc.textDt, MessageId.COMMON_STATUS_DEFENSE);
            TextControl.setIdText(this._mcStatus.status6TextMc.textDt, MessageId.COMMON_STATUS_SPEED);
            this.updateBasicStatus();
            TextControl.setText(this._mcStatus.detailTubMc.growthTypeTextMc.textDt, "");
            if (this._personalPtr.battleCount <= 999)
            {
                TextControl.setText(this._mcStatus.detailTubMc.resultNumTextMc.textDt, this._personalPtr.battleCount.toString());
            }
            else
            {
                _loc_5 = new ColorTransform();
                _loc_5.color = 14172738;
                TextControl.setText(this._mcStatus.detailTubMc.resultNumTextMc.textDt, "999", true, _loc_5);
            }
            this.updateStatusCommon();
            this.updateEquipment();
            if (BuildSwitch.SW_EMPEROR_SKILL)
            {
                TextControl.setText(this._mcStatus.emperorSkillMc.textMc.textDt, PlayerManager.getInstance().getEmperorSkillEffectsText(_loc_4, PlayerManager.getInstance().getEmperorSkillEffectsBonus(this._personalPtr, _loc_4)));
            }
            else
            {
                TextControl.setText(this._mcStatus.emperorSkillMc.textMc.textDt, "");
                this._mcStatus.emperorSkillMc.visible = false;
            }
            if (_loc_4.hasCommanderSkill())
            {
                TextControl.setText(this._mcStatus.commanderSkillMc.textMc.textDt, PlayerManager.getInstance().getCommanderSkillEffectsText(_loc_4));
                this._mcStatus.commanderSkillMc.visible = true;
            }
            else
            {
                TextControl.setText(this._mcStatus.commanderSkillMc.textMc.textDt, "");
                this._mcStatus.commanderSkillMc.visible = false;
            }
            return;
        }// end function

        public function setStatusByPlayerId(param1:int) : void
        {
            this._playerId = param1;
            this._personalPtr = null;
            this._aItemData = [];
            (this._mcStatus.emperorMarkMc as MovieClip).visible = false;
            var _loc_2:* = UserDataManager.getInstance().userData;
            var _loc_3:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            this._bCorrelation = _loc_3.diagramName != "" && _loc_3.diagramName != "Dummy";
            TextControl.setIdText(this._mcStatus.status1TextMc.textDt, MessageId.COMMON_STATUS_HP);
            TextControl.setIdText(this._mcStatus.status2TextMc.textDt, MessageId.COMMON_STATUS_LP);
            TextControl.setIdText(this._mcStatus.status3TextMc.textDt, MessageId.COMMON_STATUS_ATTACK);
            TextControl.setIdText(this._mcStatus.status4TextMc.textDt, MessageId.COMMON_STATUS_DEFENSE);
            TextControl.setIdText(this._mcStatus.status5TextMc.textDt, MessageId.COMMON_STATUS_SPEED);
            var _loc_4:* = String(_loc_3.hp + "/" + _loc_3.hp);
            var _loc_5:* = String(_loc_3.lp + "/" + _loc_3.lp);
            TextControl.setText(this._mcStatus.statusNum1TextMc.textDt, _loc_4);
            TextControl.setText(this._mcStatus.statusNum2TextMc.textDt, _loc_5);
            TextControl.setText(this._mcStatus.statusNum3TextMc.textDt, _loc_3.attack.toString());
            TextControl.setText(this._mcStatus.statusNum4TextMc.textDt, _loc_3.defense.toString());
            TextControl.setText(this._mcStatus.statusNum5TextMc.textDt, _loc_3.speed.toString());
            TextControl.setText(this._mcStatus.detailTubMc.resist1TextMc.textMc.textDt, "" + BattleToleranceData.dispRate(_loc_3.getDefenseToleranceRate(CharacterConstant.ATTRIBUTE_SLASH)));
            TextControl.setText(this._mcStatus.detailTubMc.resist2TextMc.textMc.textDt, "" + BattleToleranceData.dispRate(_loc_3.getDefenseToleranceRate(CharacterConstant.ATTRIBUTE_PUNCH)));
            TextControl.setText(this._mcStatus.detailTubMc.resist3TextMc.textMc.textDt, "" + BattleToleranceData.dispRate(_loc_3.getDefenseToleranceRate(CharacterConstant.ATTRIBUTE_THRUST)));
            TextControl.setText(this._mcStatus.detailTubMc.resist4TextMc.textMc.textDt, "");
            TextControl.setText(this._mcStatus.detailTubMc.resist5TextMc.textMc.textDt, "" + BattleToleranceData.dispRate(_loc_3.getDefenseToleranceRate(CharacterConstant.ATTRIBUTE_HEAT)));
            TextControl.setText(this._mcStatus.detailTubMc.resist6TextMc.textMc.textDt, "" + BattleToleranceData.dispRate(_loc_3.getDefenseToleranceRate(CharacterConstant.ATTRIBUTE_ICY)));
            TextControl.setText(this._mcStatus.detailTubMc.resist7TextMc.textMc.textDt, "" + BattleToleranceData.dispRate(_loc_3.getDefenseToleranceRate(CharacterConstant.ATTRIBUTE_THUNDER)));
            if (this._type != STATUS_TYPE_ALBUM)
            {
                TextControl.setText(this._mcStatus.statusSubNum1TextMc.textDt, "");
                TextControl.setText(this._mcStatus.statusSubNum2TextMc.textDt, "");
                TextControl.setText(this._mcStatus.statusSubNum3TextMc.textDt, "");
                TextControl.setText(this._mcStatus.statusSubNum4TextMc.textDt, "");
                TextControl.setText(this._mcStatus.statusSubNum5TextMc.textDt, "");
                this._mcStatus.statusSubNum1TextMc.visible = false;
                this._mcStatus.statusSubNum2TextMc.visible = false;
                this._mcStatus.statusSubNum3TextMc.visible = false;
                this._mcStatus.statusSubNum4TextMc.visible = false;
                this._mcStatus.statusSubNum5TextMc.visible = false;
                TextControl.setIdText(this._mcStatus.status6TextMc.textDt, MessageId.COMMON_STATUS_GROWTH);
                (this._mcStatus.conditionMc as MovieClip).gotoAndStop(1);
                TextControl.setText(this._mcStatus.detailTubMc.resultNumTextMc.textDt, "0");
            }
            else
            {
                TextControl.setIdText(this._mcStatus.status6TextMc.textDt, MessageId.COMMON_STATUS_GROWTH_TYPE);
                TextControl.setText(this._mcStatus.growTypeTextMc.textDt, "");
            }
            if (BuildSwitch.SW_EMPEROR_SKILL)
            {
                TextControl.setText(this._mcStatus.emperorSkillMc.textMc.textDt, PlayerManager.getInstance().getEmperorSkillEffectsText(_loc_3, PlayerManager.getInstance().getEmperorSkillEffectsBonus(null, _loc_3)));
            }
            else
            {
                TextControl.setText(this._mcStatus.emperorSkillMc.textMc.textDt, "");
                this._mcStatus.emperorSkillMc.visible = false;
            }
            if (_loc_3.hasCommanderSkill())
            {
                TextControl.setText(this._mcStatus.commanderSkillMc.textMc.textDt, PlayerManager.getInstance().getCommanderSkillEffectsText(_loc_3));
                this._mcStatus.commanderSkillMc.visible = true;
            }
            else
            {
                TextControl.setText(this._mcStatus.commanderSkillMc.textMc.textDt, "");
                this._mcStatus.commanderSkillMc.visible = false;
            }
            this.updateStatusCommon();
            return;
        }// end function

        private function createBustUp() : void
        {
            var _loc_1:* = null;
            if (this._bmpBustUp == null)
            {
                _loc_1 = PlayerManager.getInstance().getPlayerInformation(this._playerId);
                this._bmpBustUp = ResourceManager.getInstance().createBitmap(ResourcePath.PLAYER_BUSTUP_PATH + _loc_1.bustUpFileName);
                this._bmpBustUp.smoothing = true;
                this._bmpBustUp.x = this._bmpBustUp.x - this._bmpBustUp.width / 2;
                this._bmpBustUp.y = this._bmpBustUp.y - this._bmpBustUp.height;
                (this._mcStatus.bigCharacterNull as MovieClip).addChild(this._bmpBustUp);
            }
            return;
        }// end function

        private function updateStatusCommon() : void
        {
            var _loc_1:* = UserDataManager.getInstance().userData;
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            if (this._bmpBustUp)
            {
                this._bmpBustUp.parent.removeChild(this._bmpBustUp);
            }
            this._bmpBustUp = null;
            TextControl.setText(this._mcStatus.characterNameMc.textDt, _loc_2.name);
            var _loc_3:* = new WeaponTypeIcon(this._mcStatus.weaponTypeMc, _loc_2.weaponType);
            var _loc_4:* = new MagicTypeIcon(this._mcStatus.attributeTypeSetMc, _loc_2.magicType);
            var _loc_5:* = new PlayerRarityIcon(this._mcStatus.setCharaRankMc, _loc_2.rarity);
            TextControl.setText(this._mcStatus.categoryTextMc.textDt, PlayerManager.getInstance().getPlayerTagName(_loc_2));
            this.updateGrowthCurve();
            return;
        }// end function

        private function updateBasicStatus() : void
        {
            var pInfo:PlayerInformation;
            var aDefToleranceTotal:Array;
            pInfo = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            var bEmperor:* = this._personalPtr && this._personalPtr.isEmperor();
            var hpStr:* = String(this._personalPtr.getHpAtResting() + "/" + this._personalPtr.hpMax);
            var lpStr:* = bEmperor ? ("-") : (String(this._personalPtr.lp + "/" + pInfo.lp));
            var spStr:* = String(this._personalPtr.sp + "/" + this._personalPtr.spMax);
            TextControl.setText(this._mcStatus.statusNum1TextMc.textDt, hpStr);
            TextControl.setText(this._mcStatus.statusNum2TextMc.textDt, lpStr);
            TextControl.setText(this._mcStatus.statusNum3TextMc.textDt, spStr);
            TextControl.setText(this._mcStatus.statusNum4TextMc.textDt, this._personalPtr.attackTotal.toString());
            TextControl.setText(this._mcStatus.statusNum5TextMc.textDt, this._personalPtr.defenseTotal.toString());
            TextControl.setText(this._mcStatus.statusNum6TextMc.textDt, this._personalPtr.speedTotal.toString());
            TextControl.setBonusText(this._mcStatus.statusSubNum1TextMc, this._personalPtr.isBonusAttack(), this._personalPtr.bonusAttackTotal);
            TextControl.setBonusText(this._mcStatus.statusSubNum2TextMc, this._personalPtr.isBonusDefense(), this._personalPtr.bonusDefenseTotal);
            TextControl.setBonusText(this._mcStatus.statusSubNum3TextMc, this._personalPtr.isBonusSpeed(), this._personalPtr.bonusSpeedTotal);
            aDefToleranceTotal = this._personalPtr.getDefenseToleranceTotal();
            var bonusToleranceFunc:* = function (param1:MovieClip, param2:Boolean, param3:int) : void
            {
                var _loc_4:* = null;
                var _loc_5:* = 0;
                var _loc_6:* = 0;
                var _loc_7:* = 0;
                for each (_loc_4 in aDefToleranceTotal)
                {
                    
                    if (_loc_4.toleranceId == param3)
                    {
                        _loc_5 = _loc_4.rate;
                        _loc_6 = pInfo.getDefenseToleranceRate(param3);
                        _loc_7 = BattleToleranceData.dispRate(_loc_5);
                        param1.gotoAndStop(param2 ? (_loc_5 < _loc_6 ? ("down") : ("up")) : ("normal"));
                        TextControl.setText(param1.textMc.textDt, _loc_5 < 0 ? ("-" + (-_loc_7)) : (_loc_7.toString()));
                        return;
                    }
                }
                return;
            }// end function
            ;
            this.bonusToleranceFunc(this._mcStatus.detailTubMc.resist1TextMc, this._personalPtr.isBonusDefenseTolerance(CharacterConstant.ATTRIBUTE_SLASH), CharacterConstant.ATTRIBUTE_SLASH);
            this.bonusToleranceFunc(this._mcStatus.detailTubMc.resist2TextMc, this._personalPtr.isBonusDefenseTolerance(CharacterConstant.ATTRIBUTE_PUNCH), CharacterConstant.ATTRIBUTE_PUNCH);
            this.bonusToleranceFunc(this._mcStatus.detailTubMc.resist3TextMc, this._personalPtr.isBonusDefenseTolerance(CharacterConstant.ATTRIBUTE_THRUST), CharacterConstant.ATTRIBUTE_THRUST);
            TextControl.setText(this._mcStatus.detailTubMc.resist4TextMc.textMc.textDt, "");
            this.bonusToleranceFunc(this._mcStatus.detailTubMc.resist5TextMc, this._personalPtr.isBonusDefenseTolerance(CharacterConstant.ATTRIBUTE_HEAT), CharacterConstant.ATTRIBUTE_HEAT);
            this.bonusToleranceFunc(this._mcStatus.detailTubMc.resist6TextMc, this._personalPtr.isBonusDefenseTolerance(CharacterConstant.ATTRIBUTE_ICY), CharacterConstant.ATTRIBUTE_ICY);
            this.bonusToleranceFunc(this._mcStatus.detailTubMc.resist7TextMc, this._personalPtr.isBonusDefenseTolerance(CharacterConstant.ATTRIBUTE_THUNDER), CharacterConstant.ATTRIBUTE_THUNDER);
            return;
        }// end function

        private function setDiagramData(param1:PlayerInformation) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            for each (_loc_2 in this._aCorrelationCharacter)
            {
                
                _loc_2.release();
            }
            this._aCorrelationCharacter = [];
            if (param1.diagramType == 0)
            {
                this._mcStatus.detailTubMc.CorrelationPicMC.visible = false;
                return;
            }
            this._mcStatus.detailTubMc.CorrelationPicMC.gotoAndStop("type" + param1.diagramType.toString());
            var _loc_3:* = 0;
            while (_loc_3 < param1.aDiagramCharaId.length)
            {
                
                _loc_4 = param1.aDiagramCharaId[_loc_3];
                _loc_5 = this._mcStatus.detailTubMc.CorrelationPicMC.getChildByName("character" + int((_loc_3 + 1)).toString() + "Null") as MovieClip;
                if (_loc_4 != 0 && _loc_5 != null)
                {
                    _loc_6 = UserDataManager.getInstance().userData.getCorrelationInfo(_loc_4);
                    if (_loc_6 != null)
                    {
                        _loc_2 = new PlayerDisplay(_loc_5, _loc_6.playerId, 0);
                    }
                    else
                    {
                        _loc_7 = PlayerManager.getInstance().getPlayerInformationByCharacterId(_loc_4);
                        if (_loc_7 != null)
                        {
                            _loc_2 = new PlayerDisplay(_loc_5, _loc_7.id, 0);
                        }
                    }
                    if (_loc_2 != null)
                    {
                        this._aCorrelationCharacter.push(_loc_2);
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

        private function updateEquipment() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (this._personalPtr == null)
            {
                return;
            }
            var _loc_3:* = this._personalPtr.aSetSkillId;
            _loc_2 = 0;
            while (_loc_2 < _loc_3.length)
            {
                
                if (_loc_2 < this._aEquipmentBox.length)
                {
                    _loc_1 = this._aEquipmentBox[_loc_2] as EquipmentTextBox;
                    if (this._type == STATUS_TYPE_HISTORY)
                    {
                        _loc_5 = new OwnSkillData({skillId:_loc_3[_loc_2]});
                    }
                    else
                    {
                        _loc_5 = this._personalPtr.getOwnSkillData(_loc_3[_loc_2]);
                    }
                    _loc_1.setEquipmentData(EquipmentTextBox.EQUIPMENT_TARGET_SKILL, _loc_5);
                }
                _loc_2++;
            }
            var _loc_4:* = this._personalPtr.aSetItemId;
            _loc_2 = 0;
            while (_loc_2 < _loc_4.length)
            {
                
                _loc_6 = _loc_2 + _loc_3.length;
                if (_loc_6 < this._aEquipmentBox.length)
                {
                    _loc_1 = this._aEquipmentBox[_loc_6] as EquipmentTextBox;
                    if (this._type == STATUS_TYPE_HISTORY)
                    {
                        _loc_7 = new OwnItemData(_loc_4[_loc_2], CommonConstant.ITEM_KIND_ACCESSORIES, 1);
                    }
                    else
                    {
                        _loc_7 = this.getItemData(_loc_4[_loc_2]);
                    }
                    _loc_8 = null;
                    if (_loc_7 && _loc_7.itemId != Constant.EMPTY_ID)
                    {
                        _loc_8 = ItemManager.getInstance().getItemInformation(_loc_7.itemId);
                    }
                    if (_loc_8)
                    {
                        _loc_1.setCanEquipped(this._personalPtr.canEquippedAccessories(_loc_8));
                        _loc_1.setSpecial(_loc_8 && _loc_8.bSpecialItem);
                    }
                    else
                    {
                        _loc_1.setCanEquipped(true);
                        _loc_1.setSpecial(false);
                    }
                    _loc_1.setEquipmentData(EquipmentTextBox.EQUIPMENT_TARGET_ITEM, _loc_7);
                }
                _loc_2++;
            }
            this.updateEquipmentButton();
            return;
        }// end function

        private function updateEquipmentButton() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this._personalPtr == null)
            {
                return;
            }
            _loc_1 = 0;
            while (_loc_1 < this._personalPtr.aSetSkillId.length)
            {
                
                if (_loc_1 < this._aRemoveButton.length)
                {
                    (this._aRemoveButton[_loc_1] as ButtonBase).setDisable((this._aEquipmentBox[_loc_1] as EquipmentTextBox).id == Constant.EMPTY_ID || this._type != STATUS_TYPE_EQUIPMENT);
                }
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this._personalPtr.aSetItemId.length)
            {
                
                _loc_2 = _loc_1 + this._personalPtr.aSetSkillId.length;
                if (_loc_2 < this._aRemoveButton.length)
                {
                    (this._aRemoveButton[_loc_2] as ButtonBase).setDisable((this._aEquipmentBox[_loc_2] as EquipmentTextBox).id == Constant.EMPTY_ID || this._type != STATUS_TYPE_EQUIPMENT);
                }
                _loc_1++;
            }
            return;
        }// end function

        private function updateGrowthResetButton(param1:Boolean) : void
        {
            if (this._btnGrowthReset)
            {
                this._btnGrowthReset.setDisable(!param1 || this._type != STATUS_TYPE_EQUIPMENT || this._personalPtr == null || this._personalPtr.battleCount <= 0);
            }
            return;
        }// end function

        private function updateGrowthCurve() : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            if (this._growthCurveLine == null)
            {
                return;
            }
            var _loc_1:* = UserDataManager.getInstance().userData;
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            var _loc_3:* = null;
            if (this._personalPtr)
            {
                for each (_loc_5 in _loc_1.aGrowthCurve)
                {
                    
                    if (_loc_5.uniqueId == this._personalPtr.uniqueId)
                    {
                        _loc_3 = _loc_5;
                        break;
                    }
                }
            }
            var _loc_4:* = 0;
            if (this._type == STATUS_TYPE_HISTORY)
            {
                _loc_3 = null;
                _loc_6 = _loc_2.attack + _loc_2.defense + _loc_2.speed + _loc_2.hp;
                _loc_4 = this._personalPtr.attack + this._personalPtr.defense + this._personalPtr.speed + this._personalPtr.hp - _loc_6;
            }
            this.drawGrowthCurve(_loc_4, _loc_3, PlayerManager.getInstance().getGrowthEndBattleCount(_loc_2));
            return;
        }// end function

        private function drawGrowthCurve(param1:int, param2:GrowthCurveData, param3:int) : void
        {
            var startPos:Point;
            var pos:Point;
            var i:int;
            var totalParam:* = param1;
            var growthCurve:* = param2;
            var battleCountEnd:* = param3;
            startPos = new Point(this.DRAW_X, this.DRAW_Y);
            var offset:* = this.DRAW_WIDTH * 0.9 / this.COUNT_MAX;
            var sum:* = totalParam;
            pos = startPos.clone();
            var setPosY:* = function (param1:int) : void
            {
                var _loc_2:* = param1 / VALUE_RANGE_MAX;
                pos.y = startPos.y - DRAW_HEIGHT * _loc_2;
                return;
            }// end function
            ;
            var g:* = this._growthCurveLine.graphics;
            g.clear();
            this.setPosY(sum);
            g.moveTo(pos.x, pos.y);
            battleCountEnd = this._personalPtr.battleCount <= battleCountEnd ? (this._personalPtr.battleCount) : (battleCountEnd);
            if (battleCountEnd > this.COUNT_MAX)
            {
                battleCountEnd = this.COUNT_MAX;
            }
            if (growthCurve)
            {
                g.lineStyle(2, 187, 1);
                i;
                while (i < battleCountEnd)
                {
                    
                    if (i < growthCurve.aGrowth.length)
                    {
                        sum = sum + growthCurve.aGrowth[i];
                        this.setPosY(sum);
                    }
                    pos.x = pos.x + offset;
                    g.lineTo(pos.x, pos.y);
                    i = (i + 1);
                }
            }
            else
            {
                i;
                while (i < battleCountEnd)
                {
                    
                    pos.x = pos.x + offset;
                    g.moveTo(pos.x, pos.y);
                    i = (i + 1);
                }
            }
            g.beginFill(187);
            g.drawRect(pos.x - 2, pos.y - 2, 4, 4);
            g.endFill();
            if (this._personalPtr)
            {
                if (this._growthCurveEndMark)
                {
                    this._growthCurveEndMark.visible = true;
                    pos = this._growthCurveLine.parent.localToGlobal(pos);
                    pos = this._growthCurveEndMark.parent.globalToLocal(pos);
                    this._growthCurveEndMark.x = pos.x;
                    this._growthCurveEndMark.y = pos.y - 3;
                    this._growthCurveEndMark.gotoAndStop(this._personalPtr.getGrowthLabel());
                }
            }
            else if (this._growthCurveEndMark)
            {
                this._growthCurveEndMark.visible = false;
            }
            return;
        }// end function

        private function drawBgLine() : void
        {
            var _loc_1:* = this._mcStatus.detailTubMc.GraphLine;
            this.createSideLine(_loc_1, this.DRAW_HEIGHT * 0.25);
            this.createSideLine(_loc_1, this.DRAW_HEIGHT * 0.5);
            this.createSideLine(_loc_1, this.DRAW_HEIGHT * 0.75);
            this.createSideLine(_loc_1, this.DRAW_HEIGHT);
            this.createVertLine(_loc_1, this.DRAW_WIDTH * 0.225);
            this.createVertLine(_loc_1, this.DRAW_WIDTH * 0.45);
            this.createVertLine(_loc_1, this.DRAW_WIDTH * 0.675);
            this.createVertLine(_loc_1, this.DRAW_WIDTH * 0.9);
            return;
        }// end function

        private function createSideLine(param1:DisplayObjectContainer, param2:Number) : MovieClip
        {
            var _loc_3:* = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", "GraphLineSide");
            param1.addChild(_loc_3);
            _loc_3.y = -param2;
            return _loc_3;
        }// end function

        private function createVertLine(param1:DisplayObjectContainer, param2:Number) : MovieClip
        {
            var _loc_3:* = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", "GraphLineHeight");
            param1.addChild(_loc_3);
            _loc_3.x = param2;
            return _loc_3;
        }// end function

        private function cbMouseMove(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (this._skillSelecter && this._skillSelecter.isOpen())
            {
                return;
            }
            if (this._viewer)
            {
                return;
            }
            if (this._aEquipmentBox.length == 0)
            {
                return;
            }
            var _loc_2:* = null;
            for each (_loc_3 in this._aEquipmentBox)
            {
                
                if (!_loc_3.isEmpty() && _loc_3.isHitTest())
                {
                    _loc_2 = _loc_3;
                    for each (_loc_4 in this._aEquipmentBox)
                    {
                        
                        if (_loc_3 != _loc_4)
                        {
                            _loc_4.setSelect(false);
                        }
                    }
                    break;
                    continue;
                }
                _loc_3.setSelect(false);
            }
            if (_loc_2 != null)
            {
                _loc_2.setSelect(true);
                _loc_6 = new Point();
                _loc_7 = new Point();
                if (_loc_2.target == EquipmentTextBox.EQUIPMENT_TARGET_SKILL)
                {
                    if (this._equipSimpleStatus)
                    {
                        this._equipSimpleStatus.hide();
                    }
                    if (this._skillSimpleStatus)
                    {
                        _loc_5 = this._mcStatus.accessoriesTubMc.SkillBalloonAmbitNull;
                        _loc_6.x = _loc_5.x;
                        _loc_6.y = _loc_5.y + (_loc_2.mcBase.y - this._mcStatus.accessoriesTubMc.skillSet1Mc.y);
                        _loc_6 = _loc_5.parent.localToGlobal(_loc_6);
                        _loc_5 = _loc_2.getBalloonNull();
                        if (_loc_5)
                        {
                            _loc_7.x = _loc_5.x;
                            _loc_7.y = _loc_5.y;
                            _loc_7 = _loc_5.parent.localToGlobal(_loc_7);
                        }
                        else
                        {
                            _loc_7.x = _loc_6.x;
                            _loc_7.y = _loc_6.y;
                        }
                        this._skillSimpleStatus.show();
                        this._skillSimpleStatus.setOwnSkillData(_loc_2.getOwnSkillData());
                        this._skillSimpleStatus.setPosition(_loc_6);
                        this._skillSimpleStatus.setArrowTargetPosition(_loc_7);
                    }
                }
                else
                {
                    if (this._skillSimpleStatus)
                    {
                        this._skillSimpleStatus.hide();
                    }
                    if (this._equipSimpleStatus)
                    {
                        _loc_5 = this._mcStatus.accessoriesTubMc.ItemBalloonAmbitNull;
                        _loc_6.x = _loc_5.x;
                        _loc_6.y = _loc_5.y;
                        _loc_6 = _loc_5.parent.localToGlobal(_loc_6);
                        _loc_5 = _loc_2.getBalloonNull();
                        if (_loc_5)
                        {
                            _loc_7.x = _loc_5.x;
                            _loc_7.y = _loc_5.y;
                            _loc_7 = _loc_5.parent.localToGlobal(_loc_7);
                        }
                        else
                        {
                            _loc_7.x = _loc_6.x;
                            _loc_7.y = _loc_6.y;
                        }
                        this._equipSimpleStatus.show();
                        this._equipSimpleStatus.setItemData(_loc_2.id);
                        this._equipSimpleStatus.setPosition(_loc_6);
                        this._equipSimpleStatus.setArrowTargetPosition(_loc_7);
                    }
                }
            }
            else
            {
                if (this._skillSimpleStatus)
                {
                    this._skillSimpleStatus.hide();
                }
                if (this._equipSimpleStatus)
                {
                    this._equipSimpleStatus.hide();
                }
            }
            return;
        }// end function

        private function cbSkillSelecterClose(param1:int, param2:int, param3:int) : void
        {
            if (this._personalPtr == null)
            {
                return;
            }
            this._fadeEquipmentPopup.setFadeIn(Constant.FADE_IN_TIME);
            this.disableButton(false);
            if (param1 == Constant.UNDECIDED)
            {
                return;
            }
            switch(param2)
            {
                case PlayerSkillSelecter.EQUIPMENT_TARGET_SKILL:
                {
                    if (param1 >= 0 && param1 < this._personalPtr.aSetSkillId.length)
                    {
                        if (this._personalPtr.aSetSkillId[param1] != param3)
                        {
                            this._personalPtr.setEquippedSkillId(param1, param3);
                            this._bUpdate = true;
                        }
                    }
                    break;
                }
                case PlayerSkillSelecter.EQUIPMENT_TARGET_ITEM:
                {
                    if (param1 >= 0 && param1 < this._personalPtr.aSetItemId.length)
                    {
                        if (this._personalPtr.aSetItemId[param1] != param3)
                        {
                            this._personalPtr.setEquippedItemId(param1, param3);
                            this._bUpdate = true;
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.updateEquipment();
            this.updateBasicStatus();
            return;
        }// end function

        private function cbSkillChangeBtn(param1:int) : void
        {
            var _loc_2:* = 0;
            this._fadeEquipmentPopup.setFadeOut(Constant.FADE_OUT_TIME);
            this.disableButton(true);
            var _loc_3:* = this._personalPtr.aOwnSkillData;
            this._skillSelecter.setItem(PlayerSkillSelecter.EQUIPMENT_TARGET_SKILL, _loc_3, this._personalPtr.aSetSkillId, (this._aEquipmentBox[param1] as EquipmentTextBox).id);
            this._skillSelecter.open(param1);
            return;
        }// end function

        private function cbSkillRemoveBtn(param1:int) : void
        {
            this._personalPtr.setEquippedSkillId(param1, Constant.EMPTY_ID);
            this._bUpdate = true;
            this.updateEquipment();
            this.updateBasicStatus();
            return;
        }// end function

        private function cbAcceChangeBtn(param1:int) : void
        {
            this._fadeEquipmentPopup.setFadeOut(Constant.FADE_OUT_TIME);
            this.disableButton(true);
            this._skillSelecter.setItem(PlayerSkillSelecter.EQUIPMENT_TARGET_ITEM, this._aItemData, this._personalPtr.aSetItemId, (this._aEquipmentBox[_SKILL_LIST_NUM + param1] as EquipmentTextBox).id);
            this._skillSelecter.open(param1);
            return;
        }// end function

        private function cbAcceRemoveBtn(param1:int) : void
        {
            this._personalPtr.setEquippedItemId(param1, Constant.EMPTY_ID);
            this._bUpdate = true;
            this.updateEquipment();
            this.updateBasicStatus();
            return;
        }// end function

        private function cbDiagramDetailBtn(param1:int) : void
        {
            this.disableButton(true);
            this._correlation = new CorrelationMain(this._parent, this._playerId, this._cbClose, this.cbCloseDiagramDetail);
            return;
        }// end function

        private function cbCloseDiagramDetail() : void
        {
            if (this._correlation)
            {
                this._correlation.release();
            }
            this._correlation = null;
            this.disableButton(false);
            return;
        }// end function

        private function cbZoomBtn(param1:int) : void
        {
            var id:* = param1;
            this.disableButton(true);
            if (this._viewer == null)
            {
                this._viewer = new PlayerCardViewer(this._mcBase, this._playerId, function () : void
            {
                disableButton(false);
                _viewer.release();
                _viewer = null;
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function cbGrowthResetBtn(param1:int) : void
        {
            var id:* = param1;
            this.disableButton(true);
            this._growthReset = new GrowsResetConfirmPopup(this._parent, this._personalPtr, this.cbResetReceive, function (param1:int) : void
            {
                disableButton(false);
                _growthReset.release();
                _growthReset = null;
                if (param1 == GrowsResetConfirmPopup.RESULT_GOTO_TRADING_POST)
                {
                    _statusResult.bGotoTradingPost = true;
                }
                if (param1 == GrowsResetConfirmPopup.RESULT_RESET)
                {
                    _statusResult.bGrowsReset = true;
                }
                if (_statusResult.bGotoTradingPost)
                {
                    close();
                    return;
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function cbResetReceive(param1:NetResult) : void
        {
            if (this._personalPtr == null)
            {
                return;
            }
            var _loc_2:* = UserDataManager.getInstance().userData.getPlayerPersonal(this._personalPtr.uniqueId);
            if (_loc_2)
            {
                this._personalPtr.copyParamOnEdit(_loc_2);
                this.setStatusByPersonal(this._personalPtr, this._aItemData);
                this.createBustUp();
            }
            return;
        }// end function

        private function cbCloseBtn(param1:int) : void
        {
            this.close();
            return;
        }// end function

    }
}
