package home
{
    import balloon.*;
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import input.*;
    import layer.*;
    import message.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class InstitutionMenu extends Object
    {
        private var _layer:LayerHome;
        private var _baseMc:MovieClip;
        private var _aIcon:Array;
        private var _nextProcessId:int;
        private var _charactermove:HomeCharacterMove;
        private var _selectWait:Number;
        private var _selectMenuIconId:int;
        private var _aMenuIconMc:Array;
        private var _aBolloon:Array;
        private var _aFacilityMessageId:Array;
        private var _employmentCheck:AnnouncementCheck;
        private var _aInformationIcon:Array;
        private var _aTimeInfoIcon:Array;
        private var upGradeTraining:HomeFacilityUpGradeCount;
        private var upGradeMagicDevelop:HomeFacilityUpGradeCount;
        private var upGradeSkillInitiate:HomeFacilityUpGradeCount;
        private var upGradeMakeEquip:HomeFacilityUpGradeCount;
        private var upGradeBarracks:HomeFacilityUpGradeCount;
        private var _numTrainingMc:NumericNumberMc;
        private var _numMagicDevelopMc:NumericNumberMc;
        private var _numSkillInitiateMc:NumericNumberMc;
        private var _numMakeEquipMc:NumericNumberMc;
        private var _numBarracksMc:NumericNumberMc;
        private var _timeCountArray:Array;
        private var _upgradeEndArray:Array;
        private var _id:Array;

        public function InstitutionMenu(param1:LayerHome, param2:MovieClip)
        {
            this._baseMc = param2;
            this._layer = param1;
            this._nextProcessId = Constant.UNDECIDED;
            this._selectMenuIconId = Constant.UNDECIDED;
            this._selectWait = 0;
            this._aIcon = [];
            this._aBolloon = [];
            this._timeCountArray = [];
            this._upgradeEndArray = [];
            this._id = [];
            this.createIconMenu();
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this._employmentCheck.release();
            if (this._charactermove)
            {
                this._charactermove.release();
            }
            this._charactermove = null;
            for each (_loc_1 in this._aBolloon)
            {
                
                BalloonManager.getInstance().removeBalloon(_loc_1);
            }
            this._aBolloon = [];
            for each (_loc_2 in this._aIcon)
            {
                
                ButtonManager.getInstance().removeArray(_loc_2);
                _loc_2.release();
            }
            this._aIcon = null;
            if (this.upGradeTraining)
            {
                this.upGradeTraining.release();
            }
            if (this.upGradeMagicDevelop)
            {
                this.upGradeMagicDevelop.release();
            }
            if (this.upGradeSkillInitiate)
            {
                this.upGradeSkillInitiate.release();
            }
            if (this.upGradeMakeEquip)
            {
                this.upGradeMakeEquip.release();
            }
            if (this.upGradeBarracks)
            {
                this.upGradeBarracks.release();
            }
            if (this._numTrainingMc)
            {
                this._numTrainingMc.release();
            }
            if (this._numMagicDevelopMc)
            {
                this._numMagicDevelopMc.release();
            }
            if (this._numSkillInitiateMc)
            {
                this._numSkillInitiateMc.release();
            }
            if (this._numMakeEquipMc)
            {
                this._numMakeEquipMc.release();
            }
            if (this._numBarracksMc)
            {
                this._numBarracksMc.release();
            }
            this._timeCountArray = [];
            this._upgradeEndArray = [];
            this._id = [];
            this._aInformationIcon = [];
            return;
        }// end function

        public function open() : void
        {
            if (this._charactermove == null)
            {
                this._charactermove = new HomeCharacterMove(this._baseMc.menuCharaMoveNull, this._aMenuIconMc);
            }
            return;
        }// end function

        public function close() : void
        {
            if (this._charactermove)
            {
                this._charactermove.bStop();
                this._charactermove.release();
            }
            this._charactermove = null;
            return;
        }// end function

        public function emperReCheak() : void
        {
            this._employmentCheck.reCheak();
            return;
        }// end function

        public function barracksReCheak() : void
        {
            this._employmentCheck.reCheakBarracks();
            return;
        }// end function

        public function control(param1:Number) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            this.updateSelectFacilityId();
            if (this._charactermove)
            {
                this._charactermove.constrol(param1);
            }
            if (this._selectMenuIconId > 0 && this._selectWait <= Constant.HOME_BALLOON && this._aBolloon.length == 0)
            {
                this._selectWait = this._selectWait + param1;
                if (this._selectWait >= Constant.HOME_BALLOON)
                {
                    _loc_2 = this._aMenuIconMc[(this._selectMenuIconId - 1)];
                    _loc_3 = this._aFacilityMessageId[this._selectMenuIconId];
                    _loc_4 = new BalloonNormal(this._layer.getLayer(LayerHome.BALLOON), _loc_2, _loc_2.balloonNullMc, MessageManager.getInstance().getMessage(_loc_3));
                    _loc_4.setPos(new Point(_loc_2.x + _loc_2.balloonNullMc.x, _loc_2.y + _loc_2.balloonNullMc.y));
                    _loc_4.setMouseOver(true);
                    BalloonManager.getInstance().addBalloon(_loc_4);
                    this._aBolloon.push(_loc_4);
                }
            }
            return this._nextProcessId != Constant.UNDECIDED;
        }// end function

        public function iconDisable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aIcon)
            {
                
                _loc_2.setDisableFlag(param1);
            }
            return;
        }// end function

        public function informationIconDisable(param1:int, param2:Boolean) : void
        {
            if (param1 > 0 && param1 < this._aInformationIcon.length)
            {
                this._aInformationIcon[(param1 - 1)].visible = param2;
            }
            return;
        }// end function

        public function getFacilityIcon(param1:int) : MovieClip
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._aIcon.length)
            {
                
                _loc_3 = this._aIcon[_loc_2];
                if (_loc_3.id == param1)
                {
                    return _loc_3.getMoveClip();
                }
                _loc_2++;
            }
            return null;
        }// end function

        public function get nextProcessId() : int
        {
            return this._nextProcessId;
        }// end function

        public function resetNextProcessId() : void
        {
            this._nextProcessId = Constant.UNDECIDED;
            return;
        }// end function

        private function createIconMenu() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = false;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            this._aMenuIconMc = [this._baseMc.menuIconBtn_PalaceMc, this._baseMc.menuIconBtn_StoreHouseMc, this._baseMc.menuIconBtn_SkillInitiateMc, this._baseMc.menuIconBtn_MagicDevelopMc, this._baseMc.menuIconBtn_TrainingMc, this._baseMc.menuIconBtn_CommandMc, this._baseMc.menuIconBtn_BarracksMc, this._baseMc.menuIconBtn_SortieMc, this._baseMc.menuIconBtn_MakeEquipMc, this._baseMc.menuIconBtn_PracticeMc, this._baseMc.menuIconBtn_TradingMc];
            var _loc_1:* = [CommonConstant.FACILITY_ID_MYPAGE, CommonConstant.FACILITY_ID_WEARHOUSE, CommonConstant.FACILITY_ID_SKILL_INITIATE, CommonConstant.FACILITY_ID_MAGIC_DEVELOP, CommonConstant.FACILITY_ID_TRAINING_ROOM, CommonConstant.FACILITY_ID_COMMAND_ROOM, CommonConstant.FACILITY_ID_BARRACKS, CommonConstant.FACILITY_ID_SORTIE, CommonConstant.FACILITY_ID_MAKE_EQUIP, CommonConstant.FACILITY_ID_PRACTICE, CommonConstant.FACILITY_ID_TRADING];
            var _loc_2:* = [CommonConstant.FACILITY_ID_BARRACKS, CommonConstant.FACILITY_ID_MAGIC_DEVELOP, CommonConstant.FACILITY_ID_MAKE_EQUIP, CommonConstant.FACILITY_ID_SKILL_INITIATE, CommonConstant.FACILITY_ID_TRAINING_ROOM];
            this._aInformationIcon = [this._baseMc.FinisheMark5Mc, this._baseMc.FinisheMark9Mc, this._baseMc.FinisheMark3Mc, this._baseMc.FinisheMark2Mc, this._baseMc.FinisheMark1Mc, this._baseMc.FinisheMark6Mc, this._baseMc.FinisheMark11Mc, this._baseMc.FinisheMark7Mc, this._baseMc.FinisheMark4Mc, this._baseMc.FinisheMark10Mc, this._baseMc.FinisheMark8Mc];
            this._aTimeInfoIcon = [{timeIcon:this._baseMc.timeInfo1Mc, constructionIcon:this._baseMc.menuIconBtn_TrainingMc.menuIconMc.kentikuNow}, {timeIcon:this._baseMc.timeInfo2Mc, constructionIcon:this._baseMc.menuIconBtn_MagicDevelopMc.menuIconMc.kentikuNow}, {timeIcon:this._baseMc.timeInfo3Mc, constructionIcon:this._baseMc.menuIconBtn_SkillInitiateMc.menuIconMc.kentikuNow}, {timeIcon:this._baseMc.timeInfo4Mc, constructionIcon:this._baseMc.menuIconBtn_MakeEquipMc.menuIconMc.kentikuNow}, {timeIcon:this._baseMc.timeInfo11Mc, constructionIcon:this._baseMc.menuIconBtn_BarracksMc.menuIconMc.kentikuNow}];
            this.createBalloonMessage();
            for each (_loc_3 in this._aInformationIcon)
            {
                
                _loc_3.visible = false;
            }
            _loc_4 = 0;
            while (_loc_4 < this._aTimeInfoIcon.length)
            {
                
                this._aTimeInfoIcon[_loc_4].timeIcon.visible = false;
                this._aTimeInfoIcon[_loc_4].constructionIcon.visible = false;
                _loc_4++;
            }
            var _loc_5:* = UserDataManager.getInstance().userData.aInstitution;
            var _loc_6:* = 0;
            for each (_loc_7 in this._aMenuIconMc)
            {
                
                _loc_8 = false;
                _loc_9 = _loc_1[_loc_6];
                if (_loc_2.indexOf(_loc_9) >= 0)
                {
                    _loc_11 = UserDataManager.getInstance().userData.getInstitutionInfo(_loc_9);
                    if (_loc_11 != null)
                    {
                        _loc_7.menuIconMc.gotoAndStop("lv" + UserFacilityLv.getFacilityLv(_loc_11.grade));
                        if (_loc_11.grade == 0 && !UserDataManager.getInstance().isUnlockFacility(_loc_11.id))
                        {
                            _loc_8 = true;
                        }
                    }
                }
                if (TutorialManager.getInstance().isTutorial())
                {
                    if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_EMPLOY_1))
                    {
                        _loc_8 = _loc_9 != CommonConstant.FACILITY_ID_PRACTICE;
                    }
                    else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_COMMAND_POST_1))
                    {
                        _loc_8 = _loc_9 != CommonConstant.FACILITY_ID_COMMAND_ROOM;
                    }
                    else if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_WORLD_MAP))
                    {
                        _loc_8 = _loc_9 != CommonConstant.FACILITY_ID_SORTIE;
                    }
                }
                _loc_10 = new ButtonBase(_loc_7, this.cbFacilityIcon);
                _loc_10.setId(_loc_9);
                _loc_10.setDisable(_loc_8);
                _loc_10.setHitMovieClip(_loc_7.collisionMc);
                _loc_10.enterSeId = ButtonBase.SE_DECIDE_ID;
                if (_loc_8 == false)
                {
                    ButtonManager.getInstance().addButtonBase(_loc_10);
                    this._aIcon.push(_loc_10);
                }
                _loc_6++;
            }
            this._employmentCheck = new AnnouncementCheck(this._aFacilityMessageId, this._aInformationIcon);
            this.iconDisable(true);
            return;
        }// end function

        private function createBalloonMessage() : void
        {
            this._aFacilityMessageId = [];
            this._aFacilityMessageId[CommonConstant.FACILITY_ID_MYPAGE] = MessageId.FACILITY_BALLOON_PALACE;
            this._aFacilityMessageId[CommonConstant.FACILITY_ID_WEARHOUSE] = MessageId.FACILITY_BALLOON_STPRE_HOUSE;
            this._aFacilityMessageId[CommonConstant.FACILITY_ID_SKILL_INITIATE] = MessageId.FACILITY_BALLOON_SKILL_INITIATE;
            this._aFacilityMessageId[CommonConstant.FACILITY_ID_MAGIC_DEVELOP] = MessageId.FACILITY_BALLOON_MAGIC_DEVELOP;
            this._aFacilityMessageId[CommonConstant.FACILITY_ID_TRAINING_ROOM] = MessageId.FACILITY_BALLOON_TRANING;
            this._aFacilityMessageId[CommonConstant.FACILITY_ID_COMMAND_ROOM] = MessageId.FACILITY_BALLOON_COMMAND;
            this._aFacilityMessageId[CommonConstant.FACILITY_ID_BARRACKS] = MessageId.FACILITY_BALLOON_BARRACKS;
            this._aFacilityMessageId[CommonConstant.FACILITY_ID_SORTIE] = MessageId.FACILITY_BALLOON_SORTIE;
            this._aFacilityMessageId[CommonConstant.FACILITY_ID_MAKE_EQUIP] = MessageId.FACILITY_BALLOON_MAKE_EQUIP;
            this._aFacilityMessageId[CommonConstant.FACILITY_ID_PRACTICE] = MessageId.FACILITY_BALLOON_PRACTICE;
            this._aFacilityMessageId[CommonConstant.FACILITY_ID_TRADING] = MessageId.FACILITY_BALLOON_TRADING;
            return;
        }// end function

        private function updateSelectFacilityId() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = false;
            var _loc_2:* = false;
            for each (_loc_3 in this._aIcon)
            {
                
                if (_loc_3.isEnable() == false)
                {
                    continue;
                }
                _loc_4 = InputManager.getInstance().corsor;
                if (_loc_3.getHitMoveClip().hitTestPoint(_loc_4.x, _loc_4.y))
                {
                    if (this._aBolloon.length != 0)
                    {
                        this._selectWait = 0;
                        if (this._selectMenuIconId != _loc_3.id)
                        {
                            _loc_2 = true;
                        }
                    }
                    this._selectMenuIconId = _loc_3.id;
                    _loc_1 = true;
                    break;
                }
            }
            if (_loc_1 == false)
            {
                this._selectMenuIconId = Constant.UNDECIDED;
                this._selectWait = 0;
                _loc_2 = true;
            }
            if (_loc_2)
            {
                for each (_loc_5 in this._aBolloon)
                {
                    
                    BalloonManager.getInstance().removeBalloon(_loc_5);
                }
                this._aBolloon = [];
            }
            return;
        }// end function

        private function cbFacilityIcon(param1:int) : void
        {
            var _loc_2:* = null;
            this._nextProcessId = ProcessMain.PROCESS_TITLE;
            for each (_loc_2 in this._aBolloon)
            {
                
                BalloonManager.getInstance().removeBalloon(_loc_2);
            }
            switch(param1)
            {
                case CommonConstant.FACILITY_ID_MYPAGE:
                {
                    this._nextProcessId = ProcessMain.PROCESS_MY_PAGE;
                    this._employmentCheck.setbMyPage(true);
                    break;
                }
                case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                {
                    this._nextProcessId = ProcessMain.PROCESS_SKILL_INITIATE;
                    break;
                }
                case CommonConstant.FACILITY_ID_WEARHOUSE:
                {
                    this._nextProcessId = ProcessMain.PROCESS_STORAGE;
                    this._employmentCheck.setbWareHouse(true);
                    break;
                }
                case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                {
                    this._nextProcessId = ProcessMain.PROCESS_MAGIC_DEVELOP;
                    break;
                }
                case CommonConstant.FACILITY_ID_COMMAND_ROOM:
                {
                    this._nextProcessId = ProcessMain.PROCESS_COMMAND_POST;
                    this._employmentCheck.setbCommandRoom(true);
                    break;
                }
                case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                {
                    this._nextProcessId = ProcessMain.PROCESS_TRAINING_ROOM;
                    break;
                }
                case CommonConstant.FACILITY_ID_BARRACKS:
                {
                    this._nextProcessId = ProcessMain.PROCESS_BARRACKS;
                    break;
                }
                case CommonConstant.FACILITY_ID_MAKE_EQUIP:
                {
                    this._nextProcessId = ProcessMain.PROCESS_MAKE_EQUIP;
                    break;
                }
                case CommonConstant.FACILITY_ID_SORTIE:
                {
                    this._nextProcessId = ProcessMain.PROCESS_QUEST_SELECT;
                    break;
                }
                case CommonConstant.FACILITY_ID_PRACTICE:
                {
                    this._nextProcessId = ProcessMain.PROCESS_EMPLOYMENT;
                    break;
                }
                case CommonConstant.FACILITY_ID_TRADING:
                {
                    this._nextProcessId = ProcessMain.PROCESS_TRADING_POST;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function cbFacilityIconOver(param1:int) : void
        {
            this._selectMenuIconId = param1;
            return;
        }// end function

        private function cbFacilityIconOut(param1:int) : void
        {
            var _loc_2:* = null;
            this._selectWait = 0;
            this._selectMenuIconId = Constant.UNDECIDED;
            for each (_loc_2 in this._aBolloon)
            {
                
                BalloonManager.getInstance().removeBalloon(_loc_2);
            }
            this._aBolloon = [];
            return;
        }// end function

        public function countCheak() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_1:* = UserDataManager.getInstance().userData;
            var _loc_2:* = TimeClock.getNowTime();
            for each (_loc_3 in _loc_1.aInstitution)
            {
                
                if (_loc_3.upgradeEnd >= _loc_2)
                {
                    _loc_4 = _loc_3.upgradeEnd - _loc_2;
                    _loc_5 = _loc_3.grade == 0 ? (MessageId.FACILITY_UPGRADE_RUNTIME_MESSAGE) : (MessageId.FACILITY_BALOON_FACILITY_UNDER_UPGLADE);
                    _loc_6 = _loc_3.grade == 0 ? (MessageId.FACILITY_UPGRADE_RUNTIME_TITLE) : (MessageId.FACILITY_UPGRADE_ENDTIME_MESSAGE);
                    switch(_loc_3.id)
                    {
                        case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                        {
                            if (!this._numTrainingMc)
                            {
                                if (_loc_3.grade == 0 && _loc_4 > 30)
                                {
                                    _loc_4 = 30;
                                }
                                this._numTrainingMc = new NumericNumberMc(this._aTimeInfoIcon[0].timeIcon.remainingTimeMc, _loc_4, 0);
                                this._numTrainingMc.startCount(_loc_4, 0);
                                this._timeCountArray.push(this._numTrainingMc);
                                this._id.push(0);
                                this._aTimeInfoIcon[0].timeIcon.visible = true;
                                this._aTimeInfoIcon[0].constructionIcon.visible = true;
                                this._aFacilityMessageId[CommonConstant.FACILITY_ID_TRAINING_ROOM] = _loc_5;
                                TextControl.setIdText(this._aTimeInfoIcon[0].timeIcon.textMc.textDt, _loc_6);
                            }
                            break;
                        }
                        case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                        {
                            if (!this._numMagicDevelopMc)
                            {
                                if (_loc_3.grade == 0 && _loc_4 > 30)
                                {
                                    _loc_4 = 30;
                                }
                                this._numMagicDevelopMc = new NumericNumberMc(this._aTimeInfoIcon[1].timeIcon.remainingTimeMc, _loc_4, 0);
                                this._numMagicDevelopMc.startCount(_loc_4, 0);
                                this._timeCountArray.push(this._numMagicDevelopMc);
                                this._id.push(1);
                                this._aTimeInfoIcon[1].timeIcon.visible = true;
                                this._aTimeInfoIcon[1].constructionIcon.visible = true;
                                this._aFacilityMessageId[CommonConstant.FACILITY_ID_MAGIC_DEVELOP] = _loc_5;
                                TextControl.setIdText(this._aTimeInfoIcon[1].timeIcon.textMc.textDt, _loc_6);
                            }
                            break;
                        }
                        case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                        {
                            if (!this._numSkillInitiateMc)
                            {
                                if (_loc_3.grade == 0 && _loc_4 > 30)
                                {
                                    _loc_4 = 30;
                                }
                                this._numSkillInitiateMc = new NumericNumberMc(this._aTimeInfoIcon[2].timeIcon.remainingTimeMc, _loc_4, 0);
                                this._numSkillInitiateMc.startCount(_loc_4, 0);
                                this._timeCountArray.push(this._numSkillInitiateMc);
                                this._id.push(2);
                                this._aTimeInfoIcon[2].timeIcon.visible = true;
                                this._aTimeInfoIcon[2].constructionIcon.visible = true;
                                this._aFacilityMessageId[CommonConstant.FACILITY_ID_SKILL_INITIATE] = _loc_5;
                                TextControl.setIdText(this._aTimeInfoIcon[2].timeIcon.textMc.textDt, _loc_6);
                            }
                            break;
                        }
                        case CommonConstant.FACILITY_ID_MAKE_EQUIP:
                        {
                            if (!this._numMakeEquipMc)
                            {
                                if (_loc_3.grade == 0 && _loc_4 > 30)
                                {
                                    _loc_4 = 30;
                                }
                                this._numMakeEquipMc = new NumericNumberMc(this._aTimeInfoIcon[3].timeIcon.remainingTimeMc, _loc_4, 0);
                                this._numMakeEquipMc.startCount(_loc_4, 0);
                                this._timeCountArray.push(this._numMakeEquipMc);
                                this._id.push(3);
                                this._aTimeInfoIcon[3].timeIcon.visible = true;
                                this._aTimeInfoIcon[3].constructionIcon.visible = true;
                                this._aFacilityMessageId[CommonConstant.FACILITY_ID_MAKE_EQUIP] = _loc_5;
                                TextControl.setIdText(this._aTimeInfoIcon[3].timeIcon.textMc.textDt, _loc_6);
                            }
                            break;
                        }
                        case CommonConstant.FACILITY_ID_BARRACKS:
                        {
                            if (!this._numBarracksMc)
                            {
                                if (_loc_3.grade == 0 && _loc_4 > 30)
                                {
                                    _loc_4 = 30;
                                }
                                this._numBarracksMc = new NumericNumberMc(this._aTimeInfoIcon[4].timeIcon.remainingTimeMc, _loc_4, 0);
                                this._numBarracksMc.startCount(_loc_4, 0);
                                this._timeCountArray.push(this._numBarracksMc);
                                this._id.push(4);
                                this._aTimeInfoIcon[4].timeIcon.visible = true;
                                this._aTimeInfoIcon[4].constructionIcon.visible = true;
                                this._aFacilityMessageId[CommonConstant.FACILITY_ID_BARRACKS] = _loc_5;
                                TextControl.setIdText(this._aTimeInfoIcon[4].timeIcon.textMc.textDt, _loc_6);
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                if (_loc_3.upgradeEnd != 0)
                {
                    if (_loc_3.upgradeEnd <= _loc_2)
                    {
                        switch(_loc_3.id)
                        {
                            case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                            {
                                if (!this.upGradeTraining)
                                {
                                    this.upGradeTraining = new HomeFacilityUpGradeCount(this._baseMc, CommonConstant.FACILITY_ID_TRAINING_ROOM);
                                    this._upgradeEndArray.push(this.upGradeTraining);
                                }
                                break;
                            }
                            case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                            {
                                if (!this.upGradeMagicDevelop)
                                {
                                    this.upGradeMagicDevelop = new HomeFacilityUpGradeCount(this._baseMc, CommonConstant.FACILITY_ID_MAGIC_DEVELOP);
                                    this._upgradeEndArray.push(this.upGradeMagicDevelop);
                                }
                                break;
                            }
                            case CommonConstant.FACILITY_ID_SKILL_INITIATE:
                            {
                                if (!this.upGradeSkillInitiate)
                                {
                                    this.upGradeSkillInitiate = new HomeFacilityUpGradeCount(this._baseMc, CommonConstant.FACILITY_ID_SKILL_INITIATE);
                                    this._upgradeEndArray.push(this.upGradeSkillInitiate);
                                }
                                break;
                            }
                            case CommonConstant.FACILITY_ID_MAKE_EQUIP:
                            {
                                if (!this.upGradeMakeEquip)
                                {
                                    this.upGradeMakeEquip = new HomeFacilityUpGradeCount(this._baseMc, CommonConstant.FACILITY_ID_MAKE_EQUIP);
                                    this._upgradeEndArray.push(this.upGradeMakeEquip);
                                }
                                break;
                            }
                            case CommonConstant.FACILITY_ID_BARRACKS:
                            {
                                if (!this.upGradeBarracks)
                                {
                                    this.upGradeBarracks = new HomeFacilityUpGradeCount(this._baseMc, CommonConstant.FACILITY_ID_BARRACKS);
                                    this._upgradeEndArray.push(this.upGradeBarracks);
                                }
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        public function countControl(param1:Number, param2:Boolean) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._timeCountArray != null)
            {
                this.countCheak();
                if (this._timeCountArray.length > Constant.EMPTY_ID)
                {
                    _loc_3 = Constant.EMPTY_ID;
                    for each (_loc_4 in this._timeCountArray)
                    {
                        
                        _loc_4.count(param1);
                        _loc_4.countTime();
                        if (_loc_4.countEnd)
                        {
                            this._aTimeInfoIcon[this._id[_loc_3]].timeIcon.visible = false;
                            this._aTimeInfoIcon[this._id[_loc_3]].constructionIcon.visible = false;
                        }
                        if (_loc_4.countEndBefore)
                        {
                            this._aTimeInfoIcon[this._id[_loc_3]].timeIcon.visible = false;
                        }
                        _loc_3++;
                    }
                }
                if (param2)
                {
                    if (this._upgradeEndArray.length != Constant.EMPTY_ID)
                    {
                        this.iconDisable(true);
                        this._upgradeEndArray[Constant.EMPTY_ID].control(param1);
                        if (this._upgradeEndArray[Constant.EMPTY_ID].End())
                        {
                            _loc_5 = this._upgradeEndArray.shift();
                            this._aFacilityMessageId[_loc_5.returnId()] = _loc_5.getCompletionMessageId();
                            this._aInformationIcon[(_loc_5.returnId() - 1)].visible = true;
                            _loc_5.release();
                            _loc_5 = null;
                            this.iconDisable(false);
                        }
                    }
                }
            }
            return;
        }// end function

    }
}
