package skillInitiate
{
    import button.*;
    import effect.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import message.*;
    import player.*;
    import resource.*;
    import sound.*;
    import user.*;
    import utility.*;

    public class SkillInitiateView extends Object
    {
        private const _LABEL_STOP:String = "stop";
        private const _LABEL_START1:String = "start1";
        private const _LABEL_CROUCHSTOP_OTHERS:String = "crouchStop_others";
        private const _LABEL_GUARD_NULL1:String = "guard_null1";
        private const _LABEL_JUMP_OTHERS:String = "jump_others";
        private const _LABEL_SIDEWARK_NULL1:String = "sideWark_null1";
        private const _LABEL_SIDEWARK_NULL2:String = "sideWark_null2";
        private const _LABEL_SIDESTOP_OTHERS:String = "sideStop_others";
        private const _LABEL_SIDESTOP_NULL2:String = "sideStop_null2";
        private const _LABEL_GUARD_NULL2:String = "guard_null2";
        private const _LABEL_INITIATIONSTART:String = "initiationStart";
        private const _LABEL_SIDESTOP_NULL1:String = "sideStop_null1";
        private const _LABEL_LOST_NULL2:String = "lost_null2";
        private const _LABEL_LOST_END:String = "end";
        private const _LABEL_CAPTIONSTART:String = "captionStart";
        private const _LABEL_EFFCLASH1:String = "effClash1";
        private const _LABEL_EFFPOWERUP:String = "effPowerUp";
        private const _LABEL_AURAEFF:String = "auraEff";
        private const _LABEL_EFFCLASH2:String = "effClash2";
        private const _INDEX_STUDENT:int = 0;
        private const _INDEX_TEACHER:int = 1;
        private const _INDEX_OTHER:int = 2;
        private const _MAX_CHARA_NUM:int = 11;
        private const _PHASE_WAIT:int = 10;
        private const _PHASE_INIT:int = 19;
        private const _PHASE_START:int = 20;
        private const _PHASE_INITIATE:int = 30;
        private const _PHASE_SUCCESS_1:int = 35;
        private const _PHASE_SUCCESS_2:int = 36;
        private const _PHASE_SUCCESS_3:int = 37;
        private const _PHASE_FINISH:int = 40;
        private var _phase:int;
        private var _effectManager:EffectManager;
        private var _aEffect:Array;
        private var _baseMc:MovieClip;
        private var _bButtonEnable:Boolean;
        private var _overSelectedId:int;
        private var _selectedId:int;
        private var _releaseButton:ButtonBase;
        private var _siManager:SkillInitiateManager;
        private var _aCharaView:Array;
        private var _bSuccess:Boolean;
        private var _effectStudent:MovieClip;
        private var _effectTeacher:MovieClip;
        private var _effectSupporter:MovieClip;
        private var _studentSkillParamMc:MovieClip;
        private var _teacherSkillParamMc:MovieClip;
        private var _isoEffectSupporter:InStayOut;
        private var _isoInitiateArrow:InStayOut;
        private var _isoLabelStudent:InStayOut;
        private var _isoLabelTeacher:InStayOut;
        private var _isoLabelSupporter:InStayOut;
        private var _isoStudentSkillBalloon:InStayOut;
        private var _isoTeacherSkillBalloon:InStayOut;
        private var _isoTeacherSkillParam:InStayOut;
        private var _bEnd:Boolean;
        private var _aSupporter:Array;
        private var _bJump:Boolean;
        private var _releaseId:int;

        public function SkillInitiateView(param1:MovieClip, param2:SkillInitiateManager)
        {
            this._aSupporter = [];
            this._baseMc = param1;
            this._siManager = param2;
            this.createCharaView();
            this._effectStudent = this._baseMc.effMark1Mc;
            this._effectStudent.visible = false;
            this._effectTeacher = this._baseMc.effMark2Mc;
            this._effectTeacher.visible = false;
            this._effectSupporter = this._baseMc.SelectBgMc;
            this._studentSkillParamMc = this._baseMc.DenjuSkillParam1Mc;
            this._teacherSkillParamMc = this._baseMc.DenjuSkillParam2Mc.ParamSetMc;
            this._isoEffectSupporter = new InStayOut(this._effectSupporter);
            this._isoLabelStudent = new InStayOut(this._baseMc.InitiationBg1Mc);
            this._isoLabelTeacher = new InStayOut(this._baseMc.InitiationBg2Mc);
            this._isoLabelSupporter = new InStayOut(this._baseMc.InitiationBg3Mc);
            this._isoInitiateArrow = new InStayOut(this._baseMc.arrowDenjyuSetMc);
            this._isoStudentSkillBalloon = new InStayOut(this._baseMc.DenjuSkillParam1Mc);
            this._isoTeacherSkillBalloon = new InStayOut(this._baseMc.DenjuSkillParam2Mc);
            this._isoTeacherSkillParam = new InStayOut(this._teacherSkillParamMc);
            TextControl.setIdText(this._baseMc.InitiationBg1Mc.textMc.textDt, MessageId.SKILL_INITIATE_LABEL_STUDENT);
            TextControl.setIdText(this._baseMc.InitiationBg2Mc.textMc.textDt, MessageId.SKILL_INITIATE_LABEL_TEACHER);
            TextControl.setIdText(this._baseMc.InitiationBg3Mc.textMc.textDt, MessageId.SKILL_INITIATE_LABEL_SUPPORTER);
            TextControl.setIdText(this._studentSkillParamMc.text1Mc.textDt, MessageId.COMMON_SKILL_STATUS_POWER);
            TextControl.setIdText(this._studentSkillParamMc.text2Mc.textDt, MessageId.COMMON_SKILL_STATUS_HIT);
            TextControl.setIdText(this._studentSkillParamMc.text3Mc.textDt, MessageId.COMMON_SKILL_STATUS_SP);
            TextControl.setIdText(this._teacherSkillParamMc.text1Mc.textDt, MessageId.COMMON_SKILL_STATUS_POWER);
            TextControl.setIdText(this._teacherSkillParamMc.text2Mc.textDt, MessageId.COMMON_SKILL_STATUS_HIT);
            TextControl.setIdText(this._teacherSkillParamMc.text3Mc.textDt, MessageId.COMMON_SKILL_STATUS_SP);
            DisplayUtils.setTopPriority(this._baseMc, this._baseMc.InitiationBg1Mc);
            DisplayUtils.setTopPriority(this._baseMc, this._baseMc.InitiationBg2Mc);
            DisplayUtils.setTopPriority(this._baseMc, this._baseMc.InitiationBg3Mc);
            this._effectManager = new EffectManager();
            InputManager.getInstance().addMouseCallback(this._baseMc, this.cbMove, this.cbClick);
            var _loc_3:* = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_FacilityGradeUp.swf", "ReserveMoveBtn");
            this._baseMc.addChild(_loc_3);
            this._releaseButton = ButtonManager.getInstance().addButton(_loc_3, this.cbReleaseCharacter);
            this._releaseButton.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._releaseButton.getMoveClip().visible = false;
            this._releaseButton.setDisable(true);
            this._bButtonEnable = true;
            this._bEnd = true;
            this._bSuccess = false;
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            InputManager.getInstance().delMouseCallback(this._baseMc);
            if (this._releaseButton)
            {
                if (this._releaseButton.getMoveClip().parent)
                {
                    this._releaseButton.getMoveClip().parent.removeChild(this._releaseButton.getMoveClip());
                }
                ButtonManager.getInstance().removeButton(this._releaseButton);
            }
            for each (_loc_1 in this._aCharaView)
            {
                
                _loc_1.release();
            }
            if (this._effectManager)
            {
                this._effectManager.release();
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            for each (_loc_2 in this._aCharaView)
            {
                
                _loc_3 = this._aCharaView.indexOf(_loc_2);
                if (this._bEnd == false)
                {
                    if (_loc_3 == this._INDEX_STUDENT || _loc_3 == this._INDEX_TEACHER)
                    {
                        _loc_4 = this._baseMc.getChildByName("charaNull" + (_loc_3 + 1)) as MovieClip;
                        this._aCharaView[_loc_3].playerDisplay.setTargetPoint(new Point(_loc_4.x, _loc_4.y), 0);
                    }
                }
                _loc_2.control(param1);
            }
            switch(this._phase)
            {
                case this._PHASE_WAIT:
                {
                    this.controlWait(param1);
                    break;
                }
                case this._PHASE_INIT:
                {
                    this.controlInit(param1);
                    break;
                }
                case this._PHASE_START:
                {
                    this.controlStart(param1);
                    break;
                }
                case this._PHASE_INITIATE:
                {
                    this.controlInitiate(param1);
                    break;
                }
                case this._PHASE_SUCCESS_1:
                {
                    this.controlSuccess1(param1);
                    break;
                }
                case this._PHASE_SUCCESS_2:
                {
                    this.controlSuccess2(param1);
                    break;
                }
                case this._PHASE_SUCCESS_3:
                {
                    this.controlSuccess3(param1);
                    break;
                }
                case this._PHASE_FINISH:
                {
                    this.controlFinish(param1);
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
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_WAIT:
                    {
                        this.phaseWait();
                        break;
                    }
                    case this._PHASE_INIT:
                    {
                        this.phaseInit();
                        break;
                    }
                    case this._PHASE_START:
                    {
                        this.phaseStart();
                        break;
                    }
                    case this._PHASE_INITIATE:
                    {
                        this.phaseInitiate();
                        break;
                    }
                    case this._PHASE_SUCCESS_1:
                    {
                        this.phaseSuccess1();
                        break;
                    }
                    case this._PHASE_SUCCESS_2:
                    {
                        this.phaseSuccess2();
                        break;
                    }
                    case this._PHASE_SUCCESS_3:
                    {
                        this.phaseSuccess3();
                        break;
                    }
                    case this._PHASE_FINISH:
                    {
                        this.phaseFinish();
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

        public function setButtonEnable(param1:Boolean) : void
        {
            this._bButtonEnable = param1;
            this._releaseButton.setDisable(!param1 || this._releaseButton.getMoveClip().visible == false);
            return;
        }// end function

        public function setResult(param1:Boolean) : void
        {
            this._bSuccess = param1;
            return;
        }// end function

        public function startAnimation(param1:Boolean) : void
        {
            if (this._bEnd)
            {
                this.setPhase(this._PHASE_INIT);
                this.setButtonEnable(false);
            }
            return;
        }// end function

        public function backAnimation() : void
        {
            this._baseMc.gotoAndStop(this._LABEL_STOP);
            this.setButtonEnable(true);
            return;
        }// end function

        public function setStudent(param1:int) : void
        {
            if (param1 == Constant.EMPTY_ID)
            {
                if (this._isoLabelStudent.bOpened)
                {
                    this._isoLabelStudent.setOut();
                }
                if (this._isoInitiateArrow.bOpened)
                {
                    this._isoInitiateArrow.setOut();
                }
                this._effectStudent.visible = false;
            }
            else
            {
                if (this._isoLabelStudent.bClosed)
                {
                    this._isoLabelStudent.setIn();
                }
                if (this._isoInitiateArrow.bClosed)
                {
                    this._isoInitiateArrow.setIn();
                }
                this._effectStudent.visible = true;
            }
            var _loc_2:* = this._aCharaView[this._INDEX_STUDENT] as SICharacterView;
            _loc_2.setFromUniqueId(param1);
            _loc_2.playerDisplay.pos = _loc_2.getCharaPosition();
            _loc_2.playerDisplay.setAnimation(PlayerDisplay.LABEL_FRONT_STOP);
            return;
        }// end function

        public function setTeacher(param1:int) : void
        {
            if (param1 == Constant.EMPTY_ID)
            {
                if (this._isoLabelTeacher.bOpened)
                {
                    this._isoLabelTeacher.setOut();
                }
                this._effectTeacher.visible = false;
            }
            else
            {
                if (this._isoLabelTeacher.bClosed)
                {
                    this._isoLabelTeacher.setIn();
                }
                this._effectTeacher.visible = true;
            }
            var _loc_2:* = this._aCharaView[this._INDEX_TEACHER] as SICharacterView;
            _loc_2.setFromUniqueId(param1);
            _loc_2.playerDisplay.pos = _loc_2.getCharaPosition();
            _loc_2.playerDisplay.setAnimation(PlayerDisplay.LABEL_FRONT_STOP);
            return;
        }// end function

        public function addSupporter(param1:int) : void
        {
            var _loc_2:* = this._aCharaView[(this._INDEX_TEACHER + 1) + this._aSupporter.length] as SICharacterView;
            _loc_2.setFromUniqueId(param1);
            _loc_2.playerDisplay.pos = _loc_2.getCharaPosition();
            _loc_2.playerDisplay.setAnimation(PlayerDisplay.LABEL_FRONT_STOP);
            this._aSupporter.push(param1);
            this.updateSupporter();
            return;
        }// end function

        public function removeSupporter(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (this._aSupporter.indexOf(param1) != -1)
            {
                this._aSupporter.splice(this._aSupporter.indexOf(param1), 1);
                for each (_loc_2 in this._aCharaView)
                {
                    
                    _loc_3 = this._aCharaView.indexOf(_loc_2);
                    if (_loc_3 == this._INDEX_STUDENT || _loc_3 == this._INDEX_TEACHER)
                    {
                        continue;
                    }
                    if (_loc_3 < this._aSupporter.length + this._INDEX_OTHER)
                    {
                        _loc_2.setFromUniqueId(this._aSupporter[_loc_3 - this._INDEX_OTHER]);
                        _loc_2.playerDisplay.pos = _loc_2.getCharaPosition();
                        _loc_2.playerDisplay.setAnimation(PlayerDisplay.LABEL_FRONT_STOP);
                        continue;
                    }
                    _loc_2.setFromUniqueId(Constant.EMPTY_ID);
                }
            }
            this.updateSupporter();
            return;
        }// end function

        public function resetSupporter() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            for each (_loc_1 in this._aCharaView)
            {
                
                _loc_2 = this._aCharaView.indexOf(_loc_1);
                if (_loc_2 == this._INDEX_STUDENT || _loc_2 == this._INDEX_TEACHER)
                {
                    continue;
                }
                _loc_3 = this._baseMc.getChildByName("charaNull" + (_loc_2 + 1)) as MovieClip;
                this._aCharaView[_loc_2].setFromUniqueId(Constant.EMPTY_ID);
            }
            this._aSupporter = [];
            this.updateSupporter();
            return;
        }// end function

        public function setSkillId(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1 == Constant.EMPTY_ID)
            {
                if (this._isoTeacherSkillBalloon.bOpened)
                {
                    this._isoTeacherSkillBalloon.setOut();
                }
            }
            else if (this._isoTeacherSkillBalloon.bClosed)
            {
                this._isoTeacherSkillBalloon.setIn();
            }
            var _loc_2:* = this._aCharaView[this._INDEX_STUDENT] as SICharacterView;
            if (_loc_2.playerDisplay.uniqueId != Constant.UNDECIDED)
            {
                _loc_3 = UserDataManager.getInstance().userData.getPlayerPersonal(_loc_2.playerDisplay.uniqueId);
                _loc_4 = _loc_3.getOwnSkillData(param1);
                if (_loc_4)
                {
                    TextControl.setText(this._studentSkillParamMc.numText1Mc.textDt, _loc_4.powerTotal.toString());
                    TextControl.setText(this._studentSkillParamMc.numText2Mc.textDt, TextControl.createHitValText(_loc_4.hitTotal));
                    TextControl.setText(this._studentSkillParamMc.numText3Mc.textDt, _loc_4.spTotal.toString());
                    if (this._isoStudentSkillBalloon.bClosed)
                    {
                        this._isoStudentSkillBalloon.setIn();
                    }
                }
                else if (this._isoStudentSkillBalloon.bOpened)
                {
                    this._isoStudentSkillBalloon.setOut();
                }
            }
            else if (this._isoStudentSkillBalloon.bOpened)
            {
                this._isoStudentSkillBalloon.setOut();
            }
            return;
        }// end function

        public function setInitiateSkillPanel(param1:OwnSkillData = null) : void
        {
            if (param1)
            {
                TextControl.setText(this._teacherSkillParamMc.numText1Mc.textDt, param1.powerTotal.toString());
                TextControl.setText(this._teacherSkillParamMc.numText2Mc.textDt, TextControl.createHitValText(param1.hitTotal));
                TextControl.setText(this._teacherSkillParamMc.numText3Mc.textDt, param1.spTotal.toString());
                if (this._isoTeacherSkillParam.bClosed)
                {
                    this._isoTeacherSkillParam.setIn();
                }
            }
            else if (this._isoTeacherSkillParam.bOpened)
            {
                this._isoTeacherSkillParam.setOut();
            }
            return;
        }// end function

        private function updateSupporter() : void
        {
            if (this._aSupporter.length == 0)
            {
                if (this._isoLabelSupporter.bOpened)
                {
                    this._isoLabelSupporter.setOut();
                }
                if (this._isoEffectSupporter.bOpened)
                {
                    this._isoEffectSupporter.setOut();
                }
            }
            else
            {
                if (this._isoLabelSupporter.bClosed)
                {
                    this._isoLabelSupporter.setIn();
                }
                if (this._isoEffectSupporter.bClosed)
                {
                    this._isoEffectSupporter.setIn();
                }
                this._effectSupporter.SelectBg.gotoAndStop(this._aSupporter.length);
            }
            return;
        }// end function

        private function phaseWait() : void
        {
            this._baseMc.gotoAndPlay("stop");
            return;
        }// end function

        private function controlWait(param1:Number) : void
        {
            return;
        }// end function

        private function phaseInit() : void
        {
            this._bEnd = false;
            this._effectStudent.visible = false;
            this._effectTeacher.visible = false;
            if (this._isoEffectSupporter.bOpened)
            {
                this._isoEffectSupporter.setOut();
            }
            if (this._isoInitiateArrow.bOpened)
            {
                this._isoInitiateArrow.setOut();
            }
            if (this._isoLabelStudent.bOpened)
            {
                this._isoLabelStudent.setOut();
            }
            if (this._isoLabelSupporter.bOpened)
            {
                this._isoLabelSupporter.setOut();
            }
            if (this._isoLabelTeacher.bOpened)
            {
                this._isoLabelTeacher.setOut();
            }
            if (this._isoStudentSkillBalloon.bOpened)
            {
                this._isoStudentSkillBalloon.setOut();
            }
            if (this._isoTeacherSkillBalloon.bOpened)
            {
                this._isoTeacherSkillBalloon.setOut();
            }
            return;
        }// end function

        private function controlInit(param1:Number) : void
        {
            if (this._isoEffectSupporter.bClosed && this._isoInitiateArrow.bClosed && this._isoLabelStudent.bClosed && this._isoLabelSupporter.bClosed && this._isoLabelTeacher.bClosed)
            {
                this.setPhase(this._PHASE_START);
            }
            return;
        }// end function

        private function phaseStart() : void
        {
            var _loc_1:* = null;
            this._baseMc.gotoAndPlay(this._LABEL_START1);
            for each (_loc_1 in this._aCharaView)
            {
                
                _loc_1.mc.visible = false;
            }
            this._bJump = false;
            return;
        }// end function

        private function controlStart(param1:Number) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_5:* = null;
            if (this._bJump)
            {
                _loc_4 = true;
                _loc_2 = this._INDEX_OTHER;
                while (_loc_2 < this._aCharaView.length)
                {
                    
                    _loc_3 = this._aCharaView[_loc_2];
                    if (_loc_3.playerDisplay.bMoveing)
                    {
                        _loc_4 = false;
                        break;
                    }
                    _loc_2++;
                }
                if (_loc_4)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_LANDING1016B);
                    this._bJump = false;
                }
            }
            switch(this._baseMc.currentFrameLabel)
            {
                case this._LABEL_CAPTIONSTART:
                {
                    this._baseMc.captionStartMc.gotoAndPlay("start");
                    DisplayUtils.setTopPriority(this._baseMc, this._baseMc.captionStartMc);
                    SoundManager.getInstance().playSe(SoundId.SE_REV_DOUJYOU_TITLE);
                    break;
                }
                case this._LABEL_CROUCHSTOP_OTHERS:
                {
                    _loc_2 = this._INDEX_OTHER;
                    while (_loc_2 < this._aCharaView.length)
                    {
                        
                        _loc_3 = this._aCharaView[_loc_2];
                        _loc_3.playerDisplay.setAnimCrouch();
                        _loc_2++;
                    }
                    break;
                }
                case this._LABEL_GUARD_NULL1:
                {
                    _loc_3 = this._aCharaView[this._INDEX_STUDENT];
                    _loc_3.playerDisplay.setAnimSelectedGuard();
                    break;
                }
                case this._LABEL_JUMP_OTHERS:
                {
                    this._bJump = false;
                    _loc_2 = this._INDEX_OTHER;
                    while (_loc_2 < this._aCharaView.length)
                    {
                        
                        _loc_3 = this._aCharaView[_loc_2];
                        _loc_5 = this._baseMc.getChildByName("landingNull" + (_loc_2 + 1)) as MovieClip;
                        _loc_3.playerDisplay.setTargetJump(new Point(_loc_5.x, _loc_5.y));
                        if (_loc_3.playerDisplay.uniqueId != Constant.UNDECIDED)
                        {
                            if (!this._bJump)
                            {
                                SoundManager.getInstance().playSe(SoundId.SE_JUMP1);
                            }
                            this._bJump = true;
                        }
                        _loc_2++;
                    }
                    break;
                }
                case this._LABEL_SIDEWARK_NULL1:
                {
                    _loc_3 = this._aCharaView[this._INDEX_STUDENT];
                    _loc_3.playerDisplay.setAnimation(PlayerDisplay.LABEL_SIDE_WALK);
                    break;
                }
                case this._LABEL_SIDEWARK_NULL2:
                {
                    _loc_3 = this._aCharaView[this._INDEX_TEACHER];
                    _loc_3.playerDisplay.setAnimation(PlayerDisplay.LABEL_SIDE_WALK);
                    break;
                }
                case this._LABEL_SIDESTOP_OTHERS:
                {
                    _loc_2 = this._INDEX_OTHER;
                    while (_loc_2 < this._aCharaView.length)
                    {
                        
                        _loc_3 = this._aCharaView[_loc_2];
                        _loc_3.playerDisplay.setAnimation(PlayerDisplay.LABEL_SIDE_STOP);
                        _loc_2++;
                    }
                    break;
                }
                case this._LABEL_SIDESTOP_NULL2:
                {
                    _loc_3 = this._aCharaView[this._INDEX_TEACHER];
                    _loc_3.playerDisplay.setAnimation(PlayerDisplay.LABEL_SIDE_STOP);
                    break;
                }
                case this._LABEL_GUARD_NULL2:
                {
                    _loc_3 = this._aCharaView[this._INDEX_TEACHER];
                    _loc_3.playerDisplay.setAnimSelectedGuard();
                    break;
                }
                case this._LABEL_EFFCLASH1:
                {
                    this._baseMc.effClash1Mc.gotoAndPlay("start");
                    DisplayUtils.setTopPriority(this._baseMc, this._baseMc.effClash1Mc);
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK);
                    break;
                }
                case this._LABEL_INITIATIONSTART:
                {
                    _loc_3 = this._aCharaView[this._INDEX_STUDENT];
                    _loc_3 = this._aCharaView[this._INDEX_TEACHER];
                    this.setPhase(this._PHASE_INITIATE);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function phaseInitiate() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._aEffect = [];
            var _loc_1:* = false;
            var _loc_2:* = this._INDEX_OTHER;
            while (_loc_2 < this._aCharaView.length)
            {
                
                _loc_3 = this._aCharaView[_loc_2];
                if (_loc_3.playerDisplay.uniqueId == Constant.UNDECIDED)
                {
                }
                else
                {
                    _loc_4 = new EffectMc(this._baseMc, ResourcePath.FACILITY_PATH + "UI_SkillInitiate.swf", "initiationEffAnmMc", _loc_3.playerDisplay.pos);
                    this._effectManager.addEffect(_loc_4);
                    this._aEffect.push(_loc_4);
                    _loc_1 = true;
                }
                _loc_2++;
            }
            if (_loc_1)
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_DOUJYOU_AURA);
            }
            return;
        }// end function

        private function controlInitiate(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aEffect.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aEffect[_loc_2];
                if (_loc_3.isEnd())
                {
                    this._aEffect.splice(_loc_2, 1);
                }
                else if (_loc_3.mcEffect.currentFrameLabel == "charaNullOff")
                {
                    this._aCharaView[_loc_2 + this._INDEX_OTHER].playerDisplay.mc.visible = false;
                }
                _loc_2 = _loc_2 - 1;
            }
            if (this._aEffect.length == 0)
            {
                this.setPhase(this._PHASE_FINISH);
            }
            return;
        }// end function

        private function phaseFinish() : void
        {
            this._baseMc.play();
            return;
        }// end function

        private function controlFinish(param1:Number) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            this._effectManager.control(param1);
            switch(this._baseMc.currentFrameLabel)
            {
                case this._LABEL_EFFPOWERUP:
                {
                    this._baseMc.effPowerUpMc.gotoAndPlay("start");
                    DisplayUtils.setTopPriority(this._baseMc, this._baseMc.effPowerUpMc);
                    break;
                }
                case "SE_REV_DOUJYOU_AURA":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_DOUJYOU_AURA);
                    break;
                }
                case this._LABEL_AURAEFF:
                {
                    _loc_4 = this._baseMc.getChildIndex(this._baseMc.auraEff);
                    _loc_3 = this._aCharaView[this._INDEX_TEACHER];
                    this._baseMc.setChildIndex(_loc_3.playerDisplay.layer, (_loc_4 - 1));
                    break;
                }
                case this._LABEL_EFFCLASH2:
                {
                    this._baseMc.effClash2Mc.gotoAndPlay("start");
                    DisplayUtils.setTopPriority(this._baseMc, this._baseMc.effClash2Mc);
                    SoundManager.getInstance().playSe(SoundId.SE_REV_DOUJYOU_HIT_2ND);
                    break;
                }
                case this._LABEL_SIDESTOP_NULL2:
                {
                    _loc_3 = this._aCharaView[this._INDEX_TEACHER];
                    break;
                }
                case this._LABEL_SIDESTOP_NULL1:
                {
                    _loc_3 = this._aCharaView[this._INDEX_STUDENT];
                    _loc_3.playerDisplay.setAnimation(PlayerDisplay.LABEL_SIDE_STOP);
                    break;
                }
                case "crouchStop_null2":
                {
                    _loc_3 = this._aCharaView[this._INDEX_TEACHER];
                    _loc_3.playerDisplay.setAnimCrouch();
                    break;
                }
                case "dead_null2":
                {
                    _loc_3 = this._aCharaView[this._INDEX_TEACHER];
                    _loc_3.playerDisplay.setAnimDead();
                    SoundManager.getInstance().playSe(SoundId.SE_REV_DOUJYOU_FALL);
                    break;
                }
                case "SE_REV_DOUJYOU_RISE":
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_DOUJYOU_RISE);
                    break;
                }
                case "winSword_null1":
                {
                    if (this._bSuccess)
                    {
                        this.setPhase(this._PHASE_SUCCESS_1);
                    }
                    this._baseMc.play();
                    break;
                }
                case this._LABEL_LOST_END:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._baseMc.currentFrameLabel == this._LABEL_LOST_END)
            {
                this._bEnd = true;
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseSuccess1() : void
        {
            DisplayUtils.setTopPriority(this._baseMc, this._baseMc.successEffMc);
            this._baseMc.successEffMc.gotoAndPlay("start");
            SoundManager.getInstance().playSe(SoundId.SE_REV_DOUJYOU_DWELL);
            return;
        }// end function

        private function controlSuccess1(param1:Number) : void
        {
            if (this._baseMc.successEffMc.currentLabel == "_end")
            {
                this.setPhase(this._PHASE_SUCCESS_2);
            }
            return;
        }// end function

        private function phaseSuccess2() : void
        {
            var _loc_1:* = this._aCharaView[this._INDEX_STUDENT];
            _loc_1.playerDisplay.setAnimWin();
            SoundManager.getInstance().playSe(SoundId.SE_REV_INN_SPIN);
            return;
        }// end function

        private function controlSuccess2(param1:Number) : void
        {
            var _loc_2:* = this._aCharaView[this._INDEX_STUDENT];
            if (_loc_2.playerDisplay.bAnimationEnd)
            {
                this.setPhase(this._PHASE_SUCCESS_3);
            }
            return;
        }// end function

        private function phaseSuccess3() : void
        {
            DisplayUtils.setTopPriority(this._baseMc, this._baseMc.kiraAnmSet2Mc);
            this._baseMc.kiraAnmSet2Mc.gotoAndPlay("start");
            SoundManager.getInstance().playSe(SoundId.SE_REV_DOUJYOU_SUCCESS);
            return;
        }// end function

        private function controlSuccess3(param1:Number) : void
        {
            if (this._baseMc.kiraAnmSet2Mc.currentLabel == "end")
            {
                this._bEnd = true;
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function cbInitiateSuccess() : void
        {
            this._bEnd = true;
            this.setPhase(this._PHASE_WAIT);
            return;
        }// end function

        private function cbMove(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            if (!this._bButtonEnable)
            {
                return;
            }
            var _loc_2:* = Constant.UNDECIDED;
            for each (_loc_3 in this._aCharaView)
            {
                
                if (_loc_3.playerDisplay.isHitTest2())
                {
                    _loc_2 = _loc_3.playerDisplay.uniqueId;
                }
            }
            if (_loc_2 != this._overSelectedId)
            {
                this._overSelectedId = _loc_2;
                if (this._overSelectedId != Constant.UNDECIDED)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_BED);
                    for each (_loc_3 in this._aCharaView)
                    {
                        
                        if (this._overSelectedId == _loc_3.playerDisplay.uniqueId)
                        {
                            _loc_3.playerDisplay.setSelect(true);
                            continue;
                        }
                        if (this._selectedId != _loc_3.playerDisplay.uniqueId)
                        {
                            _loc_3.playerDisplay.setSelect(false);
                        }
                    }
                }
                else
                {
                    for each (_loc_3 in this._aCharaView)
                    {
                        
                        if (this._selectedId != _loc_3.playerDisplay.uniqueId)
                        {
                            _loc_3.playerDisplay.setSelect(false);
                        }
                    }
                }
            }
            return;
        }// end function

        private function cbClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (!this._bButtonEnable)
            {
                return;
            }
            if (this._releaseId != Constant.EMPTY_ID && this._releaseButton.isHit(event.stageX, event.stageY))
            {
                return;
            }
            this._releaseButton.setId(this._overSelectedId);
            this._selectedId = this._overSelectedId;
            if (this._selectedId == Constant.UNDECIDED || this._selectedId == Constant.EMPTY_ID)
            {
                if (this._releaseButton.getMoveClip().visible == true)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_CANCEL);
                }
                this._releaseButton.getMoveClip().visible = false;
                this._releaseButton.setDisable(true);
                for each (_loc_2 in this._aCharaView)
                {
                    
                    _loc_2.playerDisplay.setSelect(false);
                }
            }
            else
            {
                for each (_loc_2 in this._aCharaView)
                {
                    
                    if (this._selectedId == _loc_2.playerDisplay.uniqueId)
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_CHARA_SELECT);
                        this._releaseButton.getMoveClip().visible = true;
                        this._releaseButton.setDisable(false);
                        this._releaseButton.getMoveClip().x = _loc_2.getPosition().x + 10;
                        this._releaseButton.getMoveClip().y = _loc_2.getPosition().y - 80;
                        _loc_2.playerDisplay.setSelect(true);
                        continue;
                    }
                    _loc_2.playerDisplay.setSelect(false);
                }
            }
            return;
        }// end function

        private function createCharaView() : void
        {
            var _loc_2:* = null;
            this._aCharaView = [];
            var _loc_1:* = 0;
            while (_loc_1 < this._MAX_CHARA_NUM)
            {
                
                _loc_2 = new SICharacterView(this._baseMc);
                _loc_2.setPositionFromMc(this._baseMc.getChildByName("charaNull" + (_loc_1 + 1)) as MovieClip);
                this._aCharaView.push(_loc_2);
                _loc_2.setAnimationMc(this._baseMc.getChildByName("charaNull" + (_loc_1 + 1)) as MovieClip);
                _loc_1++;
            }
            return;
        }// end function

        public function get releaseId() : int
        {
            return this._releaseId;
        }// end function

        public function resetReleaseId() : void
        {
            this._releaseId = Constant.EMPTY_ID;
            this._releaseButton.getMoveClip().visible = false;
            return;
        }// end function

        private function cbReleaseCharacter(param1:int) : void
        {
            this._releaseButton.getMoveClip().y = -50;
            this._releaseButton.getMoveClip().visible = false;
            this._releaseButton.setDisable(true);
            this._releaseId = param1;
            return;
        }// end function

    }
}
