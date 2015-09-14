package quest
{
    import button.*;
    import enemy.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import message.*;
    import player.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import status.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class QuestDivide extends Object
    {
        private const _WINDOW_BUTTON_BASE:int = 0;
        private const _WINDOW_BUTTON_A:int = 1;
        private const _WINDOW_BUTTON_B:int = 2;
        private var _aRoute:Array;
        private var _phase:int;
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _simpleStatus:PlayerSimpleStatus;
        private var _aButton:Array;
        private var _btnDivide:ButtonBase;
        private var _btnScroll:ButtonBase;
        private var _btnAllLeft:ButtonBase;
        private var _btnAllRight:ButtonBase;
        private var _statusShown:Boolean = false;
        private var _selectButton:int;
        private var _aPlayer:Array;
        private var _selectNullMc:MovieClip;
        private var _aChrNull:Array;
        private var _aStatusNull:Array;
        private var _maxHitWidth:Number;
        private var _aWindow:Array;
        private var _aWindowBtn:Array;
        private var _aWindowParam:Array;
        private var _aWindowImg:Array;
        private var _selectPlayer:QuestDividePlayerDisplay;
        private var _nextPlayer:QuestDividePlayerDisplay;
        private var _movePlayer:QuestDividePlayerDisplay;
        private var _moveSubListPlayer:QuestDividePlayerDisplay;
        private var _aEnemySymbol:Array;
        private var _unit:QuestUnit;
        private var _aPlayerPersonal:Array;
        private var _aPlayerIndex:Array;
        private var _autoSelectTeamNo:int;
        private var _selectTeamNo:int;
        private var _aSwitchTeamNo:Array;
        private var _aSwitchSquareId:Array;
        private var _bInit:Boolean;
        private var _bTutorialExplained:Boolean;
        private var _bDivWarning:Boolean;
        private var _parent:DisplayObjectContainer;
        private static const _ROUTE_NOTHING:int = 0;
        private static const _ROUTE_BASE_POINT:int = 1;
        private static const _ROUTE_DIVIDE:int = 2;
        private static const _ROUTE_BATTLE:int = 3;
        private static const _ROUTE_BOSS_BATTLE:int = 4;
        private static const _ROUTE_JOIN:int = 5;
        public static const BUTTON_RETURN_MAP:int = 1;
        public static const BUTTON_DIVIDE:int = 2;
        public static const BUTTON_SCROLL:int = 3;
        private static const _PHASE_MAIN:int = 0;
        private static const _PHASE_SELECT:int = 1;
        private static const _PHASE_PLAYER_MOVE:int = 2;
        private static const _PHASE_NEXT_PLAYER:int = 3;
        private static const _PHASE_READING:int = 10;
        private static const _PHASE_CLOSE:int = 99;

        public function QuestDivide(param1:DisplayObjectContainer)
        {
            this._aRoute = [["", ""], [MessageManager.getInstance().getMessage(MessageId.QUEST_ROUTE_DIVIDEICON_CITY), "DivideIcon_City.png"], [MessageManager.getInstance().getMessage(MessageId.QUEST_ROUTE_DIVIDEICON_TURNINGPOINT), "DivideIcon_TurningPoint.png"], [MessageManager.getInstance().getMessage(MessageId.QUEST_ROUTE_DIVIDEICON_FLAMETYRANT), "DivideIcon_MonsterBG.png"], [MessageManager.getInstance().getMessage(MessageId.QUEST_ROUTE_DIVIDEICON_BOSSFLAMETYRANT), "DivideIcon_MonsterBG.png"], [MessageManager.getInstance().getMessage(MessageId.QUEST_ROUTE_DIVIDEICON_JOIN), "DivideIcon_ConfluencePoint.png"]];
            this._bInit = false;
            this._parent = param1;
            this._bTutorialExplained = false;
            this._aPlayer = new Array();
            this._aButton = new Array();
            this._aWindow = new Array();
            this._aWindowBtn = new Array();
            this._aPlayerPersonal = new Array();
            this._aEnemySymbol = new Array();
            this._aPlayerIndex = [[], []];
            this._autoSelectTeamNo = Constant.UNDECIDED;
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + QuestMap.getResourceName(), "EventPop_DivideMc");
            param1.addChild(this._mc);
            this._isoMain = new InStayOut(this._mc);
            TextControl.setIdText(this._mc.textMc.textDt, MessageId.QUEST_DIVIDE_TITLE);
            var _loc_2:* = CommanderSkillUtility.isUnlockCommander();
            if (_loc_2)
            {
                this._mc.teamBaseMc.gotoAndStop("commander");
                this._mc.DivideTeamBaseMc1.gotoAndStop("commander");
                this._mc.DivideTeamBaseMc2.gotoAndStop("commander");
            }
            else
            {
                this._mc.teamBaseMc.gotoAndStop("normal");
                this._mc.DivideTeamBaseMc1.gotoAndStop("normal");
                this._mc.DivideTeamBaseMc2.gotoAndStop("normal");
            }
            this._selectNullMc = this._mc.teamBaseMc.charaNullSelect;
            this._aChrNull = [[this._mc.teamBaseMc.charaNull1, this._mc.teamBaseMc.charaNull2, this._mc.teamBaseMc.charaNull3, this._mc.teamBaseMc.charaNull4, this._mc.teamBaseMc.charaNull5], [this._mc.DivideTeamBaseMc1.charaNull1, this._mc.DivideTeamBaseMc1.charaNull2, this._mc.DivideTeamBaseMc1.charaNull3, this._mc.DivideTeamBaseMc1.charaNull4, this._mc.DivideTeamBaseMc1.charaNull5], [this._mc.DivideTeamBaseMc2.charaNull1, this._mc.DivideTeamBaseMc2.charaNull2, this._mc.DivideTeamBaseMc2.charaNull3, this._mc.DivideTeamBaseMc2.charaNull4, this._mc.DivideTeamBaseMc2.charaNull5]];
            this._aStatusNull = [[this._mc.teamBaseMc.StatusNull1, this._mc.teamBaseMc.StatusNull2, this._mc.teamBaseMc.StatusNull3, this._mc.teamBaseMc.StatusNull4, this._mc.teamBaseMc.StatusNull5], [this._mc.DivideTeamBaseMc1.StatusNull1, this._mc.DivideTeamBaseMc1.StatusNull2, this._mc.DivideTeamBaseMc1.StatusNull3, this._mc.DivideTeamBaseMc1.StatusNull4, this._mc.DivideTeamBaseMc1.StatusNull5], [this._mc.DivideTeamBaseMc2.StatusNull1, this._mc.DivideTeamBaseMc2.StatusNull2, this._mc.DivideTeamBaseMc2.StatusNull3, this._mc.DivideTeamBaseMc2.StatusNull4, this._mc.DivideTeamBaseMc2.StatusNull5]];
            if (_loc_2)
            {
                this._aChrNull[0].push(this._mc.teamBaseMc.charaNull6);
                this._aChrNull[1].push(this._mc.DivideTeamBaseMc1.charaNull6);
                this._aChrNull[2].push(this._mc.DivideTeamBaseMc2.charaNull6);
                this._aStatusNull[0].push(this._mc.teamBaseMc.StatusNull6);
                this._aStatusNull[1].push(this._mc.DivideTeamBaseMc1.StatusNull6);
                this._aStatusNull[2].push(this._mc.DivideTeamBaseMc2.StatusNull6);
            }
            this._maxHitWidth = this._mc.DivideTeamBaseMc2.charaNull2.x - this._mc.DivideTeamBaseMc2.charaNull1.x + 2;
            this._aWindow = [this._mc.DivideTeamBaseMc1, this._mc.DivideTeamBaseMc2];
            var _loc_3:* = new ButtonBase(this._mc.DivideTeamBaseMc1.teameBaseBtnMc, this.cbWindowBtn);
            _loc_3.enterSeId = Constant.UNDECIDED;
            _loc_3.setId(this._WINDOW_BUTTON_A);
            this._aWindowBtn.push(_loc_3);
            _loc_3 = new ButtonBase(this._mc.DivideTeamBaseMc2.teameBaseBtnMc, this.cbWindowBtn);
            _loc_3.enterSeId = Constant.UNDECIDED;
            _loc_3.setId(this._WINDOW_BUTTON_B);
            this._aWindowBtn.push(_loc_3);
            InputManager.getInstance().addMouseCallback(this, null, this.cbInputClick);
            var _loc_4:* = UserDataManager.getInstance().userData.chapter;
            if (!TutorialManager.getInstance().isTutorial() && (_loc_4 == 1 || _loc_4 == 2) && !Main.GetApplicationData().userConfigData.bCheckedQuestDivide)
            {
                this._bDivWarning = true;
            }
            else
            {
                this._bDivWarning = false;
            }
            this._selectButton = Constant.UNDECIDED;
            return;
        }// end function

        public function get selectButton() : int
        {
            return this._selectButton;
        }// end function

        public function setSelectButton() : void
        {
            this._selectButton = Constant.UNDECIDED;
            return;
        }// end function

        public function get bOpened() : Boolean
        {
            return this._isoMain.bOpened;
        }// end function

        public function get bClosed() : Boolean
        {
            return this._isoMain.bClosed && this._bInit;
        }// end function

        public function get aPlayer() : Array
        {
            return this._aPlayer;
        }// end function

        public function get aSwitchTeamNo() : Array
        {
            return this._aSwitchTeamNo;
        }// end function

        public function get aSwitchSquareId() : Array
        {
            return this._aSwitchSquareId;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            for each (_loc_1 in this._aWindowImg)
            {
                
                if (_loc_1.parent)
                {
                    _loc_1.parent.removeChild(_loc_1);
                }
                _loc_1.bitmapData.dispose();
            }
            this._aWindowImg = null;
            if (this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            InputManager.getInstance().delMouseCallback(this);
            for each (_loc_2 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_2);
            }
            this._aButton = null;
            this._btnDivide = null;
            this._btnScroll = null;
            this._btnAllLeft = null;
            this._btnAllRight = null;
            for each (_loc_3 in this._aPlayer)
            {
                
                _loc_3.release();
            }
            this._aPlayer = null;
            for each (_loc_4 in this._aEnemySymbol)
            {
                
                _loc_4.release();
            }
            this._aEnemySymbol = null;
            if (this._simpleStatus)
            {
                this._simpleStatus.release();
            }
            this._simpleStatus = null;
            for each (_loc_5 in this._aWindowBtn)
            {
                
                _loc_2.release();
            }
            this._aWindow = null;
            this._isoMain.release();
            this._isoMain = null;
            for each (_loc_6 in this._aChrNull)
            {
                
                for each (_loc_7 in _loc_6)
                {
                    
                    if (_loc_7.parent)
                    {
                        _loc_7.parent.removeChild(_loc_7);
                    }
                }
            }
            this._unit = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            switch(this._phase)
            {
                case _PHASE_NEXT_PLAYER:
                {
                    this.controlNextPlayer();
                    break;
                }
                case _PHASE_SELECT:
                {
                    this.controlWindowSelect(param1);
                    break;
                }
                case _PHASE_PLAYER_MOVE:
                {
                    this.controlCharacterMove();
                    break;
                }
                case _PHASE_READING:
                {
                    if (ResourceManager.getInstance().isLoaded())
                    {
                        this.init();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            for each (_loc_2 in this._aPlayer)
            {
                
                _loc_2.mc.alpha = this._mc.teamBaseMc.alpha;
                _loc_2.control(param1);
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case _PHASE_NEXT_PLAYER:
                    {
                        this.phaseNextPlayer();
                        break;
                    }
                    case _PHASE_SELECT:
                    {
                        this.phaseWindowSelect();
                        break;
                    }
                    case _PHASE_PLAYER_MOVE:
                    {
                        this.phaseCharacterMove();
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

        private function phaseNextPlayer() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = false;
            var _loc_2:* = true;
            if (this._btnDivide != null)
            {
                _loc_3 = 0;
                while (_loc_3 < this._aPlayer.length)
                {
                    
                    _loc_4 = this._aPlayer[_loc_3];
                    if (_loc_4.setTeamNo == 0)
                    {
                        _loc_2 = false;
                        if (this._selectPlayer == null)
                        {
                            this._selectPlayer = _loc_4;
                            _loc_1 = true;
                        }
                        else if (this._nextPlayer == null && (this._selectPlayer != null && this._selectPlayer.personal.uniqueId != _loc_4.personal.uniqueId))
                        {
                            this._nextPlayer = _loc_4;
                        }
                        if (this._selectPlayer != null && this._nextPlayer != null)
                        {
                            break;
                        }
                    }
                    _loc_3++;
                }
                this._btnDivide.setDisable(_loc_2 == false);
                if (_loc_2 && TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_DIVIDE_UNIT))
                {
                    TutorialManager.getInstance().setTutorialArrow(this._btnDivide.getMoveClip());
                    TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_DIVIDE_UNIT_006), TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
                }
                else
                {
                    TutorialManager.getInstance().hideTutorialArrow();
                }
            }
            this._selectTeamNo = Constant.UNDECIDED;
            this._movePlayer = null;
            this._moveSubListPlayer = null;
            if (this._selectPlayer != null && _loc_1)
            {
                _loc_5 = this._selectNullMc.localToGlobal(new Point());
                if (this._selectPlayer.pos.x != _loc_5.x || this._selectPlayer.pos.y != _loc_5.y)
                {
                    this._selectPlayer.setTargetPoint(_loc_5, 0.5);
                    this._selectPlayer.setAnimation(PlayerDisplay.LABEL_BACK_WALK);
                }
            }
            else if (_loc_2 == false)
            {
                this.setPhase(_PHASE_SELECT);
            }
            else
            {
                this._btnScroll.setDisable(false);
                this._autoSelectTeamNo = Constant.UNDECIDED;
                this._phase = _PHASE_SELECT;
            }
            return;
        }// end function

        private function controlNextPlayer() : void
        {
            if (this._selectPlayer != null && this._selectPlayer.bMoveing == false)
            {
                this._selectPlayer.setAnimation(PlayerDisplay.LABEL_FRONT_WALK);
                this._selectPlayer.setReverse(false);
                this.setPhase(_PHASE_SELECT);
            }
            return;
        }// end function

        private function phaseWindowSelect() : void
        {
            if (this._autoSelectTeamNo != Constant.UNDECIDED)
            {
                if (this._selectPlayer == null)
                {
                    this.setPhase(_PHASE_NEXT_PLAYER);
                }
                else
                {
                    this._selectTeamNo = this._autoSelectTeamNo;
                }
                return;
            }
            this._btnScroll.setDisable(false);
            if (this._selectPlayer == null)
            {
                this.setPhase(_PHASE_NEXT_PLAYER);
                return;
            }
            this.addWindowButton();
            this._btnAllLeft.setDisable(false);
            this._btnAllRight.setDisable(false);
            if (TutorialManager.getInstance().isTutorial())
            {
                if (this._bTutorialExplained == false)
                {
                    if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_DIVIDE_UNIT))
                    {
                        TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_DIVIDE_UNIT, this.tutorialDivideUnit);
                    }
                    else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_2, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_ROUTE_CHECK_BEFORE))
                    {
                        TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_2, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_ROUTE_CHECK_BEFORE, function () : void
            {
                var _loc_1:* = [];
                _loc_1.push(_btnScroll);
                ButtonManager.getInstance().seal(_loc_1, true);
                TutorialManager.getInstance().setTutorialArrow(_btnScroll.getMoveClip(), TutorialManager.TUTORIAL_ARROW_DIRECTION_UP, TutorialManager.TUTORIAL_ARROW_POS_CENTER);
                return;
            }// end function
            );
                    }
                    this._bTutorialExplained = true;
                }
                else
                {
                    if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_2, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_ROUTE_CHECK_BEFORE))
                    {
                        TutorialManager.getInstance().addBasicTutorialEnd(TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_ROUTE_CHECK_BEFORE);
                        ButtonManager.getInstance().unseal();
                    }
                    if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_2, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_ROUTE_CHECK_AFTER))
                    {
                        TutorialManager.getInstance().basicTutorialPopup(CommonConstant.USER_STATE_TUTORIAL_2, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_ROUTE_CHECK_AFTER);
                    }
                }
                if (!CommonPopup.isUse() && TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_DIVIDE_UNIT))
                {
                    this.tutorialDivideUnit();
                }
            }
            else if (this._bDivWarning)
            {
                this._bDivWarning = false;
                CommonPopup.getInstance().openCheckBoxPopup(CommonPopup.POPUP_TYPE_NAVI, MessageManager.getInstance().getMessage(MessageId.QUEST_MESSAGE_JUNCTION), false, MessageManager.getInstance().getMessage(MessageId.QUEST_MESSAGE_JUNCTION_CHECKBOX), function (param1:Boolean) : void
            {
                if (param1)
                {
                    Main.GetApplicationData().userConfigData.bCheckedQuestDivide = true;
                    Main.GetApplicationData().userConfigData.save();
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function controlWindowSelect(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_6:* = null;
            if (CommonPopup.isUse())
            {
                return;
            }
            if (this._selectTeamNo != Constant.UNDECIDED)
            {
                this._movePlayer = this._selectPlayer;
                if (this._nextPlayer != null)
                {
                    this._moveSubListPlayer = this._nextPlayer;
                }
                this.setPhase(_PHASE_PLAYER_MOVE);
            }
            var _loc_4:* = false;
            var _loc_5:* = this._aPlayer.length - 1;
            while (_loc_5 >= 0)
            {
                
                _loc_6 = this._aPlayer[_loc_5];
                _loc_6.control(param1);
                if (InputManager.getInstance().isHitTest(_loc_6.hitTarget.target) && _loc_4 == false)
                {
                    if (this._selectPlayer != null)
                    {
                        this._selectPlayer.setSelect(false);
                    }
                    _loc_4 = true;
                    this.setStatusPos(_loc_6);
                    this._simpleStatus.setStatus(_loc_6.personal);
                    this._simpleStatus.show();
                    _loc_6.setSelect(true);
                }
                else
                {
                    _loc_6.setSelect(false);
                }
                _loc_5 = _loc_5 - 1;
            }
            if (_loc_4 == false)
            {
                if (this._selectPlayer != null && this._selectPlayer.bMoveing == false)
                {
                    this._selectPlayer.setSelect(true);
                    this.setStatusPos(this._selectPlayer);
                    this._simpleStatus.setStatus(this._selectPlayer.personal);
                    if (InputManager.getInstance().isHitTest(this._selectPlayer.hitTarget.target))
                    {
                        this._simpleStatus.show();
                    }
                    else
                    {
                        this._simpleStatus.hide();
                    }
                }
                else
                {
                    this._simpleStatus.hide();
                }
            }
            return;
        }// end function

        private function setStatusPos(param1:QuestDividePlayerDisplay) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._selectPlayer && this._selectPlayer.personal.uniqueId == param1.personal.uniqueId)
            {
                _loc_2 = new Point(this._selectPlayer.pos.x, this._selectPlayer.pos.y - this._simpleStatus.statusMc_height);
            }
            else
            {
                _loc_4 = this._aStatusNull[this.getSwitchTeamIndex(param1.setTeamNo)][param1.index];
                _loc_5 = new Point(_loc_4.x, _loc_4.y);
                _loc_5 = _loc_4.parent.localToGlobal(_loc_5);
                _loc_5 = this._mc.globalToLocal(_loc_5);
                _loc_2 = new Point(_loc_5.x, _loc_5.y);
            }
            this._simpleStatus.setPosition(_loc_2);
            if (_loc_2.y < param1.pos.y)
            {
                _loc_3 = param1.faceNull.localToGlobal(new Point());
            }
            else
            {
                _loc_3 = param1.effectNull.localToGlobal(new Point());
            }
            this._simpleStatus.setArrowTargetPosition(_loc_3);
            return;
        }// end function

        private function phaseCharacterMove() : void
        {
            var _loc_1:* = null;
            this._btnDivide.setDisable(true);
            this._btnScroll.setDisable(true);
            this._btnAllLeft.setDisable(true);
            this._btnAllRight.setDisable(true);
            if (this._simpleStatus.isShow == true)
            {
                this._simpleStatus.hide();
            }
            this._movePlayer.setTeamNo = this._selectTeamNo;
            if (this._autoSelectTeamNo != Constant.UNDECIDED)
            {
                for each (_loc_1 in this._aPlayer)
                {
                    
                    if (_loc_1.setTeamNo == 0)
                    {
                        _loc_1.setTeamNo = this._selectTeamNo;
                    }
                }
            }
            if (this._selectPlayer)
            {
                this._selectPlayer.setSelect(false);
            }
            if (this._movePlayer)
            {
                this._movePlayer.setSelect(false);
            }
            this.switchPlayerTable(this._aPlayer);
            this._movePlayer.bChange = true;
            if (this._autoSelectTeamNo != Constant.UNDECIDED)
            {
                this.setupMoveJumpAll();
            }
            else
            {
                this.setupMoveJump();
            }
            return;
        }// end function

        private function setupMoveJump() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = null;
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_4 in this._aPlayer)
            {
                
                if (_loc_4.bChange)
                {
                    _loc_1 = this._aChrNull[this.getSwitchTeamIndex(_loc_4.setTeamNo)][_loc_4.index];
                    _loc_2 = _loc_4.layer.parent.localToGlobal(_loc_4.pos);
                    _loc_2 = _loc_1.globalToLocal(_loc_2);
                    _loc_3 = _loc_1.localToGlobal(new Point());
                    _loc_5 = _loc_2.x < 0;
                    _loc_4.setReverse(_loc_5);
                    if (_loc_4.personal.uniqueId == this._movePlayer.personal.uniqueId)
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_JUMP2);
                        _loc_4.setTargetJump(_loc_3);
                        _loc_4.setMiniStatusVisible(false);
                        continue;
                    }
                    _loc_4.setAnimation(PlayerDisplay.LABEL_SIDE_WALK);
                    _loc_4.setTargetPoint(_loc_3, 0.5);
                }
            }
            if (this._moveSubListPlayer != null)
            {
                _loc_6 = this._selectNullMc.localToGlobal(new Point());
                if (this._moveSubListPlayer.pos.x != _loc_6.x || this._moveSubListPlayer.pos.y != _loc_6.y)
                {
                    this._moveSubListPlayer.setTargetPoint(_loc_6, 0.5);
                    this._moveSubListPlayer.setAnimation(PlayerDisplay.LABEL_BACK_WALK);
                }
            }
            return;
        }// end function

        private function setupMoveJumpAll() : void
        {
            var _loc_5:* = null;
            var _loc_6:* = false;
            var _loc_7:* = false;
            var _loc_8:* = false;
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = false;
            for each (_loc_5 in this._aPlayer)
            {
                
                _loc_1 = this._aChrNull[this.getSwitchTeamIndex(_loc_5.setTeamNo)][_loc_5.index];
                _loc_2 = _loc_5.layer.parent.localToGlobal(_loc_5.pos);
                _loc_3 = _loc_1.localToGlobal(new Point());
                _loc_6 = Math.floor(_loc_2.x) != Math.floor(_loc_3.x);
                _loc_7 = Math.floor(_loc_2.y) != Math.floor(_loc_3.y);
                _loc_2 = _loc_1.globalToLocal(_loc_2);
                _loc_8 = _loc_2.x < 0;
                _loc_5.setReverse(_loc_8);
                if (_loc_7)
                {
                    _loc_4 = true;
                    _loc_5.setTargetJump(_loc_3);
                    _loc_5.setMiniStatusVisible(false);
                    continue;
                }
                if (_loc_6)
                {
                    _loc_5.setAnimation(PlayerDisplay.LABEL_SIDE_WALK);
                    _loc_5.setTargetPoint(_loc_3, 0.5);
                }
            }
            if (_loc_4)
            {
                SoundManager.getInstance().playSe(SoundId.SE_JUMP2);
            }
            return;
        }// end function

        private function controlCharacterMove() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = false;
            for each (_loc_2 in this._aPlayer)
            {
                
                if (_loc_2.bMoveing)
                {
                    _loc_1 = true;
                    continue;
                }
                _loc_2.setReverse(false);
                _loc_2.setAnimation(PlayerDisplay.LABEL_FRONT_WALK);
                _loc_2.setMiniStatusVisible(true);
            }
            if (_loc_1 == false)
            {
                if (this._selectPlayer != null && this._movePlayer != null && this._selectPlayer.personal.uniqueId == this._movePlayer.personal.uniqueId)
                {
                    this._selectPlayer = null;
                }
                if (this._nextPlayer != null)
                {
                    this._nextPlayer = null;
                }
                this.setPhase(_PHASE_NEXT_PLAYER);
            }
            return;
        }// end function

        private function advanceRoute(param1:QuestSquare) : Object
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = false;
            var _loc_10:* = null;
            var _loc_2:* = param1;
            var _loc_3:* = QuestManager.getInstance().questData.aSquare.length;
            var _loc_4:* = new Object();
            new Object().routeType = _ROUTE_NOTHING;
            _loc_4.attribute = QuestConstant.SQUARE_ATTR1_NORMAL;
            _loc_4.aEnemy = new Array();
            _loc_4.aSymbolTarget = new Array();
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_3)
            {
                
                if (_loc_2 == null)
                {
                    break;
                }
                _loc_7 = [];
                for each (_loc_8 in _loc_2.aConnectionId)
                {
                    
                    _loc_10 = QuestManager.getInstance().getSquare(_loc_8);
                    if (_loc_10 != null)
                    {
                        _loc_7.push(_loc_8);
                    }
                }
                _loc_9 = false;
                switch(_loc_2.attribute1)
                {
                    case QuestConstant.SQUARE_ATTR1_JOIN:
                    {
                        _loc_4.routeType = _ROUTE_JOIN;
                        _loc_4.attribute = QuestConstant.SQUARE_ATTR1_JOIN;
                        _loc_9 = true;
                        break;
                    }
                    case QuestConstant.SQUARE_ATTR1_BASE:
                    {
                        if (_loc_4.routeType == _ROUTE_NOTHING)
                        {
                            _loc_4.routeType = _ROUTE_BASE_POINT;
                            _loc_4.attribute = QuestConstant.SQUARE_ATTR1_BASE;
                        }
                        break;
                    }
                    case QuestConstant.SQUARE_ATTR1_BATTLE:
                    {
                        if (_loc_2.bBattle && _loc_2.bEncountSymbol)
                        {
                            _loc_4.routeType = _ROUTE_BATTLE;
                            _loc_4.attribute = QuestConstant.SQUARE_ATTR1_BATTLE;
                            _loc_4.aEnemy = (_loc_2.aEnemy[0] as QuestEnemyList).aEnemyPersonal;
                        }
                        break;
                    }
                    case QuestConstant.SQUARE_ATTR1_BOSSBATTLE:
                    {
                        _loc_4.routeType = _ROUTE_BOSS_BATTLE;
                        _loc_4.attribute = QuestConstant.SQUARE_ATTR1_BOSSBATTLE;
                        _loc_4.aEnemy = (_loc_2.aEnemy[0] as QuestEnemyList).aEnemyPersonal;
                        _loc_9 = true;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (_loc_9 == false)
                {
                    if (_loc_2.id == QuestManager.getInstance().paymentEventActiveSqId)
                    {
                        _loc_4.aSymbolTarget.push(new QuestDivideSymbolTarget(QuestDivideSymbolTarget.TARGET_TYPE_HIPOPOTAMUS, _loc_2.id));
                    }
                    if (_loc_2.bBattle && _loc_2.attribute1 != QuestConstant.SQUARE_ATTR1_BOSSBATTLE)
                    {
                        _loc_5++;
                        _loc_4.aSymbolTarget.push(new QuestDivideSymbolTarget(QuestDivideSymbolTarget.TARGET_TYPE_ENEMY, _loc_2.id));
                    }
                    if (_loc_2.isTreasure())
                    {
                        _loc_4.aSymbolTarget.push(new QuestDivideSymbolTarget(QuestDivideSymbolTarget.TARGET_TYPE_TREASURE, _loc_2.id));
                    }
                }
                if (_loc_7.length > 1)
                {
                    _loc_4.routeType = _ROUTE_DIVIDE;
                    break;
                }
                if (_loc_2.attribute1 != QuestConstant.SQUARE_ATTR1_BOSSBATTLE)
                {
                    if (_loc_2.aConnectionId.length == 0)
                    {
                        _loc_9 = true;
                        break;
                    }
                }
                if (_loc_9)
                {
                    break;
                }
                _loc_2 = QuestManager.getInstance().getSquare(_loc_7[0]);
                _loc_6++;
            }
            _loc_4.battleNum = _loc_5;
            return _loc_4;
        }// end function

        private function init() : void
        {
            var _loc_2:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = false;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            if (this._bInit)
            {
                return;
            }
            this._bInit = true;
            var _loc_1:* = QuestManager.getInstance().getSquare(this._unit.squareId);
            var _loc_3:* = QuestManager.getInstance().getTeamNum();
            this._aSwitchTeamNo = [0, this._unit.teamNo];
            _loc_2 = 0;
            while (_loc_2 < (_loc_3 + 1))
            {
                
                _loc_5 = QuestManager.getInstance().getUnit((_loc_2 + 1));
                if (_loc_5 == null || _loc_5 != null && _loc_5.aPlayer.length == 0)
                {
                    this._aSwitchTeamNo.push((_loc_2 + 1));
                    break;
                }
                _loc_2++;
            }
            this._aSwitchTeamNo.sort(Array.NUMERIC);
            this._aWindowImg = [];
            _loc_2 = 0;
            while (_loc_2 < _loc_1.aConnectionId.length)
            {
                
                _loc_6 = this._aWindow[_loc_2];
                _loc_7 = this._aWindowParam[_loc_2];
                _loc_8 = null;
                _loc_9 = _loc_2 + 1;
                if (this._aSwitchTeamNo[_loc_9] == QuestConstant.TEAM_NO1)
                {
                    TextControl.setIdText(_loc_6.textMc.textDT, MessageId.QUEST_TAB_TEAM1);
                }
                if (this._aSwitchTeamNo[_loc_9] == QuestConstant.TEAM_NO2)
                {
                    TextControl.setIdText(_loc_6.textMc.textDT, MessageId.QUEST_TAB_TEAM2);
                }
                if (this._aSwitchTeamNo[_loc_9] == QuestConstant.TEAM_NO3)
                {
                    TextControl.setIdText(_loc_6.textMc.textDT, MessageId.QUEST_TAB_TEAM3);
                }
                _loc_10 = this._aRoute[_loc_7.routeType];
                if (_loc_7.routeType != _ROUTE_NOTHING)
                {
                    if (_loc_10[1] != "")
                    {
                        _loc_8 = ResourceManager.getInstance().createBitmap(ResourcePath.QUEST_MAP_PARTS_PATH + _loc_10[1]);
                        ResourceManager.getInstance().createBitmap(ResourcePath.QUEST_MAP_PARTS_PATH + _loc_10[1]).x = _loc_8.width / 2 * -1;
                        _loc_8.y = -_loc_8.height;
                        _loc_6.objectNull.addChild(_loc_8);
                        this._aWindowImg.push(_loc_8);
                    }
                }
                if (_loc_7.routeType == _ROUTE_BATTLE || _loc_7.routeType == _ROUTE_BOSS_BATTLE)
                {
                    this.createEnemySymbol(_loc_6.objectNull, _loc_7.aEnemy as Array, _loc_7.attribute, _loc_2 == 0);
                }
                TextControl.setText(_loc_6.routePointNameMc.textDt, _loc_10[0]);
                _loc_11 = _loc_7.battleNum;
                if (_loc_11 > 0)
                {
                    TextControl.setText(_loc_6.BattleNumMc.textDt, _loc_11.toString());
                    _loc_6.BattleNumMc.visible = true;
                }
                else
                {
                    _loc_6.BattleNumMc.visible = false;
                }
                this.createBattleSymbol(_loc_6.MonsterSymbolSet, _loc_7.aSymbolTarget, _loc_2 == 0);
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < this._aPlayerPersonal.length)
            {
                
                _loc_12 = this._aPlayerPersonal[_loc_2];
                if (_loc_12.bDead == false)
                {
                    _loc_13 = _loc_12.uniqueId == QuestManager.getInstance().commanderUniqueId ? (true) : (false);
                    _loc_14 = new QuestDividePlayerDisplay(_loc_12, this._unit.teamNo, _loc_13);
                    _loc_14.setAnimation(PlayerDisplay.LABEL_FRONT_WALK);
                    _loc_14.setHitTarget(this._maxHitWidth);
                    _loc_14.setTeamNo = 0;
                    this._aPlayer.push(_loc_14);
                }
                _loc_2++;
            }
            this.switchPlayerTable(this._aPlayer);
            _loc_2 = 0;
            for each (_loc_4 in this._aPlayer)
            {
                
                _loc_4.setParent(this._mc);
                _loc_15 = this._aChrNull[0][_loc_2];
                _loc_16 = _loc_15.localToGlobal(new Point());
                _loc_4.pos = _loc_16;
                _loc_2++;
            }
            this._simpleStatus = new PlayerSimpleStatus(this._mc, PlayerSimpleStatus.LABEL_MAIN, null, null, false);
            this._simpleStatus.setArrowTargetPosition(new Point(this._simpleStatus.baseMc.x, this._simpleStatus.statusMc_pos.y + this._simpleStatus.statusMc_height + 30));
            this._simpleStatus.hide();
            ButtonManager.getInstance().push();
            this._btnDivide = new ButtonBase(this._mc.divideBtnMc, this.cbSelectButton);
            this._btnDivide.setId(BUTTON_DIVIDE);
            this._btnDivide.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mc.divideBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_DECIDE);
            this._aButton.push(this._btnDivide);
            this._btnScroll = new ButtonBase(this._mc.mapBtnMc, this.cbSelectButton);
            this._btnScroll.setId(BUTTON_SCROLL);
            this._btnScroll.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._btnScroll.setDisable(true);
            TextControl.setIdText(this._mc.mapBtnMc.textMc.textDt, MessageId.QUEST_DIVIDE_SCROLL);
            this._aButton.push(this._btnScroll);
            this._btnAllLeft = new ButtonBase(this._mc.allLeftbtn, this.cbAllButton);
            this._btnAllLeft.setId(1);
            this._btnAllLeft.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._btnAllLeft.setDisable(true);
            TextControl.setIdText(this._mc.allLeftbtn.textMc.textDt, MessageId.QUEST_TURNING_POINT_ALL_LEFT);
            this._aButton.push(this._btnAllLeft);
            this._btnAllRight = new ButtonBase(this._mc.allRightbtn, this.cbAllButton);
            this._btnAllRight.setId(2);
            this._btnAllRight.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._btnAllRight.setDisable(true);
            TextControl.setIdText(this._mc.allRightbtn.textMc.textDt, MessageId.QUEST_TURNING_POINT_ALL_RIGHT);
            this._aButton.push(this._btnAllRight);
            this._selectButton = Constant.UNDECIDED;
            this._isoMain.setIn(this.cbOpen);
            SoundManager.getInstance().playSe(SoundId.SE_WINDOW_OPEN);
            return;
        }// end function

        public function setIn(param1:QuestUnit) : void
        {
            var _loc_4:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            this._unit = param1;
            var _loc_2:* = QuestManager.getInstance().getSquare(this._unit.squareId);
            var _loc_3:* = [];
            if (_loc_2.aConnectionId.length > 1)
            {
                _loc_6 = QuestManager.getInstance().getSquare(_loc_2.aConnectionId[0]);
                _loc_7 = QuestManager.getInstance().getSquare(_loc_2.aConnectionId[1]);
                if (_loc_6.x < _loc_7.x)
                {
                    _loc_3.push(_loc_6.id);
                    _loc_3.push(_loc_7.id);
                }
                else
                {
                    _loc_3.push(_loc_7.id);
                    _loc_3.push(_loc_6.id);
                }
            }
            this._aSwitchSquareId = [];
            this._aWindowParam = [];
            var _loc_5:* = null;
            _loc_4 = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_8 = QuestManager.getInstance().getSquare(_loc_3[_loc_4]);
                _loc_9 = this.advanceRoute(_loc_8);
                if (_loc_5 != null && _loc_5.id != _loc_8.id)
                {
                    if (_loc_5.x > _loc_8.x)
                    {
                        this._aSwitchSquareId.unshift(_loc_8.id);
                    }
                    else
                    {
                        this._aSwitchSquareId.push(_loc_8.id);
                    }
                }
                else
                {
                    _loc_5 = _loc_8;
                    this._aSwitchSquareId.push(_loc_8.id);
                }
                this._aWindowParam.push(_loc_9);
                if (_loc_9.routeType != _ROUTE_NOTHING)
                {
                    _loc_10 = this._aRoute[_loc_9.routeType];
                    ResourceManager.getInstance().loadResource(ResourcePath.QUEST_MAP_PARTS_PATH + _loc_10[1]);
                }
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < this._unit.aPlayer.length)
            {
                
                _loc_11 = this._unit.aPlayer[_loc_4];
                _loc_12 = QuestManager.getInstance().questData.getPlayerPersonal(_loc_11.uniqueId);
                this._aPlayerPersonal.push(_loc_12);
                _loc_4++;
            }
            this.setPhase(_PHASE_READING);
            return;
        }// end function

        private function cbPlayerClick(param1:QuestDividePlayerDisplay) : void
        {
            if (this._movePlayer != null || this._phase != _PHASE_SELECT)
            {
                return;
            }
            this._movePlayer = param1;
            this._nextPlayer = null;
            if (this._movePlayer != null && this._movePlayer.setTeamNo != 0)
            {
                this.removeWindowButton();
                this._simpleStatus.hide();
                this._selectTeamNo = 0;
                this.setPhase(_PHASE_PLAYER_MOVE);
            }
            return;
        }// end function

        private function cbSelectButton(param1:int) : void
        {
            this._phase = _PHASE_CLOSE;
            this._selectButton = param1;
            if (TutorialManager.getInstance().isTutorial())
            {
                if (param1 == BUTTON_DIVIDE && TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_DIVIDE_UNIT))
                {
                    TutorialManager.getInstance().addBasicTutorialEnd(TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_DIVIDE_UNIT);
                }
                TutorialManager.getInstance().hideTutorial();
            }
            return;
        }// end function

        private function cbAllButton(param1:int) : void
        {
            if (this._phase == _PHASE_SELECT && this._selectPlayer != null)
            {
                this.removeWindowButton();
                this._btnAllLeft.setDisable(true);
                this._btnAllRight.setDisable(true);
                this._selectTeamNo = this._aSwitchTeamNo[param1];
                this._autoSelectTeamNo = this._selectTeamNo;
            }
            return;
        }// end function

        public function setOut() : void
        {
            this.removeButton();
            this._isoMain.setOut(this.cbOut);
            return;
        }// end function

        private function cbOut() : void
        {
            ButtonManager.getInstance().pop();
            return;
        }// end function

        public function setOpen() : void
        {
            ButtonManager.getInstance().push();
            this._isoMain.setIn(this.cbOpen);
            TutorialManager.getInstance().hideTutorial();
            return;
        }// end function

        public function cbOpen() : void
        {
            this.addButton();
            if (this._selectPlayer == null)
            {
                this.setPhase(_PHASE_NEXT_PLAYER);
            }
            else
            {
                this.setPhase(_PHASE_SELECT);
            }
            return;
        }// end function

        private function addButton() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                _loc_1.setMouseOut();
                ButtonManager.getInstance().addButtonBase(_loc_1);
            }
            return;
        }// end function

        private function removeButton() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                _loc_1.setMouseOut();
                ButtonManager.getInstance().removeArray(_loc_1);
            }
            return;
        }// end function

        private function addWindowButton() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aWindowBtn)
            {
                
                _loc_1.setDisable(false);
                ButtonManager.getInstance().addButtonBase(_loc_1);
            }
            return;
        }// end function

        private function removeWindowButton() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aWindowBtn)
            {
                
                _loc_1.setMouseOut();
                _loc_1.setDisable(true);
                ButtonManager.getInstance().removeArray(_loc_1);
            }
            return;
        }// end function

        private function switchPlayerTable(param1:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_2:* = [[], [], []];
            var _loc_3:* = 0;
            for each (_loc_4 in param1)
            {
                
                _loc_5 = this.getSwitchTeamIndex(_loc_4.setTeamNo);
                if (_loc_5 != 0)
                {
                    _loc_6 = _loc_2[_loc_5];
                    _loc_4.bChange = _loc_6.length != _loc_4.index;
                    _loc_4.index = _loc_6.length;
                    _loc_6.push(_loc_4);
                }
                else
                {
                    _loc_4.bChange = _loc_3 != _loc_4.index;
                    _loc_4.index = _loc_3;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function getSwitchTeamIndex(param1:int) : int
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._aSwitchTeamNo.length)
            {
                
                if (this._aSwitchTeamNo[_loc_2] == param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        public function switchDisable(param1:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_2:* = this._aWindowBtn[(this._WINDOW_BUTTON_A - 1)];
            var _loc_3:* = this._aWindowBtn[(this._WINDOW_BUTTON_B - 1)];
            _loc_2.setDisable(param1 ? (true) : (false));
            _loc_3.setDisable(param1 ? (false) : (true));
            this._btnAllLeft.setDisable(true);
            this._btnAllRight.setDisable(true);
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_JUNCTION_DIVIDE_UNIT))
            {
                _loc_4 = param1 ? (_loc_3.getMoveClip()) : (_loc_2.getMoveClip());
                TutorialManager.getInstance().setTutorialArrowPos(_loc_4.localToGlobal(new Point(_loc_4.width / 2, -_loc_4.height / 2 + 50)));
                _loc_5 = TutorialManager.getInstance().getTutorialPlayerIdx(this._selectPlayer.personal);
                _loc_6 = "";
                switch(_loc_5)
                {
                    case 0:
                    {
                        _loc_6 = MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_DIVIDE_UNIT_001);
                        break;
                    }
                    case 1:
                    {
                        _loc_6 = MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_DIVIDE_UNIT_002);
                        break;
                    }
                    case 2:
                    {
                        _loc_6 = MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_DIVIDE_UNIT_003);
                        break;
                    }
                    case 3:
                    {
                        _loc_6 = MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_DIVIDE_UNIT_004);
                        break;
                    }
                    case 4:
                    {
                        _loc_6 = MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_DIVIDE_UNIT_005);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                TutorialManager.getInstance().setTutorialBalloon(_loc_6, TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
            }
            return;
        }// end function

        public function tutorialDivideUnit() : void
        {
            var _loc_1:* = TutorialManager.getInstance().getTutorialPlayerIdx(this._selectPlayer.personal);
            this.switchDisable((_loc_1 & 1) == 0);
            return;
        }// end function

        private function createTreasureSymbol(param1:DisplayObjectContainer, param2:QuestSquare, param3:Boolean) : void
        {
            var _loc_4:* = QuestPieceTreasure.createDivideMc(param2.itemDisp);
            QuestPieceTreasure.createDivideMc(param2.itemDisp).y = QuestPieceTreasure.createDivideMc(param2.itemDisp).y - 25;
            param1.addChild(_loc_4);
            if (param3)
            {
                _loc_4.scaleX = _loc_4.scaleX * -1;
            }
            return;
        }// end function

        private function createHipopotamusSymbol(param1:DisplayObjectContainer, param2:QuestSquare, param3:Boolean) : void
        {
            var _loc_4:* = QuestPieceHippopotamus.createMc(QuestPieceHippopotamus.ICON_TYPE_PAYMENT_EVENT_DIVIDE);
            QuestPieceHippopotamus.createMc(QuestPieceHippopotamus.ICON_TYPE_PAYMENT_EVENT_DIVIDE).y = QuestPieceHippopotamus.createMc(QuestPieceHippopotamus.ICON_TYPE_PAYMENT_EVENT_DIVIDE).y - 25;
            param1.addChild(_loc_4);
            if (param3)
            {
                _loc_4.scaleX = _loc_4.scaleX * -1;
            }
            return;
        }// end function

        private function createEnemySymbol(param1:DisplayObjectContainer, param2:Array, param3:int, param4:Boolean, param5:int = 3) : void
        {
            var _loc_8:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (param2.length == 0)
            {
                return;
            }
            var _loc_9:* = ResourceManager.getInstance().createMovieClip(QuestPieceEnemy.getResource(), "MonsterSymbolNum");
            ResourceManager.getInstance().createMovieClip(QuestPieceEnemy.getResource(), "MonsterSymbolNum").y = ResourceManager.getInstance().createMovieClip(QuestPieceEnemy.getResource(), "MonsterSymbolNum").y - 25;
            param1.addChild(_loc_9);
            for each (_loc_10 in param2)
            {
                
                if (_loc_10 != null)
                {
                    _loc_7 = _loc_7 + _loc_10.rank;
                    _loc_6++;
                }
            }
            _loc_7 = Math.ceil(_loc_7 / _loc_6) as int;
            _loc_6 = Math.ceil(_loc_6 / 3);
            _loc_11 = _loc_6;
            _loc_9.gotoAndStop("rank2");
            if (param3 == QuestConstant.SQUARE_ATTR1_BOSSBATTLE)
            {
                _loc_9.gotoAndStop("rank1");
                _loc_11 = 1;
            }
            if (_loc_11 > param5)
            {
                _loc_11 = param5;
            }
            var _loc_12:* = 1;
            var _loc_13:* = 0;
            while (_loc_13 < param2.length)
            {
                
                _loc_14 = param2[_loc_13];
                if (_loc_14 != null)
                {
                    _loc_15 = _loc_9.getChildByName("monsNull" + _loc_12.toString()) as MovieClip;
                    _loc_8 = EnemyManager.getInstance().getEnemyInformation(_loc_14.infoId);
                    _loc_16 = new QuestPieceEnemy(_loc_15, param3, _loc_8, _loc_7);
                    _loc_16.squareId = 0;
                    _loc_16.setFrame(_loc_13 * Random.range(1, 3));
                    _loc_16.setReverse(param4);
                    this._aEnemySymbol.push(_loc_16);
                    _loc_12++;
                    _loc_11 = _loc_11 - 1;
                }
                if (_loc_11 == 0)
                {
                    break;
                }
                _loc_13++;
            }
            return;
        }// end function

        private function createBattleSymbol(param1:MovieClip, param2:Array, param3:Boolean) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_4:* = 1;
            var _loc_5:* = param2.length;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5)
            {
                
                if (_loc_4 > 9)
                {
                    break;
                }
                _loc_7 = param1.getChildByName("Null0" + _loc_4.toString()) as MovieClip;
                _loc_8 = param2[_loc_6];
                _loc_9 = QuestManager.getInstance().getSquare(_loc_8.sqId);
                switch(_loc_8.targetType)
                {
                    case QuestDivideSymbolTarget.TARGET_TYPE_HIPOPOTAMUS:
                    {
                        this.createHipopotamusSymbol(_loc_7, _loc_9, param3);
                        _loc_4++;
                        break;
                    }
                    case QuestDivideSymbolTarget.TARGET_TYPE_ENEMY:
                    {
                        this.createEnemySymbol(_loc_7, (_loc_9.aEnemy[0] as QuestEnemyList).aEnemyPersonal, QuestConstant.SQUARE_ATTR1_BATTLE, param3, 1);
                        _loc_4++;
                        break;
                    }
                    case QuestDivideSymbolTarget.TARGET_TYPE_TREASURE:
                    {
                        this.createTreasureSymbol(_loc_7, _loc_9, param3);
                        _loc_4++;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_6++;
            }
            return;
        }// end function

        private function cbWindowBtn(param1:int) : void
        {
            if (this._phase != _PHASE_SELECT)
            {
                return;
            }
            this.removeWindowButton();
            switch(param1)
            {
                case this._WINDOW_BUTTON_BASE:
                {
                    this._selectTeamNo = this._aSwitchTeamNo[0];
                    break;
                }
                case this._WINDOW_BUTTON_A:
                {
                    this._selectTeamNo = this._aSwitchTeamNo[1];
                    break;
                }
                case this._WINDOW_BUTTON_B:
                {
                    this._selectTeamNo = this._aSwitchTeamNo[2];
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function cbInputClick(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aPlayer.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aPlayer[_loc_2];
                if (_loc_3.setTeamNo != 0 && InputManager.getInstance().isHitTest(_loc_3.hitTarget.target))
                {
                    this.cbPlayerClick(_loc_3);
                    break;
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

    }
}

import button.*;

import enemy.*;

import flash.display.*;

import flash.events.*;

import flash.geom.*;

import input.*;

import message.*;

import player.*;

import popup.*;

import resource.*;

import sound.*;

import status.*;

import tutorial.*;

import user.*;

import utility.*;

class QuestDivideSymbolTarget extends Object
{
    private var _targetType:int;
    private var _sqId:int;
    public static const TARGET_TYPE_HIPOPOTAMUS:int = 1;
    public static const TARGET_TYPE_ENEMY:int = 2;
    public static const TARGET_TYPE_TREASURE:int = 3;

    function QuestDivideSymbolTarget(param1:int, param2:int)
    {
        this._targetType = param1;
        this._sqId = param2;
        return;
    }// end function

    public function get targetType() : int
    {
        return this._targetType;
    }// end function

    public function get sqId() : int
    {
        return this._sqId;
    }// end function

}

