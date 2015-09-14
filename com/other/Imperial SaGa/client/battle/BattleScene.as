package battle
{
    import button.*;
    import character.*;
    import effect.*;
    import enemy.*;
    import fever.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import formation.*;
    import formationSettings.*;
    import formationSkill.*;
    import item.*;
    import layer.*;
    import message.*;
    import network.*;
    import player.*;
    import popup.*;
    import quest.*;
    import resource.*;
    import skill.*;
    import sound.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class BattleScene extends Object
    {
        private const _PHASE_RESOURCE:int = 1;
        private const _PHASE_OPEN:int = 2;
        private const _PHASE_TURN_INIT:int = 10;
        private const _PHASE_INPUT_WAIT_START:int = 13;
        private const _PHASE_INPUT_WAIT:int = 14;
        private const _PHASE_TURN_START:int = 20;
        private const _PHASE_CONNECTION_DEATH:int = 110;
        private const _PHASE_TURN_START_MOVE:int = 21;
        private const _PHASE_PLAY_ATTACK:int = 30;
        private const _PHASE_PLAY_SKILL_NAME:int = 31;
        private const _PHASE_PLAY_SKILL:int = 32;
        private const _PHASE_CHARA_LOST_VOICE:int = 33;
        private const _PHASE_PLAY_FORMATION_SKILL_START:int = 34;
        private const _PHASE_PLAY_FORMATION_SKILL:int = 35;
        private const _PHASE_PLAY_BAD_STATUS_POISON:int = 36;
        private const _PHASE_PLAY_FEVER:int = 37;
        private const _PHASE_TURN_END:int = 40;
        private const _PHASE_MERGE_PARTY_INIT:int = 41;
        private const _PHASE_MERGE_PARTY_CUTIN:int = 42;
        private const _PHASE_MERGE_PARTY:int = 43;
        private const _PHASE_FORWARD_PARTY:int = 44;
        private const _PHASE_NEW_SKILL_LOAD:int = 50;
        private const _PHASE_COME_UP_SKILL:int = 51;
        private const _PHASE_COMBO_START:int = 55;
        private const _PHASE_METAMORPHOSE:int = 60;
        private const _PHASE_REPLENISH:int = 61;
        private const _PHASE_ESCAPE_MOTION:int = 70;
        private const _PHASE_BATTLE_RESULT_WIN:int = 90;
        private const _PHASE_BATTLE_RESULT_LOSE:int = 91;
        private const _PHASE_BATTLE_RESULT_ESCAPE:int = 92;
        private const _PHASE_BATTLE_RESULT_STATUS_UP:int = 93;
        private const _PHASE_BATTLE_RESULT_STATUS_UP_END:int = 94;
        private const _PHASE_CHECK_CONTINUE:int = 100;
        private const _PHASE_CHECK_RETREAT:int = 101;
        private const _PHASE_CHECK_LOSE_ALERT:int = 102;
        private const _PHASE_LAYOUT_CHANGE:int = 999;
        private const _PHASE_BATTLE_END:int = 1000;
        private const _COME_UP_MAX:int = 5;
        private const _BG_FADE_TIME_WIN:Number = 0.5;
        private const _BG_FADE_TIME_LOSE:Number = 0.5;
        private const _FORMATION_SKILL_START_EFFECT_INTERVAL:Number = 0.6;
        private const _SKILL_WINDOW_MIN_POS_Y:int = 50;
        private const _OFFSET_BADSTATUS_ICON:Point;
        private const _AUTO_SKIP_STATUS_UP_TIME:Number = 1;
        private var _phase:int;
        private var _battleSpeed:Number;
        private var _questOperationId:int;
        private var _cam:BattleCamera;
        private var _battleManager:BattleManager;
        private var _effectManager:EffectManager;
        private var _mcUi:MovieClip;
        private var _isoUi:InStayOut;
        private var _isoAmulet:InStayOut;
        private var _parent:DisplayObjectContainer;
        private var _layerUi:LayerBattleUi;
        private var _layer:LayerBattle;
        private var _bg:BattleBg;
        private var _formationData:FormationData;
        private var _formationDataEnemy:FormationDataEnemy;
        private var _battleScroll:BattleScroll;
        private var _layoutManager:BattleLayoutManager;
        private var _battleType:int;
        private var _bgmId:int;
        private var _feverBgmId:int;
        private var _bgId:int;
        private var _aPlayer:Array;
        private var _aEnemy:Array;
        private var _cutIn:BattleCutIn;
        private var _cutInSide:BattleCutInSide;
        private var _effectCombo:EffectCombo;
        private var _battleComboCounter:BattleComboCounter;
        private var _aBonus:Array;
        private var _statusUpIndex:int;
        private var _statusUpBonusIndex:int;
        private var _bStatusUpMode:Boolean;
        private var _bStatusUped:Boolean;
        private var _bSelectMode:Boolean;
        private var _aSelectInput:Array;
        private var _selectUniqueId:int;
        private var _focusUniqueId:int;
        private var _selectSkillMenu:SelectSkillMenu;
        private var _aFormationSkillOrder:Array;
        private var _aOrder:Array;
        private var _aPassQuestUniqueId:Array;
        private var _attackDataIndex:int;
        private var _aAttackData:Array;
        private var _executeSkill:SkillBase;
        private var _executeFormationSkill:FormationSkillBase;
        private var _playerTargetId:int;
        private var _enemyTargetId:int;
        private var _aComboName:Array;
        private var _aAttackPlayerStatus:Array;
        private var _aAttackEnemyStatus:Array;
        private var _aStatusBar:Array;
        private var _formationStatusBar:FormationStatusbar;
        private var _aPartyStatusBar:Array;
        private var _btnAttack:ButtonBase;
        private var _btnFormationAttack:ButtonBase;
        private var _btnAutoAttack:ButtonBase;
        private var _btnAutoAttackOff:ButtonBase;
        private var _btnEscape:ButtonBase;
        private var _isoNext:InStayOut;
        private var _effFlash:EffectCoruscate = null;
        private var _comeUpCount:int = 0;
        private var _feverMode:FeverModeAction;
        private var _fadeTime:Number;
        private var _aBadStatusIcon:Array;
        private var _aDeathUniqueId:Array;
        private var _mcAnnihilation:MovieClip;
        private var _isoAnnihilation:InStayOut;
        private var _bResultLoseMode:Boolean;
        private var _checkContinue:BattleCheckContinue;
        private var _popupEscape:BattlePopupEscape;
        private var _bDarkFadeIn:Boolean;
        private var _battleMessage:BattleMessageMain;
        private var _escapeMain:BattlePhaseEscapeMain;
        private var _bRetreat:Boolean;
        private var _bResourceLoaded:Boolean;
        private var _bEnd:Boolean;
        private var _result:int;
        private var _bResourceComplete:Boolean;
        private var _autoSkipStatusUpTime:Number;
        private var _bAutoMode:Boolean;
        private var _bFeverMode:Boolean;
        private var _bTurnStartInit:Boolean;
        private var _bDivideParty:Boolean;
        private var _turnCount:int;
        private var _bChainTutorialSkillSelecting:Boolean;
        private var _bBattleStart:Boolean;
        private var _aChangeEnemyParsonal:Array;
        private var _battleMetamorphoseMain:BattleMetamorphoseMain;
        private var _battleFormationChange:BattleFormationChange;
        private var _bFormationChangeMoving:Boolean;
        private var _cbFormationChangeMoved:Function;
        private var _unitFormation:FormationSetData;
        private var _writebackUnitFormation:FormationSetData;
        private var _formationSkillStartTimer:Number;
        private var _formationSkillStartCount:int;
        private var _aFormationSkillStartEffect:Array;
        private var _aFormationSkillStartPlayer:Array;
        private var _aFormationSkillResourceLoaded:Array;
        private const SHOW_CUTIN_TIME:Number = 0.5;
        private var _mergingParty:PartyStatusbar;
        private var _cutinTimer:Number = 0;
        private var _aDeathConnectResult:Array;
        private var _bBrokenItem:Boolean;
        private var _lostVoiceWait:Boolean = false;
        private var _lostVoiceCharacter:Array;
        private var _brokenItemCharacter:Array;

        public function BattleScene(param1:DisplayObjectContainer, param2:int, param3:int, param4:BattleSceneBgmData, param5:Array, param6:Array, param7:Array, param8:Boolean, param9:FormationSetData, param10:int, param11:Array, param12:Boolean = false)
        {
            this._OFFSET_BADSTATUS_ICON = new Point(0, -15);
            this._battleSpeed = 1;
            this._autoSkipStatusUpTime = 0;
            this._battleType = param2;
            this._questOperationId = param10;
            this._aPlayer = param5;
            this._aEnemy = param6;
            this._aBonus = param7;
            this._bDivideParty = param8;
            this._comeUpCount = 0;
            this._aComboName = [];
            this._statusUpIndex = 0;
            this._statusUpBonusIndex = 0;
            this._bStatusUpMode = false;
            this._bStatusUped = false;
            this._bResourceComplete = false;
            this._bBattleStart = false;
            this._bResultLoseMode = false;
            this._bDarkFadeIn = false;
            this._aFormationSkillOrder = [];
            this._aBadStatusIcon = [];
            this._aDeathUniqueId = [];
            this._escapeMain = null;
            this._turnCount = 0;
            this._bChainTutorialSkillSelecting = false;
            this._feverMode = null;
            this._bgmId = param4.bgmId;
            this._feverBgmId = param4.feverBgmId;
            this._bgId = param3;
            this._battleManager = new BattleManager();
            this._effectManager = new EffectManager();
            this._parent = param1;
            this._cam = new BattleCamera();
            this._result = BattleConstant.RESULT_NOT_END;
            this._bEnd = false;
            this._aPartyStatusBar = [];
            this._aStatusBar = [];
            this._battleFormationChange = null;
            this._cbFormationChangeMoved = null;
            this._aFormationSkillResourceLoaded = [];
            this._unitFormation = param9;
            this._parent.addEventListener(MouseEvent.CLICK, this.cbScreenClick);
            this._parent.addEventListener(MouseEvent.MOUSE_MOVE, this.cbScreenMove);
            this._aChangeEnemyParsonal = param11;
            this.setPhase(this._PHASE_RESOURCE);
            return;
        }// end function

        public function get bRetreat() : Boolean
        {
            return this._bRetreat;
        }// end function

        public function get bResourceLoaded() : Boolean
        {
            return this._bResourceLoaded;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function get result() : int
        {
            return this._result;
        }// end function

        public function get bResourceComplete() : Boolean
        {
            return this._bResourceComplete;
        }// end function

        public function getBattlePlayer() : Array
        {
            return this._battleManager.getEntryPlayerAll();
        }// end function

        public function getBattleEnemy() : Array
        {
            return this._battleManager.aEnemy;
        }// end function

        public function get turnCount() : int
        {
            return this._turnCount;
        }// end function

        public function setBattleStart() : void
        {
            this._bBattleStart = true;
            return;
        }// end function

        public function get writebackUnitFormation() : FormationSetData
        {
            return this._writebackUnitFormation;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._escapeMain != null)
            {
                this._escapeMain.release();
            }
            this._escapeMain = null;
            if (this._isoNext)
            {
                this._isoNext.release();
            }
            this._isoNext = null;
            if (this._battleMessage)
            {
                this._battleMessage.release();
            }
            this._battleMessage = null;
            this._aComboName = [];
            if (this._battleComboCounter)
            {
                this._battleComboCounter.release();
            }
            this._battleComboCounter = null;
            if (this._feverMode)
            {
                this._feverMode.release();
            }
            this._feverMode = null;
            if (this._cutIn)
            {
                this._cutIn.release();
            }
            this._cutIn = null;
            if (this._cutInSide)
            {
                this._cutInSide.release();
            }
            this._cutInSide = null;
            if (this._mcAnnihilation)
            {
                if (this._mcAnnihilation.parent)
                {
                    this._mcAnnihilation.parent.removeChild(this._mcAnnihilation);
                }
            }
            this._mcAnnihilation = null;
            if (this._isoAnnihilation)
            {
                this._isoAnnihilation.release();
            }
            this._isoAnnihilation = null;
            if (this._selectSkillMenu)
            {
                this._selectSkillMenu.release();
            }
            this._selectSkillMenu = null;
            if (this._executeSkill != null)
            {
                this._executeSkill.release();
            }
            this._executeSkill = null;
            if (this._executeFormationSkill != null)
            {
                this._executeFormationSkill.release();
            }
            this._executeFormationSkill = null;
            if (this._btnAttack)
            {
                ButtonManager.getInstance().removeButton(this._btnAttack);
            }
            this._btnAttack = null;
            if (this._btnFormationAttack)
            {
                ButtonManager.getInstance().removeButton(this._btnFormationAttack);
            }
            this._btnFormationAttack = null;
            if (this._btnAutoAttack)
            {
                ButtonManager.getInstance().removeButton(this._btnAutoAttack);
            }
            this._btnAutoAttack = null;
            if (this._btnAutoAttackOff != null)
            {
                ButtonManager.getInstance().removeButton(this._btnAutoAttackOff);
            }
            this._btnAutoAttackOff = null;
            if (this._btnEscape != null)
            {
                ButtonManager.getInstance().removeButton(this._btnEscape);
            }
            this._btnEscape = null;
            if (this._checkContinue)
            {
                this._checkContinue.release();
            }
            this._checkContinue = null;
            if (this._layoutManager)
            {
                this._layoutManager.release();
            }
            this._layoutManager = null;
            if (this._battleScroll)
            {
                this._battleScroll.release();
            }
            this._battleScroll = null;
            if (this._formationDataEnemy)
            {
                this._formationDataEnemy.release();
            }
            this._formationDataEnemy = null;
            if (this._formationData)
            {
                this._formationData.release();
            }
            this._formationData = null;
            if (this._battleFormationChange)
            {
                this._battleFormationChange.release();
            }
            if (this._bg)
            {
                this._bg.release();
            }
            this._bg = null;
            if (this._mcUi != null)
            {
                if (this._mcUi.parent)
                {
                    this._mcUi.parent.removeChild(this._mcUi);
                }
            }
            this._mcUi = null;
            if (this._isoUi)
            {
                this._isoUi.release();
            }
            this._isoUi = null;
            if (this._isoAmulet)
            {
                this._isoAmulet.release();
            }
            this._isoAmulet = null;
            if (this._cam)
            {
                this._cam.release();
            }
            this._cam = null;
            if (this._layerUi)
            {
                this._layerUi.release();
            }
            this._layerUi = null;
            if (this._layer)
            {
                this._layer.release();
            }
            this._layer = null;
            if (this._parent)
            {
                this._parent.removeEventListener(MouseEvent.CLICK, this.cbScreenClick);
                this._parent.removeEventListener(MouseEvent.MOUSE_MOVE, this.cbScreenMove);
            }
            this._parent = null;
            if (this._effectManager)
            {
                this._effectManager.release();
            }
            this._effectManager = null;
            if (this._battleManager)
            {
                this._battleManager.release();
            }
            this._battleManager = null;
            this._aPlayer = null;
            this._aEnemy = null;
            if (this._aStatusBar)
            {
                while (this._aStatusBar.length > 0)
                {
                    
                    _loc_1 = this._aStatusBar.pop();
                    _loc_1.release();
                    _loc_1 = null;
                }
            }
            this._aStatusBar = null;
            if (this._formationStatusBar)
            {
                this._formationStatusBar.release();
            }
            this._formationStatusBar = null;
            if (this._aPartyStatusBar)
            {
                while (this._aPartyStatusBar.length > 0)
                {
                    
                    _loc_2 = this._aPartyStatusBar.pop();
                    _loc_2.release();
                    _loc_2 = null;
                }
            }
            this._aPartyStatusBar = null;
            this._aChangeEnemyParsonal = [];
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = false;
            param1 = param1 * this._battleSpeed;
            this._cam.control(param1);
            this._effectManager.control(param1);
            var _loc_2:* = this._battleManager.getEntryPlayerAll();
            for each (_loc_3 in _loc_2)
            {
                
                _loc_3.control(param1);
            }
            for each (_loc_4 in this._battleManager.getEntryEnemy())
            {
                
                _loc_4.control(param1);
            }
            for each (_loc_5 in this._aStatusBar)
            {
                
                _loc_5.control(param1);
            }
            if (this._formationStatusBar)
            {
                this._formationStatusBar.control(param1);
            }
            for each (_loc_6 in this._aPartyStatusBar)
            {
                
                _loc_6.control(param1);
            }
            for each (_loc_7 in this._aBadStatusIcon)
            {
                
                _loc_7.control(param1);
            }
            if (this._feverMode)
            {
                this._feverMode.control(param1);
            }
            if (this._selectSkillMenu != null)
            {
                if (this._selectSkillMenu.bEnd)
                {
                    this._selectSkillMenu.release();
                    this._selectSkillMenu = null;
                    this._bSelectMode = true;
                    this.buttonEnable(true);
                    this.setChainTutorialArrow();
                }
            }
            if (this._popupEscape != null)
            {
                this._popupEscape.control(param1);
                if (this._popupEscape.bEnd)
                {
                    _loc_8 = this._popupEscape.bEscape;
                    this._popupEscape.release();
                    this._popupEscape = null;
                    if (_loc_8)
                    {
                        this.setPhase(this._PHASE_ESCAPE_MOTION);
                        return;
                    }
                    this._bSelectMode = true;
                    this.buttonEnable(true);
                }
            }
            if (this._battleMessage)
            {
                this._battleMessage.control(param1);
            }
            if (this._bg)
            {
                this._bg.control(param1);
            }
            if (this._battleComboCounter)
            {
                this._battleComboCounter.control(param1);
            }
            switch(this._phase)
            {
                case this._PHASE_RESOURCE:
                {
                    this.controlResource();
                    break;
                }
                case this._PHASE_OPEN:
                {
                    this.controlOpen(param1);
                    break;
                }
                case this._PHASE_TURN_INIT:
                {
                    this.controlTurnInit(param1);
                    break;
                }
                case this._PHASE_INPUT_WAIT_START:
                {
                    this.controlInputWaitStart(param1);
                    break;
                }
                case this._PHASE_INPUT_WAIT:
                {
                    this.controlInputWait(param1);
                    break;
                }
                case this._PHASE_TURN_START:
                {
                    this.controlTurnStart();
                    break;
                }
                case this._PHASE_CONNECTION_DEATH:
                {
                    this.controlConnectionDeath(param1);
                    break;
                }
                case this._PHASE_TURN_START_MOVE:
                {
                    this.controlTurnStartMove(param1);
                    break;
                }
                case this._PHASE_PLAY_ATTACK:
                {
                    this.controlPlayAttack(param1);
                    break;
                }
                case this._PHASE_PLAY_SKILL_NAME:
                {
                    this.controlPlaySkillName(param1);
                    break;
                }
                case this._PHASE_PLAY_SKILL:
                {
                    this.controlPlaySkill(param1);
                    break;
                }
                case this._PHASE_CHARA_LOST_VOICE:
                {
                    this.controlCharaLostVoice();
                    break;
                }
                case this._PHASE_PLAY_FORMATION_SKILL_START:
                {
                    this.controlPlayFormationSkillStart(param1);
                    break;
                }
                case this._PHASE_PLAY_FORMATION_SKILL:
                {
                    this.controlPlayFormationSkill(param1);
                    break;
                }
                case this._PHASE_PLAY_BAD_STATUS_POISON:
                {
                    this.controlPlayBadStatusPoison(param1);
                    break;
                }
                case this._PHASE_PLAY_FEVER:
                {
                    this.controlPlayFever(param1);
                    break;
                }
                case this._PHASE_TURN_END:
                {
                    this.controlTurnEnd(param1);
                    break;
                }
                case this._PHASE_MERGE_PARTY_INIT:
                {
                    this.controlMergePartyInit(param1);
                    break;
                }
                case this._PHASE_MERGE_PARTY_CUTIN:
                {
                    this.controlMergePartyCutin(param1);
                    break;
                }
                case this._PHASE_MERGE_PARTY:
                {
                    this.controlMergeParty(param1);
                    break;
                }
                case this._PHASE_FORWARD_PARTY:
                {
                    this.controlForwardParty(param1);
                    break;
                }
                case this._PHASE_NEW_SKILL_LOAD:
                {
                    this.controlNewSkill(param1);
                    break;
                }
                case this._PHASE_COME_UP_SKILL:
                {
                    this.controlComeUpSkill(param1);
                    break;
                }
                case this._PHASE_COMBO_START:
                {
                    this.controlComboStart(param1);
                    break;
                }
                case this._PHASE_METAMORPHOSE:
                {
                    this.controlMetamorphose(param1);
                    break;
                }
                case this._PHASE_REPLENISH:
                {
                    this.controlReplenish(param1);
                    break;
                }
                case this._PHASE_ESCAPE_MOTION:
                {
                    this.controlEscapeMotion(param1);
                    break;
                }
                case this._PHASE_BATTLE_RESULT_WIN:
                {
                    this.controlBattleResultWin(param1);
                    break;
                }
                case this._PHASE_BATTLE_RESULT_LOSE:
                {
                    this.controlBattleResultLose(param1);
                    break;
                }
                case this._PHASE_BATTLE_RESULT_ESCAPE:
                {
                    this.controlBattleResultEscape(param1);
                    break;
                }
                case this._PHASE_BATTLE_RESULT_STATUS_UP:
                {
                    this.controlBattleResultStatusUp(param1);
                    break;
                }
                case this._PHASE_BATTLE_RESULT_STATUS_UP_END:
                {
                    this.controlBattleResultStatusUpEnd(param1);
                    break;
                }
                case this._PHASE_CHECK_CONTINUE:
                {
                    this.controlCheckContinue(param1);
                    break;
                }
                case this._PHASE_CHECK_RETREAT:
                {
                    this.controlCheckRetreat(param1);
                    break;
                }
                case this._PHASE_CHECK_LOSE_ALERT:
                {
                    this.controlCheckLoseAlert(param1);
                    break;
                }
                case this._PHASE_LAYOUT_CHANGE:
                {
                    this.controlLayoutChange(param1);
                    break;
                }
                case this._PHASE_BATTLE_END:
                {
                    this.controlBattleEnd(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case this._PHASE_RESOURCE:
                {
                    this.phaseResource();
                    break;
                }
                case this._PHASE_OPEN:
                {
                    this.phaseOpen();
                    break;
                }
                case this._PHASE_TURN_INIT:
                {
                    this.phaseTurnInit();
                    break;
                }
                case this._PHASE_INPUT_WAIT_START:
                {
                    this.phaseInputWaitStart();
                    break;
                }
                case this._PHASE_INPUT_WAIT:
                {
                    this.phaseInputWait();
                    break;
                }
                case this._PHASE_TURN_START:
                {
                    this.phaseTurnStart();
                    break;
                }
                case this._PHASE_CONNECTION_DEATH:
                {
                    this.phaseConnectionDeath();
                    break;
                }
                case this._PHASE_TURN_START_MOVE:
                {
                    this.phaseTurnStartMove();
                    break;
                }
                case this._PHASE_PLAY_ATTACK:
                {
                    this.phasePlayAttack();
                    break;
                }
                case this._PHASE_PLAY_SKILL_NAME:
                {
                    this.phasePlaySkillName();
                    break;
                }
                case this._PHASE_PLAY_SKILL:
                {
                    this.phasePlaySkill();
                    break;
                }
                case this._PHASE_CHARA_LOST_VOICE:
                {
                    this.phaseCharaLostVoice();
                    break;
                }
                case this._PHASE_PLAY_FORMATION_SKILL_START:
                {
                    this.phasePlayFormationSkillStart();
                    break;
                }
                case this._PHASE_PLAY_FORMATION_SKILL:
                {
                    this.phasePlayFormationSkill();
                    break;
                }
                case this._PHASE_PLAY_BAD_STATUS_POISON:
                {
                    this.phasePlayBadStatusPoison();
                    break;
                }
                case this._PHASE_PLAY_FEVER:
                {
                    this.phasePlayFever();
                    break;
                }
                case this._PHASE_TURN_END:
                {
                    this.phaseTurnEnd();
                    break;
                }
                case this._PHASE_MERGE_PARTY_INIT:
                {
                    this.phaseMergePartyInit();
                    break;
                }
                case this._PHASE_MERGE_PARTY_CUTIN:
                {
                    this.phaseMergePartyCutin();
                    break;
                }
                case this._PHASE_MERGE_PARTY:
                {
                    this.phaseMergeParty();
                    break;
                }
                case this._PHASE_FORWARD_PARTY:
                {
                    this.phaseForwardParty();
                    break;
                }
                case this._PHASE_NEW_SKILL_LOAD:
                {
                    this.phaseNewSkill();
                    break;
                }
                case this._PHASE_COME_UP_SKILL:
                {
                    this.phaseComeUpSkill();
                    break;
                }
                case this._PHASE_COMBO_START:
                {
                    this.phaseComboStart();
                    break;
                }
                case this._PHASE_METAMORPHOSE:
                {
                    this.phaseMetamorphose();
                    break;
                }
                case this._PHASE_REPLENISH:
                {
                    this.phaseReplenish();
                    break;
                }
                case this._PHASE_ESCAPE_MOTION:
                {
                    this.phaseEscapeMotion();
                    break;
                }
                case this._PHASE_BATTLE_RESULT_WIN:
                {
                    this.phaseBattleResultWin();
                    break;
                }
                case this._PHASE_BATTLE_RESULT_LOSE:
                {
                    this.phaseBattleResultLose();
                    break;
                }
                case this._PHASE_BATTLE_RESULT_ESCAPE:
                {
                    this.phaseBattleResultEscape();
                    break;
                }
                case this._PHASE_BATTLE_RESULT_STATUS_UP:
                {
                    this.phaseBattleResultStatusUp();
                    break;
                }
                case this._PHASE_BATTLE_RESULT_STATUS_UP_END:
                {
                    this.phaseBattleResultStatusUpEnd();
                    break;
                }
                case this._PHASE_CHECK_CONTINUE:
                {
                    this.phaseCheckContinue();
                    break;
                }
                case this._PHASE_CHECK_RETREAT:
                {
                    this.phaseCheckRetreat();
                    break;
                }
                case this._PHASE_CHECK_LOSE_ALERT:
                {
                    this.phaseCheckLoseAlert();
                    break;
                }
                case this._PHASE_LAYOUT_CHANGE:
                {
                    this.phaseLayoutChange();
                    break;
                }
                case this._PHASE_BATTLE_END:
                {
                    this.phaseBattleEnd();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function phaseResource() : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            var _loc_19:* = 0;
            var _loc_20:* = null;
            var _loc_21:* = null;
            ResourceManager.getInstance().loadResource(ResourcePath.BATTLE_PATH + "UI_BattleMain.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.BATTLE_PATH + "BattleNum.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.BATTLE_PATH + "BattleFormation.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.BATTLE_PATH + "BattleFormationEnemy.swf");
            var _loc_1:* = BattleInformationManager.getInstance().getBgFileName(this._bgId);
            if (_loc_1 == null || _loc_1 == "")
            {
                Assert.print("バトル背景の読み込みに失敗しました。");
            }
            ResourceManager.getInstance().loadResource(ResourcePath.BATTLE_BG_PATH + _loc_1);
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.SKILL_PATH + "Weapons.swf");
            SoundManager.getInstance().loadSoundArray([SoundId.SE_RS3_OTHER_FLASH, SoundId.SE_JUMP3, SoundId.SE_ADDITIONAL_DAMAGE]);
            SoundManager.getInstance().loadSoundArray(BattleActionPlayer.getSoundId());
            SoundManager.getInstance().loadSoundArray(DamageUtility.getSoundId());
            ResourceManager.getInstance().loadResource(ResourcePath.BATTLE_PATH + "BattleComboEffect.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Balloon.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.SKILL_PATH + "Defense_Guard.swf");
            FormationSettings.loadResource();
            CommonPopup.getInstance().loadResource();
            var _loc_2:* = [];
            if (this._bgmId != Constant.EMPTY_ID)
            {
                _loc_2.push(this._bgmId);
            }
            _loc_2.push(SoundId.BGM_BATTLE_WIN);
            _loc_2.push(SoundId.BGM_BATTLE_LOSE);
            if (this._battleType == BattleConstant.BATTLE_TYPE_BOSS)
            {
                _loc_10 = UserDataManager.getInstance().userData.emperorId;
                _loc_11 = PlayerManager.getInstance().getPlayerInformation(_loc_10);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_BUSTUP_PATH + _loc_11.bustUpFileName);
                if (this._feverBgmId == Constant.EMPTY_ID)
                {
                    for each (_loc_12 in this._aEnemy)
                    {
                        
                        if (_loc_12 == null)
                        {
                            continue;
                        }
                        _loc_13 = EnemyManager.getInstance().getEnemyInformation(_loc_12.infoId);
                        this._feverBgmId = BattleManager.getFeverBgmId(_loc_13.series);
                        break;
                    }
                }
                _loc_2.push(this._feverBgmId);
            }
            SoundManager.getInstance().loadSoundArray(_loc_2);
            var _loc_3:* = [];
            _loc_3.push(SoundId.SE_RS3_SYSTEM_CURSOR);
            _loc_3.push(SoundId.SE_RS3_SYSTEM_ENTER);
            _loc_3.push(SoundId.SE_RS3_SYSTEM_SKILL_ENTER);
            _loc_3.push(SoundId.SE_RS3_SYSTEM_RETURN);
            _loc_3.push(SoundId.SE_CHARA_RUNNING);
            _loc_3.push(SoundId.SE_REV_ZENGUNTOTSUGEKI);
            _loc_3.push(SoundId.SE_REV_CUTIN);
            SoundManager.getInstance().loadSoundArray(_loc_3);
            var _loc_4:* = this._aPlayer.concat();
            if (this._battleType == BattleConstant.BATTLE_TYPE_BOSS)
            {
                _loc_14 = UserDataManager.getInstance().userData.aSortiePlayerUniqueId;
                for each (_loc_15 in _loc_14)
                {
                    
                    if (_loc_15 == Constant.EMPTY_ID)
                    {
                        continue;
                    }
                    _loc_17 = 0;
                    while (_loc_17 < _loc_4.length)
                    {
                        
                        _loc_16 = _loc_4[_loc_17];
                        if (_loc_16.uniqueId == _loc_15)
                        {
                            break;
                        }
                        _loc_17++;
                    }
                    if (_loc_17 >= _loc_4.length)
                    {
                        _loc_16 = QuestManager.getInstance().questData.getPlayerPersonal(_loc_15);
                        if (_loc_16)
                        {
                            _loc_4.push(_loc_16);
                        }
                    }
                }
            }
            for each (_loc_7 in _loc_4)
            {
                
                _loc_18 = PlayerManager.getInstance().getPlayerInformation(_loc_7.playerId);
                ResourceManager.getInstance().loadArray(PlayerManager.getInstance().getResourceBustupPath(_loc_7.playerId));
                ResourceManager.getInstance().loadResource(ResourcePath.CARD_SMALL_PATH + CharacterConstant.ID_CARD + _loc_18.cardFileName);
                _loc_19 = BattleManager.getDefaultSkillId(_loc_18);
                _loc_6 = SkillManager.getInstance().getSkillInformation(_loc_19);
                ResourceManager.getInstance().loadArray(SkillManager.getInstance().getSkillPath(_loc_6.effectId));
                SoundManager.getInstance().loadSoundArray(SkillManager.getInstance().getSkillSeId(_loc_6.effectId));
                for each (_loc_5 in _loc_7.aSetSkillId)
                {
                    
                    if (_loc_5 != Constant.EMPTY_ID)
                    {
                        _loc_6 = SkillManager.getInstance().getSkillInformation(_loc_5);
                        ResourceManager.getInstance().loadArray(SkillManager.getInstance().getSkillPath(_loc_6.effectId));
                        SoundManager.getInstance().loadSoundArray(SkillManager.getInstance().getSkillSeId(_loc_6.effectId));
                    }
                }
            }
            if (TutorialManager.getInstance().isTutorial())
            {
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_SKILL_CHAIN_AFTER) && !TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_FIRST_BATTLE_END))
                {
                    _loc_6 = SkillManager.getInstance().getSkillInformation(CommonConstant.TUTORIAL_SKILL_CHAIN_SKILL_ID_1);
                    ResourceManager.getInstance().loadArray(SkillManager.getInstance().getSkillPath(_loc_6.effectId));
                    SoundManager.getInstance().loadSoundArray(SkillManager.getInstance().getSkillSeId(_loc_6.effectId));
                    _loc_6 = SkillManager.getInstance().getSkillInformation(CommonConstant.TUTORIAL_SKILL_CHAIN_SKILL_ID_3);
                    ResourceManager.getInstance().loadArray(SkillManager.getInstance().getSkillPath(_loc_6.effectId));
                    SoundManager.getInstance().loadSoundArray(SkillManager.getInstance().getSkillSeId(_loc_6.effectId));
                    _loc_6 = SkillManager.getInstance().getSkillInformation(CommonConstant.TUTORIAL_SKILL_CHAIN_SKILL_ID_5);
                    ResourceManager.getInstance().loadArray(SkillManager.getInstance().getSkillPath(_loc_6.effectId));
                    SoundManager.getInstance().loadSoundArray(SkillManager.getInstance().getSkillSeId(_loc_6.effectId));
                }
            }
            var _loc_8:* = this._aEnemy.concat();
            _loc_8 = this._aEnemy.concat().concat(this._aChangeEnemyParsonal);
            for each (_loc_9 in _loc_8)
            {
                
                if (_loc_9 != null)
                {
                    ResourceManager.getInstance().loadArray(EnemyManager.getInstance().getResourceBustupPath(_loc_9.infoId));
                    SoundManager.getInstance().loadSoundArray(EnemyManager.getInstance().getSeId(_loc_9.infoId));
                    _loc_20 = EnemyManager.getInstance().getUseSkill(_loc_9.infoId);
                    for each (_loc_21 in _loc_20)
                    {
                        
                        if (_loc_21.skillId != Constant.EMPTY_ID)
                        {
                            _loc_6 = SkillManager.getInstance().getSkillInformation(_loc_21.skillId);
                            ResourceManager.getInstance().loadArray(SkillManager.getInstance().getSkillPath(_loc_6.effectId));
                            SoundManager.getInstance().loadSoundArray(SkillManager.getInstance().getSkillSeId(_loc_6.effectId));
                        }
                    }
                }
            }
            this._bResourceLoaded = false;
            return;
        }// end function

        private function controlResource() : void
        {
            var _loc_5:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = 0;
            var _loc_17:* = null;
            var _loc_18:* = 0;
            var _loc_19:* = null;
            var _loc_20:* = 0;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = 0;
            var _loc_26:* = null;
            var _loc_27:* = 0;
            var _loc_28:* = null;
            var _loc_29:* = 0;
            var _loc_30:* = null;
            var _loc_31:* = null;
            if (ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false)
            {
                return;
            }
            this._bResourceComplete = true;
            if (this._bBattleStart == false)
            {
                return;
            }
            this._layerUi = new LayerBattleUi();
            this._layer = new LayerBattle();
            this._mcUi = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "UI_BattleMain.swf", "BattleMainMc");
            this._mcUi.allMoveMc.bgMc.battleLayer.addChild(this._cam.mc);
            this._isoUi = new InStayOut(this._mcUi);
            this._layerUi.getLayer(LayerBattleUi.UI).addChild(this._mcUi);
            this._parent.addChild(this._layerUi);
            var _loc_1:* = QuestManager.getInstance().aAmuletLabel;
            if (_loc_1.length > 0)
            {
                this._isoAmulet = new InStayOut(this._mcUi.allMoveMc.growthUpMc);
                _loc_12 = this._mcUi.allMoveMc.growthUpMc.growthUpSetMc;
                _loc_13 = 0;
                _loc_12.gotoAndStop("set" + _loc_1.length);
                for each (_loc_14 in _loc_1)
                {
                    
                    _loc_15 = _loc_12["amuletType" + (_loc_13 + 1) + "Mc"];
                    _loc_15.gotoAndStop(_loc_14);
                    _loc_13++;
                }
            }
            TextControl.setText(this._mcUi.allMoveMc.chrCutInMoveMc.chrCutInMc.chrCutInBalloonMc.textMc.textDt, " ");
            TextControl.setText(this._mcUi.allMoveMc.chrCutInMoveMc.chrCutInMc.chrCutInBalloon2Mc.textMc.textDt, " ");
            var _loc_2:* = BattleInformationManager.getInstance().getBgFileName(this._bgId);
            var _loc_3:* = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_BG_PATH + _loc_2, "BattleBG");
            this._bg = new BattleBg(this._cam.mc, _loc_3);
            _loc_3.battleLayer.addChild(this._layer);
            this._battleManager.setBattleScreen(_loc_3);
            this._formationData = new FormationData(_loc_3.formationCharaNull, this._unitFormation.id);
            this._formationDataEnemy = new FormationDataEnemy(_loc_3.formationEnemyNull, this._aEnemy);
            var _loc_4:* = this._unitFormation.aPlayerUniqueId;
            var _loc_6:* = Constant.UNDECIDED;
            var _loc_7:* = 0;
            _loc_5 = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                _loc_16 = _loc_4[_loc_5];
                if (_loc_6 == Constant.UNDECIDED)
                {
                    _loc_6 = _loc_5;
                }
                for each (_loc_17 in this._aPlayer)
                {
                    
                    if (_loc_17.uniqueId == _loc_16)
                    {
                        if (_loc_5 == FormationSetData.FORMATION_INDEX_COMMANDER && _loc_7 < 5)
                        {
                            _loc_4[_loc_5] = Constant.EMPTY_ID;
                            _loc_4[_loc_6] = _loc_16;
                            this._battleManager.addPlayer(this._layer, _loc_17, _loc_6);
                        }
                        else
                        {
                            this._battleManager.addPlayer(this._layer, _loc_17, _loc_5);
                        }
                        _loc_7++;
                        if (_loc_6 == _loc_5)
                        {
                            _loc_6 = Constant.UNDECIDED;
                        }
                        break;
                    }
                }
                _loc_5++;
            }
            var _loc_8:* = FormationManager.getInstance().getFormationInformation(this._unitFormation.id);
            if (FormationManager.getInstance().getFormationInformation(this._unitFormation.id).member < this._battleManager.aPlayer.length)
            {
                _loc_18 = FormationManager.getInstance().getBasicFormationId(this._battleManager.aPlayer.length);
                _loc_19 = [Constant.EMPTY_ID, Constant.EMPTY_ID, Constant.EMPTY_ID, Constant.EMPTY_ID, Constant.EMPTY_ID, Constant.EMPTY_ID];
                _loc_20 = 0;
                for each (_loc_21 in this._battleManager.getEntryPlayer())
                {
                    
                    _loc_19[_loc_20] = _loc_21.playerPersonal.uniqueId;
                    _loc_20++;
                }
                this._unitFormation.setData(_loc_18, _loc_19);
                this._formationData.setFormationLabel(_loc_18);
            }
            else
            {
                this._unitFormation.setData(this._unitFormation.id, _loc_4);
            }
            this.updateFormationBonus();
            this.updateCommanderSkillBonus();
            _loc_5 = 0;
            while (_loc_5 < this._aEnemy.length)
            {
                
                _loc_22 = this._aEnemy[_loc_5];
                if (_loc_22 == null)
                {
                }
                else
                {
                    this._battleManager.addEnemy(this._layer, _loc_22, _loc_5, this._questOperationId, this._aChangeEnemyParsonal);
                }
                _loc_5++;
            }
            this._battleScroll = new BattleScroll(this._battleManager, this._formationData, this._cam);
            this.setPosition();
            this._aStatusBar = [];
            var _loc_9:* = [this._mcUi.allMoveMc.status1Mc, this._mcUi.allMoveMc.status2Mc, this._mcUi.allMoveMc.status3Mc, this._mcUi.allMoveMc.status4Mc, this._mcUi.allMoveMc.status5Mc, this._mcUi.allMoveMc.status6Mc];
            for each (_loc_10 in _loc_9)
            {
                
                _loc_23 = new StatusBar(_loc_10);
                this._aStatusBar.push(_loc_23);
            }
            this._formationStatusBar = new FormationStatusbar(this._mcUi.allMoveMc.formationTopMc, this.cbFormationAttack, this.cbFormationChange);
            this._formationStatusBar.updateFormation(this._unitFormation.id);
            this._formationStatusBar.updateFormationSkill(FormationManager.getInstance().getFormationSkillInformationByFormationId(this._unitFormation.id));
            this._aPartyStatusBar = [];
            _loc_11 = [this._mcUi.allMoveMc.unitMerge1Mc, this._mcUi.allMoveMc.unitMerge2Mc, this._mcUi.allMoveMc.unitMerge3Mc, this._mcUi.allMoveMc.unitMerge4Mc, this._mcUi.allMoveMc.unitMerge5Mc, this._mcUi.allMoveMc.unitMerge6Mc];
            if (this._battleType == BattleConstant.BATTLE_TYPE_BOSS)
            {
                _loc_24 = QuestManager.getInstance().getBossBattleJoinParty();
                _loc_25 = this._battleManager.getEntryPlayer().length;
                while (_loc_24.length > 0)
                {
                    
                    _loc_27 = 9999;
                    for each (_loc_28 in _loc_24)
                    {
                        
                        _loc_29 = 0;
                        _loc_29 = QuestManager.getInstance().getBossBattleRouteCount(_loc_28.teamNo);
                        if (_loc_29 < 0)
                        {
                            _loc_29 = this._aPartyStatusBar.length + 1;
                        }
                        if (_loc_29 > 0 && _loc_29 < _loc_27)
                        {
                            _loc_26 = _loc_28;
                            _loc_27 = _loc_29;
                        }
                    }
                    if (_loc_26 != null)
                    {
                        _loc_30 = _loc_11[_loc_25];
                        _loc_31 = new PartyStatusbar(_loc_30, _loc_30 == this._mcUi.allMoveMc.unitMerge6Mc);
                        _loc_31.setParty(_loc_26, _loc_27, 5 - _loc_25);
                        this._aPartyStatusBar.push(_loc_31);
                        _loc_25 = _loc_25 + _loc_26.aPlayer.length;
                        _loc_24.splice(_loc_24.indexOf(_loc_26), 1);
                        _loc_26 = null;
                        continue;
                    }
                    break;
                }
            }
            this._layoutManager = new BattleLayoutManager(this._battleManager, this._battleScroll);
            this._btnAttack = ButtonManager.getInstance().addButton(this._mcUi.allMoveMc.formationTopMc.individuaBtnMc, this.cbAttack);
            this._btnAttack.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcUi.allMoveMc.formationTopMc.individuaBtnMc.textMc.textDt, MessageId.BATTLE_BUTTON_SINGLE);
            this._btnAutoAttack = ButtonManager.getInstance().addButton(this._mcUi.allMoveMc.formationTopMc.autoBtnMc, this.cbAutoAttack);
            this._btnAutoAttack.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcUi.allMoveMc.formationTopMc.autoBtnMc.textMc.textDt, MessageId.BATTLE_BUTTON_AUTO_ON);
            this._btnAutoAttackOff = ButtonManager.getInstance().addButton(this._mcUi.allMoveMc.formationTopMc.autoStopBtnMc, this.cbAutoAttack);
            this._btnAutoAttackOff.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mcUi.allMoveMc.formationTopMc.autoStopBtnMc.textMc.textDt, MessageId.BATTLE_BUTTON_AUTO_OFF);
            this._btnAutoAttackOff.setVisible(false);
            this._btnEscape = ButtonManager.getInstance().addButton(this._mcUi.allMoveMc.formationTopMc.escapeBtnMc, this.cbEscape);
            this._btnEscape.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcUi.allMoveMc.formationTopMc.escapeBtnMc.textMc.textDt, MessageId.BATTLE_BUTTON_ESCAPE);
            if (this._mcUi.allMoveMc.autoBtnMc)
            {
                this._mcUi.allMoveMc.autoBtnMc.visible = false;
            }
            if (this._mcUi.allMoveMc.autoStopBtnMc)
            {
                this._mcUi.allMoveMc.autoStopBtnMc.visible = false;
            }
            if (this._mcUi.allMoveMc.escapeBtnMc)
            {
                this._mcUi.allMoveMc.escapeBtnMc.visible = false;
            }
            this._battleMessage = new BattleMessageMain(this._mcUi.allMoveMc.skillWindowsMoveMc, this._layer.getLayer(LayerBattle.CHARACTER), this._battleManager, this._formationData, this._formationDataEnemy);
            this._battleComboCounter = new BattleComboCounter(this._mcUi.allMoveMc.renkeiCountNum.renkei_moji);
            this._isoNext = new InStayOut(this._mcUi.allMoveMc.eventNextMc);
            if (this._battleType == BattleConstant.BATTLE_TYPE_BOSS)
            {
                this._feverMode = new FeverModeAction(this._mcUi.allMoveMc, this._layer, this._battleManager);
                this._feverMode.bgmId = this._feverBgmId;
            }
            this._battleFormationChange = new BattleFormationChange(this._parent, this._battleManager, this.cbFormationChangeCloseStart, this.cbFormationChangeCloseEnd);
            this._bResourceLoaded = true;
            this.buttonEnable(false);
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        private function phaseOpen() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_1:* = Main.GetApplicationData().userConfigData;
            this._battleSpeed = _loc_1.setBattleSpeed();
            this._isoUi.setIn(this.cbBattleOpen);
            var _loc_2:* = this._battleManager.getEntryPlayer();
            var _loc_3:* = 0;
            for each (_loc_4 in _loc_2)
            {
                
                if (_loc_3 >= this._aStatusBar.length)
                {
                    break;
                }
                _loc_6 = this._aStatusBar[_loc_3];
                _loc_6.setPlayer(_loc_4, _loc_4.formationIndex);
                _loc_6.openWindow(_loc_3 * 0.1);
                _loc_3++;
            }
            for each (_loc_5 in this._aPartyStatusBar)
            {
                
                _loc_5.openWindow(_loc_3 * 0.1);
                _loc_3++;
            }
            if (this._aPartyStatusBar.length == 0)
            {
                this._formationStatusBar.openWindow(_loc_3 * 0.1);
            }
            if (this._bgmId != Constant.EMPTY_ID)
            {
                SoundManager.getInstance().playBgm(this._bgmId);
            }
            return;
        }// end function

        private function controlOpen(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._isoUi.bOpened == false)
            {
                return;
            }
            for each (_loc_2 in this._aStatusBar)
            {
                
                if (_loc_2.bWait == false && _loc_2.bOpened == false)
                {
                    return;
                }
            }
            for each (_loc_3 in this._aPartyStatusBar)
            {
                
                if (_loc_3.bAnimation)
                {
                    return;
                }
            }
            this.partyStatusBarAutoHide();
            if (this._formationStatusBar.isOpend() == false)
            {
                if (!this._formationStatusBar.isAnimetionOpen())
                {
                    this._formationStatusBar.openWindow(0.1);
                }
                return;
            }
            this.setPhase(this._PHASE_TURN_INIT);
            return;
        }// end function

        private function partyStatusBarAutoHide() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aPartyStatusBar)
            {
                
                if (_loc_1.bAutoHide)
                {
                    _loc_1.closeWindow();
                }
            }
            return;
        }// end function

        private function partyStatusBarAutoShow() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aPartyStatusBar)
            {
                
                if (_loc_1.bAutoHide)
                {
                    _loc_1.reopenWindow();
                }
            }
            return;
        }// end function

        private function cbBattleOpen() : void
        {
            return;
        }// end function

        private function phaseTurnInit() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            this._bTurnStartInit = false;
            this._bFeverMode = false;
            this._selectUniqueId = 0;
            this._focusUniqueId = 0;
            this._aSelectInput = [];
            this._aDeathUniqueId = [];
            this._aComboName = [];
            this.setSelectStatusBar(Constant.EMPTY_ID);
            this.sortCharacterDisplay(this._battleManager.getEntryCharacter());
            var _loc_1:* = true;
            for each (_loc_2 in this._battleManager.getEntryPlayer())
            {
                
                if (_loc_2.personal.bDead)
                {
                    continue;
                }
                _loc_1 = false;
                if (_loc_2.personal.useSkillId != _loc_2.defaultSkillId)
                {
                    _loc_3 = SkillManager.getInstance().getSkillInformation(_loc_2.personal.useSkillId);
                    if (_loc_2.playerPersonal.sp < _loc_2.getSkillUseSp(_loc_3))
                    {
                        _loc_2.characterAction.setUseSkillId(_loc_2.defaultSkillId);
                    }
                    if (BattleManager.isSelectNoBe(_loc_2.status) && _loc_2.personal.useSkillId == SkillId.DEFENSE)
                    {
                        _loc_2.characterAction.setUseSkillId(_loc_2.defaultSkillId);
                        _loc_2.characterAction.setActionReset();
                    }
                }
            }
            if (this._battleType == BattleConstant.BATTLE_TYPE_BOSS)
            {
                if (this._feverMode.bExecuted == false && QuestManager.getInstance().getFeverGaugePersent() >= BattleConstant.FEVER_USE_PERSENT)
                {
                    _loc_4 = 0;
                    for each (_loc_5 in this._battleManager.getEntryPlayer())
                    {
                        
                        if (_loc_5.personal.bDead == false)
                        {
                            _loc_4++;
                        }
                    }
                    if (_loc_4 == BattleConstant.FEVER_PLAYER_COUNT)
                    {
                        this._bFeverMode = true;
                    }
                }
            }
            this.updateFormationBonus();
            if (this._bAutoMode || this._bFeverMode || _loc_1)
            {
                this.setPhase(this._PHASE_TURN_START);
            }
            else
            {
                this.setPhase(this._PHASE_INPUT_WAIT_START);
            }
            return;
        }// end function

        private function controlTurnInit(param1:Number) : void
        {
            return;
        }// end function

        private function phaseInputWaitStart() : void
        {
            if (this._bg.bInputWait == false)
            {
                this._bg.setInputWait();
            }
            return;
        }// end function

        private function controlInputWaitStart(param1:Number) : void
        {
            this._formationData.updatePos();
            this.setPosition();
            if (this._bg.bInputWait)
            {
                this.setPhase(this._PHASE_INPUT_WAIT);
            }
            return;
        }// end function

        private function phaseInputWait() : void
        {
            var pos:Point;
            var mtx:Matrix;
            var bPl:BattlePlayer;
            var battleEnemy:BattleEnemy;
            var statusBar:StatusBar;
            var playerPersonal:PlayerPersonal;
            var skillInfo:SkillInformation;
            var icon:BattleBadStatusIcon;
            var iconEnemy:BattleBadStatusIcon;
            this._bSelectMode = true;
            this.buttonEnable(true);
            var _loc_2:* = 0;
            var _loc_3:* = this._battleManager.getEntryPlayer();
            while (_loc_3 in _loc_2)
            {
                
                bPl = _loc_3[_loc_2];
                playerPersonal = bPl.playerPersonal;
                if (playerPersonal.bDead)
                {
                    continue;
                }
                if (BattleBadStatusIcon.isIconDisplay(bPl.status.badStatus))
                {
                    mtx = bPl.characterAction.characterDisplay.getfaceNullMatrix();
                    pos = this._formationData.getPosition(bPl.formationIndex);
                    pos = pos.add(new Point(mtx.tx, mtx.ty));
                    pos = pos.add(this._OFFSET_BADSTATUS_ICON);
                    icon = new BattleBadStatusIcon(this._layer.getLayer(LayerBattle.FRONT_EFFECT), bPl.status.badStatus, pos);
                    this._aBadStatusIcon.push(icon);
                }
                if (BattleManager.isSelectNoBe(bPl.status))
                {
                    bPl.characterAction.setActionReset();
                    continue;
                }
                bPl.characterAction.setActionSkillInput(playerPersonal.useSkillId);
                this._aSelectInput.push(bPl);
                if (TutorialManager.getInstance().isTutorial())
                {
                    if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_SKILL_CHAIN_AFTER) && !TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_FIRST_BATTLE_END))
                    {
                        if (playerPersonal.playerId == CommonConstant.NEW_CYCLE_DEFAULT_PLAYER_ID)
                        {
                            playerPersonal.useSkillId = CommonConstant.TUTORIAL_SKILL_CHAIN_SKILL_ID_1;
                        }
                        else if (playerPersonal.playerId == CommonConstant.TUTORIAL_INIT_PLAYER_ID_3)
                        {
                            playerPersonal.useSkillId = CommonConstant.TUTORIAL_SKILL_CHAIN_SKILL_ID_3;
                        }
                    }
                }
                skillInfo = SkillManager.getInstance().getSkillInformation(playerPersonal.useSkillId);
                if (skillInfo != null)
                {
                    this._battleMessage.addMessageCharacter(playerPersonal.questUniqueId, skillInfo.name);
                }
            }
            var _loc_2:* = 0;
            var _loc_3:* = this._battleManager.getEntryEnemy();
            while (_loc_3 in _loc_2)
            {
                
                battleEnemy = _loc_3[_loc_2];
                if (battleEnemy.personal.bDead)
                {
                    continue;
                }
                if (BattleBadStatusIcon.isIconDisplay(battleEnemy.status.badStatus))
                {
                    mtx = battleEnemy.characterAction.characterDisplay.getfaceNullMatrix();
                    pos = this._formationDataEnemy.getPosition(battleEnemy.formationIndex);
                    pos = pos.add(new Point(mtx.tx, mtx.ty));
                    pos = pos.add(this._OFFSET_BADSTATUS_ICON);
                    iconEnemy = new BattleBadStatusIcon(this._layer.getLayer(LayerBattle.FRONT_EFFECT), battleEnemy.status.badStatus, pos);
                    this._aBadStatusIcon.push(iconEnemy);
                }
                this._battleMessage.addCharacterName(battleEnemy.personal.questUniqueId);
            }
            var _loc_2:* = 0;
            var _loc_3:* = this._aStatusBar;
            while (_loc_3 in _loc_2)
            {
                
                statusBar = _loc_3[_loc_2];
                statusBar.setPreviewMode(true);
            }
            this._btnAutoAttack.setVisible(true);
            this._btnAutoAttackOff.setVisible(false);
            if (TutorialManager.getInstance().isTutorial())
            {
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_FIRST_BATTLE_START))
                {
                    TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_FIRST_BATTLE_START, function () : void
            {
                var _loc_1:* = [];
                _loc_1.push(_btnAttack);
                ButtonManager.getInstance().seal(_loc_1, true);
                TutorialManager.getInstance().setTutorialArrow(_btnAttack.getMoveClip());
                TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_FIRST_BATTLE_001));
                return;
            }// end function
            );
                }
                else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_SKILL_CHAIN_BEFORE) && !TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_FIRST_BATTLE_END))
                {
                    TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_SKILL_CHAIN_BEFORE, function () : void
            {
                ButtonManager.getInstance().seal([], true);
                TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_SKILL_CHOICE_001));
                _bChainTutorialSkillSelecting = true;
                setChainTutorialArrow();
                return;
            }// end function
            );
                }
                else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_BOSS_BATTLE) && this._battleType == BattleConstant.BATTLE_TYPE_BOSS)
                {
                    TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_BOSS_BATTLE, function () : void
            {
                var _loc_1:* = [];
                _loc_1.push(_btnAttack);
                ButtonManager.getInstance().seal(_loc_1, true);
                TutorialManager.getInstance().setTutorialArrow(_btnAttack.getMoveClip());
                TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_BOSS_BATTLE_001));
                return;
            }// end function
            );
                }
                else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_2, TutorialManager.BASIC_TUTORIAL_FLAG_FORMATION_SKILL_BEFORE))
                {
                    if (BuildSwitch.SW_FORMATION_SKILL)
                    {
                        TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_2, TutorialManager.BASIC_TUTORIAL_FLAG_FORMATION_SKILL_BEFORE, function () : void
            {
                var _loc_1:* = [];
                _loc_1.push(_formationStatusBar.btnFormationAttack);
                ButtonManager.getInstance().seal(_loc_1, true);
                var _loc_2:* = FormationManager.getInstance().getFormationSkillInformationByFormationId(_formationData.formationId);
                TutorialManager.getInstance().setTutorialArrow(_formationStatusBar.btnFormationAttack.getMoveClip());
                TutorialManager.getInstance().setTutorialBalloon(TextControl.formatIdText(MessageId.TUTORIAL_BALLOON_FORMATION_SKILL_001, _loc_2.skillName));
                return;
            }// end function
            );
                    }
                }
            }
            return;
        }// end function

        private function controlInputWait(param1:Number) : void
        {
            if (this._battleFormationChange && this._battleFormationChange.bOpened)
            {
                this._battleFormationChange.control(param1);
            }
            if (this._bFormationChangeMoving)
            {
                if (!this.isEntryPlayerMoving())
                {
                    this._bFormationChangeMoving = false;
                    SoundManager.getInstance().playSe(SoundId.SE_LANDING1016B);
                    if (this._cbFormationChangeMoved != null)
                    {
                        this._cbFormationChangeMoved();
                    }
                }
            }
            return;
        }// end function

        private function phaseTurnStart() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_8:* = null;
            TutorialManager.getInstance().hideTutorial();
            this._bSelectMode = false;
            this._aSelectInput = [];
            this.buttonEnable(false);
            this.clearBadStateIcon();
            this._battleMessage.setMessageCharacterClose();
            this._battleMessage.clearCharacterName();
            this._attackDataIndex = 0;
            this._aAttackData = [];
            this._aAttackPlayerStatus = [];
            this._aAttackEnemyStatus = [];
            if (this._bFeverMode == false)
            {
                this.setEnemySkill();
                this.setDefense();
                this.setDecisionOrder();
                this.executionAttack();
            }
            else
            {
                this.executeFeverMode();
            }
            for each (_loc_1 in this._battleManager.getEntryPlayer())
            {
                
                if (_loc_1.personal.bDead)
                {
                    continue;
                }
                if (BattleManager.isActionNotBe(_loc_1.status.badStatus))
                {
                    continue;
                }
                _loc_1.characterAction.setActionSkillSelected();
            }
            for each (_loc_2 in this._aAttackData)
            {
                
                for each (_loc_3 in _loc_2.aDamage)
                {
                    
                    if (_loc_3.damageLp == 0)
                    {
                        continue;
                    }
                    _loc_4 = this._battleManager.getCharacter(_loc_3.questUniqueId);
                    if (_loc_4.division == BattleConstant.DIVISION_PLAYER)
                    {
                        _loc_5 = _loc_4 as BattlePlayer;
                        if (_loc_5.playerPersonal.isEmperor())
                        {
                            continue;
                        }
                        _loc_6 = {uniqueId:_loc_5.playerPersonal.uniqueId, bDead:_loc_3.bDead, subLp:_loc_3.damageLp};
                        _loc_7 = false;
                        for each (_loc_8 in this._aDeathUniqueId)
                        {
                            
                            if (_loc_8.uniqueId == _loc_6.uniqueId)
                            {
                                _loc_8.bDead = _loc_8.bDead | _loc_6.bDead;
                                _loc_8.subLp = _loc_8.subLp + _loc_6.subLp;
                                _loc_7 = true;
                                break;
                            }
                        }
                        if (_loc_7 == false)
                        {
                            this._aDeathUniqueId.push(_loc_6);
                        }
                    }
                }
            }
            if (this._aDeathUniqueId.length == 0)
            {
                this.setPhase(this._PHASE_TURN_START_MOVE);
            }
            else
            {
                this.setPhase(this._PHASE_CONNECTION_DEATH);
            }
            return;
        }// end function

        private function controlTurnStart() : void
        {
            return;
        }// end function

        private function phaseConnectionDeath() : void
        {
            if (TutorialManager.getInstance().isTutorial())
            {
                this.setPhase(this._PHASE_TURN_START_MOVE);
                return;
            }
            NetManager.getInstance().request(new NetTaskCharacterDeath(this._aDeathUniqueId, this.cbNetTaskCharacterDeath));
            return;
        }// end function

        private function controlConnectionDeath(param1:Number) : void
        {
            return;
        }// end function

        private function cbNetTaskCharacterDeath(param1:NetResult) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_2:* = this._battleManager.getEntryPlayer();
            var _loc_3:* = param1.data.aDeadResultData;
            this._aDeathConnectResult = param1.data.aDeadResultData;
            for each (_loc_4 in _loc_2)
            {
                
                for each (_loc_5 in _loc_3)
                {
                    
                    if (_loc_5.uniqueId == _loc_4.playerPersonal.uniqueId)
                    {
                        _loc_6 = _loc_5.aItem;
                        _loc_7 = 0;
                        while (_loc_7 < _loc_4.playerPersonal.aSetItemId.length)
                        {
                            
                            if (_loc_7 < _loc_6.length)
                            {
                                _loc_8 = _loc_6[_loc_7];
                                _loc_4.playerPersonal.setEquippedItemId(_loc_7, _loc_8);
                            }
                            else
                            {
                                _loc_4.playerPersonal.setEquippedItemId(_loc_7, Constant.EMPTY_ID);
                            }
                            _loc_7++;
                        }
                    }
                }
            }
            this.setPhase(this._PHASE_TURN_START_MOVE);
            return;
        }// end function

        private function phaseTurnStartMove() : void
        {
            if (this._bg.bTurnStart == false)
            {
                this._bg.setTurnStart();
            }
            return;
        }// end function

        private function controlTurnStartMove(param1:Number) : void
        {
            this._formationData.updatePos();
            this.setPosition();
            if (this._bg.bTurnStart)
            {
                this.setPhase(this._PHASE_NEW_SKILL_LOAD);
            }
            return;
        }// end function

        private function phasePlayAttack() : void
        {
            var _loc_2:* = null;
            if (this._attackDataIndex >= this._aAttackData.length)
            {
                return;
            }
            var _loc_1:* = this._aAttackData[this._attackDataIndex];
            if (_loc_1.attackType == BattleConstant.ATTACK_DATA_TYPE_SKILL)
            {
                _loc_2 = _loc_1 as AttackDataSkill;
                if (_loc_2.bComeUp)
                {
                    this.setPhase(this._PHASE_COME_UP_SKILL);
                    return;
                }
                this.setPhase(this._PHASE_COMBO_START);
            }
            if (_loc_1.attackType == BattleConstant.ATTACK_DATA_TYPE_FORMATION)
            {
                this.setPhase(this._PHASE_PLAY_FORMATION_SKILL_START);
            }
            if (_loc_1.attackType == BattleConstant.ATTACK_DATA_TYPE_FEVER)
            {
                this.setPhase(this._PHASE_PLAY_FEVER);
            }
            if (_loc_1.attackType == BattleConstant.ATTACK_DATA_TYPE_BAD_STATUS_POISON)
            {
                this.setPhase(this._PHASE_PLAY_BAD_STATUS_POISON);
            }
            return;
        }// end function

        private function controlPlayAttack(param1:Number) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._battleManager.getEntryCharacter())
            {
                
                if (_loc_2.characterAction.bDamageDisp)
                {
                    return;
                }
            }
            this.setPhase(this._PHASE_TURN_END);
            return;
        }// end function

        private function phasePlaySkillName() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = this._aAttackData[this._attackDataIndex] as AttackDataSkill;
            if (_loc_1.bDefaultSkill == false)
            {
                _loc_2 = SkillManager.getInstance().getSkillInformation(_loc_1.skillId);
                if (_loc_2 != null)
                {
                    _loc_3 = this._battleMessage.addMessageCharacter(_loc_1.questUniqueId, _loc_2.name + "！");
                    _loc_3.setTimeClose(0.7);
                }
            }
            return;
        }// end function

        private function controlPlaySkillName(param1:Number) : void
        {
            var _loc_2:* = false;
            if (this._battleMessage.bMessageCharacterDisp == false)
            {
                this.setPhase(this._PHASE_PLAY_SKILL);
            }
            return;
        }// end function

        private function phasePlaySkill() : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_1:* = this._aAttackData[this._attackDataIndex] as AttackDataSkill;
            var _loc_2:* = this._battleManager.getCharacter(_loc_1.questUniqueId);
            var _loc_3:* = SkillManager.getInstance().getSkillInformation(_loc_1.skillId);
            DisplayUtils.setTopPriority(_loc_2.characterAction.characterDisplay.layer.parent, _loc_2.characterAction.characterDisplay.layer);
            if (_loc_2.division == BattleConstant.DIVISION_PLAYER)
            {
                _loc_9 = _loc_2 as BattlePlayer;
                _loc_9.playerPersonal.decreaseSp(_loc_1.useSp);
            }
            var _loc_4:* = [];
            this._bBrokenItem = false;
            var _loc_5:* = false;
            for each (_loc_6 in _loc_1.aDamage)
            {
                
                if (_loc_6.bCounter)
                {
                    _loc_5 = true;
                }
            }
            for each (_loc_7 in _loc_1.aDamage)
            {
                
                if (_loc_7.counterSkillId == Constant.EMPTY_ID && !_loc_7.bOutDamage)
                {
                    this.inDamageData(_loc_7);
                }
                _loc_10 = this._battleManager.getCharacter(_loc_7.questUniqueId);
                if (_loc_7.sheld != BattleConstant.DEFENSE_SHIELD_NON)
                {
                    _loc_10.status.setShield(_loc_7.sheld);
                }
                if (_loc_7.counterSkillId != Constant.EMPTY_ID)
                {
                    _loc_10.status.setCounterSkillId(_loc_7.counterSkillId);
                }
                if (_loc_7.bCounter)
                {
                    _loc_10.status.bCounterHit = true;
                }
                if (_loc_7.bBrokenItem)
                {
                    this._bBrokenItem = true;
                }
                if (!_loc_5 || _loc_7.questUniqueId != _loc_2.personal.questUniqueId)
                {
                    _loc_4.push(_loc_10.characterAction);
                }
            }
            this._executeSkill = SkillManager.getInstance().createSkill(_loc_3.effectId, this._layer, _loc_2, _loc_4, this._effectManager, this._battleManager, _loc_1.invokeType);
            _loc_8 = BattleManager.getComboGrade(_loc_1.comboCount);
            if (_loc_8 >= BattleConstant.COMBO_GRADE1)
            {
                _loc_11 = "";
                if (this._aComboName.length > 5)
                {
                    this._aComboName.splice(0, this._aComboName.length - 5);
                }
                for each (_loc_12 in this._aComboName)
                {
                    
                    _loc_11 = _loc_11 + _loc_12;
                }
                this._battleMessage.setMessageTop(_loc_11);
            }
            return;
        }// end function

        private function controlPlaySkill(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (this._executeSkill)
            {
                this._executeSkill.control(param1);
                if (this._executeSkill.isEnd() && !CommonPopup.isUse())
                {
                    _loc_2 = this._aAttackData[this._attackDataIndex] as AttackDataSkill;
                    if (TutorialManager.getInstance().isTutorial())
                    {
                        if (_loc_2.bComeUp && TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_SKILL_COMES_UP))
                        {
                            for each (_loc_6 in this._battleManager.getEntryEnemy())
                            {
                                
                                if (_loc_6.characterAction.bDamageDisp || _loc_6.characterAction.bPlayingDeadEffect)
                                {
                                    return;
                                }
                            }
                            TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_SKILL_COMES_UP);
                            return;
                        }
                        if (_loc_2.comboCount > 1 && TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_SKILL_CHAIN_AFTER))
                        {
                            for each (_loc_6 in this._battleManager.getEntryEnemy())
                            {
                                
                                if (_loc_6.characterAction.bDamageDisp || _loc_6.characterAction.bPlayingDeadEffect)
                                {
                                    return;
                                }
                            }
                            _loc_7 = this._aAttackData[(this._attackDataIndex + 1)] as AttackDataSkill;
                            if (_loc_7 == null || _loc_7.comboCount <= 1)
                            {
                                TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_SKILL_CHAIN_AFTER);
                                return;
                            }
                        }
                    }
                    if (this._battleManager.isRemainingDamage(_loc_2.questUniqueId))
                    {
                        return;
                    }
                    _loc_3 = this._battleManager.getCharacter(_loc_2.questUniqueId);
                    if (_loc_3.division == BattleConstant.DIVISION_PLAYER && _loc_2.bDefaultSkill == true)
                    {
                        _loc_3.dealDamage(_loc_2.totalDamage);
                    }
                    for each (_loc_4 in _loc_2.aComboDeadId)
                    {
                        
                        _loc_8 = this._battleManager.getCharacter(_loc_4) as BattleEnemy;
                        if (_loc_8.bBattleDead)
                        {
                            _loc_8.characterAction.setActionDead();
                        }
                    }
                    for each (_loc_5 in _loc_2.aDamage)
                    {
                        
                        _loc_9 = this._battleManager.getCharacter(_loc_5.questUniqueId);
                        _loc_9.status.clearShield();
                        _loc_9.status.bCounterHit = false;
                        if (_loc_9.isDefense() && BattleManager.isActionNotBe(_loc_9.status.badStatus))
                        {
                            _loc_9.setDefense(false);
                        }
                    }
                    this.setCharacterDarkOut(_loc_3.division, _loc_3.personal.questUniqueId, false);
                    this._executeSkill.release();
                    this._executeSkill = null;
                    this._battleMessage.setMessageTopClose();
                    this.sortCharacterDisplay(this._battleManager.getEntryCharacter());
                    var _loc_10:* = this;
                    var _loc_11:* = this._attackDataIndex + 1;
                    _loc_10._attackDataIndex = _loc_11;
                    this.setPhase(this._PHASE_CHARA_LOST_VOICE);
                }
            }
            else
            {
                var _loc_10:* = this;
                var _loc_11:* = this._attackDataIndex + 1;
                _loc_10._attackDataIndex = _loc_11;
                this.setPhase(this._PHASE_CHARA_LOST_VOICE);
            }
            return;
        }// end function

        private function phaseCharaLostVoice() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = false;
            this._lostVoiceCharacter = [];
            this._brokenItemCharacter = [];
            for each (_loc_1 in this._battleManager.getEntryPlayer())
            {
                
                if (_loc_1.characterAction.bUseDeadEffect)
                {
                    _loc_4 = false;
                    if (_loc_1.characterAction.characterPersonal as PlayerPersonal)
                    {
                        _loc_4 = (_loc_1.characterAction.characterPersonal as PlayerPersonal).isEmperor();
                    }
                    if (!_loc_4 && _loc_1.characterAction.characterPersonal.lp == 0)
                    {
                        this._lostVoiceCharacter.push(_loc_1);
                    }
                }
            }
            _loc_2 = this._aAttackData[(this._attackDataIndex - 1)] as AttackDataBase;
            for each (_loc_3 in _loc_2.aDamage)
            {
                
                if (_loc_3.bBrokenItem)
                {
                    this._brokenItemCharacter.push(this._battleManager.getCharacter(_loc_3.questUniqueId) as BattlePlayer);
                }
            }
            return;
        }// end function

        private function controlCharaLostVoice() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            for each (_loc_1 in this._battleManager.getEntryPlayer())
            {
                
                if (_loc_1.characterAction.bDamageDisp || _loc_1.characterAction.bPlayingDeadEffect || _loc_1.characterAction.bActionEnd)
                {
                    return;
                }
            }
            if (this._lostVoiceWait)
            {
                return;
            }
            if (this._lostVoiceCharacter.length > 0)
            {
                _loc_2 = this._lostVoiceCharacter.pop();
                _loc_3 = _loc_2.playerPersonal;
                _loc_4 = PlayerManager.getInstance().getPlayerInformation(_loc_3.playerId);
                _loc_5 = this._battleManager.getPartnerCharacterId(_loc_3.questUniqueId);
                _loc_6 = PlayerManager.getInstance().getWordLost(_loc_4.characterId, _loc_5);
                _loc_7 = this._battleMessage.addMessageCharacter(_loc_2.characterAction.questUniqueId, _loc_6);
                this._lostVoiceWait = true;
                return;
            }
            if (this._brokenItemCharacter.length > 0)
            {
                _loc_2 = this._brokenItemCharacter.pop();
                _loc_3 = _loc_2.playerPersonal;
                _loc_4 = PlayerManager.getInstance().getPlayerInformation(_loc_3.playerId);
                if (!_loc_3.isEmperor())
                {
                    _loc_8 = ItemManager.getInstance().getPaymentItemInformation(PaymentItemId.ITEM_DEFENCE_LP_DAMEAGE);
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.BATTLE_LPDEFENCE_MESSAGE, _loc_8.name, _loc_4.name), this.cbPopupClose);
                    this._lostVoiceWait = true;
                    return;
                }
            }
            this._lostVoiceCharacter = [];
            if (this._lostVoiceWait == false)
            {
                this._battleMessage.setMessageCharacterClose();
                this.setPhase(this._PHASE_PLAY_ATTACK);
            }
            return;
        }// end function

        private function phasePlayFormationSkillStart() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._bg.bDarkOut = true;
            var _loc_1:* = this._aAttackData[this._attackDataIndex] as AttackDataFormation;
            this._aFormationSkillStartPlayer = [];
            this._aFormationSkillStartEffect = [];
            for each (_loc_2 in _loc_1.aQuestUniqueId)
            {
                
                _loc_3 = this._battleManager.getCharacter(_loc_2) as BattlePlayer;
                this._aFormationSkillStartPlayer.push(_loc_3);
            }
            this._formationSkillStartTimer = 0;
            this._formationSkillStartCount = this._aFormationSkillStartPlayer.length;
            if (this._aFormationSkillResourceLoaded.indexOf(this._unitFormation.id) == -1)
            {
                _loc_4 = FormationManager.getInstance().getFormationSkillInformationByFormationId(this._unitFormation.id);
                ResourceManager.getInstance().loadArray(FormationManager.getInstance().getFormationSkillPath(_loc_4.id));
                SoundManager.getInstance().loadSoundArray(FormationManager.getInstance().getFormationSkillSeId(_loc_4.id));
            }
            return;
        }// end function

        private function controlPlayFormationSkillStart(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (this._formationSkillStartCount == 0 && this._aFormationSkillStartEffect.length == 0)
            {
                if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
                {
                    this._aFormationSkillStartEffect = null;
                    this._aFormationSkillStartPlayer = null;
                    if (this._aFormationSkillResourceLoaded.indexOf(this._unitFormation.id) == -1)
                    {
                        this._aFormationSkillResourceLoaded.push(this._unitFormation.id);
                    }
                    this.setPhase(this._PHASE_PLAY_FORMATION_SKILL);
                }
            }
            else
            {
                if (this._formationSkillStartCount * 2 >= this._aFormationSkillStartEffect.length)
                {
                    this._formationSkillStartTimer = this._formationSkillStartTimer - param1;
                    if (this._formationSkillStartTimer < 0)
                    {
                        var _loc_9:* = this;
                        var _loc_10:* = this._formationSkillStartCount - 1;
                        _loc_9._formationSkillStartCount = _loc_10;
                        _loc_2 = this._aFormationSkillStartPlayer[this._formationSkillStartCount];
                        _loc_3 = _loc_2.characterAction.characterDisplay as PlayerDisplay;
                        _loc_5 = _loc_3.pos.add(new Point(_loc_3.effectNull.x, _loc_3.effectNull.y));
                        _loc_6 = new EffectMc(this._layer.getLayer(LayerBattle.FRONT_EFFECT), ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf", "SetSkillStart_Efc_Front", _loc_5);
                        this._aFormationSkillStartEffect.push(_loc_6);
                        this._effectManager.addEffect(_loc_6);
                        _loc_7 = new EffectFormationSkillBack(this._layer.getLayer(LayerBattle.CHARACTER), ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf", "SetSkillStart_Efc_Back", _loc_5, _loc_2.playerPersonal.playerId);
                        this._aFormationSkillStartEffect.push(_loc_7);
                        this._effectManager.addEffect(_loc_7);
                        DisplayUtils.setTopPriority(_loc_3.layer.parent, _loc_3.layer);
                        this._formationSkillStartTimer = this._FORMATION_SKILL_START_EFFECT_INTERVAL;
                        SoundManager.getInstance().playSe(SoundId.SE_REV_CUTIN);
                    }
                }
                _loc_4 = this._aFormationSkillStartEffect.length - 1;
                while (_loc_4 >= 0)
                {
                    
                    _loc_8 = this._aFormationSkillStartEffect[_loc_4];
                    if (_loc_8.isEnd())
                    {
                        this._effectManager.releaseEffect(this._aFormationSkillStartEffect[_loc_4]);
                        this._aFormationSkillStartEffect.splice(_loc_4, 1);
                    }
                    _loc_4 = _loc_4 - 1;
                }
            }
            return;
        }// end function

        private function phasePlayFormationSkill() : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = this._aAttackData[this._attackDataIndex] as AttackDataFormation;
            var _loc_2:* = [];
            var _loc_3:* = [];
            for each (_loc_4 in _loc_1.aQuestUniqueId)
            {
                
                _loc_6 = this._battleManager.getCharacter(_loc_4) as BattlePlayer;
                _loc_6.playerPersonal.decreaseSp(_loc_1.useSp);
                _loc_2.push(_loc_6.characterAction);
            }
            for each (_loc_5 in _loc_1.aDamage)
            {
                
                this.inDamageData(_loc_5);
                _loc_7 = this._battleManager.getCharacter(_loc_5.questUniqueId);
                _loc_3.push(_loc_7.characterAction);
            }
            this._executeFormationSkill = FormationManager.getInstance().createFormationSkill(_loc_1.formationSkillId, this._layer, _loc_2, _loc_3, this._effectManager, this._battleManager);
            return;
        }// end function

        private function controlPlayFormationSkill(param1:Number) : void
        {
            var battleEnemy:BattleEnemy;
            var t:* = param1;
            if (this._executeFormationSkill)
            {
                this._executeFormationSkill.control(t);
                if (this._executeFormationSkill.bSkillEnd && !CommonPopup.isUse())
                {
                    if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_2, TutorialManager.BASIC_TUTORIAL_FLAG_FORMATION_SKILL_AFTER))
                    {
                        var _loc_3:* = 0;
                        var _loc_4:* = this._battleManager.getEntryEnemy();
                        while (_loc_4 in _loc_3)
                        {
                            
                            battleEnemy = _loc_4[_loc_3];
                            if (battleEnemy.characterAction.bDamageDisp || battleEnemy.characterAction.bPlayingDeadEffect)
                            {
                                return;
                            }
                        }
                        TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_2, TutorialManager.BASIC_TUTORIAL_FLAG_FORMATION_SKILL_AFTER, function () : void
            {
                ButtonManager.getInstance().unseal();
                return;
            }// end function
            );
                        return;
                    }
                    this._executeFormationSkill.release();
                    this._executeFormationSkill = null;
                    this._battleMessage.setMessageTopClose();
                    this._bg.bDarkOut = false;
                    var _loc_3:* = this;
                    var _loc_4:* = this._attackDataIndex + 1;
                    _loc_3._attackDataIndex = _loc_4;
                    this.setPhase(this._PHASE_PLAY_ATTACK);
                }
            }
            return;
        }// end function

        private function phasePlayBadStatusPoison() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = this._aAttackData[this._attackDataIndex] as AttackDataBadStatusPoison;
            for each (_loc_2 in _loc_1.aDamage)
            {
                
                this._battleManager.createDamageHp(_loc_2.questUniqueId, _loc_2.attackerQuestUniqueId, _loc_2.damageHp, _loc_2.hitType);
                if (_loc_2.damageLp > 0)
                {
                    this._battleManager.createDamageLp(_loc_2.questUniqueId, _loc_2.attackerQuestUniqueId, _loc_2.damageLp, _loc_2.bBrokenItem);
                }
                _loc_3 = this._battleManager.getCharacter(_loc_2.questUniqueId);
                this._battleManager.playDamage(_loc_2.questUniqueId, null);
                _loc_3.characterAction.setActionDamage();
            }
            return;
        }// end function

        private function controlPlayBadStatusPoison(param1:Number) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._attackDataIndex + 1;
            _loc_2._attackDataIndex = _loc_3;
            this.setPhase(this._PHASE_CHARA_LOST_VOICE);
            return;
        }// end function

        private function phasePlayFever() : void
        {
            var _loc_1:* = this._aAttackData[this._attackDataIndex] as AttackDataFever;
            this.sortCharacterDisplay(this._battleManager.getEntryPlayer());
            this._feverMode.setFeverStart();
            this._bAutoMode = false;
            this.buttonEnable(false);
            return;
        }// end function

        private function controlPlayFever(param1:Number) : void
        {
            if (this._feverMode)
            {
                if (this._feverMode.bFeverMode == false)
                {
                    this.sortCharacterDisplay(this._battleManager.getEntryCharacter());
                    var _loc_2:* = this;
                    var _loc_3:* = this._attackDataIndex + 1;
                    _loc_2._attackDataIndex = _loc_3;
                    this.setPhase(this._PHASE_PLAY_ATTACK);
                }
            }
            return;
        }// end function

        private function phaseTurnEnd() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = false;
            var _loc_6:* = false;
            var _loc_7:* = false;
            var _loc_8:* = false;
            var _loc_9:* = this;
            var _loc_10:* = this._turnCount + 1;
            _loc_9._turnCount = _loc_10;
            this._bg.bDarkOut = false;
            this._battleComboCounter.close();
            var _loc_3:* = 0;
            for each (_loc_1 in this._battleManager.getEntryPlayer())
            {
                
                if (_loc_1.bBattleDead == false)
                {
                    _loc_3++;
                }
            }
            _loc_4 = 0;
            for each (_loc_2 in this._battleManager.getEntryEnemy())
            {
                
                if (_loc_2.bBattleDead == false)
                {
                    _loc_4++;
                }
            }
            _loc_5 = _loc_3 > 0;
            _loc_6 = this._battleManager.commanderPlayer && this._battleManager.commanderPlayer.bBattleDead == false;
            _loc_7 = this._aPartyStatusBar.length > 0;
            _loc_8 = _loc_4 > 0;
            if (_loc_5 == false && _loc_6 == false && _loc_7 == false)
            {
                this.setPhase(this._PHASE_BATTLE_RESULT_LOSE);
                return;
            }
            if (_loc_8 == false)
            {
                this.changePhase_BattleResultWin();
                return;
            }
            for each (_loc_1 in this._battleManager.getEntryPlayer())
            {
                
                _loc_1.setDefense(false);
                _loc_1.status.clearCounterSkill();
            }
            for each (_loc_2 in this._battleManager.getEntryEnemy())
            {
                
                _loc_2.setDefense(false);
                _loc_2.status.clearCounterSkill();
            }
            if (this.checkTermination(_loc_3, _loc_4) == false)
            {
                this.executionTrunRecoveryBadStatus();
            }
            this._aFormationSkillOrder = [];
            return;
        }// end function

        private function controlTurnEnd(param1:Number) : void
        {
            if (this._battleType == BattleConstant.BATTLE_TYPE_BOSS && this._bDivideParty)
            {
                this.setPhase(this._PHASE_MERGE_PARTY_INIT);
            }
            else
            {
                this.setPhase(this._PHASE_METAMORPHOSE);
            }
            return;
        }// end function

        private function phaseMergePartyInit() : void
        {
            if (this._aPartyStatusBar.length > 0)
            {
                if (this._formationStatusBar.isClose() == false)
                {
                    this._formationStatusBar.closeWindow();
                }
            }
            this.partyStatusBarAutoShow();
            return;
        }// end function

        private function controlMergePartyInit(param1:Number) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aPartyStatusBar)
            {
                
                if (_loc_2.bAnimation)
                {
                    return;
                }
            }
            this.setPhase(this._PHASE_MERGE_PARTY_CUTIN);
            return;
        }// end function

        private function phaseMergePartyCutin() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            for each (_loc_1 in this._aPartyStatusBar)
            {
                
                if (_loc_1.bJoinable)
                {
                    _loc_2 = _loc_1.aPartyUnit;
                    _loc_3 = PlayerDisplay(_loc_1.aPartyUnit[0]).uniqueId;
                    _loc_4 = QuestManager.getInstance().questData.getPlayerPersonal(_loc_3);
                    if (this._cutIn == null)
                    {
                        this._cutIn = new BattleCutIn(_loc_4.playerId, this._mcUi.allMoveMc.chrCutInMoveMc);
                        _loc_5 = PlayerManager.getInstance().getPlayerInformation(_loc_4.playerId);
                        _loc_6 = this._battleManager.getPartnerCharacterId(_loc_4.questUniqueId);
                        _loc_7 = PlayerManager.getInstance().getWordMergeParty(_loc_5.characterId, _loc_6);
                        this._cutIn.setWordTop(_loc_7);
                        this._cutinTimer = this.SHOW_CUTIN_TIME;
                        this._mergingParty = _loc_1;
                        this._aPartyStatusBar.splice(this._aPartyStatusBar.indexOf(_loc_1), 1);
                        return;
                    }
                }
            }
            return;
        }// end function

        private function controlMergePartyCutin(param1:Number) : void
        {
            if (this._mergingParty == null)
            {
                this.setPhase(this._PHASE_FORWARD_PARTY);
                return;
            }
            if (this._cutinTimer > 0)
            {
                this._cutinTimer = this._cutinTimer - param1;
                if (this._cutinTimer <= 0)
                {
                    this._cutIn.setClose();
                }
            }
            else if (this._cutIn != null)
            {
                if (this._cutIn.bEnd)
                {
                    this._cutIn.release();
                    this._cutIn = null;
                }
            }
            else
            {
                this.setPhase(this._PHASE_MERGE_PARTY);
            }
            return;
        }// end function

        private function phaseMergeParty() : void
        {
            var pd:PlayerDisplay;
            var entryNum:int;
            var id:int;
            var allJoined:Boolean;
            var index:int;
            var playerPersonal:PlayerPersonal;
            var currentUnitNum:int;
            var entry:BattlePlayer;
            var joinPlayer:BattlePlayer;
            var statusBar:StatusBar;
            var commanderUniqueId:int;
            var commander:BattlePlayer;
            var deadPlayer:BattlePlayer;
            var bp:BattlePlayer;
            var basicFormationId:int;
            var aId:Array;
            var bpl:BattlePlayer;
            var mergePlayerDisplay:PlayerDisplay;
            var uid:int;
            var i:int;
            var userData:* = UserDataManager.getInstance().userData;
            var aSortiePlayerUniqueId:* = userData.aSortiePlayerUniqueId;
            var aTargetPoint:Array;
            var _loc_2:* = 0;
            var _loc_3:* = this._mergingParty.aPartyUnit;
            while (_loc_3 in _loc_2)
            {
                
                pd = _loc_3[_loc_2];
                index;
                while (index < aSortiePlayerUniqueId.length)
                {
                    
                    if (pd.uniqueId == aSortiePlayerUniqueId[index])
                    {
                        playerPersonal = QuestManager.getInstance().questData.getPlayerPersonal(pd.uniqueId);
                        currentUnitNum = this._battleManager.getEntryPlayer().length;
                        if (currentUnitNum < this._aStatusBar.length)
                        {
                            statusBar = this._aStatusBar[currentUnitNum];
                            statusBar.setPlayer(entry, currentUnitNum);
                        }
                        entry = this._battleManager.addPlayer(this._layer, playerPersonal, Constant.UNDECIDED);
                        this._aPlayer.push(playerPersonal);
                        joinPlayer = this._battleManager.getCharacter(playerPersonal.questUniqueId) as BattlePlayer;
                        joinPlayer.characterAction.characterDisplay.mc.visible = false;
                    }
                    index = (index + 1);
                }
            }
            entryNum;
            var _loc_2:* = 0;
            var _loc_3:* = aSortiePlayerUniqueId;
            while (_loc_3 in _loc_2)
            {
                
                id = _loc_3[_loc_2];
                if (id != Constant.EMPTY_ID)
                {
                    entryNum = (entryNum + 1);
                }
            }
            allJoined = this._battleManager.getEntryPlayer().length >= entryNum;
            if (allJoined)
            {
                commanderUniqueId = aSortiePlayerUniqueId[FormationSetData.FORMATION_INDEX_COMMANDER];
                if (commanderUniqueId != Constant.EMPTY_ID)
                {
                    this._battleManager.setCommander(commanderUniqueId);
                    commander = this._battleManager.commanderPlayer;
                    if (commander && commander.playerPersonal.bDead == false)
                    {
                        deadPlayer;
                        var _loc_2:* = 0;
                        var _loc_3:* = this._battleManager.aPlayer;
                        while (_loc_3 in _loc_2)
                        {
                            
                            bp = _loc_3[_loc_2];
                            if (bp.playerPersonal.bDead)
                            {
                                deadPlayer = bp;
                                break;
                            }
                        }
                        if (deadPlayer)
                        {
                            this._battleManager.changeCommander(deadPlayer.playerPersonal.uniqueId);
                            i;
                            while (i < aSortiePlayerUniqueId.length)
                            {
                                
                                if (aSortiePlayerUniqueId[i] == deadPlayer.playerPersonal.uniqueId)
                                {
                                    aSortiePlayerUniqueId[i] = commander.playerPersonal.uniqueId;
                                    break;
                                }
                                i = (i + 1);
                            }
                            aSortiePlayerUniqueId[FormationSetData.FORMATION_INDEX_COMMANDER] = deadPlayer.playerPersonal.uniqueId;
                            deadPlayer.formationIndex = FormationSetData.FORMATION_INDEX_COMMANDER;
                            deadPlayer.setPosition(this._formationData.getCommanderOutPosition());
                        }
                    }
                }
                this._unitFormation.setData(userData.formationId, aSortiePlayerUniqueId.concat());
                if (this._battleManager.commanderPlayer)
                {
                    this._battleManager.commanderPlayer.formationIndex = FormationSetData.FORMATION_INDEX_COMMANDER;
                    this._battleScroll.setCommanderTargetPosition(this._battleManager.commanderPlayer);
                    this._battleManager.commanderPlayer.status.badStatusClear();
                }
                this.updateCommanderSkillBonus();
            }
            else
            {
                basicFormationId = FormationManager.getInstance().getBasicFormationId(this._battleManager.getEntryPlayer().length);
                aId;
                i;
                var _loc_2:* = 0;
                var _loc_3:* = this._battleManager.getEntryPlayer();
                while (_loc_3 in _loc_2)
                {
                    
                    bpl = _loc_3[_loc_2];
                    aId[i] = bpl.playerPersonal.uniqueId;
                    i = (i + 1);
                }
                this._unitFormation.setData(basicFormationId, aId);
            }
            this.formationPositionResetStart(this._unitFormation.id, this._unitFormation.aPlayerUniqueId, true, function () : void
            {
                var _loc_1:* = FormationManager.getInstance().getFormationSkillInformationByFormationId(_formationData.formationId);
                _formationStatusBar.updateFormation(_formationData.formationId);
                _formationStatusBar.updateFormationSkill(_loc_1);
                var _loc_2:* = _battleManager.getEntryPlayer();
                var _loc_3:* = _unitFormation.aPlayerUniqueId;
                formationPositionResetEnd(_battleManager.getEntryPlayer(), _unitFormation.aPlayerUniqueId);
                setPhase(_PHASE_MERGE_PARTY_CUTIN);
                return;
            }// end function
            );
            if (allJoined)
            {
                var _loc_2:* = 0;
                var _loc_3:* = this._mergingParty.aPartyUnit;
                while (_loc_3 in _loc_2)
                {
                    
                    mergePlayerDisplay = _loc_3[_loc_2];
                    i;
                    var _loc_4:* = 0;
                    var _loc_5:* = this._unitFormation.aPlayerUniqueId;
                    while (_loc_5 in _loc_4)
                    {
                        
                        uid = _loc_5[_loc_4];
                        if (mergePlayerDisplay.uniqueId == uid)
                        {
                            aTargetPoint.push(this._formationData.getOutPosition(i));
                            break;
                        }
                        i = (i + 1);
                    }
                }
            }
            else
            {
                i;
                while (i < this._mergingParty.aPartyUnit.length)
                {
                    
                    aTargetPoint.push(this._formationData.getOutPosition(this._battleManager.getEntryPlayer().length - this._mergingParty.aPartyUnit.length + i));
                    i = (i + 1);
                }
            }
            this._mergingParty.mergeParty(aTargetPoint);
            return;
        }// end function

        private function controlMergeParty(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this._bFormationChangeMoving)
            {
                if (!this.isEntryPlayerMoving())
                {
                    this._bFormationChangeMoving = false;
                    this.sortCharacterDisplay(this._battleManager.getEntryCharacter());
                }
            }
            if (this._mergingParty != null)
            {
                this._mergingParty.control(param1);
                if (this._mergingParty.bAnimation)
                {
                    if (this._mergingParty.bClosing)
                    {
                        for each (_loc_2 in this._battleManager.getEntryPlayerAll())
                        {
                            
                            _loc_2.characterAction.characterDisplay.mc.visible = true;
                        }
                        this._mergingParty.setCharacterVisible(false);
                    }
                    return;
                }
                else
                {
                    this._mergingParty.release();
                    this._mergingParty = null;
                }
            }
            if (this._bFormationChangeMoving == false && this._mergingParty == null)
            {
                if (this._cbFormationChangeMoved != null)
                {
                    this._cbFormationChangeMoved();
                }
                if (this._aPartyStatusBar.length == 0)
                {
                    this._bDivideParty = false;
                }
            }
            return;
        }// end function

        private function phaseForwardParty() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aPartyStatusBar)
            {
                
                QuestManager.getInstance().addFeverCount();
                _loc_1.goForward();
            }
            return;
        }// end function

        private function controlForwardParty(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_4:* = null;
            for each (_loc_2 in this._aPartyStatusBar)
            {
                
                if (_loc_2.bAnimation || _loc_2.bMoving)
                {
                    return;
                }
            }
            this.partyStatusBarAutoHide();
            if (this._formationStatusBar.isOpend() == false)
            {
                _loc_3 = true;
                for each (_loc_4 in this._battleManager.aPlayer)
                {
                    
                    if (_loc_4.playerPersonal.bDead == false)
                    {
                        _loc_3 = false;
                        break;
                    }
                }
                if (this._battleManager.commanderPlayer && this._battleManager.commanderPlayer.playerPersonal.bDead == false)
                {
                    _loc_3 = false;
                }
                if (_loc_3 == false)
                {
                    if (!this._formationStatusBar.isAnimetionOpen())
                    {
                        this._formationStatusBar.openWindow();
                    }
                }
            }
            this.setPhase(this._PHASE_METAMORPHOSE);
            return;
        }// end function

        private function phaseNewSkill() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_1 in this._aAttackData)
            {
                
                if (_loc_1.attackType == BattleConstant.ATTACK_DATA_TYPE_SKILL)
                {
                    _loc_2 = _loc_1 as AttackDataSkill;
                    if (_loc_2.bComeUp)
                    {
                        _loc_3 = SkillManager.getInstance().getSkillInformation(_loc_2.skillId);
                        ResourceManager.getInstance().loadArray(SkillManager.getInstance().getSkillPath(_loc_3.effectId));
                        SoundManager.getInstance().loadSoundArray(SkillManager.getInstance().getSkillSeId(_loc_3.effectId));
                    }
                }
            }
            return;
        }// end function

        private function controlNewSkill(param1:Number) : void
        {
            if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.setPhase(this._PHASE_PLAY_ATTACK);
            }
            return;
        }// end function

        private function phaseComeUpSkill() : void
        {
            var _loc_1:* = this._aAttackData[this._attackDataIndex] as AttackDataSkill;
            var _loc_2:* = this._battleManager.getCharacter(_loc_1.questUniqueId) as BattlePlayer;
            this.setCharacterDarkOut(_loc_2.division, _loc_2.personal.questUniqueId, true);
            var _loc_3:* = new Point();
            _loc_3 = _loc_3.add(new Point(0, -40));
            _loc_3 = _loc_3.add(this._formationData.getPosition(_loc_2.formationIndex));
            this._effFlash = new EffectCoruscate(this._layer.getLayer(LayerBattle.FRONT_EFFECT), _loc_3);
            this._effectManager.addEffect(this._effFlash);
            _loc_2.playerPersonal.addSetSkill(_loc_1.skillId);
            _loc_2.playerPersonal.addOwnSkill(_loc_1.skillId);
            this._cam.moveCamera(_loc_3, 1.5, 0.2);
            return;
        }// end function

        private function controlComeUpSkill(param1:Number) : void
        {
            if (this._effFlash != null)
            {
                if (this._effectManager.isExist(this._effFlash) == false && this._cam.isMoveEnd())
                {
                    this._cam.moveDefaultCamera(0.2);
                    this._effFlash = null;
                }
            }
            else if (this._cam.isMoveEnd())
            {
                this.setCharacterDarkOut(0, 0, false);
                this.setPhase(this._PHASE_COMBO_START);
            }
            return;
        }// end function

        private function phaseComboStart() : void
        {
            var _loc_9:* = null;
            var _loc_1:* = this._aAttackData[this._attackDataIndex] as AttackDataSkill;
            var _loc_2:* = SkillManager.getInstance().getSkillInformation(_loc_1.skillId);
            if (_loc_1.comboCount <= 1)
            {
                this._aComboName = [];
                this._aComboName.push(_loc_2.linkSkillNameHead);
            }
            else
            {
                this._aComboName.push(_loc_2.linkSkillNameNext);
            }
            var _loc_3:* = BattleManager.getComboGrade(_loc_1.comboCount);
            if (_loc_3 == BattleConstant.COMBO_GRADE0)
            {
                this._battleComboCounter.close();
                this._bg.bDarkOut = false;
                return;
            }
            this._bg.bDarkOut = true;
            this._battleComboCounter.open(_loc_1.comboCount);
            var _loc_4:* = this._battleManager.getCharacter(_loc_1.questUniqueId);
            var _loc_5:* = this._battleManager.getCharacter(_loc_1.questUniqueId).characterAction.characterDisplay;
            var _loc_6:* = this._battleManager.getCharacter(_loc_1.questUniqueId).characterAction.characterDisplay.pos;
            this._effectCombo = new EffectCombo(this._layer.getLayer(LayerBattle.CHARACTER), _loc_5, _loc_6, _loc_3);
            this._effectManager.addEffect(this._effectCombo);
            var _loc_7:* = false;
            var _loc_8:* = false;
            if (_loc_5.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_7 = true;
            }
            if (_loc_5.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                _loc_9 = (_loc_5 as EnemyDisplay).info;
                if (_loc_9.bossFlag)
                {
                    _loc_7 = true;
                    _loc_8 = true;
                }
                if (_loc_6.y > 440)
                {
                    _loc_6.y = 440;
                }
            }
            if (_loc_7)
            {
                this._cutInSide = new BattleCutInSide(this._layer.getLayer(LayerBattle.CHARACTER), _loc_5, _loc_6, _loc_8);
            }
            this.setCharacterDarkOut(_loc_4.division, _loc_4.personal.questUniqueId, true);
            return;
        }// end function

        private function controlComboStart(param1:Number) : void
        {
            if (this._effectCombo != null && this._effectManager.isExist(this._effectCombo) == false)
            {
                this._effectCombo.release();
                this._effectCombo = null;
                if (this._cutInSide != null)
                {
                    this._cutInSide.play();
                }
            }
            if (this._cutInSide != null && this._cutInSide.isEnd)
            {
                this._cutInSide.release();
                this._cutInSide = null;
            }
            if (this._effectCombo == null && this._cutInSide == null)
            {
                this.setPhase(this._PHASE_PLAY_SKILL_NAME);
            }
            return;
        }// end function

        private function phaseMetamorphose() : void
        {
            this._battleMetamorphoseMain = new BattleMetamorphoseMain(this._battleManager);
            return;
        }// end function

        private function controlMetamorphose(param1:Number) : void
        {
            this._battleMetamorphoseMain.control(param1);
            if (this._battleMetamorphoseMain.bEnd)
            {
                this._battleMetamorphoseMain.release();
                this._battleMetamorphoseMain = null;
                this.changePhase_Replenish();
            }
            return;
        }// end function

        private function changePhase_Replenish() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = false;
            var _loc_2:* = this._battleManager.commanderPlayer;
            if (_loc_2 && _loc_2.playerPersonal.bDead == false)
            {
                for each (_loc_3 in this._battleManager.aPlayer)
                {
                    
                    if (_loc_3.playerPersonal.bDead)
                    {
                        _loc_1 = true;
                        break;
                    }
                }
            }
            if (_loc_1)
            {
                this._layoutManager.changeLayout(BattleLayoutManager.LAYOUT_REPLENISH, this._PHASE_REPLENISH);
                this.setPhase(this._PHASE_LAYOUT_CHANGE);
            }
            else
            {
                this.setPhase(this._PHASE_TURN_INIT);
            }
            return;
        }// end function

        private function phaseReplenish() : void
        {
            var bp:BattlePlayer;
            var commander:BattlePlayer;
            var aFormationPlayerUniqueId:Array;
            var i:int;
            var deadPlayer:BattlePlayer;
            var _loc_2:* = 0;
            var _loc_3:* = this._battleManager.aPlayer;
            while (_loc_3 in _loc_2)
            {
                
                bp = _loc_3[_loc_2];
                if (bp.playerPersonal.bDead)
                {
                    deadPlayer = bp;
                    break;
                }
            }
            commander = this._battleManager.commanderPlayer;
            this._battleManager.changeCommander(deadPlayer.playerPersonal.uniqueId);
            aFormationPlayerUniqueId = this._unitFormation.aPlayerUniqueId;
            i;
            while (i < aFormationPlayerUniqueId.length)
            {
                
                if (aFormationPlayerUniqueId[i] == deadPlayer.playerPersonal.uniqueId)
                {
                    aFormationPlayerUniqueId[i] = commander.playerPersonal.uniqueId;
                }
                else if (aFormationPlayerUniqueId[i] == commander.playerPersonal.uniqueId)
                {
                    aFormationPlayerUniqueId[i] = deadPlayer.playerPersonal.uniqueId;
                }
                i = (i + 1);
            }
            this._unitFormation.setData(this._unitFormation.id, aFormationPlayerUniqueId);
            commander.formationIndex = Constant.UNDECIDED;
            commander.characterAction.characterDisplay.mc.visible = true;
            deadPlayer.formationIndex = FormationSetData.FORMATION_INDEX_COMMANDER;
            deadPlayer.setPosition(this._formationData.getCommanderOutPosition());
            this.updateCommanderSkillBonus();
            this.formationPositionResetStart(this._unitFormation.id, aFormationPlayerUniqueId, false, function () : void
            {
                var _loc_1:* = FormationManager.getInstance().getFormationSkillInformationByFormationId(_formationData.formationId);
                _formationStatusBar.updateFormation(_formationData.formationId);
                _formationStatusBar.updateFormationSkill(_loc_1);
                var _loc_2:* = _battleManager.getEntryPlayer();
                var _loc_3:* = _unitFormation.aPlayerUniqueId;
                formationPositionResetEnd(_battleManager.getEntryPlayer(), _unitFormation.aPlayerUniqueId);
                _layoutManager.changeLayout(BattleLayoutManager.LAYOUT_NORMAL, _PHASE_TURN_INIT);
                setPhase(_PHASE_LAYOUT_CHANGE);
                return;
            }// end function
            );
            return;
        }// end function

        private function controlReplenish(param1:Number) : void
        {
            if (this._bFormationChangeMoving)
            {
                if (!this.isEntryPlayerMoving())
                {
                    this._bFormationChangeMoving = false;
                    SoundManager.getInstance().playSe(SoundId.SE_LANDING1016B);
                    if (this._cbFormationChangeMoved != null)
                    {
                        this._cbFormationChangeMoved();
                    }
                }
            }
            return;
        }// end function

        private function phaseEscapeMotion() : void
        {
            this._escapeMain = new BattlePhaseEscapeMain(this._battleManager);
            this._battleMessage.setMessageCharacterClose();
            this.clearBadStateIcon();
            return;
        }// end function

        private function controlEscapeMotion(param1:Number) : void
        {
            if (this._escapeMain != null)
            {
                this._escapeMain.control(param1);
                if (this._escapeMain.bEnd)
                {
                    this.setPhase(this._PHASE_BATTLE_RESULT_ESCAPE);
                }
            }
            return;
        }// end function

        private function setCharacterDarkOut(param1:int, param2:uint, param3:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param3)
            {
                if (param1 == BattleConstant.DIVISION_PLAYER)
                {
                    for each (_loc_4 in this._battleManager.getEntryPlayer())
                    {
                        
                        if (_loc_4.personal.questUniqueId != param2)
                        {
                            _loc_4.characterAction.characterDisplay.bDarkOut = true;
                        }
                    }
                }
                if (param1 == BattleConstant.DIVISION_ENEMY)
                {
                    for each (_loc_5 in this._battleManager.getEntryEnemy())
                    {
                        
                        if (_loc_5.personal.questUniqueId != param2)
                        {
                            _loc_5.characterAction.characterDisplay.bDarkOut = true;
                        }
                    }
                }
            }
            else
            {
                for each (_loc_6 in this._battleManager.getEntryCharacter())
                {
                    
                    _loc_6.characterAction.characterDisplay.bDarkOut = false;
                }
            }
            return;
        }// end function

        private function changePhase_BattleResultWin() : void
        {
            this._layoutManager.changeLayout(BattleLayoutManager.LAYOUT_WIN, this._PHASE_BATTLE_RESULT_WIN);
            this.setPhase(this._PHASE_LAYOUT_CHANGE);
            return;
        }// end function

        private function phaseBattleResultWin() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this._result = BattleConstant.RESULT_WIN;
            this.buttonEnable(false);
            SoundManager.getInstance().playBgm(SoundId.BGM_BATTLE_WIN);
            this.sortCharacterDisplay(this._battleManager.getEntryPlayer());
            for each (_loc_1 in this._aStatusBar)
            {
                
                _loc_1.setPreviewMode(false);
            }
            for each (_loc_2 in this._battleManager.getEntryPlayerAll())
            {
                
                if (_loc_2.personal.bDead)
                {
                    continue;
                }
                _loc_2.status.badStatusClear();
                _loc_2.characterAction.setActionWin();
            }
            return;
        }// end function

        private function controlBattleResultWin(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = false;
            for each (_loc_3 in this._battleManager.getEntryPlayerAll())
            {
                
                if (_loc_3.characterAction.bAnimationEnd == false)
                {
                    _loc_2 = true;
                    break;
                }
            }
            if (_loc_2 == false)
            {
                this.setPhase(this._PHASE_BATTLE_RESULT_STATUS_UP);
            }
            return;
        }// end function

        private function phaseBattleResultLose() : void
        {
            this._result = BattleConstant.RESULT_LOSE;
            this.buttonEnable(false);
            SoundManager.getInstance().playBgm(SoundId.BGM_BATTLE_LOSE);
            if (this._bDivideParty && this._battleType == BattleConstant.BATTLE_TYPE_NORMAL)
            {
                this.setPhase(this._PHASE_CHECK_CONTINUE);
                return;
            }
            this._bRetreat = true;
            this._bResultLoseMode = true;
            this._mcAnnihilation = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "UI_BattleMain.swf", "UnitWipeOutTextMc");
            this._parent.addChild(this._mcAnnihilation);
            this._isoAnnihilation = new InStayOut(this._mcAnnihilation);
            TextControl.setIdText(this._mcAnnihilation.texrMc.textDt, MessageId.BATTLE_LOSE_MESSAGE);
            this._fadeTime = 0;
            return;
        }// end function

        private function controlBattleResultLose(param1:Number) : void
        {
            var _loc_2:* = NaN;
            if (this._fadeTime < this._BG_FADE_TIME_LOSE)
            {
                this._fadeTime = this._fadeTime + param1;
                if (this._fadeTime > this._BG_FADE_TIME_LOSE)
                {
                    this._fadeTime = this._BG_FADE_TIME_LOSE;
                }
                _loc_2 = 1 - 0.5 * (this._fadeTime / this._BG_FADE_TIME_LOSE);
                this._mcUi.transform.colorTransform = new ColorTransform(_loc_2, _loc_2, _loc_2);
                if (this._isoAnnihilation.bWait)
                {
                    this._isoAnnihilation.setIn();
                }
            }
            else if (this._isoAnnihilation.bEnd)
            {
                this.setPhase(this._PHASE_CHECK_LOSE_ALERT);
            }
            return;
        }// end function

        private function phaseBattleResultEscape() : void
        {
            this._bRetreat = true;
            this._result = BattleConstant.RESULT_ESCAPE;
            return;
        }// end function

        private function controlBattleResultEscape(param1:Number) : void
        {
            this.setPhase(this._PHASE_BATTLE_END);
            return;
        }// end function

        private function phaseBattleResultStatusUp() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            this._formationStatusBar.closeWindow();
            if (this._isoAmulet)
            {
                if (this._isoAmulet.bClosed)
                {
                    this._isoAmulet.setIn();
                }
            }
            this._bStatusUpMode = false;
            this._battleMessage.setMessageCharacterClose();
            while (this._statusUpIndex < this._aBonus.length)
            {
                
                _loc_1 = this._aBonus[this._statusUpIndex];
                _loc_2 = this._battleManager.getCharacter(_loc_1.questUniqueId) as BattlePlayer;
                if (_loc_2 == null)
                {
                }
                else if (_loc_2.personal.bDead)
                {
                }
                else
                {
                    _loc_3 = _loc_1.bonus.getStatusUpId();
                    while (this._statusUpBonusIndex < _loc_3.length)
                    {
                        
                        _loc_4 = _loc_3[this._statusUpBonusIndex];
                        _loc_5 = Constant.UNDECIDED;
                        switch(_loc_4)
                        {
                            case PlayerBattleBonus.STATUS_ATTAK:
                            {
                                _loc_5 = MessageId.BATTLE_STATUSUP_ATTACK;
                                break;
                            }
                            case PlayerBattleBonus.STATUS_DEFENSE:
                            {
                                _loc_5 = MessageId.BATTLE_STATUSUP_DEFENSE;
                                break;
                            }
                            case PlayerBattleBonus.STATUS_SPEED:
                            {
                                _loc_5 = MessageId.BATTLE_STATUSUP_SPEED;
                                break;
                            }
                            case PlayerBattleBonus.STATUS_HP:
                            {
                                _loc_5 = MessageId.BATTLE_STATUSUP_HP;
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        if (_loc_5 != Constant.UNDECIDED)
                        {
                            this._autoSkipStatusUpTime = this._AUTO_SKIP_STATUS_UP_TIME;
                            this._bStatusUpMode = true;
                            this._bStatusUped = true;
                            if (this._isoNext.bClosed)
                            {
                                this._isoNext.setIn();
                            }
                            this._battleMessage.addMessageCharacter(_loc_1.questUniqueId, MessageManager.getInstance().getMessage(_loc_5));
                            _loc_2.characterAction.setActionStatusUp();
                            if (_loc_4 == PlayerBattleBonus.STATUS_HP)
                            {
                                _loc_2.fixRecoverTargetDamage();
                                _loc_2.playerPersonal.addMaxHp(_loc_1.bonus.hp);
                            }
                            var _loc_10:* = this;
                            var _loc_11:* = this._statusUpBonusIndex + 1;
                            _loc_10._statusUpBonusIndex = _loc_11;
                            _loc_6 = new Point();
                            _loc_6 = _loc_6.add(new Point(80, -100));
                            _loc_6 = _loc_6.add(this._formationData.getPosition(_loc_2.formationIndex));
                            this._cam.moveCamera(_loc_6, 1.5, 0.2);
                            return;
                        }
                        var _loc_10:* = this;
                        var _loc_11:* = this._statusUpBonusIndex + 1;
                        _loc_10._statusUpBonusIndex = _loc_11;
                    }
                    if (_loc_3.length > 0 && _loc_1.bonus.getStatusUpId().length == this._statusUpBonusIndex)
                    {
                        this._bStatusUpMode = true;
                        this._bStatusUped = true;
                        if (this._isoNext.bClosed)
                        {
                            this._isoNext.setIn();
                        }
                        this._cutIn = new BattleCutIn(_loc_2.playerPersonal.playerId, this._mcUi.allMoveMc.chrCutInMoveMc);
                        _loc_7 = PlayerManager.getInstance().getPlayerInformation(_loc_2.playerPersonal.playerId);
                        _loc_8 = this._battleManager.getPartnerCharacterId(_loc_2.personal.questUniqueId);
                        _loc_9 = PlayerManager.getInstance().getWordStatusUp(_loc_7.characterId, _loc_8);
                        this._cutIn.setWordTop(_loc_9);
                        var _loc_10:* = this;
                        var _loc_11:* = this._statusUpBonusIndex + 1;
                        _loc_10._statusUpBonusIndex = _loc_11;
                        SoundManager.getInstance().playSe(SoundId.SE_JUMP3);
                        return;
                    }
                    this._statusUpBonusIndex = 0;
                }
                var _loc_10:* = this;
                var _loc_11:* = this._statusUpIndex + 1;
                _loc_10._statusUpIndex = _loc_11;
            }
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_FIRST_BATTLE_END))
            {
                TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_FIRST_BATTLE_END);
                this._bStatusUpMode = true;
                this._bStatusUped = true;
                if (this._isoNext.bClosed)
                {
                    this._isoNext.setIn();
                }
                this._autoSkipStatusUpTime = 0;
                return;
            }
            if (this._bStatusUped)
            {
                this.setPhase(this._PHASE_BATTLE_END);
            }
            else
            {
                this.setPhase(this._PHASE_BATTLE_RESULT_STATUS_UP_END);
            }
            return;
        }// end function

        private function controlBattleResultStatusUp(param1:Number) : void
        {
            if (CommonPopup.isUse())
            {
                return;
            }
            if (this._bStatusUpMode && this._cutIn == null)
            {
                this._autoSkipStatusUpTime = this._autoSkipStatusUpTime - param1;
                if (this._autoSkipStatusUpTime <= 0)
                {
                    this.setPhase(this._PHASE_BATTLE_RESULT_STATUS_UP);
                }
            }
            if (this._cutIn != null)
            {
                if (this._cutIn.bEnd)
                {
                    this._cutIn.release();
                    this._cutIn = null;
                    this.setPhase(this._PHASE_BATTLE_RESULT_STATUS_UP);
                }
            }
            return;
        }// end function

        private function phaseBattleResultStatusUpEnd() : void
        {
            if (this._isoNext.bClosed)
            {
                this._isoNext.setIn();
            }
            return;
        }// end function

        private function controlBattleResultStatusUpEnd(param1:Number) : void
        {
            return;
        }// end function

        private function phaseCheckContinue() : void
        {
            if (this._isoNext.bClosed == false)
            {
                this._isoNext.setOut();
            }
            if (this._battleType == BattleConstant.BATTLE_TYPE_BOSS)
            {
                this.setPhase(this._PHASE_BATTLE_END);
                return;
            }
            this._checkContinue = new BattleCheckContinue(this._parent);
            if (this._bDarkFadeIn == false)
            {
                this._bDarkFadeIn = true;
                this._fadeTime = 0;
            }
            return;
        }// end function

        private function controlCheckContinue(param1:Number) : void
        {
            var _loc_3:* = 0;
            this._fadeTime = this._fadeTime + param1;
            if (this._fadeTime > this._BG_FADE_TIME_WIN)
            {
                this._fadeTime = this._BG_FADE_TIME_WIN;
            }
            var _loc_2:* = 1 - 0.5 * (this._fadeTime / this._BG_FADE_TIME_WIN);
            this._mcUi.transform.colorTransform = new ColorTransform(_loc_2, _loc_2, _loc_2);
            if (this._checkContinue && this._checkContinue.bClose)
            {
                if (this._checkContinue.select != Constant.UNDECIDED)
                {
                    _loc_3 = this._PHASE_BATTLE_END;
                    if (this._checkContinue.select == BattleCheckContinue.SELECT_NO)
                    {
                        this._bRetreat = true;
                        _loc_3 = this._PHASE_CHECK_RETREAT;
                    }
                    this._checkContinue.release();
                    this._checkContinue = null;
                    this.setPhase(_loc_3);
                }
            }
            return;
        }// end function

        private function phaseCheckRetreat() : void
        {
            if (this._checkContinue != null)
            {
                this._checkContinue.release();
                this._checkContinue = null;
            }
            this._checkContinue = new BattleCheckContinue(this._parent, true);
            return;
        }// end function

        private function controlCheckRetreat(param1:Number) : void
        {
            var _loc_2:* = 0;
            if (this._checkContinue && this._checkContinue.bClose)
            {
                if (this._checkContinue.select != Constant.UNDECIDED)
                {
                    _loc_2 = this._PHASE_BATTLE_END;
                    if (this._checkContinue.select == BattleCheckContinue.SELECT_NO)
                    {
                        this._bRetreat = false;
                        _loc_2 = this._PHASE_CHECK_CONTINUE;
                    }
                    this._checkContinue.release();
                    this._checkContinue = null;
                    this.setPhase(_loc_2);
                }
            }
            return;
        }// end function

        private function phaseCheckLoseAlert() : void
        {
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.BATTLE_LOSE_MESSAGE2), function () : void
            {
                setPhase(_PHASE_BATTLE_END);
                return;
            }// end function
            );
            return;
        }// end function

        private function controlCheckLoseAlert(param1:Number) : void
        {
            return;
        }// end function

        private function phaseLayoutChange() : void
        {
            return;
        }// end function

        private function controlLayoutChange(param1:Number) : void
        {
            this._layoutManager.control(param1);
            if (this._layoutManager.bBusy == false)
            {
                this.setPhase(this._layoutManager.nextPhase);
            }
            return;
        }// end function

        private function phaseBattleEnd() : void
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_1:* = this._battleManager.getEntryPlayerAll();
            for each (_loc_2 in _loc_1)
            {
                
                if (_loc_2.playerPersonal.bDead)
                {
                    continue;
                }
                _loc_2.playerPersonal.setHp(BattleCalc.calcAfterHp(_loc_2));
            }
            if (this._battleManager.deadPlayer)
            {
                _loc_4 = this._unitFormation.aPlayerUniqueId;
                _loc_5 = _loc_4.indexOf(this._battleManager.changedCommanderUniueId);
                _loc_4[_loc_5] = this._battleManager.deadPlayer.playerPersonal.uniqueId;
                _loc_4[FormationSetData.FORMATION_INDEX_COMMANDER] = this._battleManager.changedCommanderUniueId;
                this._writebackUnitFormation = new FormationSetData(this._unitFormation.id, _loc_4);
            }
            else
            {
                this._writebackUnitFormation = new FormationSetData(this._unitFormation.id, this._unitFormation.aPlayerUniqueId);
            }
            var _loc_3:* = Main.GetApplicationData().userConfigData;
            _loc_3.resetBattleSpeed();
            this._battleSpeed = 1;
            if (TutorialManager.getInstance().isTutorial())
            {
                ButtonManager.getInstance().clearSeal();
            }
            this._bEnd = true;
            return;
        }// end function

        private function controlBattleEnd(param1:Number) : void
        {
            return;
        }// end function

        private function inDamageData(param1:AttackDamage) : void
        {
            if (param1.bRecoveryHp)
            {
                this._battleManager.createRecoveryHp(param1.questUniqueId, param1.attackerQuestUniqueId, param1.recoveryHp);
            }
            this._battleManager.createDamageHp(param1.questUniqueId, param1.attackerQuestUniqueId, param1.damageHp, param1.hitType, param1.bDeadDisable, param1.bCounter, false, param1.bSkipDamage || param1.bRecoveryHp, param1.bAllyEffect);
            if (param1.damageLp > 0)
            {
                this._battleManager.createDamageLp(param1.questUniqueId, param1.attackerQuestUniqueId, param1.damageLp, param1.bBrokenItem);
            }
            if (param1.bBadStatusResist)
            {
                this._battleManager.createDamageBadStatusResist(param1.questUniqueId, param1.attackerQuestUniqueId);
            }
            if (param1.addBadStatus.bBadStatus)
            {
                this._battleManager.createDamageBadStatus(param1.questUniqueId, param1.attackerQuestUniqueId, param1.addBadStatus, param1.bBrokenItem);
            }
            if (param1.recoveryBadStatus.bRecovery)
            {
                this._battleManager.createDamageBadStatusRecovery(param1.questUniqueId, param1.attackerQuestUniqueId, param1.recoveryBadStatus);
            }
            return;
        }// end function

        private function sortCharacterDisplay(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in param1)
            {
                
                _loc_2.push({questUniqueId:_loc_3.personal.questUniqueId, y:_loc_3.characterAction.characterDisplay.layer.y});
            }
            _loc_2.sortOn("y", Array.NUMERIC);
            for each (_loc_4 in _loc_2)
            {
                
                _loc_5 = this._battleManager.getCharacter(_loc_4.questUniqueId);
                _loc_6 = _loc_5.characterAction.characterDisplay;
                DisplayUtils.setTopPriority(_loc_6.layer.parent, _loc_6.layer);
            }
            return;
        }// end function

        private function setDecisionOrder() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            this._aOrder = [];
            this._aPassQuestUniqueId = [];
            for each (_loc_3 in this._battleManager.getEntryPlayer())
            {
                
                if (_loc_3.playerPersonal.bDead)
                {
                    continue;
                }
                if (BattleManager.isActionNotBe(_loc_3.status.badStatus))
                {
                    continue;
                }
                _loc_2 = _loc_3.personal;
                _loc_1 = SkillManager.getInstance().getSkillInformation(_loc_2.useSkillId);
                if (_loc_2.useSkillId == SkillId.DEFENSE)
                {
                    continue;
                }
                _loc_9 = new AttackOrder();
                _loc_9.questUniqueId = _loc_2.questUniqueId;
                _loc_9.speed = BattleCalc.calcSpeed(_loc_3, _loc_1);
                switch(_loc_1.sequenceType)
                {
                    case SkillConstant.SEQUENCE_TYPE_NORMAL:
                    default:
                    {
                        _loc_9.priority = AttackOrder.PRIORITY_NORMAL;
                        break;
                    }
                    case SkillConstant.SEQUENCE_TYPE_LAST:
                    {
                        _loc_9.priority = AttackOrder.PRIORITY_FAST;
                        break;
                    }
                    case :
                    {
                        _loc_9.priority = AttackOrder.PRIORITY_LAST;
                        break;
                        break;
                    }
                }
                this._aOrder.push(_loc_9);
            }
            for each (_loc_4 in this._battleManager.getEntryEnemy())
            {
                
                if (_loc_4.enemyPersonal.bDead)
                {
                    continue;
                }
                if (BattleManager.isActionNotBe(_loc_4.status.badStatus))
                {
                    continue;
                }
                _loc_2 = _loc_4.personal;
                _loc_1 = SkillManager.getInstance().getSkillInformation(_loc_2.useSkillId);
                _loc_10 = new AttackOrder();
                _loc_10.questUniqueId = _loc_2.questUniqueId;
                _loc_10.speed = BattleCalc.calcSpeed(_loc_4, _loc_1);
                switch(_loc_1.sequenceType)
                {
                    case SkillConstant.SEQUENCE_TYPE_NORMAL:
                    default:
                    {
                        _loc_10.priority = AttackOrder.PRIORITY_NORMAL;
                        break;
                    }
                    case SkillConstant.SEQUENCE_TYPE_LAST:
                    {
                        _loc_10.priority = AttackOrder.PRIORITY_FAST;
                        break;
                    }
                    case :
                    {
                        _loc_10.priority = AttackOrder.PRIORITY_LAST;
                        break;
                        break;
                    }
                }
                this._aOrder.push(_loc_10);
            }
            _loc_5 = this._aOrder.length;
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_11 = Random.range(0, (_loc_5 - 1));
                _loc_12 = this._aOrder[_loc_6];
                this._aOrder[_loc_6] = this._aOrder[_loc_11];
                this._aOrder[_loc_11] = _loc_12;
                _loc_6++;
            }
            this._aOrder.sortOn(["priority", "speed"], [Array.NUMERIC | Array.DESCENDING, Array.NUMERIC | Array.DESCENDING]);
            var _loc_7:* = [];
            var _loc_8:* = null;
            switch(this._formationData.formationId)
            {
                case BattleConstant.FORMATION_ID_LIGHTNING:
                {
                    _loc_7 = [2, 3, 4, 5, 1];
                    _loc_8 = this.changeOrder_Normal;
                    break;
                }
                case BattleConstant.FORMATION_ID_RAPID_STREAM:
                {
                    _loc_7 = [1, 2, 3, 4, 5];
                    _loc_8 = this.changeOrder_Normal;
                    break;
                }
                case BattleConstant.FORMATION_ID_MU_FENCE:
                {
                    _loc_7 = [1, 2, 3, 4, 5];
                    _loc_8 = this.changeOrder_Last;
                    break;
                }
                case BattleConstant.FORMATION_ID_DRAGON_FORM:
                {
                    _loc_7 = [1, 2, 3, 4, 5];
                    _loc_8 = this.changeOrder_Normal;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_7.length > 0 && _loc_8 != null && this.isFormationNotBe() == false)
            {
                _loc_13 = this._battleManager.getFormationPlayerQuestUniqueId(this._unitFormation);
                _loc_14 = [];
                _loc_6 = 0;
                while (_loc_6 < _loc_7.length)
                {
                    
                    _loc_15 = _loc_7[_loc_6] - 1;
                    if (_loc_15 >= 0 && _loc_15 < _loc_13.length)
                    {
                        _loc_14.push(_loc_13[_loc_15]);
                    }
                    _loc_6++;
                }
                this._loc_8(_loc_14);
            }
            return;
        }// end function

        private function changeOrder_Normal(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (this.isDifferentPriority(param1))
            {
                return;
            }
            var _loc_2:* = this.searchOrderStartIdx(param1);
            if (_loc_2 != Constant.UNDECIDED)
            {
                _loc_4 = 0;
                _loc_5 = 0;
                _loc_6 = 0;
                while (_loc_6 < this._aOrder.length)
                {
                    
                    _loc_3 = this._aOrder[_loc_6];
                    _loc_7 = param1.indexOf(_loc_3.questUniqueId);
                    if (_loc_7 >= 0)
                    {
                        _loc_3.changeOrder = _loc_2 + _loc_7;
                        if (_loc_4 == 0)
                        {
                            _loc_4 = _loc_2 + param1.length;
                        }
                    }
                    else
                    {
                        _loc_3.changeOrder = _loc_5 + _loc_4;
                        _loc_5++;
                    }
                    _loc_6++;
                }
                this._aOrder.sortOn(["changeOrder"], [Array.NUMERIC]);
            }
            return;
        }// end function

        private function changeOrder_Last(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_6:* = 0;
            if (this.isFastPriority(param1))
            {
                return;
            }
            if (this.isDifferentPriority(param1))
            {
                return;
            }
            var _loc_3:* = this._aOrder.length;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < this._aOrder.length)
            {
                
                _loc_2 = this._aOrder[_loc_5];
                _loc_6 = param1.indexOf(_loc_2.questUniqueId);
                if (_loc_6 >= 0)
                {
                    _loc_2.changeOrder = _loc_3 + _loc_6;
                }
                else
                {
                    _loc_2.changeOrder = _loc_4;
                    _loc_4++;
                }
                _loc_5++;
            }
            this._aOrder.sortOn(["changeOrder"], [Array.NUMERIC]);
            return;
        }// end function

        private function changeOrder_Fast(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_6:* = 0;
            if (this.isLastPriority(param1))
            {
                return;
            }
            if (this.isDifferentPriority(param1))
            {
                return;
            }
            var _loc_3:* = param1.length;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < this._aOrder.length)
            {
                
                _loc_2 = this._aOrder[_loc_5];
                _loc_6 = param1.indexOf(_loc_2.questUniqueId);
                if (_loc_6 >= 0)
                {
                    _loc_2.changeOrder = _loc_6;
                }
                else
                {
                    _loc_2.changeOrder = _loc_3 + _loc_4;
                    _loc_4++;
                }
                _loc_5++;
            }
            this._aOrder.sortOn(["changeOrder"], [Array.NUMERIC]);
            return;
        }// end function

        private function isFormationNotBe() : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = 0;
            for each (_loc_2 in this._battleManager.getEntryPlayer())
            {
                
                if (_loc_2.playerPersonal.bDead)
                {
                    return true;
                }
                if (BattleManager.isSelectNoBe(_loc_2.status))
                {
                    return true;
                }
                _loc_1++;
            }
            _loc_3 = FormationManager.getInstance().getFormationInformation(this._unitFormation.id);
            return _loc_3 == null || _loc_1 < _loc_3.member;
        }// end function

        private function isDifferentPriority(param1:Array) : Boolean
        {
            var _loc_2:* = null;
            var _loc_5:* = 0;
            var _loc_3:* = Constant.UNDECIDED;
            var _loc_4:* = 0;
            while (_loc_4 < this._aOrder.length)
            {
                
                _loc_2 = this._aOrder[_loc_4];
                _loc_5 = param1.indexOf(_loc_2.questUniqueId);
                if (_loc_5 >= 0)
                {
                    if (_loc_3 == Constant.UNDECIDED)
                    {
                        _loc_3 = _loc_2.priority;
                    }
                    else if (_loc_3 != _loc_2.priority)
                    {
                        return true;
                    }
                }
                _loc_4++;
            }
            return false;
        }// end function

        private function isFastPriority(param1:Array) : Boolean
        {
            var _loc_2:* = null;
            var _loc_4:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < this._aOrder.length)
            {
                
                _loc_2 = this._aOrder[_loc_3];
                _loc_4 = param1.indexOf(_loc_2.questUniqueId);
                if (_loc_4 >= 0)
                {
                    if (_loc_2.priority == AttackOrder.PRIORITY_FAST)
                    {
                        return true;
                    }
                }
                _loc_3++;
            }
            return false;
        }// end function

        private function isLastPriority(param1:Array) : Boolean
        {
            var _loc_2:* = null;
            var _loc_4:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < this._aOrder.length)
            {
                
                _loc_2 = this._aOrder[_loc_3];
                _loc_4 = param1.indexOf(_loc_2.questUniqueId);
                if (_loc_4 >= 0)
                {
                    if (_loc_2.priority == AttackOrder.PRIORITY_LAST)
                    {
                        return true;
                    }
                }
                _loc_3++;
            }
            return false;
        }// end function

        private function searchOrderStartIdx(param1:Array) : int
        {
            var _loc_4:* = 0;
            var _loc_2:* = Constant.UNDECIDED;
            var _loc_3:* = 0;
            while (_loc_3 < param1.length && _loc_2 == Constant.UNDECIDED)
            {
                
                _loc_4 = 0;
                while (_loc_4 < this._aOrder.length)
                {
                    
                    if (this._aOrder[_loc_4].questUniqueId == param1[_loc_3])
                    {
                        _loc_2 = _loc_4;
                        break;
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

        private function setEnemySkill() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            for each (_loc_1 in this._battleManager.getEntryEnemy())
            {
                
                if (_loc_1.personal.bDead)
                {
                    continue;
                }
                _loc_2 = this.lotEnemySkill(_loc_1);
                _loc_1.characterAction.setUseSkillId(_loc_2);
            }
            return;
        }// end function

        private function lotEnemySkill(param1:BattleEnemy, param2:Boolean = false) : int
        {
            var _loc_4:* = null;
            var _loc_3:* = new LotList();
            if (param2)
            {
                for each (_loc_4 in param1.aUseSkill)
                {
                    
                    if (_loc_4.skillId != 0 && _loc_4.rate != 0)
                    {
                        _loc_3.addTarget(_loc_4.skillId, 10);
                    }
                }
            }
            else
            {
                for each (_loc_4 in param1.aUseSkill)
                {
                    
                    if (_loc_4.skillId != 0)
                    {
                        _loc_3.addTarget(_loc_4.skillId, _loc_4.rate);
                    }
                }
            }
            return Lot.lotTarget(_loc_3) as int;
        }// end function

        private function setDefense() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._battleManager.getEntryPlayer())
            {
                
                if (_loc_1.personal.bDead)
                {
                    continue;
                }
                if (_loc_1.personal.useSkillId == SkillId.DEFENSE)
                {
                    _loc_1.setDefense(true);
                }
            }
            return;
        }// end function

        private function executionAttack() : void
        {
            this.saveCharacterStatus();
            this.attackFormationFunction();
            this.attackSkillFunction();
            this.executionBadStatusPoison();
            return;
        }// end function

        private function saveCharacterStatus() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._battleManager.getEntryPlayer())
            {
                
                if (_loc_1.playerPersonal.bDead)
                {
                    continue;
                }
                this._aAttackPlayerStatus.push(new AttackCharacterStatus(_loc_1));
            }
            for each (_loc_2 in this._battleManager.getEntryEnemy())
            {
                
                if (_loc_2.enemyPersonal.bDead)
                {
                    continue;
                }
                this._aAttackEnemyStatus.push(new AttackCharacterStatus(_loc_2));
            }
            return;
        }// end function

        private function getCharacterStatus(param1:int) : AttackCharacterStatus
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in this._aAttackPlayerStatus)
            {
                
                if (_loc_2.questUniqueId == param1)
                {
                    return _loc_2;
                }
            }
            for each (_loc_3 in this._aAttackEnemyStatus)
            {
                
                if (_loc_3.questUniqueId == param1)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        private function attackFormationFunction() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            if (this._aFormationSkillOrder.length == 0)
            {
                return;
            }
            var _loc_1:* = FormationManager.getInstance().getFormationSkillInformationByFormationId(this._formationData.formationId);
            for each (_loc_2 in this._aFormationSkillOrder)
            {
                
                this._aPassQuestUniqueId.push(_loc_2.questUniqueId);
            }
            _loc_5 = BattleUtilityTarget.getTargetEnemy(this._aAttackEnemyStatus);
            _loc_6 = [];
            switch(_loc_1.activeRange)
            {
                case FormationSkillConstant.ACTIVE_RANGE_SHORT_DISTANCE_SINGLE_ENEMY:
                {
                    _loc_6 = BattleUtilityTarget.getTargetRangeNormal(_loc_5);
                    break;
                }
                case FormationSkillConstant.ACTIVE_RANGE_LONG_DISTANCE_SINGLE_ENEMY:
                {
                    _loc_6 = BattleUtilityTarget.getTargetRangeLong(_loc_5);
                    break;
                }
                case FormationSkillConstant.ACTIVE_RANGE_ALL_ENEMIES:
                {
                    _loc_6 = BattleUtilityTarget.getTargetRangeAll(_loc_5);
                    break;
                }
                case FormationSkillConstant.ACTIVE_RANGE_ALL_ALLIES:
                {
                    _loc_13 = this.getTargetPlayerArray();
                    _loc_6 = BattleUtilityTarget.getTargetRangePlayerAll(_loc_13);
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_7:* = new AttackDataFormation();
            this._aAttackData.push(_loc_7);
            var _loc_8:* = [];
            var _loc_9:* = [];
            for each (_loc_2 in this._aFormationSkillOrder)
            {
                
                _loc_9.push(_loc_2.questUniqueId);
                _loc_8.push(this._battleManager.getCharacter(_loc_2.questUniqueId));
            }
            _loc_7.aQuestUniqueId = _loc_9.concat();
            _loc_7.formationSkillId = _loc_1.id;
            _loc_7.useSp = _loc_1.skillPoint;
            _loc_10 = BattleCalc.calcDamageFormationSkill(_loc_8, _loc_1);
            _loc_11 = [];
            for each (_loc_12 in _loc_6)
            {
                
                _loc_14 = this.getCharacterStatus(_loc_12);
                _loc_15 = this.executeAttackDamage(_loc_14, Constant.EMPTY_ID, BattleConstant.HIT_TYPE_NORMAL, _loc_10, new BattleAddStatusResult(), true, BattleConstant.DEFENSE_SHIELD_NON, false, false);
                if (_loc_15.bDead)
                {
                    this._aPassQuestUniqueId.push(_loc_15.questUniqueId);
                }
                _loc_11.push(_loc_15);
            }
            _loc_7.aDamage = _loc_11;
            return;
        }// end function

        private function getTargetPlayerArray() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [0, 0, 0, 0, 0];
            for each (_loc_2 in this._aAttackPlayerStatus)
            {
                
                if (_loc_2.bDead)
                {
                    continue;
                }
                _loc_1[_loc_2.formationIndex] = _loc_2.questUniqueId;
            }
            return _loc_1;
        }// end function

        private function attackSkillFunction() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = false;
            var _loc_16:* = null;
            var _loc_17:* = false;
            var _loc_18:* = false;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = 0;
            var _loc_26:* = false;
            var _loc_27:* = false;
            var _loc_28:* = false;
            var _loc_29:* = null;
            var _loc_30:* = 0;
            var _loc_31:* = null;
            var _loc_32:* = false;
            var _loc_33:* = 0;
            var _loc_34:* = null;
            var _loc_35:* = 0;
            var _loc_36:* = null;
            var _loc_37:* = null;
            var _loc_38:* = 0;
            var _loc_39:* = 0;
            var _loc_40:* = null;
            var _loc_41:* = 0;
            var _loc_42:* = 0;
            var _loc_43:* = null;
            var _loc_44:* = 0;
            var _loc_45:* = null;
            var _loc_46:* = null;
            var _loc_1:* = new AttackComboData();
            _loc_1.lastPlayerAttackIndex = this._aAttackData.length;
            var _loc_2:* = [];
            while (this._aOrder.length > 0 || _loc_2.length > 0)
            {
                
                _loc_3 = Constant.EMPTY_ID;
                _loc_4 = null;
                _loc_5 = null;
                if (_loc_2.length > 0)
                {
                    _loc_4 = _loc_2.shift();
                    _loc_3 = _loc_4.questUniqueId;
                    _loc_5 = this.getCharacterStatus(_loc_4.targetUniqueId);
                    if (_loc_5 == null || _loc_5.bDead)
                    {
                        _loc_2 = [];
                        continue;
                    }
                }
                else
                {
                    _loc_31 = this._aOrder.shift();
                    _loc_3 = _loc_31.questUniqueId;
                }
                if (this._aPassQuestUniqueId.indexOf(_loc_3) != -1)
                {
                    continue;
                }
                _loc_6 = this._battleManager.getCharacter(_loc_3);
                _loc_7 = this.getCharacterStatus(_loc_3);
                _loc_8 = FormationManager.getInstance().getFormationInformation(this._formationData.formationId);
                _loc_9 = BattleUtilityTarget.getTargetPlayer(this._aAttackPlayerStatus, _loc_8);
                _loc_10 = BattleUtilityTarget.getTargetEnemy(this._aAttackEnemyStatus);
                _loc_11 = _loc_9.getEntryCount();
                _loc_12 = _loc_10.getEntryCount();
                if (this.checkTermination(_loc_11, _loc_12))
                {
                    break;
                }
                _loc_13 = _loc_6.personal.useSkillId;
                _loc_15 = false;
                if (_loc_4)
                {
                    _loc_13 = _loc_4.counterSkillId;
                    _loc_14 = BattleUtilityTarget.targettingCounter(_loc_13, _loc_7, _loc_5, _loc_9, _loc_10, this._battleManager);
                }
                else
                {
                    _loc_32 = BattleManager.isBadStatusCharm(_loc_7.badStatus);
                    if (_loc_32)
                    {
                        _loc_13 = this.getCharmSkillId(_loc_6);
                    }
                    if (BattleManager.isBadStatusConfusion(_loc_7.badStatus))
                    {
                        _loc_13 = this.getConfusionSkillId(_loc_6);
                    }
                    _loc_14 = BattleUtilityTarget.targetting(_loc_13, _loc_6, _loc_7, _loc_32, _loc_9, _loc_10, this._battleManager);
                    if (_loc_6.division == BattleConstant.DIVISION_PLAYER)
                    {
                        _loc_33 = 0;
                        _loc_34 = this._battleManager.getCharacter(_loc_14.aTarget[0]);
                        if (_loc_34 && _loc_34 as BattleEnemy)
                        {
                            _loc_33 = (_loc_34 as BattleEnemy).enemyPersonal.rank;
                        }
                        _loc_35 = this.executionComeUp(_loc_6 as BattlePlayer, _loc_13, _loc_33);
                        if (TutorialManager.getInstance().isTutorial())
                        {
                            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_SKILL_COMES_UP) && TutorialManager.getInstance().isComesUpPlayer((_loc_6 as BattlePlayer).playerPersonal))
                            {
                                _loc_35 = CommonConstant.TUTORIAL_COMES_UP_SKILL_ID;
                            }
                            else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END))
                            {
                                _loc_35 = Constant.EMPTY_ID;
                            }
                        }
                        if (_loc_35 != Constant.EMPTY_ID)
                        {
                            _loc_13 = _loc_35;
                            var _loc_47:* = this;
                            var _loc_48:* = this._comeUpCount + 1;
                            _loc_47._comeUpCount = _loc_48;
                            _loc_15 = true;
                        }
                    }
                    if (_loc_15)
                    {
                        _loc_14 = BattleUtilityTarget.targetting(_loc_13, _loc_6, _loc_7, _loc_32, _loc_9, _loc_10, this._battleManager);
                    }
                }
                _loc_16 = _loc_14.skillInfo;
                _loc_17 = BattleManager.isDefaultSkill(_loc_6, _loc_16);
                _loc_18 = _loc_16.isSupport() || _loc_16.invokeType == SkillConstant.INVOKE_TYPE_COUNTER && _loc_4 == null;
                _loc_19 = new AttackDataSkill();
                this._aAttackData.push(_loc_19);
                _loc_19.questUniqueId = _loc_6.personal.questUniqueId;
                _loc_19.invokeType = _loc_4 != null ? (SkillConstant.INVOKE_TYPE_COUNTER) : (SkillConstant.INVOKE_TYPE_ACTION);
                _loc_19.skillId = _loc_13;
                _loc_19.bDefaultSkill = _loc_17;
                _loc_19.bComeUp = _loc_15;
                if (_loc_6.division == BattleConstant.DIVISION_PLAYER && _loc_19.bComeUp == false && _loc_4 == null)
                {
                    _loc_36 = _loc_6 as BattlePlayer;
                    _loc_19.useSp = _loc_36.getSkillUseSp(_loc_16);
                }
                _loc_20 = _loc_14.aTarget;
                _loc_21 = [];
                for each (_loc_25 in _loc_20)
                {
                    
                    _loc_22 = new AttackHitData(_loc_25);
                    _loc_23 = this._battleManager.getCharacter(_loc_25);
                    _loc_24 = this.getCharacterStatus(_loc_25);
                    if (_loc_18)
                    {
                        _loc_22.bAttackHit = true;
                    }
                    else
                    {
                        _loc_22.bCritical = BattleCalc.checkCritical(_loc_6, _loc_7, _loc_23, _loc_24, _loc_16);
                        _loc_22.bHit = _loc_15 ? (true) : (BattleCalc.checkHit(_loc_6, _loc_7, _loc_23, _loc_24, _loc_16));
                        if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_SKILL_CHAIN_AFTER) && !TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_SKILL_CHAIN_BEFORE))
                        {
                            if (_loc_6.division == BattleConstant.DIVISION_PLAYER)
                            {
                                _loc_22.bHit = true;
                            }
                        }
                        if (_loc_22.bHit)
                        {
                            _loc_22.bAttackHit = true;
                        }
                    }
                    if (_loc_16.invokeType != SkillConstant.INVOKE_TYPE_COUNTER || _loc_4 != null)
                    {
                        if (_loc_4 == null)
                        {
                            if (SkillManager.isMagicSkill(_loc_16.id) == false && _loc_16.hasSpecialQuality(BattleConstant.SPECIAL_QUALITY_FLAG_IMPOSSIBLE_COUNTER) == false)
                            {
                                if (_loc_24.counterSkillId != Constant.EMPTY_ID && BattleManager.canCounterStatus(_loc_24.badStatus, _loc_24.badStatusRecoveryTurn))
                                {
                                    if (BattleCalc.checkCounterSuccess(_loc_23, _loc_24, _loc_24.counterSkillId))
                                    {
                                        _loc_22.bCountered = true;
                                        _loc_22.bAttackHit = false;
                                    }
                                }
                            }
                        }
                        if (_loc_22.bAttackHit && _loc_22.bCountered == false && _loc_16.hasSpecialQuality(BattleConstant.SPECIAL_QUALITY_FLAG_LP_DAMAGE) == false)
                        {
                            if (_loc_23.division == BattleConstant.DIVISION_PLAYER && BattleManager.isShieldNoBe(_loc_24.badStatus) == false && BattleManager.isShieldTurnNoBe(_loc_24.badStatusRecoveryTurn) == false)
                            {
                                _loc_37 = _loc_23 as BattlePlayer;
                                _loc_38 = Constant.EMPTY_ID;
                                for each (_loc_39 in _loc_37.playerPersonal.aSetItemId)
                                {
                                    
                                    if (_loc_39 == Constant.EMPTY_ID)
                                    {
                                        continue;
                                    }
                                    if (ItemManager.getInstance().isShield(_loc_39))
                                    {
                                        _loc_38 = _loc_39;
                                        break;
                                    }
                                }
                                if (_loc_38 != Constant.EMPTY_ID)
                                {
                                    _loc_40 = ItemManager.getInstance().getItemInformation(_loc_38);
                                    _loc_41 = 0;
                                    if (Lot.isHit(_loc_41))
                                    {
                                        _loc_22.shield = _loc_40.shieldType;
                                    }
                                }
                            }
                        }
                        if (_loc_22.bAttackHit && !_loc_22.bCountered && _loc_22.shield == BattleConstant.DEFENSE_SHIELD_NON)
                        {
                            _loc_22.bAddStatusMiss = BattleAddStatusCalc.isAddStatusMiss(_loc_16, _loc_6, _loc_23, _loc_24);
                            if (_loc_22.bAddStatusMiss)
                            {
                                _loc_22.bAttackHit = false;
                            }
                        }
                    }
                    _loc_21.push(_loc_22);
                }
                _loc_26 = Random.range(0, 999) < CommonConstant.BATTLE_COMBO_RATE;
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_SKILL_CHAIN_AFTER) && !TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_SKILL_CHAIN_BEFORE))
                {
                    if (_loc_6.division == BattleConstant.DIVISION_PLAYER)
                    {
                        _loc_26 = true;
                    }
                }
                _loc_27 = _loc_6.division == _loc_1.Division ? (_loc_16.bComboFront) : (false);
                _loc_28 = _loc_6.division == _loc_1.Division ? (_loc_1.bComboLater) : (false);
                if (_loc_17 == true || _loc_4 || _loc_15 || _loc_1.bSubsequent == false || _loc_1.lastUseSkillId == _loc_16.id || _loc_27 == false || _loc_28 == false || _loc_1.checkComboTarget(_loc_21) == false || _loc_26 == false)
                {
                    this.resetCombo(_loc_1);
                }
                _loc_19.comboCount = _loc_1.comboCount;
                _loc_1.lastUseSkillId = _loc_16.id;
                _loc_1.setComboTarget(_loc_21);
                _loc_1.bSubsequent = false;
                _loc_29 = [];
                _loc_30 = 0;
                for each (_loc_22 in _loc_21)
                {
                    
                    _loc_23 = this._battleManager.getCharacter(_loc_22.questUniqueId);
                    _loc_24 = this.getCharacterStatus(_loc_22.questUniqueId);
                    _loc_42 = 0;
                    if (!_loc_22.bAttackHit || _loc_22.shield != BattleConstant.DEFENSE_SHIELD_NON)
                    {
                        _loc_42 = 0;
                    }
                    else if (_loc_22.bHit)
                    {
                        _loc_42 = _loc_42 + BattleCalc.calcDamage(_loc_6, _loc_7, _loc_23, _loc_24, _loc_16, _loc_1.comboCount, _loc_22.bCritical, _loc_22.bRefuse);
                    }
                    _loc_43 = new BattleAddStatusResult();
                    if (_loc_22.bAttackHit)
                    {
                        if (_loc_16.invokeType == SkillConstant.INVOKE_TYPE_COUNTER && _loc_4 == null)
                        {
                            _loc_43 = BattleAddStatusCalc.executionAddStatusCounter(_loc_16, _loc_6);
                        }
                        else if (_loc_22.shield == BattleConstant.DEFENSE_SHIELD_NON)
                        {
                            _loc_43 = BattleAddStatusCalc.executionAddStatus(_loc_16, _loc_6, _loc_23, _loc_24, _loc_1.comboCount);
                        }
                    }
                    _loc_44 = _loc_22.getAttackHitType(_loc_42);
                    _loc_45 = this.executeAttackDamage(_loc_24, _loc_6.personal.questUniqueId, _loc_44, _loc_42, _loc_43, true, _loc_22.shield, _loc_22.bCountered, _loc_16.targetType != SkillConstant.TARGET_TYPE_ENEMY);
                    this.entryPassQuestUniqueId(_loc_45);
                    if (_loc_18)
                    {
                        _loc_45.bSkipDamage = true;
                    }
                    _loc_29.push(_loc_45);
                    if (_loc_22.bCountered)
                    {
                        _loc_45.bOutDamage = true;
                        _loc_2.push(new CounterAttackOrder(_loc_24.questUniqueId, _loc_6.personal.questUniqueId, _loc_24.counterSkillId));
                    }
                    if (_loc_16.hasSpecialQuality(BattleConstant.SPECIAL_QUALITY_FLAG_HP_ABSORPTION) && _loc_42 > 0)
                    {
                        _loc_29.push(this.executeAbsorptionAttackDamage(_loc_6, _loc_7, _loc_42));
                    }
                    _loc_30++;
                    if (_loc_22.bAttackHit)
                    {
                        _loc_1.bSubsequent = true;
                    }
                }
                if (_loc_6.division == BattleConstant.DIVISION_PLAYER)
                {
                    _loc_1.lastPlayerAttackIndex = this._aAttackData.length - 1;
                }
                if (_loc_1.bSubsequent)
                {
                    if (_loc_6.division == BattleConstant.DIVISION_PLAYER)
                    {
                        for each (_loc_46 in _loc_29)
                        {
                            
                            if (_loc_46.targetDivision == BattleConstant.DIVISION_ENEMY && _loc_46.bDead)
                            {
                                _loc_1.addDeadEnemyQuestUniqueId(_loc_46.questUniqueId);
                            }
                        }
                    }
                    if (_loc_1.comboCount == 1)
                    {
                        _loc_1.comboStartIndex = this._aAttackData.length - 1;
                    }
                    _loc_1.addComboCount();
                }
                _loc_19.aDamage = _loc_29;
                _loc_1.bComboLater = _loc_16.bComboLater;
                _loc_1.Division = _loc_6.division;
            }
            this.resetCombo(_loc_1);
            return;
        }// end function

        private function executeAbsorptionAttackDamage(param1:BattleCharacterBase, param2:AttackCharacterStatus, param3:int) : AttackDamage
        {
            var _loc_4:* = param3 * CommonConstant.BATTLE_HP_ABSORPTION_FACTOR / 1000;
            if (param3 * CommonConstant.BATTLE_HP_ABSORPTION_FACTOR / 1000 < 1)
            {
                _loc_4 = 1;
            }
            if (_loc_4 > param1.personal.hpMax / 2)
            {
                _loc_4 = param1.personal.hpMax / 2;
            }
            if (_loc_4 > param1.personal.hpMax - param2.hp)
            {
                _loc_4 = param1.personal.hpMax - param2.hp;
            }
            var _loc_5:* = new BattleAddStatusResult();
            new BattleAddStatusResult().setRecoveryHp(_loc_4);
            return this.executeAttackDamage(param2, param1.personal.questUniqueId, BattleConstant.HIT_TYPE_NORMAL, 0, _loc_5, false, BattleConstant.DEFENSE_SHIELD_NON, false, true);
        }// end function

        private function resetCombo(param1:AttackComboData) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            if (param1.comboCount > 1)
            {
                _loc_2 = param1.lastPlayerAttackIndex - 1;
                while (_loc_2 >= param1.comboStartIndex)
                {
                    
                    _loc_3 = this._aAttackData[_loc_2];
                    for each (_loc_4 in _loc_3.aDamage)
                    {
                        
                        if (_loc_4.bDead && _loc_4.targetDivision == BattleConstant.DIVISION_ENEMY)
                        {
                            _loc_4.bDeadDisable = true;
                        }
                    }
                    _loc_2 = _loc_2 - 1;
                }
            }
            if (this._aAttackData.length > 0)
            {
                _loc_5 = this._aAttackData[param1.lastPlayerAttackIndex];
                for each (_loc_6 in param1.aDeadEnemyQuestUniqueId)
                {
                    
                    _loc_5.addComboDeadId(_loc_6);
                }
            }
            param1.clear();
            return;
        }// end function

        private function entryPassQuestUniqueId(param1:AttackDamage) : void
        {
            if (param1.bDead)
            {
                this._aPassQuestUniqueId.push(param1.questUniqueId);
            }
            else if (BattleManager.isBadStatusStan(param1.addBadStatus) || BattleManager.isBadStatusStone(param1.addBadStatus) || BattleManager.isBadStatusSleep(param1.addBadStatus) || BattleManager.isBadStatusParalysis(param1.addBadStatus))
            {
                if (this._aPassQuestUniqueId.indexOf(param1.questUniqueId) == -1)
                {
                    this._aPassQuestUniqueId.push(param1.questUniqueId);
                }
            }
            return;
        }// end function

        private function executeAttackDamage(param1:AttackCharacterStatus, param2:uint, param3:int, param4:int, param5:BattleAddStatusResult, param6:Boolean, param7:int, param8:Boolean, param9:Boolean) : AttackDamage
        {
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            if (param5.bDamageHp)
            {
                param4 = param5.damageHp;
            }
            var _loc_10:* = new AttackDamage();
            new AttackDamage().hitType = param3;
            _loc_10.questUniqueId = param1.questUniqueId;
            _loc_10.attackerQuestUniqueId = param2;
            _loc_10.targetDivision = param1.division;
            _loc_10.damageHp = param4;
            _loc_10.sheld = param7;
            _loc_10.bCounter = param8;
            _loc_10.bAllyEffect = param9;
            _loc_10.bBadStatusResist = param5.bResist;
            var _loc_11:* = new BattleRecoveryBadStatus();
            if (param3 != BattleConstant.HIT_TYPE_MISS && param6 && !param8 && !param7 && !param9)
            {
                _loc_14 = param1.badStatus.aBadStatusData;
                for each (_loc_15 in _loc_14)
                {
                    
                    _loc_16 = BattleInformationManager.getInstance().getStatusListData(_loc_15.id);
                    if (_loc_16 && _loc_16.bDamageRecovery)
                    {
                        _loc_11.addStatusId(_loc_15.id);
                    }
                }
            }
            if (param5.bRecoveryBadStatus)
            {
                _loc_11.marge(param5.recoveryBadStatus);
            }
            if (_loc_11.bRecovery)
            {
                _loc_10.setRecoveryBadStatus(_loc_11);
                param1.badStatusRecovery(_loc_11);
            }
            if (param5.bRecoveryHp)
            {
                _loc_10.recoveryHp = param5.recoveryHp;
                param1.hp = param1.hp + param5.recoveryHp;
            }
            var _loc_12:* = false;
            if (TutorialManager.getInstance().isTutorial() && param1.division == BattleConstant.DIVISION_PLAYER)
            {
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END))
                {
                    _loc_12 = true;
                }
            }
            var _loc_13:* = false;
            if (param5.bBadStatus)
            {
                param5.badStatus.subBadStatus(_loc_11);
                _loc_10.setAddBadStatus(param5.badStatus);
                param1.badStatusAdd(param5.badStatus);
                if (BattleManager.isBadStatusInstantDeath(param5.badStatus))
                {
                    _loc_13 = true;
                }
                if (param1.isDefense() && BattleManager.isActionNotBe(param1.badStatus))
                {
                    param1.clearDefense();
                }
            }
            if (_loc_13)
            {
                param1.hp = 0;
            }
            param1.hp = param1.hp - param4;
            if (param1.hp <= 0)
            {
                if (_loc_12)
                {
                    if (_loc_13 || param1.hp + param4 <= 1)
                    {
                        _loc_10.hitType = BattleConstant.HIT_TYPE_MISS;
                        _loc_10.damageHp = 0;
                    }
                    else
                    {
                        _loc_10.damageHp = param1.hp + param4 - 1;
                    }
                    param1.hp = 1;
                }
                else
                {
                    param1.hp = 0;
                    param1.bDead = true;
                    _loc_10.bDead = true;
                    if (param1.division == BattleConstant.DIVISION_PLAYER)
                    {
                        _loc_10.damageLp = 1;
                        if (QuestManager.getInstance().isLpCovering())
                        {
                            _loc_10.bBrokenItem = true;
                            param1.substituteLp();
                        }
                        else
                        {
                            (param1.lp - 1);
                        }
                    }
                }
            }
            if (param5.bDamageLp)
            {
                if (param1.division == BattleConstant.DIVISION_PLAYER)
                {
                    _loc_10.damageLp = 1;
                    _loc_10.bSkipDamage = true;
                    if (QuestManager.getInstance().isLpCovering())
                    {
                        _loc_10.bBrokenItem = true;
                        param1.substituteLp();
                    }
                    else
                    {
                        (param1.lp - 1);
                        if (param1.lp == 0)
                        {
                            _loc_17 = new BattleBadStatusData(BattleConstant.BAD_STATUS_ID_INSTANT_DEATH);
                            _loc_10.addAddBadStatusData(_loc_17);
                            param1.addBadStatusData(_loc_17);
                            param1.hp = 0;
                            param1.bDead = true;
                            _loc_10.bDead = true;
                        }
                    }
                }
            }
            if (param5.bCounterWait)
            {
                param1.setCounterSkillId(param5.counterSkillId);
                _loc_10.counterSkillId = param5.counterSkillId;
            }
            return _loc_10;
        }// end function

        private function getCharmSkillId(param1:BattleCharacterBase) : int
        {
            var _loc_2:* = Constant.EMPTY_ID;
            if (param1.division == BattleConstant.DIVISION_PLAYER)
            {
                _loc_2 = (param1 as BattlePlayer).defaultSkillId;
            }
            if (param1.division == BattleConstant.DIVISION_ENEMY)
            {
                _loc_2 = this.lotEnemySkill(param1 as BattleEnemy, true);
            }
            return _loc_2;
        }// end function

        private function getConfusionSkillId(param1:BattleCharacterBase) : int
        {
            var _loc_2:* = Constant.EMPTY_ID;
            if (param1.division == BattleConstant.DIVISION_PLAYER)
            {
                _loc_2 = this.lotPlayerSkill(param1 as BattlePlayer);
            }
            if (param1.division == BattleConstant.DIVISION_ENEMY)
            {
                _loc_2 = this.lotEnemySkill(param1 as BattleEnemy, true);
            }
            return _loc_2;
        }// end function

        private function lotPlayerSkill(param1:BattlePlayer) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in param1.playerPersonal.aSetSkillId)
            {
                
                if (_loc_3 != 0)
                {
                    _loc_2.push(_loc_3);
                }
            }
            _loc_4 = _loc_2.length - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_5 = SkillManager.getInstance().getSkillInformation(_loc_2[_loc_4]);
                if (param1.playerPersonal.sp < _loc_5.sp)
                {
                    _loc_2.splice(_loc_4, 1);
                }
                _loc_4 = _loc_4 - 1;
            }
            _loc_2.push(param1.defaultSkillId);
            return _loc_2[Random.range(0, (_loc_2.length - 1))];
        }// end function

        private function executionComeUp(param1:BattlePlayer, param2:int, param3:int) : int
        {
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_4:* = Constant.EMPTY_ID;
            if (this._comeUpCount >= this._COME_UP_MAX)
            {
                return _loc_4;
            }
            var _loc_5:* = this.getCharacterStatus(param1.personal.questUniqueId);
            if (BattleManager.isBadStatusCharm(_loc_5.badStatus) || BattleManager.isBadStatusConfusion(_loc_5.badStatus))
            {
                return _loc_4;
            }
            if (SkillManager.isMagicSkill(param2))
            {
                return _loc_4;
            }
            var _loc_6:* = BattleInformationManager.getInstance().getFlashSkillData(param3);
            if (BattleInformationManager.getInstance().getFlashSkillData(param3) == null)
            {
                return _loc_4;
            }
            var _loc_7:* = PlayerManager.getInstance().getPlayerInformation(param1.playerPersonal.playerId);
            var _loc_8:* = SkillManager.getInstance().getComeUpSkill(_loc_7.comeUpType);
            var _loc_9:* = [];
            var _loc_10:* = [];
            for each (_loc_12 in _loc_8)
            {
                
                if (param1.playerPersonal.isHaveSkill(_loc_12))
                {
                    continue;
                }
                _loc_11 = SkillManager.getInstance().getSkillInformation(_loc_12);
                if (_loc_6.getSkillRankRate(_loc_11.rank) > 0)
                {
                    _loc_9.push(_loc_11);
                    if (_loc_10.indexOf(_loc_11.rank) < 0)
                    {
                        _loc_10.push(_loc_11.rank);
                    }
                }
            }
            _loc_10.sort(Array.NUMERIC);
            _loc_13 = Constant.UNDECIDED;
            _loc_14 = 0;
            while (_loc_14 < _loc_10.length)
            {
                
                _loc_15 = _loc_10[_loc_14];
                if (Random.range(0, 999) < _loc_6.getSkillRankRate(_loc_15))
                {
                    _loc_13 = _loc_15;
                }
                _loc_14++;
            }
            if (_loc_13 == Constant.UNDECIDED)
            {
                return _loc_4;
            }
            _loc_8 = [];
            for each (_loc_11 in _loc_9)
            {
                
                if (_loc_13 == _loc_11.rank)
                {
                    _loc_8.push(_loc_11);
                }
            }
            _loc_11 = _loc_8[Random.range(0, (_loc_8.length - 1))];
            if (Random.range(0, 999) < _loc_11.gliterDiffculty)
            {
                _loc_4 = _loc_11.id;
            }
            return _loc_4;
        }// end function

        private function checkTermination(param1:int, param2:int) : Boolean
        {
            return param1 == 0 || param2 == 0;
        }// end function

        private function executionBadStatusPoison() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_1:* = [];
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            for each (_loc_4 in this._aAttackPlayerStatus)
            {
                
                if (_loc_4.bDead)
                {
                    continue;
                }
                _loc_2++;
                if (BattleManager.isBadStatusPoison(_loc_4.badStatus) == false)
                {
                    continue;
                }
                _loc_1.push(_loc_4);
            }
            for each (_loc_5 in this._aAttackEnemyStatus)
            {
                
                if (_loc_5.bDead)
                {
                    continue;
                }
                _loc_3++;
                if (BattleManager.isBadStatusPoison(_loc_5.badStatus) == false)
                {
                    continue;
                }
                _loc_1.push(_loc_5);
            }
            if (this.checkTermination(_loc_2, _loc_3))
            {
                return;
            }
            if (_loc_1.length == 0)
            {
                return;
            }
            var _loc_6:* = new AttackDataBadStatusPoison();
            var _loc_7:* = BattleInformationManager.getInstance().getStatusListData(BattleConstant.BAD_STATUS_ID_POISON);
            var _loc_8:* = BattleInformationManager.getInstance().getStatusListData(BattleConstant.BAD_STATUS_ID_POISON).param0;
            var _loc_9:* = [];
            for each (_loc_10 in _loc_1)
            {
                
                _loc_11 = this._battleManager.getCharacter(_loc_10.questUniqueId);
                _loc_12 = int(_loc_11.personal.hpMax * _loc_8 / 1000);
                _loc_13 = this.executeAttackDamage(_loc_10, Constant.EMPTY_ID, BattleConstant.HIT_TYPE_NORMAL, _loc_12, new BattleAddStatusResult(), false, BattleConstant.DEFENSE_SHIELD_NON, false, false);
                _loc_9.push(_loc_13);
            }
            _loc_6.aDamage = _loc_9;
            this._aAttackData.push(_loc_6);
            return;
        }// end function

        private function executionTrunRecoveryBadStatus() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._battleManager.getEntryPlayer())
            {
                
                if (_loc_2.personal.bDead)
                {
                    continue;
                }
                _loc_1.push(_loc_2);
            }
            for each (_loc_3 in this._battleManager.getEntryEnemy())
            {
                
                if (_loc_3.personal.bDead)
                {
                    continue;
                }
                _loc_1.push(_loc_3);
            }
            for each (_loc_4 in _loc_1)
            {
                
                _loc_4.status.badStatus.trunRecovery();
            }
            return;
        }// end function

        private function executeFeverMode() : void
        {
            var _loc_1:* = new AttackDataFever();
            _loc_1.useSp = 0;
            this._aAttackData.push(_loc_1);
            return;
        }// end function

        private function buttonEnable(param1:Boolean) : void
        {
            if (this._bAutoMode == false)
            {
                this._btnAutoAttack.setDisable(param1 == false);
                this._btnAutoAttackOff.setVisible(false);
            }
            else
            {
                this._btnAutoAttack.setVisible(false);
                if (this._phase == this._PHASE_TURN_START)
                {
                    this._btnAutoAttackOff.setVisible(true);
                }
                else
                {
                    this._btnAutoAttackOff.setDisable(param1 == false);
                }
            }
            this._btnAttack.setDisable(param1 == false);
            var _loc_2:* = param1;
            if (_loc_2)
            {
                _loc_2 = this.isUseFormationSkill(this._formationData.formationId);
            }
            this._formationStatusBar.setDisableAttackButton(_loc_2 == false);
            this._formationStatusBar.setEnableFormationSkillBlank(_loc_2);
            this._formationStatusBar.setDisableChangeButton(param1 == false);
            var _loc_3:* = param1 == false;
            if (TutorialManager.getInstance().isTutorial())
            {
                _loc_3 = true;
            }
            this._btnEscape.setDisable(_loc_3);
            return;
        }// end function

        private function cbAttack(param1:int) : void
        {
            this.setPhase(this._PHASE_TURN_START);
            return;
        }// end function

        private function cbFormationAttack(param1:int) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            this._aFormationSkillOrder = [];
            var _loc_2:* = FormationManager.getInstance().getFormationInformation(this._formationData.formationId);
            var _loc_3:* = FormationManager.getInstance().getFormationSkillInformation(_loc_2.formationSkillId);
            var _loc_4:* = this.getFormationSkillMember(_loc_3, _loc_2);
            if (this.getFormationSkillMember(_loc_3, _loc_2).length < _loc_3.memberMinNum)
            {
                return;
            }
            for each (_loc_5 in _loc_4)
            {
                
                _loc_6 = new AttackOrder();
                _loc_6.questUniqueId = _loc_5;
                this._aFormationSkillOrder.push(_loc_6);
            }
            this.setPhase(this._PHASE_TURN_START);
            return;
        }// end function

        private function getFormationSkillMember(param1:FormationSkillInformation, param2:FormationInformation) : Array
        {
            var _loc_3:* = [];
            var _loc_4:* = new BattleFormationCheck();
            _loc_3 = new BattleFormationCheck().skillMemberCheck(param1, param2, this._battleManager);
            return _loc_3;
        }// end function

        private function isUseFormationSkill(param1:int) : Boolean
        {
            var _loc_2:* = FormationManager.getInstance().getFormationInformation(param1);
            var _loc_3:* = FormationManager.getInstance().getFormationSkillInformation(_loc_2.formationSkillId);
            var _loc_4:* = this.getFormationSkillMember(_loc_3, _loc_2);
            if (this.getFormationSkillMember(_loc_3, _loc_2).length < _loc_3.memberMinNum)
            {
                return false;
            }
            return true;
        }// end function

        private function cbAutoAttack(param1:int) : void
        {
            var _loc_2:* = null;
            if (this._phase == this._PHASE_INPUT_WAIT)
            {
                this._bAutoMode = true;
                this._btnAutoAttack.setVisible(false);
                this._btnAutoAttackOff.setVisible(true);
                for each (_loc_2 in this._battleManager.getEntryPlayer())
                {
                    
                    _loc_2.characterAction.setUseSkillId(_loc_2.defaultSkillId);
                }
                this.setPhase(this._PHASE_TURN_START);
            }
            else
            {
                this._bAutoMode = false;
                this._btnAutoAttack.setVisible(true);
                this._btnAutoAttack.setDisable(true);
                this._btnAutoAttackOff.setVisible(false);
            }
            return;
        }// end function

        private function cbEscape(param1:int) : void
        {
            this.createEscapePopup();
            return;
        }// end function

        private function cbFormationChange(param1:int) : void
        {
            this._battleMessage.setMessageCharacterClose();
            this._battleMessage.clearCharacterName();
            this.clearBadStateIcon();
            this._bSelectMode = false;
            this.buttonEnable(false);
            this._bFormationChangeMoving = false;
            this._battleFormationChange.openFormationChange(this._unitFormation, this.isFormationNotBe());
            return;
        }// end function

        private function cbScreenClick(event:MouseEvent) : void
        {
            this.skillSelectClick(event);
            this.skillWindowCancel(event);
            this.statusUpClick(event);
            this.statusUpEndClick(event);
            this.resultLoseClick(event);
            this.feverModeClick(event);
            this.characterDeadClick(event);
            return;
        }// end function

        private function cbScreenMove(event:MouseEvent) : void
        {
            this.skillSelectMove(event);
            return;
        }// end function

        private function cbPopupClose() : void
        {
            this._lostVoiceWait = false;
            return;
        }// end function

        private function skillSelectClick(event:MouseEvent) : void
        {
            if (this._bSelectMode == false)
            {
                return;
            }
            if (this._selectUniqueId == 0)
            {
                return;
            }
            this._bSelectMode = false;
            this.buttonEnable(false);
            var _loc_2:* = this._battleManager.getCharacter(this._selectUniqueId) as BattlePlayer;
            if (_loc_2 == null)
            {
                return;
            }
            var _loc_3:* = new Point();
            _loc_3 = _loc_3.add(this._formationData.getPosition(_loc_2.formationIndex));
            var _loc_4:* = SelectSkillMenu.windowOffsetPos;
            if (_loc_3.y + _loc_4.y < this._SKILL_WINDOW_MIN_POS_Y)
            {
                _loc_3.y = this._SKILL_WINDOW_MIN_POS_Y - _loc_4.y;
            }
            var _loc_5:* = _loc_2.characterAction.characterDisplay as PlayerDisplay;
            var _loc_6:* = BattleManager.getDefaultSkillId(_loc_5.info);
            if (this._bChainTutorialSkillSelecting)
            {
                TutorialManager.getInstance().hideTutorialArrow();
            }
            this._selectSkillMenu = new SelectSkillMenu(this._layer.getLayer(LayerBattle.POPUP_MESSAGE), _loc_2, _loc_6, _loc_3, this.cbSelectFunction, this._parent);
            return;
        }// end function

        private function skillWindowCancel(event:MouseEvent) : void
        {
            if (this._selectSkillMenu == null)
            {
                return;
            }
            if (this._selectSkillMenu.bEnable == false)
            {
                return;
            }
            if (this._selectSkillMenu.isHitTest(event.stageX, event.stageY) == false)
            {
                this._selectSkillMenu.setClose();
                SoundManager.getInstance().playSe(SoundId.SE_RS3_SYSTEM_RETURN);
            }
            return;
        }// end function

        private function setChainTutorialArrow() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._bChainTutorialSkillSelecting)
            {
                _loc_1 = null;
                for each (_loc_2 in this._battleManager.getEntryPlayer())
                {
                    
                    if (_loc_2.playerPersonal.playerId == CommonConstant.TUTORIAL_INIT_PLAYER_ID_5)
                    {
                        _loc_1 = _loc_2.playerPersonal;
                        break;
                    }
                }
                if (_loc_1 == null || _loc_1.aSetSkillId.indexOf(CommonConstant.TUTORIAL_SKILL_CHAIN_SKILL_ID_5) < 0 || _loc_1.useSkillId == CommonConstant.TUTORIAL_SKILL_CHAIN_SKILL_ID_5)
                {
                    this._bChainTutorialSkillSelecting = false;
                    if (this._btnAttack)
                    {
                        ButtonManager.getInstance().unseal();
                        _loc_3 = [];
                        _loc_3.push(this._btnAttack);
                        ButtonManager.getInstance().seal(_loc_3, true);
                        TutorialManager.getInstance().setTutorialArrow(this._btnAttack.getMoveClip());
                        TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_SKILL_CHAIN_001));
                    }
                }
                else if (this._selectSkillMenu == null)
                {
                    TutorialManager.getInstance().setTutorialArrow(_loc_2.characterAction.characterDisplay.effectNull, TutorialManager.TUTORIAL_ARROW_DIRECTION_LEFT);
                }
            }
            return;
        }// end function

        private function skillSelectMove(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_6:* = null;
            if (this._bSelectMode == false)
            {
                return;
            }
            var _loc_4:* = Constant.EMPTY_ID;
            var _loc_5:* = Constant.EMPTY_ID;
            for each (_loc_6 in this._battleMessage.aMessageCharacter)
            {
                
                if (_loc_6.getMcHitArea().hitTestPoint(event.stageX, event.stageY, true))
                {
                    _loc_4 = _loc_6.questUniqueId;
                    _loc_5 = _loc_6.questUniqueId;
                    break;
                }
            }
            if (_loc_4 == Constant.EMPTY_ID)
            {
                for each (_loc_3 in this._aSelectInput)
                {
                    
                    _loc_2 = _loc_3.characterAction.characterDisplay as PlayerDisplay;
                    if (_loc_2.mc.hitTestPoint(event.stageX, event.stageY))
                    {
                        _loc_4 = _loc_3.personal.questUniqueId;
                        break;
                    }
                }
            }
            for each (_loc_3 in this._aSelectInput)
            {
                
                _loc_2 = _loc_3.characterAction.characterDisplay as PlayerDisplay;
                _loc_2.setSelect(_loc_4 == _loc_3.personal.questUniqueId);
            }
            this._selectUniqueId = _loc_4;
            if (_loc_5 == Constant.EMPTY_ID)
            {
                for each (_loc_3 in this._battleManager.aPlayer)
                {
                    
                    _loc_2 = _loc_3.characterAction.characterDisplay as PlayerDisplay;
                    if (_loc_2.mc.hitTestPoint(event.stageX, event.stageY))
                    {
                        _loc_5 = _loc_3.personal.questUniqueId;
                        break;
                    }
                }
            }
            this.setSelectStatusBar(_loc_5);
            if (this._focusUniqueId != _loc_5 && _loc_5)
            {
                SoundManager.getInstance().playSe(SoundId.SE_RS3_SYSTEM_CURSOR);
            }
            this._focusUniqueId = _loc_5;
            return;
        }// end function

        private function setSelectStatusBar(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aStatusBar)
            {
                
                _loc_2.setSelect(_loc_2.questUniqueId == param1);
            }
            return;
        }// end function

        private function cbSelectFunction(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._battleManager.getCharacter(this._selectUniqueId) as BattlePlayer;
            if (_loc_2.personal.useSkillId != param1)
            {
                _loc_2.characterAction.setActionSkillInput(param1);
                _loc_2.characterAction.setUseSkillId(param1);
                _loc_3 = SkillManager.getInstance().getSkillInformation(_loc_2.personal.useSkillId);
                if (_loc_3 != null)
                {
                    this._battleMessage.addMessageCharacter(_loc_2.personal.questUniqueId, _loc_3.name);
                }
            }
            this._selectSkillMenu.setClose();
            return;
        }// end function

        private function statusUpClick(event:MouseEvent) : void
        {
            if (this._bStatusUpMode == false)
            {
                return;
            }
            if (this._cutIn == null)
            {
                this.setPhase(this._PHASE_BATTLE_RESULT_STATUS_UP);
            }
            else if (this._cutIn.bOpened)
            {
                this._cutIn.setClose();
            }
            return;
        }// end function

        private function statusUpEndClick(event:MouseEvent) : void
        {
            if (this._phase == this._PHASE_BATTLE_RESULT_STATUS_UP_END)
            {
                SoundManager.getInstance().playSe(SoundId.SE_RS3_SYSTEM_CURSOR);
                this.setPhase(this._PHASE_BATTLE_END);
            }
            return;
        }// end function

        private function resultLoseClick(event:MouseEvent) : void
        {
            if (this._bResultLoseMode == false)
            {
                return;
            }
            if (this._isoAnnihilation && this._isoAnnihilation.bOpened)
            {
                this._isoAnnihilation.setOut();
            }
            return;
        }// end function

        private function feverModeClick(event:MouseEvent) : void
        {
            if (this._bFeverMode == false)
            {
                return;
            }
            if (this._feverMode != null)
            {
                this._feverMode.click();
            }
            return;
        }// end function

        private function characterDeadClick(event:MouseEvent) : void
        {
            if (this._lostVoiceWait == false)
            {
                return;
            }
            this._lostVoiceWait = false;
            return;
        }// end function

        private function clearBadStateIcon() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aBadStatusIcon)
            {
                
                _loc_1.release();
            }
            this._aBadStatusIcon = [];
            return;
        }// end function

        private function updateCommanderSkillBonus() : void
        {
            var _loc_6:* = null;
            var _loc_1:* = this._unitFormation.aPlayerUniqueId.concat();
            var _loc_2:* = this._aPlayer.concat();
            var _loc_3:* = false;
            var _loc_4:* = this._battleManager.commanderPlayer;
            if (this._battleManager.commanderPlayer)
            {
                _loc_1[FormationSetData.FORMATION_INDEX_COMMANDER] = _loc_4.playerPersonal.uniqueId;
                this._aPlayer.push(_loc_4.playerPersonal);
                _loc_3 = _loc_4.playerPersonal.bDead || BattleManager.isSelectNoBe(_loc_4.status);
            }
            CommanderSkillUtility.updateCommanderSkillBonus(_loc_1, _loc_2, false, _loc_3);
            var _loc_5:* = this._battleManager.getEntryPlayerAll();
            for each (_loc_6 in _loc_5)
            {
                
                _loc_6.updateTolerance();
            }
            return;
        }// end function

        private function updateFormationBonus() : void
        {
            if (this.isFormationNotBe())
            {
                FormationBonusUtility.resetFormationBonus(this._aPlayer);
            }
            else
            {
                FormationBonusUtility.updateFormationBonus(this._unitFormation.id, this._unitFormation.aPlayerUniqueId, this._aPlayer);
            }
            return;
        }// end function

        private function cbFormationChangeCloseStart(param1:Boolean) : void
        {
            if (!param1)
            {
                this.updateFormationBonus();
                return;
            }
            var _loc_2:* = FormationManager.getInstance().getFormationSkillInformationByFormationId(this._battleFormationChange.selectedFormationId);
            this._formationStatusBar.updateFormation(this._battleFormationChange.selectedFormationId);
            this._formationStatusBar.updateFormationSkill(_loc_2);
            this._unitFormation.setData(this._battleFormationChange.selectedFormationId, this._battleFormationChange.aFormationPlayerUniqueId);
            return;
        }// end function

        private function cbFormationChangeCloseEnd(param1:Boolean) : void
        {
            if (!param1)
            {
                this.formationChangeCloseCompleted();
                return;
            }
            var _loc_2:* = this.formationPositionResetStart(this._battleFormationChange.selectedFormationId, this._battleFormationChange.aFormationPlayerUniqueId, false, this.cbFormationChangeMoveCompleted);
            if (!_loc_2)
            {
                this.formationChangeCloseCompleted();
                return;
            }
            return;
        }// end function

        private function cbFormationChangeMoveCompleted() : void
        {
            this.formationPositionResetEnd(this._battleManager.getEntryPlayer(), this._battleFormationChange.aFormationPlayerUniqueId);
            this.formationChangeCloseCompleted();
            return;
        }// end function

        private function formationChangeCloseCompleted() : void
        {
            this.setPhase(this._PHASE_INPUT_WAIT);
            return;
        }// end function

        private function formationPositionResetStart(param1:int, param2:Array, param3:Boolean, param4:Function) : Boolean
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_8:* = false;
            var _loc_9:* = false;
            var _loc_10:* = false;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            _loc_5 = 0;
            _loc_6 = 0;
            var _loc_7:* = UserDataManager.getInstance().userData;
            _loc_8 = this._formationData.formationId != param1;
            _loc_9 = false;
            this._formationData.setFormationLabel(param1);
            _loc_10 = false;
            for each (_loc_11 in this._battleManager.getEntryPlayer())
            {
                
                _loc_5 = 0;
                while (_loc_5 < param2.length)
                {
                    
                    if (_loc_11.playerPersonal.uniqueId == param2[_loc_5])
                    {
                        _loc_12 = _loc_5;
                        if (_loc_8 || _loc_11.formationIndex != _loc_12)
                        {
                            if (_loc_11.playerPersonal.bDead)
                            {
                                (_loc_11.characterAction.characterDisplay as PlayerDisplay).setTargetPoint(this._formationData.getOutPosition(_loc_12), 0);
                            }
                            else
                            {
                                (_loc_11.characterAction.characterDisplay as PlayerDisplay).setTargetJump(this._formationData.getOutPosition(_loc_12));
                                _loc_10 = true;
                            }
                            _loc_9 = true;
                        }
                        if (_loc_11.formationIndex != _loc_12)
                        {
                            _loc_6 = 0;
                            while (_loc_6 < this._aStatusBar.length)
                            {
                                
                                _loc_13 = this._aStatusBar[_loc_6] as StatusBar;
                                if (_loc_13.uniqueId == _loc_11.playerPersonal.uniqueId)
                                {
                                    _loc_13.closeWindow();
                                    break;
                                }
                                _loc_6++;
                            }
                        }
                        break;
                    }
                    _loc_5++;
                }
            }
            if (_loc_9 || param3)
            {
                this._cbFormationChangeMoved = param4;
                this._bFormationChangeMoving = true;
                if (_loc_10)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_JUMP2);
                }
            }
            return _loc_9;
        }// end function

        private function formationPositionResetEnd(param1:Array, param2:Array) : void
        {
            var i:int;
            var bPl:BattlePlayer;
            var count:int;
            var unit:BattlePlayer;
            var statusBar:StatusBar;
            var aEntryPlayer:* = param1;
            var aFormationPlayerUniqueId:* = param2;
            i;
            var _loc_4:* = 0;
            var _loc_5:* = aEntryPlayer;
            while (_loc_5 in _loc_4)
            {
                
                bPl = _loc_5[_loc_4];
                i;
                while (i < aFormationPlayerUniqueId.length)
                {
                    
                    if (bPl.playerPersonal.uniqueId == aFormationPlayerUniqueId[i] && bPl.formationIndex != i)
                    {
                        bPl.formationIndex = i;
                        bPl.setPosition(this._formationData.getOutPosition(bPl.formationIndex));
                        break;
                    }
                    i = (i + 1);
                }
            }
            if (this._battleManager.commanderPlayer)
            {
                this._battleManager.commanderPlayer.formationIndex = FormationSetData.FORMATION_INDEX_COMMANDER;
                this._battleManager.commanderPlayer.setPosition(this._formationData.getCommanderOutPosition());
            }
            aEntryPlayer.sort(function (param1:BattlePlayer, param2:BattlePlayer) : int
            {
                return param1.formationIndex - param2.formationIndex;
            }// end function
            );
            count;
            var _loc_4:* = 0;
            var _loc_5:* = aEntryPlayer;
            while (_loc_5 in _loc_4)
            {
                
                unit = _loc_5[_loc_4];
                if (count >= this._aStatusBar.length)
                {
                    break;
                }
                statusBar = this._aStatusBar[count] as StatusBar;
                if (statusBar.bClose)
                {
                    statusBar.setPlayer(unit, unit.formationIndex);
                    statusBar.openWindow();
                }
                count = (count + 1);
            }
            this.sortCharacterDisplay(this._battleManager.getEntryCharacter());
            return;
        }// end function

        private function setPosition() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._battleManager.getEntryPlayer())
            {
                
                _loc_1.setPosition(this._formationData.getOutPosition(_loc_1.formationIndex));
            }
            if (this._battleManager.commanderPlayer)
            {
                this._battleManager.commanderPlayer.setPosition(this._battleScroll.getCommanderPosition());
            }
            for each (_loc_2 in this._battleManager.getEntryEnemy())
            {
                
                _loc_2.setPosition(this._formationDataEnemy.getPosition(_loc_2.formationIndex));
            }
            return;
        }// end function

        private function isEntryPlayerMoving() : Boolean
        {
            var _loc_1:* = false;
            var _loc_2:* = null;
            _loc_1 = false;
            for each (_loc_2 in this._battleManager.getEntryPlayer())
            {
                
                if ((_loc_2.characterAction.characterDisplay as PlayerDisplay).bMoveing)
                {
                    _loc_1 = true;
                    break;
                }
            }
            return _loc_1;
        }// end function

        private function createEscapePopup() : void
        {
            this._bSelectMode = false;
            this.buttonEnable(false);
            this._popupEscape = new BattlePopupEscape(this._parent);
            return;
        }// end function

    }
}
