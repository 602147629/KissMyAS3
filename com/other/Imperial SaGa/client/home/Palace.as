package home
{
    import button.*;
    import flash.display.*;
    import icon.*;
    import layer.*;
    import message.*;
    import player.*;
    import resource.*;
    import sound.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class Palace extends Object
    {
        private var _bEnd:Boolean;
        private var _layer:LayerHome;
        private var _baseMc:MovieClip;
        private var _isoMain:InStayOut;
        private var _mcBg:MovieClip;
        private var _isoBg:InStayOut;
        private var _nextScene:int;
        private var _aIcon:Array;
        public static const NOT_SELECTED:int = 0;
        public static const MYPAGE_SOLDIER_LIST:int = 1;
        public static const MYPAGE_LIST:int = 2;
        public static const MYPAGE_CHRONOLOGY:int = 3;
        public static const MYPAGE_CODE_INPUT:int = 4;
        public static const MYPAGE_CROWN_HISTORY:int = 5;
        public static const MYPAGE_CREDIT:int = 6;
        public static const MYPAGE_COOPERATE_CODE:int = 7;
        public static const MYPAGE_NAME_ENTRY:int = 8;
        private static const _PHASE_MAINTENANCE:int = 90;
        public static const MYPAGE_CLOSE:int = 100;

        public function Palace(param1:LayerHome)
        {
            var _loc_2:* = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Home.swf", "MyPage");
            var _loc_3:* = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Home.swf", "MyPageBg");
            this._bEnd = false;
            this._baseMc = _loc_2;
            this._layer = param1;
            this._layer.getLayer(LayerHome.MAIN).addChild(this._baseMc);
            this._isoMain = new InStayOut(this._baseMc);
            this._mcBg = _loc_3;
            this._isoBg = new InStayOut(this._mcBg);
            this._layer.getLayer(LayerHome.BG).addChild(this._mcBg);
            this._aIcon = [];
            this._createButtons();
            this._setUserStatus();
            this._nextScene = NOT_SELECTED;
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._aIcon)
            {
                for each (_loc_1 in this._aIcon)
                {
                    
                    ButtonManager.getInstance().removeButton(_loc_1);
                }
            }
            if (this._baseMc)
            {
                if (this._baseMc.parent)
                {
                    this._baseMc.parent.removeChild(this._baseMc);
                }
            }
            this._baseMc = null;
            if (this._mcBg)
            {
                if (this._mcBg.parent)
                {
                    this._mcBg.parent.removeChild(this._mcBg);
                }
            }
            this._mcBg = null;
            if (this._isoBg)
            {
                this._isoBg.release();
            }
            this._isoBg = null;
            return;
        }// end function

        public function control(param1:int) : void
        {
            if (this._isoMain.bEnd)
            {
                this._bEnd = true;
            }
            return;
        }// end function

        public function open() : void
        {
            if (SoundManager.getInstance().bgmId != SoundId.BGM_BGM_INS_PALCE)
            {
                SoundManager.getInstance().playBgm(SoundId.BGM_BGM_INS_PALCE);
            }
            if (this._isoMain.bClosed)
            {
                this._isoMain.setIn(this.cbIn);
            }
            if (this._isoBg.bClosed)
            {
                this._isoBg.setIn();
            }
            if (Main.GetApplicationData().maintenanceData.isMaintenanceTime())
            {
                Main.GetProcess().createMaintenanceWindow();
            }
            this._bEnd = false;
            this._nextScene = NOT_SELECTED;
            return;
        }// end function

        public function cbIn() : void
        {
            this.setDisableButton(false);
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MYPAGE))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MYPAGE);
            }
            return;
        }// end function

        public function close(param1:Boolean = true) : void
        {
            this.setDisableButton(true);
            if (this._isoMain.bOpened)
            {
                this._isoMain.setOut();
            }
            if (this._isoBg.bOpened && param1)
            {
                this._isoBg.setOut();
            }
            return;
        }// end function

        public function get bAnimetion() : Boolean
        {
            return this._isoMain == null || this._isoMain && this._isoMain.bAnimetion;
        }// end function

        public function get nextScene() : int
        {
            return this._nextScene;
        }// end function

        private function _setUserStatus() : void
        {
            var _loc_8:* = null;
            var _loc_10:* = null;
            var _loc_1:* = [this._baseMc.myPageMc.emperorLvMc, this._baseMc.myPageMc.expMc, this._baseMc.myPageMc.cycleMc, this._baseMc.myPageMc.chapterMc, this._baseMc.myPageMc.nowEmperorMc, this._baseMc.myPageMc.haveSoldierMc, this._baseMc.myPageMc.haveFormationMc, this._baseMc.myPageMc.haveAcceMc, this._baseMc.myPageMc.questClearMc];
            var _loc_2:* = [MessageId.PALACE_STATUS_EMPEROR_LV, MessageId.PALACE_STATUS_EXP, MessageId.PALACE_STATUS_CYCLE, MessageId.PALACE_STATUS_CHAPTER, MessageId.PALACE_STATUS_NOW_EMPEROR, MessageId.PALACE_STATUS_HAVE_SOLDIER, MessageId.PALACE_STATUS_HAVE_FOMATION, MessageId.PALACE_STATUS_HAVE_ACCE, MessageId.PALACE_STATUS_QUEST_CLEAR];
            var _loc_3:* = [this._baseMc.myPageMc.playerNameMc, this._baseMc.myPageMc.emperorLvNumberMc, this._baseMc.myPageMc.expBunsiMc, this._baseMc.myPageMc.expBunboMc, this._baseMc.myPageMc.cycleNumberMc, this._baseMc.myPageMc.chapterNumberMc, this._baseMc.myPageMc.yearNumberMc, this._baseMc.myPageMc.emperorNameMc, this._baseMc.myPageMc.soldierNumberMc, this._baseMc.myPageMc.formationNumberMc, this._baseMc.myPageMc.acceNumberMc, this._baseMc.myPageMc.questCNumberMc];
            var _loc_4:* = UserDataManager.getInstance().userData;
            var _loc_5:* = UserDataManager.getInstance().userData.emperorId;
            var _loc_6:* = PlayerManager.getInstance().getPlayerInformation(_loc_5);
            var _loc_7:* = [_loc_4.name, UserDataManager.getInstance().getEmperorLv(), _loc_4.exp, UserDataManager.getInstance().getNextExp(), _loc_4.cycle, _loc_4.chapter, _loc_4.progress, _loc_6.name, UserDataManager.getInstance().getCurrentPlayerNum(), _loc_4.getOwnFormationNum(), _loc_4.getOwnItem(CommonConstant.ITEM_KIND_ACCESSORIES).length, _loc_4.aCleatQuestId.length];
            if (BuildSwitch.SW_EMPEROR_SKILL)
            {
                _loc_1.push(this._baseMc.myPageMc.emperorSkillMc);
                _loc_2.push(MessageId.PALACE_STATUS_NOW_EMPEROR_SKILL);
                _loc_3.push(this._baseMc.myPageMc.emperorSkillTextMc);
                _loc_7.push(PlayerManager.getInstance().getEmperorSkillEffectsText(_loc_6, _loc_4.emperorData.bonus));
            }
            var _loc_9:* = 0;
            for each (_loc_8 in _loc_1)
            {
                
                TextControl.setIdText(_loc_8.textDt, _loc_2[_loc_9]);
                _loc_9++;
            }
            _loc_9 = 0;
            for each (_loc_8 in _loc_3)
            {
                
                TextControl.setText(_loc_8.textDt, _loc_7[_loc_9]);
                _loc_9++;
            }
            _loc_10 = new PlayerRarityIcon(this._baseMc.myPageMc.setCharaRankMc, _loc_6.rarity);
            return;
        }// end function

        private function _createButtons() : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_1:* = [this._baseMc.listBtnMc, this._baseMc.chronologyMc, this._baseMc.codeInputMc, this._baseMc.campaignBtnMc, this._baseMc.creditBtnMc, this._baseMc.myPageMc.NameChangeBtnMc, this._baseMc.closeBtnMc];
            var _loc_2:* = [MYPAGE_LIST, MYPAGE_CHRONOLOGY, MYPAGE_CODE_INPUT, MYPAGE_COOPERATE_CODE, MYPAGE_CREDIT, MYPAGE_NAME_ENTRY, MYPAGE_CLOSE];
            var _loc_3:* = [ButtonBase.SE_DECIDE_ID, ButtonBase.SE_DECIDE_ID, ButtonBase.SE_DECIDE_ID, ButtonBase.SE_DECIDE_ID, ButtonBase.SE_DECIDE_ID, ButtonBase.SE_DECIDE_ID, ButtonBase.SE_CANCEL_ID];
            var _loc_4:* = [MessageId.PALACE_BUTTON_LIST, MessageId.PALACE_BUTTON_CHRONOLOG, MessageId.PALACE_BUTTON_CODE, MessageId.PALACE_BENEFIT_BUTTON, MessageId.PALACE_CREDIT_BUTTON, MessageId.COMMON_BUTTON_CHANGE, MessageId.COMMON_BUTTON_RETURN];
            var _loc_5:* = 0;
            for each (_loc_6 in _loc_1)
            {
                
                _loc_7 = _loc_2[_loc_5];
                _loc_8 = _loc_4[_loc_5];
                _loc_9 = ButtonManager.getInstance().addButton(_loc_6, this._cbButton, _loc_7);
                _loc_9.enterSeId = _loc_3[_loc_5];
                TextControl.setIdText(_loc_6.textMc.textDt, _loc_8);
                this._aIcon.push(_loc_9);
                _loc_5++;
            }
            return;
        }// end function

        private function setDisableButton(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aIcon)
            {
                
                if (_loc_2.getMoveClip() != this._baseMc.soldierListBtnMc && _loc_2.getMoveClip() != this._baseMc.codeInputMc)
                {
                    _loc_2.setDisableFlag(param1);
                }
            }
            return;
        }// end function

        private function _cbButton(param1:int) : void
        {
            this.close(param1 != MYPAGE_CODE_INPUT);
            switch(param1)
            {
                case MYPAGE_LIST:
                {
                    this._nextScene = MYPAGE_LIST;
                    break;
                }
                case MYPAGE_CHRONOLOGY:
                {
                    this._nextScene = MYPAGE_CHRONOLOGY;
                    break;
                }
                case MYPAGE_CODE_INPUT:
                {
                    this._nextScene = MYPAGE_CODE_INPUT;
                    break;
                }
                case MYPAGE_CROWN_HISTORY:
                {
                    this._nextScene = MYPAGE_CROWN_HISTORY;
                    break;
                }
                case MYPAGE_CREDIT:
                {
                    this._nextScene = MYPAGE_CREDIT;
                    break;
                }
                case MYPAGE_COOPERATE_CODE:
                {
                    this._nextScene = MYPAGE_COOPERATE_CODE;
                    break;
                }
                case MYPAGE_NAME_ENTRY:
                {
                    this._nextScene = MYPAGE_NAME_ENTRY;
                    break;
                }
                case MYPAGE_CLOSE:
                {
                    this._nextScene = MYPAGE_CLOSE;
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

        public function updateUserName() : void
        {
            var _loc_1:* = UserDataManager.getInstance().userData;
            TextControl.setText(this._baseMc.myPageMc.playerNameMc.textDt, _loc_1.name);
            return;
        }// end function

    }
}
