package process
{
    import PlayerCard.*;
    import asset.*;
    import battle.*;
    import button.*;
    import develop.*;
    import effect.*;
    import externalLinkage.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import formation.*;
    import input.*;
    import item.*;
    import layer.*;
    import message.*;
    import network.*;
    import player.*;
    import popup.*;
    import quest.*;
    import resource.*;
    import script.*;
    import sound.*;
    import status.*;
    import topbar.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class ProcessQuest extends ProcessBase
    {
        private const _PHASE_WAIT:int = 0;
        private const _PHASE_MAP_OPEN:int = 1;
        private const _PHASE_CHECK_TITLE_BEFORE_EVENT:int = 2;
        private const _PHASE_QUEST_TITLE:int = 3;
        private const _PHASE_CHECK_TITLE_AFTER_EVENT:int = 4;
        private const _PHASE_QUEST_START:int = 5;
        private const _PHASE_SQUARE_CHECK:int = 9;
        private const _PHASE_PIECE_MOVE:int = 10;
        private const _PHASE_PAUSE:int = 11;
        private const _PHASE_RESUME:int = 12;
        private const _PHASE_CHECK_RETREAT:int = 13;
        private const _PHASE_CHECK_EVENT:int = 20;
        private const _PHASE_CHECK_JOIN:int = 21;
        private const _PHASE_CHECK_BATTLE:int = 22;
        private const _PHASE_CHECK_MOVE:int = 23;
        private const _PHASE_CHECK_GOSSIP:int = 24;
        private const _PHASE_SELECT_DIVIDE:int = 40;
        private const _PHASE_MAP_SCROLL:int = 50;
        private const _PHASE_RESULT_RECEIVE:int = 70;
        private const _PHASE_RESULT_RESOURCE:int = 71;
        private const _PHASE_RESULT:int = 72;
        private const _PHASE_MAP_SCROLL_AUTO_IN:int = 80;
        private const _PHASE_MAP_FADE_OUT:int = 81;
        private const _PHASE_MAP_FADE_IN:int = 82;
        private const _PHASE_MAP_SCROLL_AUTO_SKIP:int = 83;
        private const _PHASE_SCRIPT_EXE:int = 100;
        private const _PHASE_DEBUG_WAIT:int = 200;
        private const _PHASE_QUEST_END:int = 1000;
        private const _SCROLL_MAX_VALUE:Number = 25;
        private const _SCROLL_MAX_VALUE2:Number = 60;
        private const _SCROLL_ADD_VALUE:Number = 0.6;
        private const _SCROLL_ADD_VALUE2:Number = 1.5;
        private const _SCROLL_WAIT_SKIP:Number = 2;
        private const _SCROLL_WAIT_TIME:Number = 0.8;
        private const _SCROLL_FRICTION_RATE:Number = 0.18;
        private const _SCROLL_FRICTION:Number = 0.9;
        private const _BATTLE_PHASE_NONE:int = 0;
        private const _BATTLE_PHASE_ENEMY_RISE:int = 1;
        private const _BATTLE_PHASE_CHECK_EVENT_BEFORE:int = 2;
        private const _BATTLE_PHASE_INFORMATION:int = 3;
        private const _BATTLE_PHASE_ENCOUNT:int = 4;
        private const _BATTLE_PHASE_FIGHT:int = 5;
        private const _BATTLE_PHASE_FIGHT_END:int = 6;
        private const _BATTLE_PHASE_DELETE_ENEMY_PIECE:int = 7;
        private const _BATTLE_PHASE_DELETE_PLAYER_PIECE:int = 8;
        private const _BATTLE_PHASE_CHECK_EVENT_AFTER:int = 9;
        private const _BATTLE_PHASE_NO_ENCOUNT_CHECK_EVENT_BEFORE:int = 10;
        private const _BATTLE_PHASE_NO_ENCOUNT_CHECK_EVENT_AFTER:int = 11;
        private const _BATTLE_PHASE_WIN:int = 12;
        private const _BATTLE_PHASE_LOSE:int = 13;
        private const _MAP_SCROLL_TUTORIAL_STEP_NONE:int = 0;
        private const _MAP_SCROLL_TUTORIAL_STEP_SCROLL_UP:int = 1;
        private const _MAP_SCROLL_TUTORIAL_STEP_SCROLL_UP_END:int = 2;
        private const _MAP_SCROLL_TUTORIAL_STEP_RETURN:int = 3;
        private var _cam:QuestCamera;
        private var _scrollBar:QuestScrollBar;
        private var _scrollInput:QuestScrollInput;
        private var _questResultType:int;
        private var _bScroll:Boolean;
        private var _bAutoScroll:Boolean;
        private var _phase:int;
        private var _battlePhase:int;
        private var _scriptReturnPhase:int;
        private var _mapScrollTutorialStep:int;
        private var _unitMoveNo:int;
        private var _oldUnitMoveNo:int;
        private var _moveSquareId:int;
        private var _layer:LayerQuest;
        private var _layerMap:LayerQuestMap;
        private var _mcQuestMap:MovieClip;
        private var _mcQuestEnding:MovieClip;
        private var _bmpQuestEndingBg:Bitmap;
        private var _mcQuestResult:MovieClip;
        private var _miniTitle:MovieClip;
        private var _itemGetMc:MovieClip;
        private var _itemGetNameMc:MovieClip;
        private var _isoItemGet:InStayOut;
        private var _isoItemGetName:InStayOut;
        private var _isoAmulet:InStayOut;
        private var _isoResume:InStayOut;
        private var _isoDivideReturnBtn:InStayOut;
        private var _bEvent:Boolean;
        private var _questMap:QuestMap;
        private var _junctionGauge:QuestJunctionGauge;
        private var _battleWinCount:int;
        private var _questTextPopup:QuestTextPopup;
        private var _questTextInformation:QuestTextInformation;
        private var _questDivide:QuestDivide;
        private var _questEnding:QuestEnding;
        private var _aObjectType:Array;
        private var _objectType:int;
        private var _aDisplayObject:Array;
        private var _questResultMain:QuestResultMain;
        private var _bConnectionGet:Boolean;
        private var _aBattlePersonal:Array;
        private var _aBattleUnit:Array;
        private var _aBonus:Array;
        private var _aItemData:Array;
        private var _aJoinTeamNo:Array;
        private var _btnResume:ButtonBase;
        private var _btnEscape:ButtonBase;
        private var _btnDivideReturn:ButtonBase;
        private var _effectManager:EffectManager;
        private var _aGossipBallon:Array;
        private var _bGossipBallonn:Boolean;
        private var _scrollMaxPos:Point;
        private var _scrollMinPos:Point;
        private var _aBackupFlag:Array;
        private var _aEvent:Array;
        private var _emperorBgm:PlayerEmperorBgm;
        private var _bMapBgmStop:Boolean;
        private var _oldPos:Point;
        private var _accel:Number;
        private var _addTime:Number;
        private var _bAddSkip:Boolean;
        private var _bPause:Boolean;
        private var _checkContinue:BattleCheckContinue;
        private var _bItemGet:Boolean;
        private var _wait:Number;
        private var _battle:BattleScene;
        private var _battleEndState:int;
        private var _bRetreat:Boolean;
        private var _battleType:int;
        private var _battleBeforeBgmId:int;
        private var _encount:QuestEncountBase;
        private var _killCount:int;
        private var _paymentScriptFileName:String;
        private var _bPaymentEvent:Boolean = true;
        private var _bPaymentRead:Boolean = false;
        private var _entryPlayerNum:int;
        private var _maxPos:Point;
        private var _minPos:Point;
        private var _targetPos:Point;

        public function ProcessQuest()
        {
            this._maxPos = new Point();
            this._minPos = new Point();
            this._targetPos = new Point();
            return;
        }// end function

        override public function init() : void
        {
            this._cam = new QuestCamera();
            this._aJoinTeamNo = new Array();
            this._aGossipBallon = [];
            this._effectManager = new EffectManager();
            this._aBackupFlag = ScriptManager.getInstance().getCurAllFlag();
            this._aEvent = [];
            this._aItemData = [];
            this._killCount = 0;
            super.init();
            this._questResultType = Constant.UNDECIDED;
            this._bConnectionGet = false;
            QuestManager.getInstance().reset();
            var _loc_1:* = false;
            if (_loc_1 == false)
            {
                NetManager.getInstance().request(new NetTaskQuestStart(QuestManager.getInstance().questNo, QuestManager.getInstance().difficulty, QuestManager.getInstance().eventId, QuestManager.getInstance().aUseItemId, QuestManager.getInstance().isFreeAssault(), this.cbReceive));
            }
            bResourceLoadWait = true;
            this._bScroll = true;
            this._bAutoScroll = true;
            this._bEvent = false;
            this._bPause = false;
            InputManager.getInstance().addMouseCallbackEx(this._bPause, null, null, null, this.cbDownPause, this.cbWheelPause);
            this._battlePhase = this._BATTLE_PHASE_NONE;
            this._mapScrollTutorialStep = this._MAP_SCROLL_TUTORIAL_STEP_NONE;
            this._bMapBgmStop = false;
            SoundManager.getInstance().stopBgm();
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._btnResume)
            {
                ButtonManager.getInstance().removeArray(this._btnResume);
                this._btnResume.release();
            }
            this._btnResume = null;
            if (this._btnEscape)
            {
                ButtonManager.getInstance().removeArray(this._btnEscape);
                this._btnEscape.release();
            }
            this._btnEscape = null;
            if (this._btnDivideReturn)
            {
                ButtonManager.getInstance().removeArray(this._btnDivideReturn);
                this._btnDivideReturn.release();
            }
            this._btnDivideReturn = null;
            if (this._checkContinue)
            {
                this._checkContinue.release();
            }
            this._checkContinue = null;
            this._cam.release();
            this._cam = null;
            if (this._scrollInput)
            {
                this._scrollInput.release();
            }
            this._scrollInput = null;
            if (this._scrollBar)
            {
                this._scrollBar.release();
            }
            this._scrollBar = null;
            if (this._questEnding)
            {
                this._questEnding.release();
            }
            this._questEnding = null;
            if (this._isoItemGet)
            {
                this._isoItemGet.release();
            }
            this._isoItemGet = null;
            if (this._isoItemGetName)
            {
                this._isoItemGetName.release();
            }
            this._isoItemGetName = null;
            if (this._isoAmulet)
            {
                this._isoAmulet.release();
            }
            this._isoAmulet = null;
            if (this._isoResume)
            {
                this._isoResume.release();
            }
            this._isoResume = null;
            if (this._isoDivideReturnBtn)
            {
                this._isoDivideReturnBtn.release();
            }
            this._isoDivideReturnBtn = null;
            for each (_loc_1 in this._aGossipBallon)
            {
                
                _loc_1.release();
            }
            this._aGossipBallon = [];
            for each (_loc_2 in this._aDisplayObject)
            {
                
                _loc_2.release();
            }
            this._aDisplayObject = [];
            if (this._questDivide)
            {
                this._questDivide.release();
            }
            this._questDivide = null;
            if (this._questMap != null)
            {
                this._questMap.release();
            }
            this._questMap = null;
            if (this._questTextPopup != null)
            {
                this._questTextPopup.release();
            }
            this._questTextPopup = null;
            if (this._questTextInformation != null)
            {
                this._questTextInformation.release();
            }
            this._questTextInformation = null;
            if (this._questResultMain != null)
            {
                this._questResultMain.release();
            }
            this._questResultMain = null;
            if (this._mcQuestMap != null)
            {
                if (this._mcQuestMap.parent)
                {
                    this._mcQuestMap.parent.removeChild(this._mcQuestMap);
                }
            }
            this._mcQuestMap = null;
            if (this._mcQuestEnding != null)
            {
                if (this._mcQuestEnding.parent)
                {
                    this._mcQuestEnding.parent.removeChild(this._mcQuestEnding);
                }
            }
            this._mcQuestEnding = null;
            if (this._bmpQuestEndingBg != null)
            {
                if (this._bmpQuestEndingBg.parent)
                {
                    this._bmpQuestEndingBg.parent.removeChild(this._bmpQuestEndingBg);
                }
            }
            this._bmpQuestEndingBg = null;
            if (this._junctionGauge)
            {
                this._junctionGauge.release();
            }
            this._junctionGauge = null;
            if (this._mcQuestResult != null)
            {
                if (this._mcQuestResult.parent)
                {
                    this._mcQuestResult.parent.removeChild(this._mcQuestResult);
                }
            }
            this._mcQuestResult = null;
            InputManager.getInstance().delMouseCallback(this._bPause);
            PlayerManager.getInstance().setSpStopPlayer([]);
            QuestManager.getInstance().questRelease();
            ScriptManager.getInstance().releaseProcess();
            if (this._aBackupFlag)
            {
                ScriptManager.getInstance().rollbackFlag(this._aBackupFlag);
            }
            this._aBackupFlag = null;
            if (this._layer)
            {
                this._layer.release();
            }
            if (this._layerMap)
            {
                this._layerMap.release();
            }
            this._effectManager.release();
            this._effectManager = null;
            if (this._miniTitle)
            {
                if (this._miniTitle.parent)
                {
                    this._miniTitle.parent.removeChild(this._miniTitle);
                }
            }
            this._miniTitle = null;
            SoundManager.getInstance().removeSoundAll();
            TutorialManager.getInstance().release();
            super.release();
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = null;
            var _loc_16:* = 0;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = false;
            var _loc_21:* = null;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = 0;
            var _loc_25:* = 0;
            var _loc_26:* = 0;
            var _loc_27:* = null;
            if (ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false || this._bConnectionGet == false || ScriptManager.getInstance().isLoaded() == false)
            {
                return;
            }
            this._layer = new LayerQuest();
            addChild(this._layer);
            this._layerMap = new LayerQuestMap();
            this._cam.mc.addChild(this._layerMap);
            this._itemGetMc = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + QuestMap.getResourceName(), "itemGetMc");
            this._isoItemGet = new InStayOut(this._itemGetMc);
            this._itemGetNameMc = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + QuestMap.getResourceName(), "MessageBalloonMove");
            this._isoItemGetName = new InStayOut(this._itemGetNameMc);
            this._itemGetNameMc.x = 0;
            this._itemGetNameMc.y = 200;
            this._layer.getLayer(LayerQuest.DIALOG).addChild(this._itemGetNameMc);
            this._mcQuestMap = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + QuestMap.getResourceName(), "QuestMapMainMc");
            this._mcQuestMap.questMapMc.mapLayout.addChild(this._cam.mc);
            this._questMap = new QuestMap(this._mcQuestMap, this._layerMap);
            QuestManager.getInstance().setAmuletLabel();
            var _loc_1:* = QuestManager.getInstance().aAmuletLabel;
            if (_loc_1.length > 0)
            {
                this._isoAmulet = new InStayOut(this._mcQuestMap.growthUpMc);
                _loc_15 = this._mcQuestMap.growthUpMc.growthUpSetMc;
                _loc_16 = 0;
                _loc_15.gotoAndStop("set" + _loc_1.length);
                for each (_loc_17 in _loc_1)
                {
                    
                    _loc_18 = _loc_15["amuletType" + (_loc_16 + 1) + "Mc"];
                    _loc_18.gotoAndStop(_loc_17);
                    _loc_16++;
                }
            }
            this._btnResume = new ButtonBase(this._mcQuestMap.returnPauseBtnTopMc.returnPauseBtnMc, this.cbResume);
            this._btnResume.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mcQuestMap.returnPauseBtnTopMc.returnPauseBtnMc.textMc.textDt, MessageId.QUEST_BUTTON_RESUME);
            this._btnEscape = new ButtonBase(this._mcQuestMap.returnPauseBtnTopMc.retireBtnMc, this.cbEscape);
            this._btnEscape.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcQuestMap.returnPauseBtnTopMc.retireBtnMc.textMc.textDt, MessageId.QUEST_MAP_RETREAT_BUTTON);
            this._isoResume = new InStayOut(this._mcQuestMap.returnPauseBtnTopMc);
            this._btnDivideReturn = new ButtonBase(this._mcQuestMap.returnDivideBtnTopMc.returnDivideBtnMc, this.cbReturnDivide);
            this._btnDivideReturn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._btnDivideReturn.getMoveClip().textMc.textDt, MessageId.QUEST_BUTTON_DIVIDE);
            this._isoDivideReturnBtn = new InStayOut(this._mcQuestMap.returnDivideBtnTopMc);
            this._layer.getLayer(LayerQuest.MAIN).addChild(this._mcQuestMap);
            this._junctionGauge = new QuestJunctionGauge(this._mcQuestMap.timeGaugeTopMc);
            var _loc_2:* = QuestManager.getInstance().questData;
            for each (_loc_3 in _loc_2.aSquare)
            {
                
                if (_loc_3.isTreasure())
                {
                    QuestManager.getInstance().addPieceTreasure(_loc_3.id, this._layerMap.getLayer(LayerQuestMap.PIECE));
                }
                if (_loc_3.bBattle && _loc_3.bEncountSymbol && (_loc_3.attribute1 == QuestConstant.SQUARE_ATTR1_BATTLE || _loc_3.attribute1 == QuestConstant.SQUARE_ATTR1_BOSSBATTLE))
                {
                    QuestManager.getInstance().addPieceEnemy(_loc_3.id, this._layerMap.getLayer(LayerQuestMap.PIECE));
                }
            }
            this._aDisplayObject = [];
            for each (_loc_4 in this._aObjectType)
            {
                
                this._aDisplayObject = this._aDisplayObject.concat(QuestManager.getInstance().createQuestMapObject(this._layerMap.getLayer(LayerQuestMap.SKY), _loc_4, this._mcQuestMap.height));
            }
            _loc_5 = QuestManager.getInstance().setUnit(QuestConstant.TEAM_NO1, 0);
            _loc_5.addTab(this._mcQuestMap);
            _loc_6 = [];
            for each (_loc_7 in QuestManager.getInstance().questData.aPlayer)
            {
                
                _loc_19 = new PlayerDisplay(null, _loc_7.playerId, _loc_7.uniqueId);
                _loc_19.setAnimation(PlayerDisplay.LABEL_SIDE_WALK);
                _loc_5.addPlayer(_loc_19);
                _loc_6.push(_loc_7.uniqueId);
            }
            PlayerManager.getInstance().setSpStopPlayer(_loc_6);
            _loc_8 = UserDataManager.getInstance().userData;
            _loc_9 = new FormationSetData(_loc_8.formationId, _loc_8.aFormationPlayerUniqueId);
            _loc_5.setFormation(_loc_9);
            _loc_10 = _loc_5.aPlayer[0];
            _loc_5.addPiece(this._layerMap, _loc_10.info.id);
            this._unitMoveNo = _loc_5.teamNo;
            this._oldUnitMoveNo = Constant.UNDECIDED;
            _loc_5.setPiece(_loc_2.startSquareId);
            _loc_11 = QuestManager.getInstance().getSquare(_loc_2.startSquareId);
            this._scrollMaxPos = new Point(0, _loc_11.y);
            this._scrollMinPos = new Point(0, Constant.SCREEN_HEIGHT_HALF);
            if (this._scrollMaxPos.y > this._questMap.getMapSize().height - Constant.SCREEN_HEIGHT_HALF)
            {
                this._scrollMaxPos.y = this._questMap.getMapSize().height - Constant.SCREEN_HEIGHT_HALF;
            }
            this._cam.setScrollMinMax(this._scrollMinPos, this._scrollMaxPos);
            this._cam.changePosition(this._scrollMaxPos.x, this._scrollMaxPos.y);
            this._bAutoScroll = false;
            this._bScroll = false;
            this._scrollBar = new QuestScrollBar(this._mcQuestMap.indicationMc.mapScrollBerMc, this._scrollMaxPos, this._scrollMinPos);
            this._scrollBar.setButtonDisable(true);
            this._scrollInput = new QuestScrollInput(this._mcQuestMap, this._mcQuestMap.indicationMc.mapScrollBerMc, this._scrollBar);
            this._scrollInput.setButtonDisable(true);
            this._moveSquareId = _loc_5.squareId;
            var _loc_12:* = this._questMap.getSquare(this._moveSquareId);
            this._questMap.getSquare(this._moveSquareId).setCheck();
            this._miniTitle = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + QuestMap.getResourceName(), "QuestTitleMiniDisplayMc");
            var _loc_13:* = this._questMap.miniTitleNullPos;
            this._miniTitle.x = _loc_13.x;
            this._miniTitle.y = _loc_13.y;
            this._layer.getLayer(LayerQuest.MAIN).addChild(this._miniTitle);
            TextControl.setText(this._miniTitle.miniQuestTitleMc.textMc.textDt, _loc_2.title);
            DisplayUtils.setMouseEnable(this._miniTitle.miniQuestTitleMc.textMc, false);
            this._entryPlayerNum = 0;
            for each (_loc_14 in _loc_6)
            {
                
                if (_loc_14 != Constant.EMPTY_ID)
                {
                    var _loc_30:* = this;
                    var _loc_31:* = this._entryPlayerNum + 1;
                    _loc_30._entryPlayerNum = _loc_31;
                }
            }
            QuestManager.getInstance().setPaymentEventSqId(Constant.EMPTY_ID, Constant.EMPTY_ID);
            if (this._bPaymentEvent && TutorialManager.getInstance().isTutorial() == false)
            {
                _loc_20 = false;
                _loc_21 = QuestManager.getInstance().getPaymentEventStartCandidateSquareId();
                if (_loc_21.length > 0)
                {
                    _loc_24 = _loc_21.length - 1;
                    while (_loc_24 >= 0)
                    {
                        
                        if (ScriptManager.getInstance().isQuestScriptSquare(_loc_21[_loc_24]))
                        {
                            _loc_21.splice(_loc_24, 1);
                            ;
                        }
                        _loc_24 = _loc_24 - 1;
                    }
                    if (_loc_21.length > 0)
                    {
                        _loc_25 = 10;
                        while (_loc_25-- > 0)
                        {
                            
                            _loc_26 = Random.range(0, (_loc_21.length - 1));
                            _loc_22 = _loc_21[_loc_26];
                            _loc_27 = QuestManager.getInstance().getPaymentEventEndCandidateSquareId(_loc_22);
                            if (_loc_27.length > 0)
                            {
                                _loc_24 = 0;
                                while (_loc_24 < _loc_27.length)
                                {
                                    
                                    if (ScriptManager.getInstance().isQuestScriptSquare(_loc_27[_loc_24]))
                                    {
                                        _loc_27.splice(_loc_24, 1);
                                        ;
                                    }
                                    _loc_24++;
                                }
                                if (_loc_27.length > 0)
                                {
                                    _loc_26 = Random.range(0, (_loc_27.length - 1));
                                    _loc_23 = _loc_27[_loc_26];
                                    ScriptManager.getInstance().setPaymentEventSquareId(_loc_22, _loc_23);
                                    QuestManager.getInstance().setPaymentEventSqId(_loc_22, _loc_23);
                                    QuestManager.getInstance().addPieceHippopotamus(_loc_22, this._layerMap.getLayer(LayerQuestMap.PIECE), QuestPieceHippopotamus.ICON_TYPE_PAYMENT_EVENT_START);
                                    QuestManager.getInstance().addPieceHippopotamus(_loc_23, this._layerMap.getLayer(LayerQuestMap.PIECE), QuestPieceHippopotamus.ICON_TYPE_PAYMENT_EVENT_NEXT);
                                    _loc_20 = true;
                                    break;
                                }
                            }
                        }
                    }
                }
            }
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_2, TutorialManager.BASIC_TUTORIAL_FLAG_MAIN_QUEST_END))
            {
                if (Main.GetProcess().fade.isFade())
                {
                    Main.GetProcess().fade.setFadeIn(0.2);
                }
            }
            this.setPhase(this._PHASE_MAP_OPEN);
            bResourceLoadWait = false;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            switch(this._phase)
            {
                case this._PHASE_MAP_OPEN:
                {
                    this.controlMapOpen();
                    break;
                }
                case this._PHASE_MAP_SCROLL_AUTO_IN:
                {
                    this.controlMapScrollAutoIn(param1);
                    break;
                }
                case this._PHASE_MAP_FADE_OUT:
                {
                    this.controlMapFadeOut();
                    break;
                }
                case this._PHASE_MAP_SCROLL_AUTO_SKIP:
                {
                    this.controlMapScrollAutoSkip();
                    break;
                }
                case this._PHASE_CHECK_TITLE_BEFORE_EVENT:
                {
                    this.controlCheckTitleBeforeEvent();
                    break;
                }
                case this._PHASE_CHECK_TITLE_AFTER_EVENT:
                {
                    this.controlCheckTitleAfterEvent();
                    break;
                }
                case this._PHASE_QUEST_TITLE:
                {
                    this.controlQuestTitle();
                    break;
                }
                case this._PHASE_SQUARE_CHECK:
                {
                    this.controlSquareCheck(param1);
                    break;
                }
                case this._PHASE_PIECE_MOVE:
                {
                    this.controlPieceMove();
                    break;
                }
                case this._PHASE_CHECK_RETREAT:
                {
                    this.controlCheckRetreat();
                    break;
                }
                case this._PHASE_CHECK_EVENT:
                {
                    this.controlCheckEvent();
                    break;
                }
                case this._PHASE_CHECK_JOIN:
                {
                    this.controlCheckJoin();
                    break;
                }
                case this._PHASE_CHECK_BATTLE:
                {
                    this.controlCheckBattle(param1);
                    break;
                }
                case this._PHASE_CHECK_MOVE:
                {
                    this.controlCheckMove();
                    break;
                }
                case this._PHASE_CHECK_GOSSIP:
                {
                    this.controlCheckGossip();
                    break;
                }
                case this._PHASE_SELECT_DIVIDE:
                {
                    this.controlSelectDivide();
                    break;
                }
                case this._PHASE_MAP_SCROLL:
                {
                    this.controlMapScroll();
                    break;
                }
                case this._PHASE_RESULT_RESOURCE:
                {
                    this.controlResultResource();
                    break;
                }
                case this._PHASE_RESULT:
                {
                    this.controlResult(param1);
                    break;
                }
                case this._PHASE_SCRIPT_EXE:
                {
                    this.controlScriptExe(param1);
                    break;
                }
                case this._PHASE_QUEST_END:
                {
                    this.controlQuestEnd();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._scrollBar)
            {
                this._scrollBar.control();
            }
            if (this._scrollInput)
            {
                this._scrollInput.control();
            }
            if (this._cam && this._questResultType == Constant.UNDECIDED)
            {
                this._cam.control(param1);
            }
            if (this._effectManager)
            {
                this._effectManager.control(param1);
            }
            if (this._questMap)
            {
                this._questMap.control(param1);
            }
            if (this._questDivide)
            {
                this._questDivide.control(param1);
            }
            if (this._questEnding)
            {
                this._questEnding.control(param1);
            }
            if (this._questTextPopup)
            {
                this._questTextPopup.control(param1);
            }
            if (this._questTextInformation)
            {
                this._questTextInformation.control(param1);
            }
            if (this._junctionGauge)
            {
                this._junctionGauge.control(param1);
            }
            if (this._bAutoScroll)
            {
                this.mapScroll();
            }
            for each (_loc_2 in QuestManager.getInstance().aUnit)
            {
                
                if (_loc_2 != null && _loc_2.aPlayer.length > 0)
                {
                    _loc_2.control(param1);
                }
            }
            _loc_3 = this._aGossipBallon.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_5 = this._aGossipBallon[_loc_3];
                _loc_5.control(param1);
                if (_loc_5.isEnd())
                {
                    _loc_5.release();
                    this._aGossipBallon.splice(_loc_3, 1);
                }
                _loc_3 = _loc_3 - 1;
            }
            for each (_loc_4 in this._aDisplayObject)
            {
                
                _loc_4.control(param1);
            }
            if (QuestSprite.checkPieceSortRequest())
            {
                this._questMap.sortPieceLayer();
                QuestSprite.clearPieceSortRequest();
            }
            return;
        }// end function

        private function mapScroll() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            this._maxPos.y = 0;
            this._maxPos.x = _loc_5;
            var _loc_5:* = 9999;
            this._minPos.y = 9999;
            this._minPos.y = _loc_5;
            if (this._bScroll == true)
            {
                _loc_1 = QuestManager.getInstance().aUnit;
                for each (_loc_2 in _loc_1)
                {
                    
                    if (_loc_2 != null && _loc_2.aPlayer.length > 0)
                    {
                        _loc_3 = _loc_2.piece;
                        _loc_4 = _loc_3.getPosition();
                        if (_loc_4.x > this._maxPos.x)
                        {
                            this._maxPos.x = _loc_4.x;
                        }
                        if (_loc_4.y > this._maxPos.y)
                        {
                            this._maxPos.y = _loc_4.y;
                        }
                        if (_loc_4.x < this._minPos.x)
                        {
                            this._minPos.x = _loc_4.x;
                        }
                        if (_loc_4.y < this._minPos.y)
                        {
                            this._minPos.y = _loc_4.y;
                        }
                    }
                }
                this._targetPos.x = this._minPos.x * 0.8 + this._maxPos.x * 0.2;
                this._targetPos.y = this._minPos.y * 0.8 + this._maxPos.y * 0.2;
                this._scrollBar.limitCheck(this._targetPos);
                this._targetPos.x = this._targetPos.x + this._scrollBar.scrollPos.x;
                this._targetPos.y = this._targetPos.y + this._scrollBar.scrollPos.y;
                this._cam.movePosition(0, this._targetPos.y);
                this._scrollBar.update(this._cam.pos);
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            var _loc_2:* = this._phase;
            this._phase = param1;
            switch(this._phase)
            {
                case this._PHASE_MAP_SCROLL_AUTO_IN:
                {
                    this.phaseMapScrollAutoIn();
                    break;
                }
                case this._PHASE_MAP_FADE_OUT:
                {
                    this.phaseMapFadeOut();
                    break;
                }
                case this._PHASE_MAP_FADE_IN:
                {
                    this.phaseMapFadeIn();
                    break;
                }
                case this._PHASE_MAP_SCROLL_AUTO_SKIP:
                {
                    this.phaseMapScrollAutoSkip();
                    break;
                }
                case this._PHASE_CHECK_TITLE_BEFORE_EVENT:
                {
                    this.phaseCheckTitleBeforeEvent();
                    break;
                }
                case this._PHASE_CHECK_TITLE_AFTER_EVENT:
                {
                    this.phaseCheckTitleAfterEvent();
                    break;
                }
                case this._PHASE_QUEST_TITLE:
                {
                    this.phaseQuestTitle();
                    break;
                }
                case this._PHASE_QUEST_START:
                {
                    this.phaseQuestStart();
                    break;
                }
                case this._PHASE_SQUARE_CHECK:
                {
                    this.phaseSquareCheck();
                    break;
                }
                case this._PHASE_PIECE_MOVE:
                {
                    this.phasePieceMove();
                    break;
                }
                case this._PHASE_PAUSE:
                {
                    this.phasePause();
                    break;
                }
                case this._PHASE_RESUME:
                {
                    this.phaseResume();
                    break;
                }
                case this._PHASE_CHECK_RETREAT:
                {
                    this.phaseCheckRetreat();
                    break;
                }
                case this._PHASE_CHECK_EVENT:
                {
                    this.phaseCheckEvent();
                    break;
                }
                case this._PHASE_CHECK_JOIN:
                {
                    this.phaseCheckJoin();
                    break;
                }
                case this._PHASE_CHECK_BATTLE:
                {
                    this.phaseCheckBattle();
                    break;
                }
                case this._PHASE_CHECK_MOVE:
                {
                    this.phaseCheckMove();
                    break;
                }
                case this._PHASE_CHECK_GOSSIP:
                {
                    this.phaseCheckGossip();
                    break;
                }
                case this._PHASE_SELECT_DIVIDE:
                {
                    this.phaseSelectDivide();
                    break;
                }
                case this._PHASE_MAP_SCROLL:
                {
                    this.phaseMapScroll();
                    break;
                }
                case this._PHASE_RESULT_RECEIVE:
                {
                    this.phaseResultRecieve();
                    break;
                }
                case this._PHASE_RESULT_RESOURCE:
                {
                    this.phaseResultResource();
                    break;
                }
                case this._PHASE_RESULT:
                {
                    this.phaseResult();
                    break;
                }
                case this._PHASE_SCRIPT_EXE:
                {
                    this._scriptReturnPhase = _loc_2;
                    this.phaseScriptExe();
                    break;
                }
                case this._PHASE_QUEST_END:
                {
                    this.phaseQuestEnd();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function phaseMapOpen() : void
        {
            return;
        }// end function

        private function controlMapOpen() : void
        {
            var _loc_1:* = Main.GetProcess().loading;
            if (_loc_1 != null)
            {
                _loc_1.close();
                return;
            }
            if (this._questMap.bWait == false)
            {
                return;
            }
            var _loc_2:* = this._cam.pos;
            if (_loc_2.y == this._scrollMaxPos.y)
            {
                this._questMap.setMapOpen(this.cbMapOpen);
            }
            return;
        }// end function

        private function cbMapOpen() : void
        {
            this._bAutoScroll = true;
            this._bScroll = true;
            this.setPhase(this._PHASE_CHECK_TITLE_BEFORE_EVENT);
            return;
        }// end function

        private function phaseMapScrollAutoIn() : void
        {
            var _loc_1:* = this._emperorBgm != null && this._emperorBgm.wayBgmId > 0 ? (this._emperorBgm.wayBgmId) : (QuestManager.getInstance().questData.questBgmId);
            SoundManager.getInstance().playBgm(_loc_1);
            this._bAutoScroll = false;
            this._bScroll = false;
            this._bAddSkip = false;
            this._oldPos = this._cam.pos.clone();
            this._accel = -this._SCROLL_ADD_VALUE;
            this._wait = 0;
            this._addTime = 0;
            return;
        }// end function

        private function controlMapScrollAutoIn(param1:Number) : void
        {
            var _loc_4:* = NaN;
            var _loc_2:* = this._cam.pos;
            if (this._bAddSkip == false)
            {
                this._addTime = this._addTime + param1;
                if (this._addTime >= this._SCROLL_WAIT_SKIP)
                {
                    this._bAddSkip = true;
                    InputManager.getInstance().addMouseCallback(this, null, this.cbClickMouse);
                }
            }
            var _loc_3:* = _loc_2.y / this._scrollMaxPos.y;
            if (_loc_2.y > this._scrollMinPos.y && this._accel <= this._SCROLL_ADD_VALUE)
            {
                _loc_4 = 1;
                if (_loc_3 < this._SCROLL_FRICTION_RATE)
                {
                    _loc_4 = this._SCROLL_FRICTION;
                }
                else
                {
                    this._accel = this._accel - this._SCROLL_ADD_VALUE;
                }
                if (this._accel < -this._SCROLL_MAX_VALUE)
                {
                    this._accel = -this._SCROLL_MAX_VALUE;
                }
                this._accel = this._accel * _loc_4;
                if (_loc_2.y + this._accel < this._scrollMinPos.y)
                {
                    this._accel = this._scrollMinPos.y - _loc_2.y;
                }
                this._cam.movePosition(_loc_2.x, _loc_2.y + this._accel);
            }
            else
            {
                this._accel = 0;
                this._wait = this._wait + param1;
                if (this._SCROLL_WAIT_TIME < this._wait)
                {
                    this.setPhase(this._PHASE_MAP_FADE_OUT);
                }
            }
            return;
        }// end function

        private function phaseMapFadeOut() : void
        {
            InputManager.getInstance().delMouseCallback(this);
            Main.GetProcess().fade.setFadeOut(Constant.FADE_OUT_TIME, this.cbMapFadeOut);
            return;
        }// end function

        private function controlMapFadeOut() : void
        {
            if (this._bAutoScroll && (this._cam.pos.x == this._oldPos.x && this._cam.pos.y == this._oldPos.y))
            {
                this.setPhase(this._PHASE_MAP_FADE_IN);
            }
            return;
        }// end function

        private function cbMapFadeOut() : void
        {
            this._cam.moveCamera(this._oldPos);
            this._bAutoScroll = true;
            this._cam.movePosition(this._oldPos.x, this._oldPos.y);
            return;
        }// end function

        private function phaseMapFadeIn() : void
        {
            Main.GetProcess().fade.setFadeIn(Constant.FADE_IN_TIME, this.cbMapFadeIn);
            return;
        }// end function

        private function cbMapFadeIn() : void
        {
            this.setPhase(this._PHASE_QUEST_TITLE);
            return;
        }// end function

        private function phaseMapScrollAutoSkip() : void
        {
            InputManager.getInstance().delMouseCallback(this);
            this._accel = 0;
            this._wait = 0;
            this._cam.movePosition(this._oldPos.x, this._oldPos.y);
            return;
        }// end function

        private function controlMapScrollAutoSkip() : void
        {
            if (this._cam.pos.y == this._oldPos.y)
            {
                this.setPhase(this._PHASE_QUEST_TITLE);
            }
            return;
        }// end function

        private function phaseCheckTitleBeforeEvent() : void
        {
            var _loc_1:* = ScriptManager.getInstance().getQuestScript(ScriptComConstant.TRIGGER_BEFORE_OF_TITLE, Constant.UNDECIDED);
            if (_loc_1 != null)
            {
                this._aEvent.push(_loc_1.scriptId);
                ScriptManager.getInstance().initScript(_loc_1, this._layer.getLayer(LayerQuest.EVENT));
                this.setPhase(this._PHASE_SCRIPT_EXE);
            }
            return;
        }// end function

        private function controlCheckTitleBeforeEvent() : void
        {
            this.setPhase(this._PHASE_MAP_SCROLL_AUTO_IN);
            return;
        }// end function

        private function phaseCheckTitleAfterEvent() : void
        {
            var _loc_1:* = ScriptManager.getInstance().getQuestScript(ScriptComConstant.TRIGGER_AFTER_OF_TITLE, Constant.UNDECIDED);
            if (_loc_1 != null)
            {
                this._aEvent.push(_loc_1.scriptId);
                ScriptManager.getInstance().initScript(_loc_1, this._layer.getLayer(LayerQuest.EVENT));
                this.setPhase(this._PHASE_SCRIPT_EXE);
            }
            else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_START))
            {
                TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_START);
            }
            return;
        }// end function

        private function controlCheckTitleAfterEvent() : void
        {
            if (!CommonPopup.isUse())
            {
                this.setPhase(this._PHASE_QUEST_START);
            }
            return;
        }// end function

        private function phaseQuestTitle() : void
        {
            InputManager.getInstance().delMouseCallback(this);
            this._questMap.setTitleOpen();
            return;
        }// end function

        private function controlQuestTitle() : void
        {
            if (this._questMap.bTitleDisp == false)
            {
                this.setPhase(this._PHASE_CHECK_TITLE_AFTER_EVENT);
            }
            return;
        }// end function

        private function phaseQuestStart() : void
        {
            this._miniTitle.gotoAndPlay("in");
            this._questMap.setInformationOpen();
            this._junctionGauge.setIn();
            if (this._isoAmulet)
            {
                this._isoAmulet.setIn();
            }
            this.setPhase(this._PHASE_CHECK_EVENT);
            return;
        }// end function

        private function phaseSquareCheck() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            this._bItemGet = false;
            this._wait = 0;
            if (this._oldUnitMoveNo > Constant.UNDECIDED)
            {
                _loc_1 = QuestManager.getInstance().getUnit(this._oldUnitMoveNo);
                if (_loc_1 && _loc_1.piece)
                {
                    _loc_2 = this._questMap.getSquare(_loc_1.squareId);
                    if (_loc_2 != null)
                    {
                        _loc_2.setCheckWithJunctionCount();
                    }
                    _loc_3 = QuestManager.getInstance().getSquare(_loc_1.squareId);
                    if (_loc_3 && _loc_3.itemCount > 0)
                    {
                        this._itemGetMc.dsNull.removeChildren();
                        if (this._isoItemGet && this._itemGetMc.parent)
                        {
                            this._itemGetMc.parent.removeChild(this._itemGetMc);
                        }
                        QuestManager.getInstance().openPieceTreasure(_loc_3.id);
                        _loc_4 = _loc_1.piece.getPosition();
                        this._layerMap.getLayer(LayerQuestMap.SKY).addChild(this._itemGetMc);
                        this._itemGetMc.x = _loc_3.x;
                        this._itemGetMc.y = _loc_3.y;
                        _loc_5 = ResourceManager.getInstance().createBitmap(ItemManager.getInstance().getItemPng(_loc_3.itemType, _loc_3.itemId));
                        ResourceManager.getInstance().createBitmap(ItemManager.getInstance().getItemPng(_loc_3.itemType, _loc_3.itemId)).x = _loc_5.x - _loc_5.width / 2;
                        _loc_5.y = _loc_5.y - _loc_5.height / 2;
                        this._itemGetMc.dsNull.addChild(_loc_5);
                        TextControl.setText(this._itemGetMc.itemGetSetNum.textMc.textDt, MessageManager.getInstance().getMessage(MessageId.QUEST_GET_TREASURE_CROSS) + _loc_3.itemCount.toString());
                        _loc_6 = new Object();
                        _loc_6.category = _loc_3.itemType;
                        _loc_6.itemId = _loc_3.itemId;
                        _loc_6.num = _loc_3.itemCount;
                        this._aItemData.push(_loc_6);
                        _loc_7 = ItemManager.getInstance().getItemName(_loc_3.itemType, _loc_3.itemId);
                        _loc_8 = MessageId.QUEST_GET_DESTINY_STONE;
                        if (_loc_3.itemType == CommonConstant.ITEM_KIND_ASSET && _loc_3.itemId == AssetId.ASSET_GACHA_POINT)
                        {
                            _loc_8 = MessageId.QUEST_GET_GACHA_POINT;
                        }
                        TextControl.setText(this._itemGetNameMc.fukiTopMc.textMc.textDt, TextControl.formatIdText(_loc_8, _loc_7, _loc_3.itemCount));
                        this._isoItemGet.setIn();
                        this._bItemGet = true;
                        SoundManager.getInstance().playSe(SoundId.SE_POINT);
                    }
                }
            }
            this._bEvent = false;
            return;
        }// end function

        private function controlSquareCheck(param1:Number) : void
        {
            if (this._bItemGet && this._isoItemGet != null && this._isoItemGetName != null)
            {
                if (this._isoItemGet.bOpened && this._isoItemGet.bAnimetion == false)
                {
                    this._wait = this._wait + param1;
                    if (this._wait > 1)
                    {
                        this._isoItemGet.setOut(this.cbItemImageClose);
                    }
                }
                if (this._isoItemGetName.bOpened && this._isoItemGetName.bAnimetion == false)
                {
                    this._wait = this._wait + param1;
                    if (this._wait > 1)
                    {
                        this._isoItemGetName.setOut();
                    }
                }
                if (this._isoItemGet.bEnd && this._isoItemGetName.bEnd)
                {
                    if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_PICKUP_ITEM))
                    {
                        TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_PICKUP_ITEM);
                    }
                    if (CommonPopup.isUse() == false)
                    {
                        this._bItemGet = false;
                    }
                }
            }
            else
            {
                this.setPhase(this._PHASE_PIECE_MOVE);
            }
            return;
        }// end function

        private function cbItemImageClose() : void
        {
            this._isoItemGetName.setIn(this.cbItemNameOpen);
            return;
        }// end function

        private function cbItemNameOpen() : void
        {
            this._wait = 0;
            return;
        }// end function

        private function phasePieceMove() : void
        {
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            if (_loc_1 != null && _loc_1.aPlayer.length > 0 && _loc_1.targetSquareId != Constant.UNDECIDED)
            {
                this._moveSquareId = _loc_1.targetSquareId;
                _loc_1.movePiece(_loc_1.targetSquareId);
            }
            else
            {
                this.setPhase(this._PHASE_CHECK_MOVE);
            }
            this._bScroll = true;
            this._bGossipBallonn = false;
            SoundManager.getInstance().playSe(SoundId.SE_CHARA_FOOTSTEP);
            return;
        }// end function

        private function controlPieceMove() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            if (_loc_1 != null && _loc_1.aPlayer.length > 0)
            {
                _loc_2 = _loc_1.piece;
                if (_loc_2 != null)
                {
                    if (_loc_2.bArrival)
                    {
                        _loc_2.bArrival = false;
                        _loc_3 = this._questMap.getSquare(this._moveSquareId);
                        if (_loc_3.bCheck == false)
                        {
                            QuestManager.getInstance().updateUnitPosition();
                        }
                        _loc_4 = String(_loc_1.oldSquareId + "_" + _loc_1.squareId);
                        _loc_5 = this._questMap.getLine(_loc_4);
                        if (_loc_5)
                        {
                            _loc_5.setCheck();
                        }
                    }
                    if (_loc_2.bMoveing == false)
                    {
                        this.setPhase(this._PHASE_CHECK_EVENT);
                    }
                }
            }
            return;
        }// end function

        private function phasePause() : void
        {
            this._scrollBar.setButtonDisable(false);
            this._scrollInput.setButtonDisable(false);
            this._btnResume.reset();
            this._btnEscape.reset();
            ButtonManager.getInstance().addButtonBase(this._btnResume);
            ButtonManager.getInstance().addButtonBase(this._btnEscape);
            this._btnEscape.setDisable(TutorialManager.getInstance().isTutorial());
            this._isoResume.setIn();
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            if (_loc_1 != null && _loc_1.aPlayer.length > 0)
            {
                _loc_1.setPause(true);
            }
            return;
        }// end function

        private function removePauseUI() : void
        {
            this._scrollBar.setButtonDisable(true);
            this._scrollBar.scrollReset();
            this._scrollInput.setButtonDisable(true);
            this._isoResume.setOut();
            this._btnResume.setMouseOut();
            this._btnEscape.setMouseOut();
            ButtonManager.getInstance().removeArray(this._btnResume);
            ButtonManager.getInstance().removeArray(this._btnEscape);
            return;
        }// end function

        private function phaseResume() : void
        {
            this.removePauseUI();
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            if (_loc_1 != null && _loc_1.aPlayer.length > 0)
            {
                _loc_1.setPause(false);
                this._phase = this._PHASE_PIECE_MOVE;
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
            this._checkContinue = new BattleCheckContinue(this._layer.getLayer(LayerQuest.DIALOG), true);
            return;
        }// end function

        private function controlCheckRetreat() : void
        {
            var _loc_1:* = false;
            if (this._checkContinue && this._checkContinue.bClose)
            {
                if (this._checkContinue.select != Constant.UNDECIDED)
                {
                    _loc_1 = true;
                    if (this._checkContinue.select == BattleCheckContinue.SELECT_NO)
                    {
                        _loc_1 = false;
                    }
                    this._checkContinue.release();
                    this._checkContinue = null;
                    if (_loc_1)
                    {
                        this._bRetreat = true;
                        this._battleEndState = Constant.UNDECIDED;
                        this.removePauseUI();
                        this.setPhase(this._PHASE_RESULT_RECEIVE);
                    }
                    else
                    {
                        this._phase = this._PHASE_PAUSE;
                    }
                }
            }
            return;
        }// end function

        private function phaseCheckEvent() : void
        {
            var _loc_3:* = 0;
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            var _loc_2:* = ScriptManager.getInstance().getQuestScript(ScriptComConstant.TRIGGER_PIECE_LANDING, _loc_1.squareId);
            if (_loc_2 != null)
            {
                this._bPaymentRead = false;
                if (!_loc_2.bPayment)
                {
                    this._aEvent.push(_loc_2.scriptId);
                }
                else
                {
                    _loc_3 = QuestManager.getInstance().questData.paymentEventRead;
                    if (_loc_1.squareId == QuestManager.getInstance().paymentEventStartSqId)
                    {
                        this._bPaymentRead = _loc_3 != QuestConstant.PAYMENT_EVENT_READ_NONE;
                    }
                    else
                    {
                        this._bPaymentRead = _loc_3 == QuestConstant.PAYMENT_EVENT_READ_BOTH;
                    }
                }
                ScriptManager.getInstance().initScript(_loc_2, this._layer.getLayer(LayerQuest.EVENT));
                this.setPhase(this._PHASE_SCRIPT_EXE);
                this._bEvent = true;
                this._bGossipBallonn = false;
            }
            else
            {
                this.setPhase(this._PHASE_CHECK_JOIN);
            }
            return;
        }// end function

        private function controlCheckEvent() : void
        {
            return;
        }// end function

        private function phaseCheckJoin() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            for each (_loc_2 in QuestManager.getInstance().aUnit)
            {
                
                if (_loc_2 == null || _loc_2.teamNo == this._unitMoveNo)
                {
                    continue;
                }
                if (_loc_1.squareId == _loc_2.squareId)
                {
                    this._aJoinTeamNo.push(_loc_2.teamNo);
                    break;
                }
            }
            if (this._aJoinTeamNo.length > 0)
            {
                this._aJoinTeamNo.push(_loc_1.teamNo);
                this._aJoinTeamNo.sort();
                this._questTextPopup = new QuestTextPopup(this._layer.getLayer(LayerQuest.DIALOG));
                _loc_3 = StringTools.format(MessageManager.getInstance().getMessage(MessageId.QUEST_MESSAGE_JOIN), this._aJoinTeamNo[0], this._aJoinTeamNo[1]);
                this._questTextPopup.setInText(_loc_3);
                this._questTextPopup.setPlaySeId(SoundId.SE_CHEER1016);
                this._bGossipBallonn = false;
            }
            return;
        }// end function

        private function controlCheckJoin() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._questTextPopup != null)
            {
                if (this._questTextPopup.bClosed)
                {
                    this._questTextPopup.release();
                    this._questTextPopup = null;
                    _loc_1 = QuestManager.getInstance().getUnit(this._aJoinTeamNo[0]);
                    _loc_2 = [];
                    _loc_3 = 1;
                    while (_loc_3 < this._aJoinTeamNo.length)
                    {
                        
                        _loc_5 = QuestManager.getInstance().getUnit(this._aJoinTeamNo[_loc_3]);
                        _loc_2 = _loc_2.concat(_loc_5.aPlayer);
                        _loc_5.clearPlayer();
                        _loc_5.removePiece();
                        _loc_3++;
                    }
                    for each (_loc_4 in _loc_2)
                    {
                        
                        _loc_1.addPlayer(_loc_4);
                    }
                    this._aJoinTeamNo = [];
                    _loc_2 = [];
                    this.resetUnitFormation(_loc_1);
                }
            }
            else
            {
                if (this._junctionGauge.bGaugeMove == true)
                {
                    return;
                }
                if (this._aJoinTeamNo.length == 0)
                {
                    this.setPhase(this._PHASE_CHECK_BATTLE);
                }
            }
            return;
        }// end function

        private function resetUnitFormation(param1:QuestUnit) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_4:* = [];
            var _loc_5:* = [];
            _loc_7 = 0;
            while (_loc_7 < param1.aPlayer.length)
            {
                
                _loc_6 = (param1.aPlayer[_loc_7] as PlayerDisplay).uniqueId;
                _loc_3 = QuestManager.getInstance().questData.getPlayerPersonal(_loc_6);
                _loc_4.push(_loc_3);
                if (_loc_3 && _loc_3.bDead == false)
                {
                    _loc_5.push(_loc_6);
                }
                _loc_7++;
            }
            _loc_5.sort(Array.NUMERIC);
            if (_loc_5.length < this._entryPlayerNum)
            {
                _loc_10 = QuestManager.getInstance().getFormationBackup(_loc_5);
                if (_loc_10)
                {
                    _loc_8 = _loc_10.unitFormation.aPlayerUniqueId;
                    _loc_9 = _loc_10.unitFormation.id;
                }
                else
                {
                    _loc_8 = [Constant.EMPTY_ID, Constant.EMPTY_ID, Constant.EMPTY_ID, Constant.EMPTY_ID, Constant.EMPTY_ID, Constant.EMPTY_ID];
                    _loc_12 = 0;
                    _loc_7 = 0;
                    while (_loc_7 < param1.aPlayer.length)
                    {
                        
                        if ((_loc_4[_loc_7] as PlayerPersonal).bDead == false)
                        {
                            _loc_8[_loc_12] = (param1.aPlayer[_loc_7] as PlayerDisplay).uniqueId;
                            _loc_12++;
                        }
                        _loc_7++;
                    }
                    _loc_9 = FormationManager.getInstance().getBasicFormationId(_loc_12);
                }
                _loc_6 = _loc_8[FormationSetData.FORMATION_INDEX_COMMANDER];
                if (_loc_6 != Constant.EMPTY_ID && QuestManager.getInstance().commanderUniqueId)
                {
                    _loc_7 = 0;
                    while (_loc_7 < _loc_8.length)
                    {
                        
                        if (_loc_8[_loc_7] == Constant.EMPTY_ID)
                        {
                            _loc_8[_loc_7] = _loc_6;
                            _loc_8[FormationSetData.FORMATION_INDEX_COMMANDER] = Constant.EMPTY_ID;
                            break;
                        }
                        _loc_7++;
                    }
                }
                _loc_11 = new FormationSetData(_loc_9, _loc_8);
                param1.setFormation(_loc_11);
            }
            else
            {
                _loc_13 = UserDataManager.getInstance().userData;
                _loc_14 = new FormationSetData(_loc_13.formationId, _loc_13.aFormationPlayerUniqueId);
                param1.setFormation(_loc_14);
            }
            return;
        }// end function

        private function phaseCheckBattle() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._battlePhase != this._BATTLE_PHASE_NONE)
            {
                return;
            }
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            if (_loc_1 != null && _loc_1.aPlayer.length > 0)
            {
                _loc_2 = QuestManager.getInstance().getSquare(_loc_1.squareId);
                this._battleEndState = Constant.UNDECIDED;
                if (_loc_2.bBattle)
                {
                    this._bEvent = true;
                    if (_loc_2.attribute1 == QuestConstant.SQUARE_ATTR1_BOSSBATTLE)
                    {
                        this._battleType = BattleConstant.BATTLE_TYPE_BOSS;
                    }
                    else
                    {
                        _loc_3 = QuestManager.getInstance().getSquare(_loc_2.id);
                        if (_loc_3.aConnectionId.length > 0)
                        {
                            _loc_4 = QuestManager.getInstance().getSquare(_loc_3.aConnectionId[0]);
                            _loc_5 = new Point(_loc_4.x - _loc_3.x, _loc_4.y - _loc_3.y);
                            _loc_1.piece.setReverse(_loc_5.x > 0);
                            _loc_1.piece.setAnimation(PlayerDisplay.LABEL_ACTION_SELECT_END);
                        }
                        this._battleType = BattleConstant.BATTLE_TYPE_NORMAL;
                    }
                    if (_loc_2.bEncountSymbol)
                    {
                        this.battleSetPhase(this._BATTLE_PHASE_CHECK_EVENT_BEFORE);
                    }
                    else
                    {
                        this.battleSetPhase(this._BATTLE_PHASE_ENEMY_RISE);
                    }
                    this._bGossipBallonn = false;
                }
                else
                {
                    this.battleSetPhase(this._BATTLE_PHASE_NO_ENCOUNT_CHECK_EVENT_BEFORE);
                }
            }
            else
            {
                this.battleSetPhase(this._BATTLE_PHASE_NONE);
            }
            return;
        }// end function

        private function controlCheckBattle(param1:Number) : void
        {
            switch(this._battlePhase)
            {
                case this._BATTLE_PHASE_NONE:
                {
                    this.battleControlNone();
                    break;
                }
                case this._BATTLE_PHASE_ENEMY_RISE:
                {
                    this.battleControlEnemyRise();
                    break;
                }
                case this._BATTLE_PHASE_CHECK_EVENT_BEFORE:
                {
                    this.battleControlCheckEventBefore();
                    break;
                }
                case this._BATTLE_PHASE_INFORMATION:
                {
                    this.battleControlInformation();
                    break;
                }
                case this._BATTLE_PHASE_ENCOUNT:
                {
                    this.battleControlEncount(param1);
                    break;
                }
                case this._BATTLE_PHASE_FIGHT:
                {
                    this.battleControlFight(param1);
                    break;
                }
                case this._BATTLE_PHASE_FIGHT_END:
                {
                    this.battleControlFightEnd(param1);
                    break;
                }
                case this._BATTLE_PHASE_DELETE_ENEMY_PIECE:
                {
                    this.battleControlDeleteEnemyPiece();
                    break;
                }
                case this._BATTLE_PHASE_DELETE_PLAYER_PIECE:
                {
                    this.battleControlDeletePlayerPiece();
                    break;
                }
                case this._BATTLE_PHASE_WIN:
                {
                    this.battleControlWin();
                    break;
                }
                case this._BATTLE_PHASE_LOSE:
                {
                    this.battleControlLose();
                    break;
                }
                case this._BATTLE_PHASE_CHECK_EVENT_AFTER:
                {
                    this.battleControlCheckEventAfter();
                    break;
                }
                case this._BATTLE_PHASE_NO_ENCOUNT_CHECK_EVENT_BEFORE:
                {
                    this.battleControlNoEncountCheckEventBefore();
                    break;
                }
                case this._BATTLE_PHASE_NO_ENCOUNT_CHECK_EVENT_AFTER:
                {
                    this.battleControlNoEncountCheckEventAfter();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._battle != null)
            {
                this._battle.control(param1);
            }
            if (this._encount != null)
            {
                this._encount.control(param1);
            }
            return;
        }// end function

        private function battleSetPhase(param1:int) : void
        {
            this._battlePhase = param1;
            switch(this._battlePhase)
            {
                case this._BATTLE_PHASE_NONE:
                {
                    this.battlePhaseNone();
                    break;
                }
                case this._BATTLE_PHASE_ENEMY_RISE:
                {
                    this.battlePhaseEnemyRise();
                    break;
                }
                case this._BATTLE_PHASE_CHECK_EVENT_BEFORE:
                {
                    this.battlePhaseCheckEventBefore();
                    break;
                }
                case this._BATTLE_PHASE_INFORMATION:
                {
                    this.battlePhaseInformation();
                    break;
                }
                case this._BATTLE_PHASE_ENCOUNT:
                {
                    this.battlePhaseEncount();
                    break;
                }
                case this._BATTLE_PHASE_FIGHT:
                {
                    this.battlePhaseFight();
                    break;
                }
                case this._BATTLE_PHASE_FIGHT_END:
                {
                    this.battlePhaseFightEnd();
                    break;
                }
                case this._BATTLE_PHASE_DELETE_ENEMY_PIECE:
                {
                    this.battlePhaseDeleteEnemyPiece();
                    break;
                }
                case this._BATTLE_PHASE_DELETE_PLAYER_PIECE:
                {
                    this.battlePhaseDeletePlayerPiece();
                    break;
                }
                case this._BATTLE_PHASE_WIN:
                {
                    this.battlePhaseWin();
                    break;
                }
                case this._BATTLE_PHASE_LOSE:
                {
                    this.battlePhaseLose();
                    break;
                }
                case this._BATTLE_PHASE_CHECK_EVENT_AFTER:
                {
                    this.battlePhaseCheckEventAfter();
                    break;
                }
                case this._BATTLE_PHASE_NO_ENCOUNT_CHECK_EVENT_BEFORE:
                {
                    this.battlePhaseNoEncountCheckEventBefore();
                    break;
                }
                case this._BATTLE_PHASE_NO_ENCOUNT_CHECK_EVENT_AFTER:
                {
                    this.battlePhaseNoEncountCheckEventAfter();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function battlePhaseNone() : void
        {
            return;
        }// end function

        private function battleControlNone() : void
        {
            this.setPhase(this._PHASE_CHECK_MOVE);
            return;
        }// end function

        private function battlePhaseEnemyRise() : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            var _loc_2:* = QuestManager.getInstance().getSquare(_loc_1.squareId);
            var _loc_3:* = this._layerMap.getLayer(LayerQuestMap.PIECE);
            var _loc_4:* = QuestManager.getInstance().addPieceEnemy(_loc_2.id, _loc_3, _loc_3.getChildIndex(_loc_1.piece));
            if (_loc_2.aConnectionId.length > 0)
            {
                _loc_6 = QuestManager.getInstance().getSquare(_loc_2.aConnectionId[0]);
                _loc_5 = new Point(_loc_6.x - _loc_2.x, _loc_6.y - _loc_2.y);
            }
            else
            {
                _loc_5 = new Point(_loc_2.x, _loc_2.y - 100);
            }
            _loc_5.normalize(1);
            _loc_5.x = _loc_5.x * 70;
            _loc_5.y = _loc_5.y * 70;
            _loc_4.setFall(_loc_2.x + _loc_5.x, this._layerMap.transform.matrix.ty, _loc_2.x + _loc_5.x, _loc_2.y + _loc_5.y);
            if (_loc_5.x < 0)
            {
                _loc_4.setReverse(true);
            }
            return;
        }// end function

        private function battleControlEnemyRise() : void
        {
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            var _loc_2:* = QuestManager.getInstance().getPieceEnemy(_loc_1.squareId);
            if (_loc_2.bMoveing == false)
            {
                this.battleSetPhase(this._BATTLE_PHASE_CHECK_EVENT_BEFORE);
            }
            return;
        }// end function

        private function battlePhaseCheckEventBefore() : void
        {
            this.battleBeforeEventCheck();
            return;
        }// end function

        private function battleControlCheckEventBefore() : void
        {
            this.battleSetPhase(this._BATTLE_PHASE_ENCOUNT);
            return;
        }// end function

        private function battlePhaseInformation() : void
        {
            this._questTextPopup = new QuestTextPopup(this._layer.getLayer(LayerQuest.DIALOG));
            this._questTextPopup.setInIdText(MessageId.QUEST_MESSAGE_BATTLE);
            return;
        }// end function

        private function battleControlInformation() : void
        {
            if (this._questTextPopup)
            {
                if (this._questTextPopup.bClosed)
                {
                    this._questTextPopup.release();
                    this._questTextPopup = null;
                    this.battleSetPhase(this._BATTLE_PHASE_ENCOUNT);
                }
            }
            return;
        }// end function

        private function battlePhaseEncount() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            this._bScroll = false;
            this._encount = new QuestEncountNoize(this._layer.getLayer(LayerQuest.ENCOUNT), this._layer.getLayer(LayerQuest.MAIN), this._layer.getLayer(LayerQuest.BATTLE));
            this._layer.getLayer(LayerQuest.MAIN).visible = false;
            this._layer.getLayer(LayerQuest.BATTLE).visible = true;
            this._layer.getLayer(LayerQuest.ENCOUNT).visible = true;
            var _loc_4:* = [];
            this._aBattleUnit = [];
            this._aBattlePersonal = [];
            _loc_2 = QuestManager.getInstance().getUnit(this._unitMoveNo);
            this._aBattleUnit.push(_loc_2);
            for each (_loc_1 in _loc_2.aPlayer)
            {
                
                _loc_3 = QuestManager.getInstance().questData.getPlayerPersonal(_loc_1.uniqueId);
                if (_loc_3.bDead == false)
                {
                    this._aBattlePersonal.push(_loc_3);
                }
            }
            if (this._battleType == BattleConstant.BATTLE_TYPE_BOSS)
            {
                for each (_loc_2 in QuestManager.getInstance().aUnit)
                {
                    
                    if (_loc_2 == null)
                    {
                        continue;
                    }
                    this._aBattleUnit.push(_loc_2);
                }
            }
            this._battleBeforeBgmId = SoundManager.getInstance().bgmId;
            var _loc_5:* = QuestManager.getInstance().getSquare(this._moveSquareId);
            var _loc_6:* = QuestManager.getInstance().getQuestEnemyList(_loc_5.aEnemy);
            var _loc_7:* = QuestManager.getInstance().getQuestEnemyList(_loc_5.aEnemy).aEnemyPersonal;
            var _loc_8:* = _loc_6.aChangeEnemy;
            var _loc_9:* = QuestManager.getInstance().getTeamNum();
            var _loc_10:* = QuestManager.getInstance().getTeamNum() > 1;
            this._aBonus = [];
            var _loc_11:* = QuestManager.getInstance().questData.aPlayerBonus;
            var _loc_12:* = QuestManager.getInstance().checkSpecialPlayerBonus(this._aBattlePersonal.length, QuestManager.getInstance().questData.isDivideRootSquare(_loc_5.id), _loc_10);
            for each (_loc_2 in QuestManager.getInstance().aUnit)
            {
                
                if (_loc_2 == null)
                {
                    continue;
                }
                for each (_loc_1 in _loc_2.aPlayer)
                {
                    
                    _loc_19 = QuestManager.getInstance().getBattleResult(_loc_1.uniqueId);
                    _loc_20 = QuestManager.getInstance().getPlayerBonus(_loc_1.uniqueId, _loc_19.battleCount);
                    _loc_3 = QuestManager.getInstance().questData.getPlayerPersonal(_loc_1.uniqueId);
                    if (_loc_3.bDead)
                    {
                        continue;
                    }
                    if (_loc_19 == null || _loc_20 == null)
                    {
                        throw new Error("ボーナス情報が取得できなかった");
                    }
                    _loc_21 = new BattleBonus();
                    _loc_21.questUniqueId = _loc_3.questUniqueId;
                    _loc_21.bonus = QuestManager.getInstance().createPlayerAddBonus(_loc_20, _loc_3, _loc_12);
                    _loc_21.bApplied = false;
                    this._aBonus.push(_loc_21);
                }
            }
            _loc_13 = QuestManager.getInstance().getUnit(this._unitMoveNo);
            _loc_14 = QuestManager.getInstance().questData;
            _loc_15 = _loc_14.battleBgIdNormal;
            _loc_16 = this._emperorBgm != null && this._emperorBgm.normalBattleBgmId > 0 ? (this._emperorBgm.normalBattleBgmId) : (_loc_14.normalBattleBgmId);
            var _loc_17:* = this._emperorBgm != null && this._emperorBgm.feverBgmId > 0 ? (this._emperorBgm.feverBgmId) : (_loc_14.feverBgmId);
            if (this._battleType == BattleConstant.BATTLE_TYPE_BOSS)
            {
                _loc_16 = this._emperorBgm != null && this._emperorBgm.bossBattleBgmId > 0 ? (this._emperorBgm.bossBattleBgmId) : (_loc_14.bossBattlebgmId);
                _loc_15 = _loc_14.battleBgIdBoss;
            }
            var _loc_18:* = new BattleSceneBgmData(_loc_16, _loc_17);
            this._battle = new BattleScene(this._layer.getLayer(LayerQuest.BATTLE), this._battleType, _loc_15, _loc_18, this._aBattlePersonal, _loc_7, this._aBonus, _loc_10, _loc_13.unitFormation, QuestManager.getInstance().difficulty, _loc_8);
            return;
        }// end function

        private function battleControlEncount(param1:Number) : void
        {
            if (this._encount != null && this._battle != null)
            {
                if (this._encount.bAllEnd == false)
                {
                    if (this._encount.bEnd && this._encount.bBattleResourceComplete == false && this._battle.bResourceComplete)
                    {
                        this._encount.bBattleResourceComplete = true;
                        this._battle.setBattleStart();
                    }
                }
                else
                {
                    this.battleSetPhase(this._BATTLE_PHASE_FIGHT);
                }
            }
            return;
        }// end function

        private function battlePhaseFight() : void
        {
            this._layer.getLayer(LayerQuest.ENCOUNT).visible = false;
            return;
        }// end function

        private function battleControlFight(param1:Number) : void
        {
            if (this._battle != null)
            {
                if (this._battle.bEnd)
                {
                    this.battleSetPhase(this._BATTLE_PHASE_FIGHT_END);
                }
            }
            return;
        }// end function

        private function battlePhaseFightEnd() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            if (this._battleType == BattleConstant.BATTLE_TYPE_BOSS)
            {
                _loc_7 = this._battle.turnCount;
                _loc_8 = this._battle.result;
                this.bossBattleSkipPiece(_loc_7, _loc_8);
                this._junctionGauge.setOut();
                if (this._isoAmulet && this._isoAmulet.bOpened)
                {
                    this._isoAmulet.setOut();
                }
            }
            var _loc_1:* = this._battle.getBattlePlayer();
            var _loc_2:* = [];
            for each (_loc_3 in _loc_1)
            {
                
                _loc_2.push(_loc_3.playerPersonal);
            }
            _loc_4 = this._battle.getBattleEnemy();
            for each (_loc_5 in _loc_4)
            {
                
                if (_loc_5.bBattleDead)
                {
                    var _loc_15:* = this;
                    var _loc_16:* = this._killCount + 1;
                    _loc_15._killCount = _loc_16;
                }
            }
            this._bRetreat = this._battle.bRetreat;
            this._battleEndState = this._battle.result;
            _loc_6 = QuestManager.getInstance().questData;
            if (_loc_6 != null && this._battleEndState == BattleConstant.RESULT_WIN)
            {
                QuestManager.getInstance().addBattleResult(_loc_2, this._aBonus);
                _loc_6.updatePlayerPersonalAddBonus(_loc_2, this._aBonus);
            }
            if (this._battleEndState == BattleConstant.RESULT_LOSE || this._battleEndState == BattleConstant.RESULT_ESCAPE)
            {
                _loc_6.updatePlayerPersonal(_loc_2);
            }
            if (this._battleType == BattleConstant.BATTLE_TYPE_NORMAL)
            {
                this.updatePlayerPiece();
            }
            else if (this._battleType == BattleConstant.BATTLE_TYPE_BOSS)
            {
                this.updatePlayerPieceAfterBossBattle(this._battle.writebackUnitFormation);
            }
            if (this._entryPlayerNum == _loc_2.length)
            {
                _loc_9 = this._battle.writebackUnitFormation;
                _loc_10 = UserDataManager.getInstance().userData;
                _loc_11 = _loc_9.aPlayerUniqueId;
                if (this._entryPlayerNum < FormationSetData.FORMATION_INDEX_NUM)
                {
                    _loc_12 = _loc_10.aFormationPlayerUniqueId[FormationSetData.FORMATION_INDEX_COMMANDER];
                    _loc_11 = _loc_11.concat();
                    while (_loc_11.length < FormationSetData.FORMATION_INDEX_NUM)
                    {
                        
                        _loc_11.push(Constant.EMPTY_ID);
                    }
                    _loc_11[FormationSetData.FORMATION_INDEX_COMMANDER] = _loc_12;
                }
                _loc_10.setCurrentFormation(_loc_9.id);
                _loc_10.setFormationPlayer(_loc_11);
            }
            this._encount.setEncountClose();
            this._layer.getLayer(LayerQuest.ENCOUNT).visible = true;
            this._layer.getLayer(LayerQuest.MAIN).visible = true;
            return;
        }// end function

        private function battleControlFightEnd(param1:Number) : void
        {
            var _loc_2:* = 0;
            if (this._encount != null)
            {
                if (this._encount.bAllEnd)
                {
                    _loc_2 = this._battle.result;
                    if (_loc_2 == BattleConstant.RESULT_NOT_END)
                    {
                        throw new Error("バトルの決着がついていない");
                    }
                    this._battle.release();
                    this._battle = null;
                    this._encount.release();
                    this._encount = null;
                    this._layer.getLayer(LayerQuest.MAIN).visible = true;
                    if (_loc_2 == BattleConstant.RESULT_WIN)
                    {
                        if (this._battleType != BattleConstant.BATTLE_TYPE_BOSS && !this._bRetreat)
                        {
                            SoundManager.getInstance().playBgm(this._battleBeforeBgmId);
                        }
                        else
                        {
                            this._bMapBgmStop = true;
                        }
                        this.battleSetPhase(this._BATTLE_PHASE_DELETE_ENEMY_PIECE);
                    }
                    else if (_loc_2 == BattleConstant.RESULT_LOSE || _loc_2 == BattleConstant.RESULT_ESCAPE)
                    {
                        if (this._battleType != BattleConstant.BATTLE_TYPE_NORMAL || _loc_2 != BattleConstant.RESULT_LOSE || this._bRetreat)
                        {
                            this._bMapBgmStop = true;
                        }
                        this.battleSetPhase(this._BATTLE_PHASE_DELETE_PLAYER_PIECE);
                    }
                }
            }
            return;
        }// end function

        private function bossBattleSkipPiece(param1:int, param2:int) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_3:* = this._questMap.getSquare(this._moveSquareId);
            if (param2 == BattleConstant.RESULT_WIN)
            {
                if (_loc_3 != null)
                {
                    _loc_3.setCheckWithJunctionCount();
                }
                param1 = QuestManager.getInstance().junctionMax;
            }
            var _loc_4:* = this._aBattleUnit.length;
            var _loc_5:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            var _loc_6:* = 0;
            while (_loc_6 < param1)
            {
                
                _loc_7 = 0;
                while (_loc_7 < _loc_4)
                {
                    
                    _loc_8 = this._aBattleUnit[_loc_7];
                    _loc_9 = QuestManager.getInstance().getSquare(_loc_8.squareId);
                    _loc_10 = this._questMap.getSquare(_loc_8.squareId);
                    if (_loc_10 != _loc_3)
                    {
                        _loc_10.setCheckWithJunctionCount();
                    }
                    if (_loc_9.attribute1 != QuestConstant.SQUARE_ATTR1_BOSSBATTLE)
                    {
                        if (_loc_9.aConnectionId.length > 0)
                        {
                            _loc_11 = _loc_9.aConnectionId[0];
                            _loc_12 = QuestManager.getInstance().getSquare(_loc_11);
                            if (_loc_12.attribute1 == QuestConstant.SQUARE_ATTR1_BOSSBATTLE)
                            {
                                _loc_8.removePiece();
                            }
                            else
                            {
                                _loc_8.setPiece(_loc_11);
                            }
                            _loc_13 = String(_loc_9.id + "_" + _loc_9.aConnectionId[0]);
                            _loc_14 = this._questMap.getLine(_loc_13);
                            _loc_14.setCheck();
                        }
                    }
                    else
                    {
                        if (_loc_5.teamNo != _loc_8.teamNo)
                        {
                            _loc_8.removePiece();
                        }
                        if (_loc_9.aConnectionId.length > 0)
                        {
                            _loc_15 = String(_loc_8.oldSquareId + "_" + _loc_8.squareId);
                            _loc_16 = this._questMap.getLine(_loc_15);
                            _loc_16.setCheck();
                        }
                    }
                    _loc_7++;
                }
                _loc_6++;
            }
            return;
        }// end function

        private function battlePhaseDeleteEnemyPiece() : void
        {
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            var _loc_2:* = QuestManager.getInstance().getPieceEnemy(_loc_1.squareId);
            _loc_2.setVanish();
            _loc_1.piece.setAnimation(PlayerDisplay.LABEL_SIDE_STOP);
            return;
        }// end function

        private function battleControlDeleteEnemyPiece() : void
        {
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            var _loc_2:* = QuestManager.getInstance().getPieceEnemy(_loc_1.squareId);
            if (_loc_2.bVanish)
            {
                this.battleSetPhase(this._BATTLE_PHASE_WIN);
            }
            return;
        }// end function

        private function updatePlayerPiece() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            var _loc_2:* = QuestManager.getInstance().questData;
            if (_loc_1 == null || _loc_2 == null)
            {
                DebugLog.print("ユニット情報かクエストデータが取得できなかった");
                return;
            }
            _loc_1.setFormation(_loc_1.unitFormation);
            for each (_loc_3 in _loc_1.aPlayer)
            {
                
                _loc_4 = _loc_2.getPlayerPersonal(_loc_3.uniqueId);
                if (_loc_4 == null)
                {
                    continue;
                }
                if (_loc_4.bDead == false && _loc_4.hp > 0)
                {
                    if (_loc_1.piece && _loc_1.piece.playerId == _loc_4.playerId)
                    {
                        break;
                    }
                    _loc_1.addPiece(this._layerMap, _loc_4.playerId);
                    _loc_1.setPiece(_loc_1.squareId);
                    break;
                }
            }
            return;
        }// end function

        private function updatePlayerPieceAfterBossBattle(param1:FormationSetData) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_2:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            var _loc_3:* = QuestManager.getInstance().questData;
            if (_loc_2 == null || _loc_3 == null)
            {
                DebugLog.print("ユニット情報かクエストデータが取得できなかった");
                return;
            }
            var _loc_4:* = param1.aPlayerUniqueId;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                _loc_6 = _loc_4[_loc_5];
                _loc_7 = _loc_3.getPlayerPersonal(_loc_6);
                if (_loc_7 == null)
                {
                }
                else if (_loc_7.bDead == false && _loc_7.hp > 0)
                {
                    if (_loc_2.piece && _loc_2.piece.playerId == _loc_7.playerId)
                    {
                        break;
                    }
                    _loc_2.addPiece(this._layerMap, _loc_7.playerId);
                    _loc_2.setPiece(_loc_2.squareId);
                    break;
                }
                _loc_5++;
            }
            return;
        }// end function

        private function battlePhaseDeletePlayerPiece() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            if (this._battleType == BattleConstant.BATTLE_TYPE_NORMAL)
            {
                _loc_2 = _loc_1.piece;
                _loc_2.setVanish();
                _loc_2.setAnimation(PlayerDisplay.LABEL_CROUCH);
            }
            else
            {
                for each (_loc_1 in this._aBattleUnit)
                {
                    
                    _loc_2 = _loc_1.piece;
                    _loc_2.setVanish();
                    _loc_2.setAnimation(PlayerDisplay.LABEL_CROUCH);
                }
            }
            return;
        }// end function

        private function battleControlDeletePlayerPiece() : void
        {
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            var _loc_2:* = _loc_1.piece;
            if (_loc_2.bVanish)
            {
                this.battleSetPhase(this._BATTLE_PHASE_LOSE);
            }
            return;
        }// end function

        private function battlePhaseWin() : void
        {
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            var _loc_2:* = QuestManager.getInstance().getPieceEnemy(_loc_1.squareId);
            QuestManager.getInstance().removePieceEnemy(_loc_2);
            var _loc_3:* = QuestManager.getInstance().getSquare(_loc_1.squareId);
            QuestManager.getInstance().addTotalBatleExp(_loc_3.emperorExp);
            var _loc_4:* = this;
            var _loc_5:* = this._battleWinCount + 1;
            _loc_4._battleWinCount = _loc_5;
            return;
        }// end function

        private function battleControlWin() : void
        {
            this.battleSetPhase(this._BATTLE_PHASE_CHECK_EVENT_AFTER);
            return;
        }// end function

        private function battlePhaseLose() : void
        {
            this.battleSetPhase(this._BATTLE_PHASE_CHECK_EVENT_AFTER);
            return;
        }// end function

        private function battleControlLose() : void
        {
            return;
        }// end function

        private function battlePhaseCheckEventAfter() : void
        {
            this.battleEventCheck();
            return;
        }// end function

        private function battleControlCheckEventAfter() : void
        {
            if (this.battleEventCheck() == false)
            {
                if (this._battleType == BattleConstant.BATTLE_TYPE_NORMAL)
                {
                    if (this._battleEndState == BattleConstant.RESULT_WIN)
                    {
                        if (this._bRetreat == false)
                        {
                            this.battleSetPhase(this._BATTLE_PHASE_NONE);
                        }
                        if (this._bRetreat == true)
                        {
                            this.setPhase(this._PHASE_RESULT_RECEIVE);
                        }
                    }
                    if (this._battleEndState == BattleConstant.RESULT_LOSE)
                    {
                        QuestManager.getInstance().removeUnit(this._unitMoveNo);
                        if (this._bRetreat == false)
                        {
                            SoundManager.getInstance().playBgm(this._battleBeforeBgmId);
                            this.battleSetPhase(this._BATTLE_PHASE_NONE);
                        }
                        else
                        {
                            this.setPhase(this._PHASE_RESULT_RECEIVE);
                        }
                    }
                    if (this._battleEndState == BattleConstant.RESULT_ESCAPE)
                    {
                        this.setPhase(this._PHASE_RESULT_RECEIVE);
                    }
                }
                else if (this._battleType == BattleConstant.BATTLE_TYPE_BOSS)
                {
                    if (this._battleEndState == BattleConstant.RESULT_WIN)
                    {
                        this.setPhase(this._PHASE_RESULT_RECEIVE);
                    }
                    if (this._battleEndState == BattleConstant.RESULT_LOSE)
                    {
                        this.setPhase(this._PHASE_RESULT_RECEIVE);
                    }
                    if (this._battleEndState == BattleConstant.RESULT_ESCAPE)
                    {
                        this.setPhase(this._PHASE_RESULT_RECEIVE);
                    }
                }
            }
            return;
        }// end function

        private function battlePhaseNoEncountCheckEventBefore() : void
        {
            if (this.battleBeforeEventCheck() == false)
            {
                this.battleSetPhase(this._BATTLE_PHASE_NO_ENCOUNT_CHECK_EVENT_AFTER);
                return;
            }
            return;
        }// end function

        private function battleControlNoEncountCheckEventBefore() : void
        {
            this.battleSetPhase(this._BATTLE_PHASE_NO_ENCOUNT_CHECK_EVENT_AFTER);
            return;
        }// end function

        private function battlePhaseNoEncountCheckEventAfter() : void
        {
            this._bRetreat = false;
            this._battleEndState = BattleConstant.RESULT_WIN;
            if (this.battleEventCheck() == false)
            {
                this.battleSetPhase(this._BATTLE_PHASE_NONE);
                return;
            }
            return;
        }// end function

        private function battleControlNoEncountCheckEventAfter() : void
        {
            if (this.battleEventCheck() == false)
            {
                this.battleSetPhase(this._BATTLE_PHASE_NONE);
            }
            return;
        }// end function

        private function battleBeforeEventCheck() : Boolean
        {
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            var _loc_2:* = ScriptManager.getInstance().getQuestScript(ScriptComConstant.TRIGGER_BEFORE_OF_BATTLE, _loc_1.squareId);
            if (_loc_2 != null)
            {
                this._aEvent.push(_loc_2.scriptId);
                ScriptManager.getInstance().initScript(_loc_2, this._layer.getLayer(LayerQuest.EVENT));
                if (this._battleType == BattleConstant.BATTLE_TYPE_BOSS)
                {
                    this._bMapBgmStop = true;
                }
                this.setPhase(this._PHASE_SCRIPT_EXE);
                return true;
            }
            return false;
        }// end function

        private function battleEventCheck() : Boolean
        {
            var _loc_2:* = null;
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            if (!this._bRetreat)
            {
                _loc_2 = ScriptManager.getInstance().getQuestScript(ScriptComConstant.TRIGGER_AFTER_OF_BATTLE, _loc_1.squareId);
                if (_loc_2 != null)
                {
                    this._aEvent.push(_loc_2.scriptId);
                    ScriptManager.getInstance().initScript(_loc_2, this._layer.getLayer(LayerQuest.EVENT));
                    this.setPhase(this._PHASE_SCRIPT_EXE);
                    return true;
                }
                if (this._battleEndState == BattleConstant.RESULT_WIN)
                {
                    _loc_2 = ScriptManager.getInstance().getQuestScript(ScriptComConstant.TRIGGER_AFTER_OF_BATTLE_WIN, _loc_1.squareId);
                    if (_loc_2 != null)
                    {
                        this._aEvent.push(_loc_2.scriptId);
                        ScriptManager.getInstance().initScript(_loc_2, this._layer.getLayer(LayerQuest.EVENT));
                        this.setPhase(this._PHASE_SCRIPT_EXE);
                        return true;
                    }
                }
            }
            if (this._battleEndState == BattleConstant.RESULT_LOSE)
            {
                _loc_2 = ScriptManager.getInstance().getQuestScript(ScriptComConstant.TRIGGER_AFTER_OF_BATTLE_LOSE, _loc_1.squareId);
                if (_loc_2 != null)
                {
                    this._aEvent.push(_loc_2.scriptId);
                    ScriptManager.getInstance().initScript(_loc_2, this._layer.getLayer(LayerQuest.EVENT));
                    this.setPhase(this._PHASE_SCRIPT_EXE);
                    return true;
                }
            }
            return false;
        }// end function

        private function phaseCheckMove() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            this._oldUnitMoveNo = this._unitMoveNo;
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            if (_loc_1 != null && _loc_1.aPlayer.length > 0)
            {
                _loc_2 = QuestManager.getInstance().getSquare(_loc_1.squareId);
                if (_loc_2.aConnectionId.length == 0)
                {
                    return;
                }
                _loc_3 = [];
                for each (_loc_4 in _loc_2.aConnectionId)
                {
                    
                    _loc_5 = QuestManager.getInstance().getSquare(_loc_4);
                    if (_loc_5 != null)
                    {
                        _loc_3.push(_loc_4);
                    }
                }
                if (_loc_2.attribute1 == QuestConstant.SQUARE_ATTR1_DIVIDE && _loc_3.length > 1)
                {
                    for each (_loc_6 in _loc_3)
                    {
                        
                        _loc_7 = QuestManager.getInstance().getSquare(_loc_6);
                        if (_loc_7 == null)
                        {
                            return;
                        }
                    }
                    this._questTextPopup = new QuestTextPopup(this._layer.getLayer(LayerQuest.DIALOG));
                    this._questTextPopup.setInIdText(MessageId.QUEST_MESSAGE_DIVIDE);
                    this._bGossipBallonn = false;
                    return;
                }
                else
                {
                    _loc_1.targetSquareId = _loc_3[0];
                }
            }
            else
            {
                this._bGossipBallonn = false;
            }
            this._unitMoveNo = QuestManager.getInstance().getNextUnit(this._unitMoveNo);
            if (QuestManager.getInstance().isJoinWaitUnit(this._unitMoveNo))
            {
                this._unitMoveNo = QuestManager.getInstance().getNextUnit(this._unitMoveNo);
            }
            this.setPhase(this._PHASE_CHECK_GOSSIP);
            return;
        }// end function

        private function controlCheckMove() : void
        {
            if (CommonPopup.isUse())
            {
                return;
            }
            if (this._questTextPopup != null)
            {
                if (this._questTextPopup.bClosed)
                {
                    if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_REACH))
                    {
                        TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_REACH);
                        return;
                    }
                    this._questTextPopup.release();
                    this._questTextPopup = null;
                    this.setPhase(this._PHASE_SELECT_DIVIDE);
                }
            }
            return;
        }// end function

        private function phaseCheckGossip() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._bGossipBallonn)
            {
                _loc_1 = QuestManager.getInstance().getPopMessage();
                if (_loc_1 != "")
                {
                    _loc_2 = new QuestGossipBalloon(this._layer.getLayer(LayerQuest.DIALOG), _loc_1, 0, 200, 1);
                    this._aGossipBallon.push(_loc_2);
                }
            }
            return;
        }// end function

        private function controlCheckGossip() : void
        {
            if (this._aGossipBallon.length == 0)
            {
                this.setPhase(this._PHASE_SQUARE_CHECK);
            }
            return;
        }// end function

        private function phaseSelectDivide() : void
        {
            if (this._questDivide)
            {
                this._questDivide.release();
            }
            var _loc_1:* = QuestManager.getInstance().getUnit(this._unitMoveNo);
            this._questDivide = new QuestDivide(this._layer.getLayer(LayerQuest.DIALOG));
            this._questDivide.setIn(_loc_1);
            return;
        }// end function

        private function controlSelectDivide() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            if (this._questDivide != null)
            {
                if (this._questDivide.bOpened)
                {
                    if (this._questDivide.selectButton != Constant.UNDECIDED)
                    {
                        this._questDivide.setOut();
                    }
                }
                if (this._questDivide.bClosed)
                {
                    if (this._questDivide.selectButton == QuestDivide.BUTTON_SCROLL)
                    {
                        this._questDivide.setSelectButton();
                        this.setPhase(this._PHASE_MAP_SCROLL);
                    }
                    if (this._questDivide.selectButton == QuestDivide.BUTTON_DIVIDE)
                    {
                        _loc_1 = QuestManager.getInstance().getUnit(this._unitMoveNo);
                        _loc_2 = QuestManager.getInstance().getSquare(_loc_1.squareId);
                        _loc_3 = this._questDivide.aPlayer;
                        QuestManager.getInstance().addFormationBackup(_loc_1.unitFormation);
                        _loc_5 = this._questDivide.aSwitchTeamNo;
                        _loc_4 = 1;
                        while (_loc_4 < _loc_5.length)
                        {
                            
                            QuestManager.getInstance().setUnit(_loc_5[_loc_4], this._unitMoveNo);
                            _loc_4++;
                        }
                        _loc_6 = _loc_1.aPlayer.concat();
                        for each (_loc_7 in _loc_6)
                        {
                            
                            _loc_1.removePlayer(_loc_7);
                        }
                        for each (_loc_9 in _loc_3)
                        {
                            
                            _loc_12 = UserDataManager.getInstance().userData.getPlayerPersonal(_loc_9.uniqueId);
                            if (_loc_12.bDead == false)
                            {
                                _loc_8 = QuestManager.getInstance().getUnit(_loc_9.setTeamNo);
                                for each (_loc_7 in _loc_6)
                                {
                                    
                                    if (_loc_7.uniqueId == _loc_9.uniqueId)
                                    {
                                        _loc_8.addPlayer(_loc_7);
                                        break;
                                    }
                                }
                            }
                        }
                        _loc_10 = 0;
                        _loc_11 = 0;
                        for each (_loc_11 in _loc_5)
                        {
                            
                            if (_loc_11 > 0)
                            {
                                _loc_8 = QuestManager.getInstance().getUnit(_loc_11);
                                if (_loc_8 == null)
                                {
                                    continue;
                                }
                                this.resetUnitFormation(_loc_8);
                            }
                        }
                        for each (_loc_11 in _loc_5)
                        {
                            
                            if (_loc_11 > 0)
                            {
                                _loc_8 = QuestManager.getInstance().setUnit(_loc_11, (_loc_5[1] + 1));
                                if (_loc_8.aPlayer.length > 0)
                                {
                                    _loc_13 = _loc_8.aPlayer[0];
                                    _loc_8.addPiece(this._layerMap, _loc_13.info.id);
                                    _loc_8.setPiece(_loc_2.id);
                                    continue;
                                }
                                _loc_10 = _loc_11;
                                _loc_8.clearPlayer();
                                _loc_8.removePiece();
                            }
                        }
                        _loc_4 = 0;
                        while (_loc_4 < this._questDivide.aSwitchSquareId.length)
                        {
                            
                            _loc_8 = QuestManager.getInstance().getUnit(_loc_5[(_loc_4 + 1)]);
                            if (_loc_8 != null && _loc_8.aPlayer.length > 0)
                            {
                                _loc_8.targetSquareId = this._questDivide.aSwitchSquareId[_loc_4];
                            }
                            _loc_4++;
                        }
                        if (_loc_10 > 0 && QuestManager.getInstance().getUnit(1) == null)
                        {
                            QuestManager.getInstance().resetUnitTeamNo(_loc_10);
                        }
                        for each (_loc_11 in _loc_5)
                        {
                            
                            if (_loc_11 > 0)
                            {
                                _loc_8 = QuestManager.getInstance().getUnit(_loc_11);
                                if (_loc_8 != null && _loc_8.teamNo < this._unitMoveNo)
                                {
                                    this._unitMoveNo = _loc_8.teamNo;
                                    this._oldUnitMoveNo = this._oldUnitMoveNo;
                                    break;
                                }
                            }
                        }
                        this.setPhase(this._PHASE_SQUARE_CHECK);
                        this._questDivide.release();
                        this._questDivide = null;
                    }
                }
            }
            return;
        }// end function

        private function phaseMapScroll() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this._mapScrollTutorialStep = this._MAP_SCROLL_TUTORIAL_STEP_NONE;
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_2, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_ROUTE_CHECK_BEFORE))
            {
                this._scrollBar.setButtonDisable(false);
                _loc_1 = this._scrollBar.getPushButton(QuestScrollBar.SCROLL_UP);
                _loc_2 = this._scrollBar.getPushButton(QuestScrollBar.SCROLL_DOWN);
                _loc_2.setDisable(true);
                TutorialManager.getInstance().setTutorialArrow(_loc_1.getMoveClip(), TutorialManager.TUTORIAL_ARROW_DIRECTION_RIGHT);
                TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_QUEST_MAP_CHECK_001));
                this._btnDivideReturn.reset();
                this._btnDivideReturn.setDisable(true);
                this._mapScrollTutorialStep = this._MAP_SCROLL_TUTORIAL_STEP_SCROLL_UP;
            }
            else
            {
                this._scrollBar.setButtonDisable(false);
                this._scrollInput.setButtonDisable(false);
                this._btnDivideReturn.reset();
                this._btnDivideReturn.setDisable(false);
            }
            ButtonManager.getInstance().addButtonBase(this._btnDivideReturn);
            this._isoDivideReturnBtn.setIn();
            return;
        }// end function

        private function controlMapScroll() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._questDivide.bOpened == true)
            {
                if (this._mapScrollTutorialStep)
                {
                    TutorialManager.getInstance().hideTutorial();
                }
                this._scrollBar.setButtonDisable(true);
                this._scrollBar.scrollReset();
                this._scrollInput.setButtonDisable(true);
                this._phase = this._PHASE_SELECT_DIVIDE;
            }
            else if (this._mapScrollTutorialStep != this._MAP_SCROLL_TUTORIAL_STEP_NONE)
            {
                switch(this._mapScrollTutorialStep)
                {
                    case this._MAP_SCROLL_TUTORIAL_STEP_SCROLL_UP:
                    {
                        _loc_1 = this._scrollBar.getPushButton(QuestScrollBar.SCROLL_UP);
                        if (_loc_1.bPush)
                        {
                            this._mapScrollTutorialStep = this._MAP_SCROLL_TUTORIAL_STEP_SCROLL_UP_END;
                        }
                        break;
                    }
                    case this._MAP_SCROLL_TUTORIAL_STEP_SCROLL_UP_END:
                    {
                        _loc_1 = this._scrollBar.getPushButton(QuestScrollBar.SCROLL_UP);
                        if (!_loc_1.bPush && this._scrollBar.isMarkerPosMax())
                        {
                            this._scrollBar.setButtonDisable(true);
                            this._btnDivideReturn.setDisable(false);
                            TutorialManager.getInstance().setTutorialArrow(this._btnDivideReturn.getMoveClip(), TutorialManager.TUTORIAL_ARROW_DIRECTION_UP, TutorialManager.TUTORIAL_ARROW_POS_CENTER);
                            TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_QUEST_MAP_CHECK_003));
                            this._mapScrollTutorialStep = this._MAP_SCROLL_TUTORIAL_STEP_RETURN;
                        }
                        break;
                    }
                    case this._MAP_SCROLL_TUTORIAL_STEP_RETURN:
                    {
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

        private function phaseResultRecieve() : void
        {
            var playerPersonal:PlayerPersonal;
            var id:int;
            var bLost:Boolean;
            var personal:PlayerPersonal;
            if (TutorialManager.getInstance().isTutorial())
            {
                if (!TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END))
                {
                    if (this._bRetreat)
                    {
                        this.setPhase(this._PHASE_QUEST_END);
                        return;
                    }
                }
            }
            var userData:* = UserDataManager.getInstance().userData;
            var questData:* = QuestManager.getInstance().questData;
            var deadNum:int;
            var _loc_2:* = 0;
            var _loc_3:* = questData.aPlayer;
            while (_loc_3 in _loc_2)
            {
                
                playerPersonal = _loc_3[_loc_2];
                playerPersonal.updateSpRecoveryTime();
                if (playerPersonal.bDead == true)
                {
                    deadNum = (deadNum + 1);
                }
            }
            if (TutorialManager.getInstance().isTutorial())
            {
                if (!TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END))
                {
                    var _loc_2:* = 0;
                    var _loc_3:* = questData.aPlayer;
                    while (_loc_3 in _loc_2)
                    {
                        
                        playerPersonal = _loc_3[_loc_2];
                        if (playerPersonal.playerId == CommonConstant.NEW_CYCLE_DEFAULT_PLAYER_ID)
                        {
                            if (playerPersonal.bDead)
                            {
                                playerPersonal.revive();
                            }
                            playerPersonal.recoveryHp();
                            playerPersonal.resetSp();
                        }
                    }
                }
            }
            this._questResultType = CommonConstant.QUEST_RESULT_CLEAR;
            if (this._bRetreat == true)
            {
                this._questResultType = CommonConstant.QUEST_RESULT_RETIRE;
            }
            if (this._battleEndState == BattleConstant.RESULT_LOSE && this._bRetreat == true && deadNum == questData.aPlayer.length)
            {
                this._questResultType = CommonConstant.QUEST_RESULT_ANNIHILATION;
            }
            if (this._questResultType != CommonConstant.QUEST_RESULT_CLEAR)
            {
                questData.resetPlayerPersonalOwnSkill(UserDataManager.getInstance().userData.aPlayerPersonal);
                this._aItemData = [];
                ScriptManager.getInstance().rollbackFlag(this._aBackupFlag);
            }
            this._aBackupFlag = null;
            questData.resetEmperorLp(UserDataManager.getInstance().userData.getEmperorPlayerPersonal());
            userData.updatePlayerPersonal(questData.aPlayer, true);
            var obj:* = new Object();
            obj.resultId = this._questResultType;
            obj.aEvent = this._aEvent;
            obj.aPersonal = questData.aPlayer;
            obj.aBattleResult = QuestManager.getInstance().aBattleResult;
            obj.battleExp = QuestManager.getInstance().totalBattleExp;
            obj.totalBattleWin = this._battleWinCount;
            obj.totalMassCount = QuestManager.getInstance().totalMassCount;
            obj.formationData = UserDataManager.getInstance().userData.getFormationSetData();
            obj.killCount = this._killCount;
            obj.aFlag = ScriptManager.getInstance().getOnFlag(this._questResultType);
            obj.aItemData = this._aItemData;
            userData.subUseItem(QuestManager.getInstance().aUseItemId);
            if (QuestManager.getInstance().aUseFreeItemId.indexOf(PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT) >= 0)
            {
                userData.clearFreeWholeArmyAssault();
            }
            var aPlayerUniqueId:Array;
            var _loc_2:* = 0;
            var _loc_3:* = userData.getFormationSetData().aPlayerUniqueId;
            while (_loc_3 in _loc_2)
            {
                
                id = _loc_3[_loc_2];
                bLost;
                var _loc_4:* = 0;
                var _loc_5:* = questData.aPlayer;
                while (_loc_5 in _loc_4)
                {
                    
                    personal = _loc_5[_loc_4];
                    if (personal.uniqueId == id && personal.lp <= 0)
                    {
                        bLost;
                        break;
                    }
                }
                aPlayerUniqueId.push(bLost ? (Constant.EMPTY_ID) : (id));
            }
            userData.setFormationPlayer(aPlayerUniqueId);
            userData.updateFormationBonus();
            if (this._questResultType == CommonConstant.QUEST_RESULT_CLEAR)
            {
                if (!TutorialManager.getInstance().isTutorial() || !TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END))
                {
                    userData.addClearQuestId(QuestManager.getInstance().questNo);
                }
            }
            if (TutorialManager.getInstance().isTutorial())
            {
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END))
                {
                    NetManager.getInstance().request(new NetTaskTutorialQuestEnd(this.cbResultReceive));
                }
                else
                {
                    NetManager.getInstance().request(new NetTaskQuestEnd(obj, function (param1:NetResult) : void
            {
                UserDataManager.getInstance().userData.statusType = CommonConstant.USER_STATE_TUTORIAL_2;
                cbResultReceive(param1);
                return;
            }// end function
            ));
                }
            }
            else
            {
                NetManager.getInstance().request(new NetTaskQuestEnd(obj, this.cbResultReceive));
            }
            return;
        }// end function

        private function phaseResultResource() : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_1:* = UserDataManager.getInstance().userData.emperorId;
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(_loc_1);
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_2.swf);
            var _loc_3:* = QuestManager.getInstance().resultBgm();
            PlayerBigCard.loadResource();
            ResourceManager.getInstance().loadResource(QuestResultMain.getResource());
            SoundManager.getInstance().loadSound(_loc_3);
            var _loc_4:* = false;
            var _loc_5:* = QuestManager.getInstance().questResultData;
            if (QuestManager.getInstance().questResultData.aFirstRemuneration.length > 0)
            {
                ResourceManager.getInstance().loadResource(QuestResultRewardSClearPopup.getResource());
                SoundManager.getInstance().loadSoundArray(QuestResultRewardSClearPopup.getSoundResource());
                for each (_loc_8 in _loc_5.aFirstRemuneration)
                {
                    
                    if (QuestResultMain.getRemunerationResource(_loc_8))
                    {
                        _loc_4 = true;
                    }
                }
            }
            if (_loc_5.aFirstClearRemuneration.length > 0)
            {
                ResourceManager.getInstance().loadResource(QuestResultRewardSClearPopup.getResource());
                SoundManager.getInstance().loadSoundArray(QuestResultRewardSClearPopup.getSoundResource());
                for each (_loc_9 in _loc_5.aFirstClearRemuneration)
                {
                    
                    if (QuestResultMain.getRemunerationResource(_loc_9))
                    {
                        _loc_4 = true;
                    }
                }
            }
            for each (_loc_6 in _loc_5.aClearRemuneration)
            {
                
                if (QuestResultMain.getRemunerationResource(_loc_6))
                {
                    _loc_4 = true;
                }
            }
            for each (_loc_7 in _loc_5.aRoadRemuneration)
            {
                
                if (QuestResultMain.getRemunerationResource(_loc_7))
                {
                    _loc_4 = true;
                }
            }
            if (_loc_4)
            {
                ResourceManager.getInstance().loadResource(ResourcePath.GACHA_PATH + "UI_SummonFree.swf");
                SoundManager.getInstance().loadSound(SoundId.SE_GACHA_RESULT);
            }
            CommonSimpleStatus.loadResource();
            return;
        }// end function

        private function controlResultResource() : void
        {
            if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.setPhase(this._PHASE_RESULT);
            }
            return;
        }// end function

        private function phaseResult() : void
        {
            var _loc_2:* = null;
            if (QuestManager.getInstance().questResultData.bEmperorChange == false)
            {
                _loc_2 = Main.GetProcess().topBar;
                if (_loc_2)
                {
                    _loc_2.update();
                    _loc_2.updateProgress();
                }
            }
            this._mcQuestResult = ResourceManager.getInstance().createMovieClip(QuestResultMain.getResource(), "ResultMainMc");
            this._layer.getLayer(LayerQuest.DIALOG).addChild(this._mcQuestResult);
            this._questResultMain = new QuestResultMain(this._mcQuestResult, this._layer);
            var _loc_1:* = QuestManager.getInstance().resultBgm();
            if (SoundManager.getInstance().bgmId != _loc_1)
            {
                SoundManager.getInstance().playBgm(_loc_1);
            }
            return;
        }// end function

        private function controlResult(param1:Number) : void
        {
            if (this._questResultMain)
            {
                this._questResultMain.control(param1);
                if (this._questResultMain.bEnd)
                {
                    this._questResultMain.release();
                    this._questResultMain = null;
                    this.setPhase(this._PHASE_QUEST_END);
                }
            }
            return;
        }// end function

        private function phaseScriptExe() : void
        {
            if (this._bMapBgmStop)
            {
                ScriptManager.getInstance().setReturnBgm(Constant.UNDECIDED);
            }
            var _loc_1:* = false;
            if (ScriptManager.getInstance().scriptExe.bPayment)
            {
                _loc_1 = this._bPaymentRead;
            }
            else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END))
            {
                _loc_1 = UserDataManager.getInstance().userData.cycle != 1;
            }
            else
            {
                _loc_1 = QuestManager.getInstance().questData.aReadEvent.indexOf(ScriptManager.getInstance().scriptExe.scriptId) >= 0;
            }
            ScriptManager.getInstance().commandInit(_loc_1);
            return;
        }// end function

        private function controlScriptExe(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            ScriptManager.getInstance().commandControl(param1);
            if (ScriptManager.getInstance().isScriptEnd())
            {
                _loc_2 = QuestManager.getInstance().getUnit(this._unitMoveNo);
                if (_loc_2)
                {
                    _loc_4 = QuestManager.getInstance().paymentEventStartSqId;
                    _loc_5 = QuestManager.getInstance().paymentEventNextSqId;
                    if (_loc_2.squareId == _loc_4)
                    {
                        QuestManager.getInstance().vanishPieceHippopotamus(_loc_4);
                        if (QuestManager.getInstance().paymentEventNoticeId)
                        {
                            QuestManager.getInstance().showPieceHippopotamus(_loc_5);
                            QuestManager.getInstance().setPaymentEventActiveSqId(_loc_5);
                        }
                        else
                        {
                            QuestManager.getInstance().setPaymentEventActiveSqId(Constant.EMPTY_ID);
                        }
                    }
                    else if (_loc_2.squareId == _loc_5)
                    {
                        QuestManager.getInstance().vanishPieceHippopotamus(_loc_5);
                        QuestManager.getInstance().setPaymentEventActiveSqId(Constant.EMPTY_ID);
                    }
                }
                ScriptManager.getInstance().releaseScript();
                _loc_3 = this._scriptReturnPhase;
                this._scriptReturnPhase = Constant.UNDECIDED;
                this.setPhase(_loc_3);
            }
            return;
        }// end function

        private function phaseQuestEnd() : void
        {
            SoundManager.getInstance().stopBgm();
            Main.GetProcess().fade.setFadeOut(2);
            return;
        }// end function

        private function controlQuestEnd() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            if (Main.GetProcess().fade.isFadeEnd())
            {
                _loc_1 = UserDataManager.getInstance().userData.statusType;
                if (_loc_1 == CommonConstant.USER_STATE_CYCLE_RESET)
                {
                    Main.GetProcess().SetProcessId(ProcessMain.PROCESS_ENDING);
                }
                else if (TutorialManager.getInstance().isTutorial())
                {
                    _loc_4 = UserDataManager.getInstance().userData;
                    if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END))
                    {
                        TutorialManager.getInstance().addBasicTutorialEnd(TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END);
                        _loc_4.statusType = CommonConstant.USER_STATE_TUTORIAL_QUEST_SELECT;
                        _loc_5 = _loc_4.aFormationPlayerUniqueId;
                        _loc_6 = _loc_4.aPlayerPersonal;
                        for each (_loc_2 in _loc_5)
                        {
                            
                            for each (_loc_3 in _loc_6)
                            {
                                
                                if (_loc_3.uniqueId == _loc_2)
                                {
                                    _loc_3.recoveryHp();
                                    break;
                                }
                            }
                        }
                        _loc_4.setOwnPlayer(_loc_6);
                    }
                    else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_2, TutorialManager.BASIC_TUTORIAL_FLAG_MAIN_QUEST_END))
                    {
                        if (!this._bRetreat)
                        {
                            TutorialManager.getInstance().addBasicTutorialEnd(TutorialManager.BASIC_TUTORIAL_FLAG_MAIN_QUEST_END);
                            if (_loc_4.cycle <= 1)
                            {
                                _loc_4.statusType = CommonConstant.USER_STATE_TUTORIAL_3;
                            }
                            else
                            {
                                _loc_4.statusType = CommonConstant.USER_STATE_PLAY;
                            }
                            for each (_loc_2 in _loc_4.aFormationPlayerUniqueId)
                            {
                                
                                _loc_3 = _loc_4.getPlayerPersonal(_loc_2);
                                if (_loc_3 == null || _loc_3.isEmperor())
                                {
                                    continue;
                                }
                                _loc_4.removePlayerPersonal(_loc_2);
                            }
                            _loc_7 = [];
                            for each (_loc_8 in TutorialManager.getInstance().aAfterTutorialFrontMemberUniqueId)
                            {
                                
                                _loc_7.push(_loc_8);
                            }
                            _loc_4.setFormationPlayer(_loc_7);
                            _loc_4.formationId = TutorialManager.getInstance().afterTutorialFormationId;
                            _loc_4.updateFormationBonus();
                            if (_loc_4.statusType == CommonConstant.USER_STATE_PLAY)
                            {
                                Main.GetProcess().SetProcessId(ProcessMain.PROCESS_HOME);
                                return;
                            }
                        }
                        else
                        {
                            TutorialManager.getInstance().clearBasicTutorial2End();
                        }
                    }
                    Main.GetProcess().SetProcessId(ProcessMain.PROCESS_LOGIN_AFTER);
                }
                else if (UserDataManager.getInstance().checkSpecialEvent())
                {
                    Main.GetProcess().SetProcessId(ProcessMain.PROCESS_SPECIAL_EVENT);
                }
                else
                {
                    Main.GetProcess().SetProcessId(ProcessMain.PROCESS_HOME);
                }
                return;
            }
            return;
        }// end function

        private function cbReceive(param1:NetResult) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            if (param1.resultCode == NetId.RESULT_ERROR_QUEST_START_INVALID_DAILY_QUEST)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.QUEST_DAILYQUEST_ERROR), this.cbResultCodeError);
                return;
            }
            var _loc_2:* = QuestManager.getInstance().questData;
            var _loc_3:* = UserDataManager.getInstance().userData.aFormationPlayerUniqueId[FormationSetData.FORMATION_INDEX_COMMANDER];
            QuestManager.getInstance().setCommanderUniqueId(_loc_3 == 0 ? (Constant.EMPTY_ID) : (_loc_3));
            if (TutorialManager.getInstance().isTutorial())
            {
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_TUTORIAL_QUEST_END))
                {
                    QuestManager.getInstance().setTutorialQuest(false);
                }
                else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_QUEST_SELECT, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_SELECT_END))
                {
                    TutorialManager.getInstance().addBasicTutorialEnd(TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_SELECT_END);
                    UserDataManager.getInstance().userData.statusType = CommonConstant.USER_STATE_TUTORIAL_2;
                }
            }
            var _loc_4:* = PlayerManager.getInstance().getPlayerInformation(UserDataManager.getInstance().userData.emperorId);
            this._emperorBgm = PlayerManager.getInstance().characterBgm(_loc_4.characterId);
            var _loc_5:* = this._emperorBgm != null && this._emperorBgm.wayBgmId > 0 ? (this._emperorBgm.wayBgmId) : (_loc_2.questBgmId);
            SoundManager.getInstance().loadSound(_loc_5);
            for each (_loc_7 in QuestTab.getResourcePathArray())
            {
                
                ResourceManager.getInstance().loadResource(_loc_7);
            }
            ResourceManager.getInstance().loadResource(ResourcePath.QUEST_PATH + QuestMap.getResourceName());
            for each (_loc_6 in QuestMap.getSoundIdArray())
            {
                
                SoundManager.getInstance().loadSound(_loc_6);
            }
            ResourceManager.getInstance().loadResource(ResourcePath.BATTLE_PATH + "UI_BattleMain.swf");
            for each (_loc_7 in QuestPiece.getResourcePathList())
            {
                
                ResourceManager.getInstance().loadResource(_loc_7);
            }
            for each (_loc_8 in _loc_2.aSquare)
            {
                
                if (_loc_8.itemType > 0 && _loc_8.itemCount > 0)
                {
                    ResourceManager.getInstance().loadResource(ItemManager.getInstance().getItemPng(_loc_8.itemType, _loc_8.itemId));
                }
            }
            ResourceManager.getInstance().loadResource(QuestPieceEnemy.getResource());
            SoundManager.getInstance().loadSound(QuestPiece.getSoundId());
            ResourceManager.getInstance().loadResource(ResourcePath.QUEST_MAP_PATH + _loc_2.fileName);
            ResourceManager.getInstance().loadResource(PlayerDisplay.getAnimResource());
            this._aObjectType = [];
            for each (_loc_9 in param1.data.aQuestObject)
            {
                
                _loc_13 = parseInt(_loc_9);
                _loc_14 = QuestManager.getInstance().displayObjecResource(_loc_13);
                for each (_loc_7 in _loc_14)
                {
                    
                    ResourceManager.getInstance().loadResource(_loc_7);
                }
                this._aObjectType.push(_loc_13);
            }
            ScriptManager.getInstance().loadResource();
            _loc_10 = UserDataManager.getInstance().userData.emperorId;
            _loc_11 = PlayerManager.getInstance().getPlayerInformation(_loc_10);
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_BUSTUP_PATH + _loc_11.bustUpFileName);
            for each (_loc_12 in QuestManager.getInstance().questData.aPlayer)
            {
                
                _loc_15 = PlayerManager.getInstance().getPlayerInformation(_loc_12.playerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_15.swf);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_BUSTUP_PATH + _loc_15.bustUpFileName);
            }
            SoundManager.getInstance().loadSound(QuestTextPopup.getSoundId());
            SoundManager.getInstance().loadSoundArray([SoundId.SE_WINDOW_OPEN, SoundId.SE_BALLOON, SoundId.SE_CHEER1016, SoundId.SE_POINT, SoundId.SE_CHARA_FOOTSTEP, SoundId.SE_CANNON, SoundId.SE_JUMP2, SoundId.SE_RS3_SYSTEM_ENCOUNTER, SoundId.SE_REV_RESULT_KEKKA, SoundId.SE_REV_RESULT_REWARD, SoundId.SE_REV_RESULT_SRANK]);
            ScriptManager.getInstance().defaultResourceLoad();
            if (_loc_2.scriptFileName != "")
            {
                ScriptManager.getInstance().loadScript(ScriptManager.SCRIPT_PATH + "Quest/" + _loc_2.scriptFileName, ScriptScreen.SCREEN_QUEST, true);
            }
            CommonPopup.getInstance().loadResource();
            if (TutorialManager.getInstance().isTutorial())
            {
                TutorialManager.getInstance().loadResource();
            }
            this._paymentScriptFileName = param1.data.paymentEventScriptFileName;
            QuestManager.getInstance().paymentEventCrown = parseInt(param1.data.paymentEventCrown);
            this._bPaymentEvent = this._paymentScriptFileName && this._paymentScriptFileName != "";
            if (this._bPaymentEvent)
            {
                ScriptManager.getInstance().loadScript(ScriptManager.SCRIPT_PATH + "PaymentEvent/" + "script_" + this._paymentScriptFileName + ".xml", ScriptScreen.SCREEN_QUEST_PAYMENT_EVENT, true);
            }
            this._bConnectionGet = true;
            return;
        }// end function

        private function cbResultReceive(param1:NetResult) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = UserDataManager.getInstance().userData.statusType;
            var _loc_3:* = UserDataManager.getInstance().userData.cycle;
            if (_loc_3 == 1 && _loc_2 == CommonConstant.USER_STATE_EMPEROR_SELECT || _loc_2 == CommonConstant.USER_STATE_CYCLE_RESET)
            {
                _loc_4 = Constant.EMPTY_ID;
                if (_loc_2 == CommonConstant.USER_STATE_CYCLE_RESET)
                {
                    if (_loc_3 == 1)
                    {
                        _loc_4 = ExternalLinkageJSConstant.REMARKETING_TAG_END_CHAPTER4;
                    }
                    else if (_loc_3 == 2)
                    {
                        _loc_4 = ExternalLinkageJSConstant.REMARKETING_TAG_END2_CHAPTER4;
                    }
                }
                else
                {
                    _loc_5 = UserDataManager.getInstance().userData.chapter;
                    if (_loc_5 >= 3)
                    {
                        _loc_4 = ExternalLinkageJSConstant.REMARKETING_TAG_END_CHAPTER3;
                    }
                    else if (_loc_5 >= 2)
                    {
                        _loc_4 = ExternalLinkageJSConstant.REMARKETING_TAG_END_CHAPTER2;
                    }
                    else if (_loc_5 >= 1)
                    {
                        _loc_4 = ExternalLinkageJSConstant.REMARKETING_TAG_END_CHAPTER1;
                    }
                }
                if (_loc_4 != Constant.EMPTY_ID)
                {
                    ExternalLinkageJS.callJSRemarketingTag(_loc_4);
                }
            }
            this.setPhase(this._PHASE_RESULT_RESOURCE);
            return;
        }// end function

        private function cbResultCodeError() : void
        {
            Main.GetProcess().SetProcessId(ProcessMain.PROCESS_HOME);
            return;
        }// end function

        private function cbResume(param1:int) : void
        {
            if (this._phase == this._PHASE_PAUSE)
            {
                this.setPhase(this._PHASE_RESUME);
            }
            return;
        }// end function

        private function cbEscape(param1:int) : void
        {
            if (this._phase == this._PHASE_PAUSE)
            {
                this.setPhase(this._PHASE_CHECK_RETREAT);
            }
            return;
        }// end function

        private function cbReturnDivide(param1:int) : void
        {
            if (this._phase == this._PHASE_MAP_SCROLL)
            {
                this._scrollBar.scrollReset();
                this._isoDivideReturnBtn.setOut();
                this._btnDivideReturn.setMouseOut();
                ButtonManager.getInstance().removeArray(this._btnDivideReturn);
                this._questDivide.setOpen();
            }
            return;
        }// end function

        private function cbClickMouse(event:MouseEvent) : void
        {
            this.setPhase(this._PHASE_MAP_FADE_OUT);
            return;
        }// end function

        private function cbDownPause(event:MouseEvent) : void
        {
            if (this._phase == this._PHASE_PIECE_MOVE)
            {
                this.setPhase(this._PHASE_PAUSE);
            }
            return;
        }// end function

        private function cbWheelPause(event:MouseEvent) : void
        {
            if (this._phase == this._PHASE_PIECE_MOVE)
            {
                this.setPhase(this._PHASE_PAUSE);
            }
            return;
        }// end function

    }
}
