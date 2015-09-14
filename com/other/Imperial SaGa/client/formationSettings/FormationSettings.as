package formationSettings
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import formation.*;
    import input.*;
    import layer.*;
    import message.*;
    import player.*;
    import playerList.*;
    import resource.*;
    import sound.*;
    import status.*;
    import user.*;
    import utility.*;

    public class FormationSettings extends Object
    {
        private var _formationSelecter:FormationSelecter;
        private var _formationPlacement:FormationData;
        private var _formationDescription:FormationDescription;
        private var _commanderSelecter:FormationCommanderSelecter;
        private var _layer:LayerFormationSettings;
        private var _aFormationPost:Array;
        private var _selectedPlayer:FormationPlayerDisplay;
        private var _aPlayerPersonalPtr:Array;
        private var _cbFormationChangedFunc:Function;
        private var _cbFormationPositionSelectedFunc:Function;
        private var _cbFormationPlayerOverFunc:Function;
        private var _cbFormationPlayerOutFunc:Function;
        private var _cbFormationPositionChangedFunc:Function;
        private var _mouseOverPlayerFormationIndex:int;
        private var _mouseDownPlayerFormationIndex:int;
        private var _selectedPlayerFormationIndex:int;
        private var _bPlayerSelectEnable:Boolean;
        private var _bReserveSelect:Boolean;
        private var _statusInvisibleFlag:int;
        private var _bJumping:Boolean;
        private var _bNextJumpWait:Boolean;
        private var _jumpFormationId:int;
        private var _bFormationNotBe:Boolean;

        public function FormationSettings(param1:MovieClip, param2:MovieClip, param3:MovieClip, param4:MovieClip, param5:MovieClip, param6:int, param7:Array, param8:Array, param9:Boolean = false, param10:String = null, param11:Boolean = false, param12:Boolean = false)
        {
            var _loc_13:* = null;
            var _loc_16:* = null;
            this._aPlayerPersonalPtr = param7;
            this._formationSelecter = new FormationSelecter(param1, UserDataManager.getInstance().userData.aFormationData, param6, 0, this.cbFormationChange, param10);
            this._formationPlacement = new FormationData(param2, param6);
            this._formationDescription = new FormationDescription(param3, param4);
            this._commanderSelecter = new FormationCommanderSelecter(param5, param11);
            this._layer = new LayerFormationSettings();
            this._formationPlacement.formationMc.addChildAt(this._layer, 0);
            this._cbFormationChangedFunc = null;
            this._cbFormationPositionSelectedFunc = null;
            this._cbFormationPlayerOverFunc = null;
            this._cbFormationPlayerOutFunc = null;
            this._cbFormationPositionChangedFunc = null;
            this._mouseOverPlayerFormationIndex = Constant.UNDECIDED;
            this._mouseDownPlayerFormationIndex = Constant.UNDECIDED;
            this._selectedPlayerFormationIndex = Constant.UNDECIDED;
            this._statusInvisibleFlag = PlayerMiniStatus.INVISIBLE_FLAG_ALL;
            this._aFormationPost = [];
            var _loc_14:* = this._formationPlacement.aCharaMc;
            var _loc_15:* = 0;
            for each (_loc_16 in _loc_14)
            {
                
                _loc_13 = this.createFormationPostData(param8[_loc_15], this._layer, param1.parent, _loc_15, param6, param9);
                this._aFormationPost.push(_loc_13);
                _loc_15++;
            }
            _loc_13 = this.createFormationPostData(param8[FormationSetData.FORMATION_INDEX_COMMANDER], this._commanderSelecter.layer, this._commanderSelecter.mc, _loc_15, param6, param9);
            this._aFormationPost.push(_loc_13);
            _loc_15++;
            this._selectedPlayer = null;
            this._bPlayerSelectEnable = true;
            this._bReserveSelect = false;
            this._bJumping = false;
            this._bNextJumpWait = false;
            this._jumpFormationId = param6;
            this._bFormationNotBe = param12;
            InputManager.getInstance().addMouseCallback(this, this.cbMouseMove, this.cbMouseClick, this.cbMouseUp, this.cbMouseDown);
            this.updateFormation();
            this.cbFormationChange(param6, true);
            return;
        }// end function

        public function get selectedFormationId() : int
        {
            return this._formationPlacement.formationId;
        }// end function

        public function get selectedFormationMemberMax() : int
        {
            var _loc_1:* = FormationManager.getInstance().getFormationInformation(this._formationPlacement.formationId);
            return _loc_1 ? (_loc_1.member) : (0);
        }// end function

        public function set cbFormationChangedFunc(param1:Function) : void
        {
            this._cbFormationChangedFunc = param1;
            return;
        }// end function

        public function set cbFormationPositionSelectedFunc(param1:Function) : void
        {
            this._cbFormationPositionSelectedFunc = param1;
            return;
        }// end function

        public function set cbFormationPlayerOverFunc(param1:Function) : void
        {
            this._cbFormationPlayerOverFunc = param1;
            return;
        }// end function

        public function set cbFormationPlayerOutFunc(param1:Function) : void
        {
            this._cbFormationPlayerOutFunc = param1;
            return;
        }// end function

        public function set cbFormationPositionChangedFunc(param1:Function) : void
        {
            this._cbFormationPositionChangedFunc = param1;
            return;
        }// end function

        public function get selectedFormationIndex() : int
        {
            return this._selectedPlayerFormationIndex;
        }// end function

        public function get aFormationPlayerUniqueId() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aFormationPost)
            {
                
                _loc_1.push(_loc_2.uniqueId);
            }
            return _loc_1;
        }// end function

        public function setFormationPlayerUniqueId(param1:int, param2:int) : void
        {
            var _loc_3:* = this._aFormationPost[param1] as FormationPostData;
            _loc_3.uniqueId = param2;
            _loc_3.tmpUniqueId = param2;
            _loc_3.jumpUniqueId = param2;
            return;
        }// end function

        public function get bReserveSelect() : Boolean
        {
            return this._bReserveSelect;
        }// end function

        public function isJumping() : Boolean
        {
            return this._bJumping;
        }// end function

        public function set bFormationNotBe(param1:Boolean) : void
        {
            this._bFormationNotBe = param1;
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aFormationPost)
            {
                
                _loc_1.release();
            }
            this._aFormationPost = null;
            if (this._formationSelecter)
            {
                this._formationSelecter.release();
            }
            this._formationSelecter = null;
            if (this._formationPlacement)
            {
                this._formationPlacement.release();
            }
            this._formationPlacement = null;
            if (this._formationDescription)
            {
                this._formationDescription.release();
            }
            this._formationDescription = null;
            if (this._commanderSelecter)
            {
                this._commanderSelecter.release();
            }
            this._commanderSelecter = null;
            if (this._layer)
            {
                this._layer.release();
            }
            this._layer = null;
            InputManager.getInstance().delMouseCallback(this);
            return;
        }// end function

        private function createFormationPostData(param1:int, param2:LayerFormationSettings, param3:DisplayObjectContainer, param4:int, param5:int, param6:Boolean) : FormationPostData
        {
            var _loc_13:* = null;
            var _loc_7:* = new FormationPlayerDisplay(param2, param4, param5);
            new FormationPlayerDisplay(param2, param4, param5).playerActionController.setFrontMember(true, param6);
            _loc_7.status.setInvisible(this._statusInvisibleFlag);
            var _loc_8:* = new MovieClip();
            new MovieClip().transform = _loc_7.status.charaNull.transform;
            param3.addChild(_loc_8);
            var _loc_9:* = new PlayerDisplay(_loc_8, Constant.EMPTY_ID, Constant.EMPTY_ID);
            new PlayerDisplay(_loc_8, Constant.EMPTY_ID, Constant.EMPTY_ID).mc.parent.visible = false;
            if (param4 < FormationSetData.FORMATION_INDEX_COMMANDER)
            {
                if (this._formationPlacement)
                {
                    _loc_13 = this._formationPlacement.aCharaMc[param4];
                    _loc_7.setPosition(_loc_13.x, _loc_13.y);
                }
            }
            var _loc_10:* = _loc_7.status.getPositionToGlobal();
            var _loc_11:* = _loc_9.layer.parent.globalToLocal(_loc_10);
            _loc_9.pos = _loc_11;
            var _loc_12:* = new FormationPostData();
            new FormationPostData().frontPlayer = _loc_7;
            _loc_12.jumpPlayer = _loc_9;
            _loc_12.uniqueId = param1;
            _loc_12.tmpUniqueId = Constant.EMPTY_ID;
            _loc_12.jumpPos = _loc_10;
            _loc_12.jumpUniqueId = Constant.EMPTY_ID;
            _loc_12.bJump = false;
            return _loc_12;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this._formationSelecter)
            {
                this._formationSelecter.control(param1);
            }
            for each (_loc_2 in this._aFormationPost)
            {
                
                _loc_2.frontPlayer.statusUpDownIcon.control(param1);
            }
            this.controlJumping(param1);
            return;
        }// end function

        private function controlJumping(param1:Number) : void
        {
            var post:FormationPostData;
            var bLanding:Boolean;
            var bJump:Boolean;
            var i:int;
            var p:FormationPostData;
            var startPos:Point;
            var targetPos:Point;
            var t:* = param1;
            if (this._bJumping)
            {
                var _loc_3:* = 0;
                var _loc_4:* = this._aFormationPost;
                while (_loc_4 in _loc_3)
                {
                    
                    post = _loc_4[_loc_3];
                    post.jumpPlayer.control(t);
                }
                if (this._aFormationPost.some(function (param1:FormationPostData, param2:int, param3:Array) : Boolean
            {
                return param1.jumpPlayer.bMoveing;
            }// end function
            ) == false)
                {
                    this._bJumping = false;
                    if (this._bNextJumpWait)
                    {
                        this._aFormationPost.forEach(function (param1:FormationPostData, param2:int, param3:Array) : void
            {
                param1.jumpPos = param1.jumpPlayer.layer.localToGlobal(new Point());
                return;
            }// end function
            );
                        this._aFormationPost.forEach(function (param1:FormationPostData, param2:int, param3:Array) : void
            {
                var _loc_4:* = null;
                if (param1.uniqueId != param1.jumpUniqueId)
                {
                    if (param1.uniqueId == Constant.EMPTY_ID)
                    {
                        _loc_4 = getFormationPost(param1.jumpUniqueId);
                        if (_loc_4)
                        {
                            _loc_4.jumpPos = param1.jumpPos;
                        }
                    }
                }
                return;
            }// end function
            );
                    }
                    else
                    {
                        bLanding;
                        this._aFormationPost.forEach(function (param1:FormationPostData, param2:int, param3:Array) : void
            {
                if (param1.bJump)
                {
                    jumpEnd(param1);
                    bLanding = true;
                }
                return;
            }// end function
            );
                        if (bLanding)
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_LANDING1016B);
                        }
                        this.onMouseMove(InputManager.getInstance().corsor);
                    }
                }
            }
            if (this._bNextJumpWait && !this._bJumping)
            {
                bJump;
                i;
                while (i < this._aFormationPost.length)
                {
                    
                    p = this._aFormationPost[i];
                    p.frontPlayer.status.hide();
                    p.frontPlayer.playerDisplay.mc.parent.visible = false;
                    p.jumpUniqueId = Constant.EMPTY_ID;
                    p.jumpPlayer.mc.parent.visible = false;
                    if (p.frontPlayer.playerPersonal == null)
                    {
                    }
                    else if (p.frontPlayer.playerActionController.state == ListPlayerActionController.STATE_DEAD || p.frontPlayer.playerActionController.state == ListPlayerActionController.STATE_RESTING)
                    {
                        this.jumpEnd(p);
                    }
                    else
                    {
                        startPos = p.jumpPlayer.layer.parent.globalToLocal(p.jumpPos);
                        targetPos = p.jumpPlayer.layer.parent.globalToLocal(p.frontPlayer.status.getPositionToGlobal());
                        if (Math.floor(startPos.x) == Math.floor(targetPos.x) && Math.floor(startPos.y) == Math.floor(targetPos.y) && (this._jumpFormationId == this._formationPlacement.formationId || i == FormationSetData.FORMATION_INDEX_COMMANDER))
                        {
                            this.jumpEnd(p);
                        }
                        else
                        {
                            p.jumpPlayer.setId(p.frontPlayer.playerPersonal.playerId, p.frontPlayer.playerPersonal.uniqueId);
                            p.jumpPlayer.pos = startPos;
                            p.jumpPlayer.setTargetJump(targetPos);
                            p.jumpPlayer.mc.parent.visible = true;
                            p.jumpUniqueId = p.uniqueId;
                            p.bJump = true;
                            bJump;
                        }
                    }
                    i = (i + 1);
                }
                if (bJump)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_JUMP2);
                }
                this._bJumping = true;
                this._bNextJumpWait = false;
                this._jumpFormationId = this._formationPlacement.formationId;
            }
            return;
        }// end function

        private function jumpEnd(param1:FormationPostData) : void
        {
            param1.jumpPlayer.mc.parent.visible = false;
            param1.bJump = false;
            param1.frontPlayer.playerActionController.resetAction();
            param1.frontPlayer.status.show();
            param1.frontPlayer.playerDisplay.mc.parent.visible = true;
            return;
        }// end function

        public function isEmptyFormation() : Boolean
        {
            var _loc_2:* = null;
            var _loc_1:* = FormationSetData.FORMATION_INDEX_POSITION_1;
            while (_loc_1 <= FormationSetData.FORMATION_INDEX_POSITION_5)
            {
                
                _loc_2 = this._aFormationPost[_loc_1];
                if (_loc_2.frontPlayer.playerPersonal)
                {
                    return false;
                }
                _loc_1++;
            }
            return true;
        }// end function

        private function isUseFacility() : Boolean
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aFormationPost)
            {
                
                if (_loc_1.frontPlayer.playerPersonal && _loc_1.frontPlayer.playerPersonal.isUseFacility())
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function getFormationPosition(param1:int) : Point
        {
            if (param1 == FormationSetData.FORMATION_INDEX_COMMANDER)
            {
                return this._commanderSelecter.getCommanderPosition();
            }
            return this._formationPlacement.getPosition(param1);
        }// end function

        public function getFormationPlayerCenterPosition(param1:int) : Point
        {
            var _loc_2:* = this.getFormationPosition(param1);
            var _loc_3:* = (this._aFormationPost[param1] as FormationPostData).frontPlayer.playerDisplay;
            if (_loc_3.mc)
            {
                _loc_2 = _loc_2.add(new Point(_loc_3.effectNull.x, _loc_3.effectNull.y));
            }
            return _loc_2;
        }// end function

        public function getPersonalAtFormationIndex(param1:int) : PlayerPersonal
        {
            return (this._aFormationPost[param1] as FormationPostData).frontPlayer.playerPersonal;
        }// end function

        public function setStatusInvisibleFlag(param1:int) : void
        {
            var _loc_2:* = null;
            this._statusInvisibleFlag = param1;
            for each (_loc_2 in this._aFormationPost)
            {
                
                _loc_2.frontPlayer.status.setInvisible(this._statusInvisibleFlag);
            }
            return;
        }// end function

        public function resetJumpPosition() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_1 in this._aFormationPost)
            {
                
                _loc_2 = _loc_1.frontPlayer.status.getPositionToGlobal();
                _loc_3 = _loc_1.jumpPlayer.layer.parent.globalToLocal(_loc_2);
                _loc_1.jumpPlayer.pos = _loc_3;
                _loc_1.jumpPos = _loc_2;
            }
            return;
        }// end function

        public function setPlayerList(param1:Array) : void
        {
            this._aPlayerPersonalPtr = param1;
            return;
        }// end function

        public function selectFormation(param1:int) : void
        {
            this._formationSelecter.selectFormation(param1);
            this.cbFormationChange(param1, true);
            this.updateFormation(true);
            return;
        }// end function

        public function unselectPlayer() : void
        {
            if (this._selectedPlayer)
            {
                if (this._selectedPlayer.playerActionController.bMouseOverAction)
                {
                    this._selectedPlayer.playerActionController.resetAction();
                }
                this._selectedPlayer.playerDisplay.setSelect(false);
                if (this._cbFormationPositionSelectedFunc != null)
                {
                    this._cbFormationPositionSelectedFunc(Constant.UNDECIDED, null);
                }
                this._selectedPlayer.formationMark.mouseOff();
            }
            this._selectedPlayerFormationIndex = Constant.UNDECIDED;
            this._selectedPlayer = null;
            return;
        }// end function

        public function setSelectEnable(param1:Boolean) : void
        {
            this._bPlayerSelectEnable = param1;
            this._formationSelecter.setDisableFlag(!param1);
            return;
        }// end function

        public function setPlayerSelectEnable(param1:Boolean) : void
        {
            this._bPlayerSelectEnable = param1;
            this._formationSelecter.setDisableFlag(param1 == false);
            return;
        }// end function

        public function setReserveSelect(param1:Boolean) : void
        {
            this._bReserveSelect = param1;
            return;
        }// end function

        public function setSelect(param1:int) : void
        {
            if (param1 == Constant.UNDECIDED)
            {
                return;
            }
            var _loc_2:* = this._aFormationPost[param1] as FormationPostData;
            _loc_2.frontPlayer.playerDisplay.setSelect(true);
            return;
        }// end function

        public function updateFormation(param1:Boolean = true) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            _loc_2 = FormationSetData.FORMATION_INDEX_POSITION_1;
            while (_loc_2 <= FormationSetData.FORMATION_INDEX_POSITION_5)
            {
                
                _loc_3 = this._aFormationPost[_loc_2];
                if (_loc_3.uniqueId != Constant.EMPTY_ID)
                {
                    _loc_5++;
                    _loc_4 = this.getPersonal(_loc_3.uniqueId);
                    if (_loc_4 && _loc_4.bDead == false)
                    {
                        _loc_6++;
                    }
                }
                _loc_2++;
            }
            this._formationSelecter.setNumPlayer(_loc_5);
            var _loc_7:* = this.selectedFormationMemberMax;
            var _loc_8:* = _loc_6 >= _loc_7 && this._bFormationNotBe == false;
            _loc_2 = 0;
            while (_loc_2 < this._aFormationPost.length)
            {
                
                _loc_3 = this._aFormationPost[_loc_2] as FormationPostData;
                _loc_4 = this.getPersonal(_loc_3.uniqueId);
                if (_loc_4)
                {
                    if (_loc_3.frontPlayer.playerDisplay.uniqueId != _loc_4.uniqueId)
                    {
                        _loc_3.frontPlayer.setPlayerPersonal(_loc_4);
                    }
                    _loc_3.frontPlayer.setFormationBonusOccurrence(_loc_8 && FormationSetData.FORMATION_INDEX_POSITION_1 <= _loc_2 && _loc_2 <= FormationSetData.FORMATION_INDEX_POSITION_5);
                    _loc_3.frontPlayer.playerDisplay.setSelect(false);
                    _loc_3.frontPlayer.playerDisplay.mc.parent.visible = true;
                    _loc_3.frontPlayer.playerActionController.update();
                    if (param1)
                    {
                        _loc_3.tmpUniqueId = _loc_3.uniqueId;
                    }
                }
                else
                {
                    if (_loc_3.frontPlayer.playerDisplay.uniqueId != Constant.EMPTY_ID)
                    {
                        _loc_3.frontPlayer.setPlayerPersonal(null);
                    }
                    _loc_3.frontPlayer.setFormationBonusOccurrence(false);
                    if (param1)
                    {
                        _loc_3.tmpUniqueId = Constant.EMPTY_ID;
                    }
                }
                _loc_2++;
            }
            this._selectedPlayerFormationIndex = Constant.UNDECIDED;
            this._selectedPlayer = null;
            this.updateCommander();
            this.updateMiniStatus();
            return;
        }// end function

        private function updateCommander() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            for each (_loc_1 in this._aFormationPost)
            {
                
                if (_loc_1 && _loc_1.frontPlayer.playerPersonal)
                {
                    _loc_2++;
                }
            }
            _loc_1 = this._aFormationPost[FormationSetData.FORMATION_INDEX_COMMANDER];
            if (_loc_1 && _loc_1.frontPlayer.playerPersonal)
            {
                this._commanderSelecter.setCommander(_loc_1.frontPlayer.playerPersonal, _loc_2);
            }
            else
            {
                this._commanderSelecter.setCommander(null, 0);
            }
            return;
        }// end function

        public function updatePlayerUseFacilityStatus() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aFormationPost)
            {
                
                if (_loc_1.frontPlayer.playerPersonal == null)
                {
                    continue;
                }
                if (_loc_1.frontPlayer.playerActionController.state == ListPlayerActionController.STATE_RESTING)
                {
                    _loc_1.frontPlayer.status.updateGauge();
                }
            }
            return;
        }// end function

        public function forceCallFormationMouseOver(param1:int) : void
        {
            this.onPlayerMouseOver((this._aFormationPost[param1] as FormationPostData).frontPlayer);
            return;
        }// end function

        public function setRestEndAction(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aFormationPost)
            {
                
                if (_loc_2.frontPlayer.playerPersonal == null)
                {
                    continue;
                }
                if (_loc_2.frontPlayer.playerPersonal.uniqueId == param1)
                {
                    _loc_2.frontPlayer.playerActionController.restEndAction();
                    break;
                }
            }
            return;
        }// end function

        public function isCommanderEnable() : Boolean
        {
            return this._commanderSelecter.bCommanderEnable;
        }// end function

        private function getPersonal(param1:int) : PlayerPersonal
        {
            var _loc_2:* = null;
            if (param1 == Constant.EMPTY_ID)
            {
                return null;
            }
            for each (_loc_2 in this._aPlayerPersonalPtr)
            {
                
                if (_loc_2.uniqueId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        private function getFormationPost(param1:int) : FormationPostData
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aFormationPost)
            {
                
                if (_loc_2.uniqueId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        private function updateMark(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aFormationPost)
            {
                
                if (_loc_2.frontPlayer.formationMark)
                {
                    if (!this._bReserveSelect && this._selectedPlayerFormationIndex == Constant.UNDECIDED)
                    {
                        _loc_2.frontPlayer.formationMark.mouseOff();
                        continue;
                    }
                    if (_loc_2.frontPlayer.formationMark.index == this._selectedPlayerFormationIndex)
                    {
                        _loc_2.frontPlayer.formationMark.select();
                        continue;
                    }
                    if (_loc_2.frontPlayer.formationMark.index == param1)
                    {
                        _loc_2.frontPlayer.formationMark.mouseOn();
                        continue;
                    }
                    _loc_2.frontPlayer.formationMark.mouseOff();
                }
            }
            return;
        }// end function

        private function updateMiniStatus() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            this._commanderSelecter.setWarningEnable(false);
            this._commanderSelecter.setWarningText(MessageManager.getInstance().getMessage(MessageId.FORMATION_COMMANDER_NOT_SET));
            var _loc_3:* = FormationSetData.FORMATION_INDEX_POSITION_1;
            while (_loc_3 <= FormationSetData.FORMATION_INDEX_POSITION_5)
            {
                
                _loc_2 = this._aFormationPost[_loc_3];
                _loc_2.frontPlayer.status.clearWarning();
                if (_loc_2.frontPlayer.playerPersonal)
                {
                    _loc_2.frontPlayer.status.setPlayerPersonal(_loc_2.frontPlayer.playerPersonal);
                    if (!this._bJumping)
                    {
                        _loc_2.frontPlayer.status.show();
                    }
                    _loc_1++;
                }
                else
                {
                    _loc_2.frontPlayer.status.hide();
                }
                _loc_3++;
            }
            _loc_2 = this._aFormationPost[FormationSetData.FORMATION_INDEX_COMMANDER];
            if (_loc_2)
            {
                _loc_2.frontPlayer.status.clearWarning();
                if (_loc_2.frontPlayer.playerPersonal)
                {
                    if (_loc_1 < 5)
                    {
                        _loc_2.frontPlayer.status.setWarning(MessageManager.getInstance().getMessage(MessageId.QUEST_SELECT_WITHOUT_COMMANDER));
                        if (this._commanderSelecter.bCommanderChange)
                        {
                            this._commanderSelecter.setWarningEnable(true);
                            this._commanderSelecter.setWarningText(MessageManager.getInstance().getMessage(MessageId.FORMATION_COMMANDER_SORTIE_TERM));
                        }
                    }
                    _loc_2.frontPlayer.status.setPlayerPersonal(_loc_2.frontPlayer.playerPersonal);
                    if (!this._bJumping)
                    {
                        _loc_2.frontPlayer.status.show();
                    }
                }
                else
                {
                    _loc_2.frontPlayer.status.hide();
                    if (this._commanderSelecter.bCommanderChange)
                    {
                        this._commanderSelecter.setWarningEnable(true);
                        this._commanderSelecter.setWarningText(MessageManager.getInstance().getMessage(MessageId.FORMATION_COMMANDER_NOT_SET));
                    }
                }
            }
            return;
        }// end function

        private function onPlayerMouseOver(param1:FormationPlayerDisplay) : void
        {
            param1.bMouseOver = true;
            param1.status.subtractInvisible(PlayerMiniStatus.INVISIBLE_FLAG_NAME);
            DisplayUtils.setTopPriority(param1.status.mcBase.parent, param1.status.mcBase);
            if (param1.playerActionController.bMouseOverAction)
            {
            }
            else
            {
                param1.playerActionController.mouseOverAction();
            }
            return;
        }// end function

        public function isHit(param1:Point) : int
        {
            var _loc_2:* = Constant.UNDECIDED;
            if (this._bPlayerSelectEnable)
            {
                _loc_2 = this._formationPlacement.isHitFormationMc2(param1, Constant.UNDECIDED);
                if (_loc_2 == Constant.UNDECIDED && this._commanderSelecter.isHit(param1))
                {
                    _loc_2 = FormationSetData.FORMATION_INDEX_COMMANDER;
                }
            }
            return _loc_2;
        }// end function

        private function cbMouseMove(event:MouseEvent) : void
        {
            this.onMouseMove(new Point(event.stageX, event.stageY));
            return;
        }// end function

        private function onMouseMove(param1:Point) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = false;
            if (this._bJumping || this._bNextJumpWait)
            {
                return;
            }
            var _loc_2:* = this.isHit(param1);
            var _loc_3:* = null;
            var _loc_4:* = 0;
            for each (_loc_5 in this._aFormationPost)
            {
                
                if (_loc_5.frontPlayer.playerDisplay.uniqueId != Constant.EMPTY_ID)
                {
                    _loc_6 = _loc_5.frontPlayer.playerPersonal && _loc_4 == _loc_2;
                    if (_loc_5.frontPlayer.bMouseOver != _loc_6)
                    {
                        _loc_5.frontPlayer.bMouseOver = _loc_6;
                        _loc_5.frontPlayer.playerDisplay.setSelect(_loc_5.frontPlayer == this._selectedPlayer || _loc_6);
                        if (_loc_6)
                        {
                            this.onPlayerMouseOver(_loc_5.frontPlayer);
                            _loc_3 = _loc_5.frontPlayer.playerPersonal;
                            SoundManager.getInstance().playSe(ButtonBase.SE_SELECT_ID);
                        }
                        else
                        {
                            _loc_5.frontPlayer.status.addInvisible(PlayerMiniStatus.INVISIBLE_FLAG_NAME);
                            if (_loc_5.frontPlayer != this._selectedPlayer)
                            {
                                _loc_5.frontPlayer.playerActionController.resetAction();
                            }
                            if (this._cbFormationPlayerOutFunc != null)
                            {
                                this._cbFormationPlayerOutFunc(_loc_5.frontPlayer.playerPersonal);
                            }
                        }
                    }
                }
                _loc_4++;
            }
            if (_loc_3 && this._cbFormationPlayerOverFunc != null)
            {
                this._cbFormationPlayerOverFunc(_loc_2, _loc_3);
            }
            this.updateMark(_loc_2);
            this._mouseOverPlayerFormationIndex = _loc_2;
            return;
        }// end function

        private function cbMouseDown(event:MouseEvent) : void
        {
            this._mouseDownPlayerFormationIndex = this._mouseOverPlayerFormationIndex;
            return;
        }// end function

        private function cbMouseUp(event:MouseEvent) : void
        {
            return;
        }// end function

        private function cbMouseClick(event:MouseEvent) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_9:* = 0;
            var _loc_2:* = this._mouseDownPlayerFormationIndex;
            this._mouseDownPlayerFormationIndex = Constant.UNDECIDED;
            var _loc_3:* = new Point(event.stageX, event.stageY);
            var _loc_4:* = this.isHit(_loc_3);
            if (this._commanderSelecter.bCommanderChange == false && _loc_4 == FormationSetData.FORMATION_INDEX_COMMANDER)
            {
                _loc_4 = Constant.UNDECIDED;
            }
            if (_loc_4 == Constant.UNDECIDED || _loc_4 != _loc_2)
            {
                if (this._selectedPlayer)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_CANCEL);
                }
                this.unselectPlayer();
                return;
            }
            if (this._bJumping || this._bNextJumpWait)
            {
                return;
            }
            if (this._selectedPlayer != null && this._selectedPlayerFormationIndex != Constant.UNDECIDED && this._selectedPlayerFormationIndex != _loc_4)
            {
                if (this.checkSwapCommanderSkill(this._selectedPlayer, this._selectedPlayerFormationIndex, _loc_4) == false)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_CANCEL);
                    this.unselectPlayer();
                    return;
                }
                for each (_loc_5 in this._aFormationPost)
                {
                    
                    (_loc_11[_loc_10]).jumpPos = _loc_5.frontPlayer.status.getPositionToGlobal();
                }
                _loc_5 = this._aFormationPost[_loc_4] as FormationPostData;
                _loc_6 = this._aFormationPost[this._selectedPlayerFormationIndex] as FormationPostData;
                if (_loc_6.frontPlayer.playerPersonal)
                {
                    _loc_9 = _loc_5.uniqueId;
                    _loc_5.uniqueId = _loc_6.uniqueId;
                    _loc_6.uniqueId = _loc_9;
                    _loc_6.frontPlayer.playerActionController.resetAction();
                    _loc_5.jumpPos = _loc_6.frontPlayer.status.getPositionToGlobal();
                    _loc_6.jumpPos = _loc_5.frontPlayer.status.getPositionToGlobal();
                }
                this.unselectPlayer();
                this.updateFormation();
                this._bNextJumpWait = true;
                if (this._cbFormationPositionChangedFunc != null)
                {
                    this._cbFormationPositionChangedFunc();
                }
                return;
            }
            var _loc_7:* = Constant.EMPTY_ID;
            _loc_5 = this._aFormationPost[_loc_4] as FormationPostData;
            if (_loc_5.frontPlayer.playerPersonal)
            {
                this._selectedPlayerFormationIndex = _loc_4;
                this._selectedPlayer = _loc_5.frontPlayer;
                this._selectedPlayer.playerDisplay.setSelect(true);
                this._selectedPlayer.formationMark.select();
                if (!this._bNextJumpWait)
                {
                    _loc_7 = SoundId.SE_CHARA_SELECT;
                }
                if (!_loc_5.frontPlayer.bMouseOver)
                {
                    this.onPlayerMouseOver(_loc_5.frontPlayer);
                }
            }
            var _loc_8:* = false;
            if (this._cbFormationPositionSelectedFunc != null)
            {
                _loc_8 = this._cbFormationPositionSelectedFunc(_loc_4, _loc_5.frontPlayer.playerPersonal);
            }
            if (!_loc_8 && _loc_7)
            {
                SoundManager.getInstance().playSe(_loc_7);
            }
            return;
        }// end function

        private function checkSwapCommanderSkill(param1:FormationPlayerDisplay, param2:int, param3:int) : Boolean
        {
            if (param3 == FormationSetData.FORMATION_INDEX_COMMANDER && param1.playerDisplay.info.hasCommanderSkill() == false)
            {
                return false;
            }
            var _loc_4:* = this._aFormationPost[param3] as FormationPostData;
            if (this._aFormationPost[param3] as FormationPostData && _loc_4.frontPlayer.playerPersonal)
            {
                if (this._selectedPlayerFormationIndex == FormationSetData.FORMATION_INDEX_COMMANDER && _loc_4.frontPlayer.playerPersonal.hasCommanderSkill() == false)
                {
                    return false;
                }
            }
            return true;
        }// end function

        private function cbFormationChange(param1:int, param2:Boolean = false) : void
        {
            var i:int;
            var p:FormationPostData;
            var personal:PlayerPersonal;
            var tp:FormationPostData;
            var index:int;
            var ttp:FormationPostData;
            var mcFormation:MovieClip;
            var formationId:* = param1;
            var bReset:* = param2;
            var info:* = FormationManager.getInstance().getFormationInformation(formationId);
            var bChange:Boolean;
            var bJumpStart:* = !bReset && !this._bNextJumpWait;
            this.unselectPlayer();
            this._formationPlacement.setFormationLabel(formationId);
            this._formationDescription.setDescription(formationId);
            var liveNum:int;
            i = FormationSetData.FORMATION_INDEX_POSITION_1;
            while (i <= FormationSetData.FORMATION_INDEX_POSITION_5)
            {
                
                p = this._aFormationPost[i];
                if (p.uniqueId != Constant.EMPTY_ID)
                {
                    personal = this.getPersonal(p.uniqueId);
                    if (personal && personal.bDead == false)
                    {
                        liveNum = (liveNum + 1);
                    }
                }
                i = (i + 1);
            }
            var bFormationBonus:* = liveNum >= info.member && this._bFormationNotBe == false;
            i;
            while (i < this._aFormationPost.length)
            {
                
                p = this._aFormationPost[i] as FormationPostData;
                if (i < info.member)
                {
                    p.frontPlayer.statusUpDownIcon.show();
                    p.frontPlayer.statusUpDownIcon.setFormationId(formationId, bFormationBonus);
                }
                else
                {
                    p.frontPlayer.statusUpDownIcon.hide();
                }
                i = (i + 1);
            }
            if (bJumpStart)
            {
                var _loc_4:* = 0;
                var _loc_5:* = this._aFormationPost;
                while (_loc_5 in _loc_4)
                {
                    
                    p = _loc_5[_loc_4];
                    p.jumpPos = p.frontPlayer.status.getPositionToGlobal();
                }
                i = FormationSetData.FORMATION_INDEX_POSITION_1;
                while (i <= FormationSetData.FORMATION_INDEX_POSITION_5)
                {
                    
                    p = this._aFormationPost[i] as FormationPostData;
                    if (p.uniqueId != p.tmpUniqueId)
                    {
                        if (p.uniqueId == Constant.EMPTY_ID)
                        {
                            tp = this.getFormationPost(p.tmpUniqueId);
                            if (tp)
                            {
                                p.jumpPos = tp.jumpPos;
                            }
                        }
                    }
                    i = (i + 1);
                }
            }
            i;
            while (i < this._aFormationPost.length)
            {
                
                p = this._aFormationPost[i] as FormationPostData;
                if (p.uniqueId != p.tmpUniqueId)
                {
                    p.uniqueId = p.tmpUniqueId;
                    bChange;
                }
                i = (i + 1);
            }
            if (info.member < 5)
            {
                var getEmptyFormationIndex:* = function (param1:int) : int
            {
                var _loc_2:* = param1;
                while (_loc_2 >= 0)
                {
                    
                    if ((_aFormationPost[_loc_2] as FormationPostData).uniqueId == Constant.EMPTY_ID)
                    {
                        return _loc_2;
                    }
                    _loc_2 = _loc_2 - 1;
                }
                return Constant.UNDECIDED;
            }// end function
            ;
                i = FormationSetData.FORMATION_INDEX_POSITION_5;
                while (i >= info.member)
                {
                    
                    p = this._aFormationPost[i] as FormationPostData;
                    if (p.uniqueId != Constant.EMPTY_ID)
                    {
                        index = this.getEmptyFormationIndex((info.member - 1));
                        ttp = this._aFormationPost[index] as FormationPostData;
                        ttp.uniqueId = p.uniqueId;
                        p.uniqueId = Constant.EMPTY_ID;
                        if (bJumpStart)
                        {
                            ttp.jumpPos = p.jumpPos;
                        }
                        bChange;
                    }
                    i = (i - 1);
                }
            }
            if (bChange)
            {
                this.updateFormation(false);
            }
            var aFormationMc:* = this._formationPlacement.aCharaMc;
            i;
            while (i < aFormationMc.length)
            {
                
                mcFormation = aFormationMc[i];
                p = this._aFormationPost[i] as FormationPostData;
                if (info && info.member <= i)
                {
                    p.frontPlayer.formationMark.hide();
                }
                else
                {
                    p.frontPlayer.formationMark.show();
                    p.frontPlayer.setPosition(mcFormation.x, mcFormation.y);
                }
                i = (i + 1);
            }
            if (bJumpStart)
            {
                this._bNextJumpWait = true;
            }
            if (bReset)
            {
                this._jumpFormationId = formationId;
            }
            this.updateMiniStatus();
            if (this._cbFormationChangedFunc != null)
            {
                this._cbFormationChangedFunc(formationId);
            }
            return;
        }// end function

        public static function loadResource() : void
        {
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.BATTLE_PATH + "BattleFormation.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Balloon.swf");
            SoundManager.getInstance().loadSoundArray([SoundId.SE_JUMP2, SoundId.SE_LANDING1016B, SoundId.SE_CHARA_SELECT, SoundId.SE_CANCEL]);
            return;
        }// end function

    }
}
