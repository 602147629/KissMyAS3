package battle
{
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import player.*;
    import resource.*;
    import skill.*;
    import sound.*;
    import status.*;
    import tutorial.*;
    import utility.*;

    public class SelectSkillMenu extends Object
    {
        private var _balloonParent:DisplayObjectContainer;
        private var _battlePlayer:BattlePlayer;
        private var _mcMain:MovieClip;
        private var _isoMain:InStayOut;
        private var _aButton:Array;
        private var _useSkillId:int;
        private var _cbSelectFunc:Function;
        private var _aEnableSkillId:Array;
        private var _arrowTargetSkillId:int;
        private var _aBalloon:Array;
        private var _bEnable:Boolean;
        public static const windowOffsetPos:Point = new Point(-280, -200);

        public function SelectSkillMenu(param1:DisplayObjectContainer, param2:BattlePlayer, param3:int, param4:Point, param5:Function, param6:DisplayObjectContainer)
        {
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            this._balloonParent = param6;
            this._mcMain = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "UI_BattleMain.swf", "ActionSelectWindowMc");
            param1.addChild(this._mcMain);
            this._isoMain = new InStayOut(this._mcMain);
            this._battlePlayer = param2;
            this._useSkillId = this._battlePlayer.personal.useSkillId;
            this._cbSelectFunc = param5;
            this._aButton = [];
            this._aEnableSkillId = [];
            this._arrowTargetSkillId = Constant.EMPTY_ID;
            this._aBalloon = [];
            var _loc_7:* = windowOffsetPos.clone();
            _loc_7 = windowOffsetPos.clone().add(param4);
            this._mcMain.x = _loc_7.x;
            this._mcMain.y = _loc_7.y;
            var _loc_8:* = [param3, SkillId.DEFENSE];
            _loc_8 = [param3, SkillId.DEFENSE].concat(this._battlePlayer.personal.aSetSkillId.concat());
            var _loc_9:* = 0;
            if (TutorialManager.getInstance().isTutorial())
            {
                if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_SKILL_CHAIN_AFTER) && !TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_FIRST_BATTLE_END))
                {
                    _loc_10 = Constant.EMPTY_ID;
                    if (param2.playerPersonal.playerId == CommonConstant.NEW_CYCLE_DEFAULT_PLAYER_ID)
                    {
                        _loc_10 = CommonConstant.TUTORIAL_SKILL_CHAIN_SKILL_ID_1;
                    }
                    else if (param2.playerPersonal.playerId == CommonConstant.TUTORIAL_INIT_PLAYER_ID_3)
                    {
                        _loc_10 = CommonConstant.TUTORIAL_SKILL_CHAIN_SKILL_ID_3;
                    }
                    else if (param2.playerPersonal.playerId == CommonConstant.TUTORIAL_INIT_PLAYER_ID_5)
                    {
                        _loc_10 = CommonConstant.TUTORIAL_SKILL_CHAIN_SKILL_ID_5;
                    }
                    _loc_11 = _loc_8.indexOf(_loc_10);
                    if (_loc_11 < 0)
                    {
                        _loc_11 = 0;
                    }
                    _loc_9 = ~(1 << _loc_11);
                    if (param2.playerPersonal.playerId == CommonConstant.TUTORIAL_INIT_PLAYER_ID_5)
                    {
                        if (this._useSkillId != _loc_10)
                        {
                            _loc_9 = 0;
                            this._arrowTargetSkillId = _loc_10;
                        }
                    }
                }
                else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL, TutorialManager.BASIC_TUTORIAL_FLAG_FIRST_BATTLE_END))
                {
                    _loc_9 = 4294967294;
                }
            }
            this.setSkillButton(_loc_8, _loc_9);
            this._isoMain.setIn(this.cbIn);
            SoundManager.getInstance().playSe(SoundId.SE_RS3_SYSTEM_ENTER);
            return;
        }// end function

        public function get bEnable() : Boolean
        {
            return this._bEnable;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoMain.bEnd;
        }// end function

        private function cbIn() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                if (this._aEnableSkillId.indexOf(_loc_1.id) >= 0)
                {
                    _loc_1.setDisable(false);
                }
                if (this._arrowTargetSkillId != Constant.EMPTY_ID && this._arrowTargetSkillId == _loc_1.id)
                {
                    TutorialManager.getInstance().setTutorialArrow(_loc_1.getMoveClip(), TutorialManager.TUTORIAL_ARROW_DIRECTION_RIGHT);
                }
            }
            this._bEnable = true;
            this._aEnableSkillId = [];
            this._arrowTargetSkillId = Constant.EMPTY_ID;
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aButton = [];
            for each (_loc_2 in this._aBalloon)
            {
                
                _loc_2.release();
            }
            this._aBalloon = [];
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mcMain && this._mcMain.parent)
            {
                this._mcMain.parent.removeChild(this._mcMain);
            }
            this._mcMain = null;
            this._battlePlayer = null;
            return;
        }// end function

        private function setSkillButton(param1:Array, param2:uint) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = false;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_3:* = [this._mcMain.actionSelectMc.action1Mc, this._mcMain.actionSelectMc.action2Mc, this._mcMain.actionSelectMc.action3Mc, this._mcMain.actionSelectMc.action4Mc, this._mcMain.actionSelectMc.action5Mc];
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = _loc_3[_loc_4];
                _loc_6 = "-";
                _loc_7 = 0;
                _loc_8 = Constant.UNDECIDED;
                if (_loc_4 < param1.length && param1[_loc_4] != 0)
                {
                    _loc_8 = param1[_loc_4];
                    _loc_12 = SkillManager.getInstance().getSkillInformation(_loc_8);
                    _loc_6 = _loc_12.name;
                    _loc_7 = this._battlePlayer.getSkillUseSp(_loc_12);
                }
                TextControl.setText(_loc_5.actionSelectBtnMc.actionNameMc.textDt, _loc_6);
                _loc_9 = "";
                if (_loc_7 > 0)
                {
                    _loc_9 = StringTools.format(MessageManager.getInstance().getMessage(MessageId.BATTLE_SKILL_MENU_SP), _loc_7);
                }
                TextControl.setText(_loc_5.actionSelectBtnMc.spCostMc.textDt, _loc_9);
                _loc_10 = new ButtonBase(_loc_5.actionSelectBtnMc, this.cbSkillButton, this.cbSkillButtonOver, this.cbSkillButtonOut);
                _loc_10.setId(_loc_8);
                ButtonManager.getInstance().addButtonBase(_loc_10);
                _loc_10.enterSeId = SoundId.SE_RS3_SYSTEM_SKILL_ENTER;
                if (this._battlePlayer.personal.useSkillId == _loc_8)
                {
                    _loc_10.enterSeId = SoundId.SE_RS3_SYSTEM_RETURN;
                    _loc_5.gotoAndStop("on");
                }
                _loc_11 = false;
                if (_loc_8 != Constant.UNDECIDED)
                {
                    _loc_13 = _loc_3[2].balloonNullMc;
                    if (_loc_12.detailDescriptionBattle != null)
                    {
                        _loc_14 = new SkillStatusBalloonBattle(this._balloonParent, new Point(_loc_13.x, _loc_13.y));
                        for each (_loc_17 in this._battlePlayer.playerPersonal.aOwnSkillData)
                        {
                            
                            if (_loc_17.skillId == _loc_8)
                            {
                                _loc_14.setOwnSkillData(_loc_17);
                            }
                        }
                        if (_loc_14.skillId == Constant.EMPTY_ID)
                        {
                            _loc_14.setSkillData(_loc_8);
                        }
                        _loc_14.windowId = _loc_8;
                        _loc_14.hide();
                    }
                    _loc_15 = new Point(_loc_13.x, _loc_13.y);
                    new Point(_loc_13.x, _loc_13.y).x = _loc_15.x - 30;
                    _loc_14.setPosition(_loc_13.localToGlobal(_loc_15));
                    _loc_16 = _loc_10._mc.parent.localToGlobal(new Point());
                    _loc_14.setArrowTargetPosition(_loc_16.add(new Point(_loc_10._mc.width - 20, _loc_10._mc.height)));
                    this._aBalloon.push(_loc_14);
                }
                else
                {
                    _loc_11 = true;
                }
                if (this._battlePlayer.playerPersonal.sp < _loc_7)
                {
                    _loc_11 = true;
                }
                if (param2 & 1 << _loc_4)
                {
                    _loc_11 = true;
                }
                if (_loc_11 == false)
                {
                    this._aEnableSkillId.push(_loc_8);
                }
                _loc_10.setDisable(true);
                this._aButton.push(_loc_10);
                _loc_4++;
            }
            return;
        }// end function

        private function cbSkillButton(param1:int) : void
        {
            if (this._cbSelectFunc != null)
            {
                this._cbSelectFunc(param1);
            }
            return;
        }// end function

        private function cbSkillButtonOver(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBalloon)
            {
                
                if (_loc_2.windowId == param1)
                {
                    _loc_2.show();
                }
            }
            return;
        }// end function

        private function cbSkillButtonOut(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBalloon)
            {
                
                if (_loc_2.windowId == param1)
                {
                    _loc_2.hide();
                }
            }
            return;
        }// end function

        public function isHitTest(param1:Number, param2:Number) : Boolean
        {
            return this._mcMain.hitTestPoint(param1, param2);
        }// end function

        public function setClose() : void
        {
            this._isoMain.setOut();
            return;
        }// end function

    }
}
