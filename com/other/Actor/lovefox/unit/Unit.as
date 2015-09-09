package lovefox.unit
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.gui.*;
    import lovefox.isometric.*;
    import org.gif.encoder.*;

    public class Unit extends EventDispatcher
    {
        public var _moveFlag:Boolean = false;
        private var _playHurtTimer:Object;
        private var _releaseHurtTimer:Object;
        var _enterframeListenerArray:Array;
        public var _map:Map;
        public var _mc:Sprite;
        public var _stateBar:StateBar;
        public var _img:UnitClip;
        public var _effect:UnitClip;
        public var _haloEffect:Object;
        public var _haloHEffect:Object;
        public var _haloEffectOther:Object;
        public var _buffEffect:Object;
        public var _x:Number;
        public var _y:Number;
        var _attackMode:Object = null;
        var _actionLock:Boolean;
        public var _focus:Boolean = false;
        public var _angle:Number = 0;
        public var _legalAngle:Number;
        public var _legalPt:Object;
        public var _currTile:LogicalTile;
        public var _filter:String = "";
        public var _filterTimeout:Object;
        public var _state:String = "idle";
        public var _forceIdleAct:String = "";
        public var _data:Object;
        public var _headColor:Object;
        public var _bodyColor:Object;
        public var _die:Object = false;
        public var _type:int;
        public var _id:uint;
        public var _visibleTimer:Object;
        var _sayRect:Sprite;
        var _preSayTxt:RichTextField;
        var _sayTxt:RichTextField;
        var _sayBtnStack:Object;
        var _sayInterval:Object;
        private var _sayArr:Array;
        private var _sayArrIndex:int = 0;
        private var _sayTimer:Number;
        var _name:String = "";
        var _title:String = "";
        var _normalRange:Object;
        var _publicCd:Number;
        var _sex:Object;
        var _job:Object;
        var _speed:Object = 0;
        var _hp:Number;
        var _hpMax:Number;
        var _mp:Number;
        var _mpMax:Number;
        var _level:Object;
        var _exp:Number;
        var _expUpdate:Number;
        var _stamina:Number;
        var _rate:Number;
        var _evade:Number;
        var _skillRate:Number;
        var _skillEvade:Number;
        var _criticalRate:Number;
        var _criticalEvade:Number;
        var _criticalMulti:Number;
        var _criticalResist:Number;
        var _skillCriticalRate:Number;
        var _skillCriticalEvade:Number;
        var _skillCriticalMulti:Number;
        var _skillCriticalResist:Number;
        var _criticalAdd:Number;
        var _criticalMinus:Number;
        var _atk:Number;
        var _atkRanged:Number;
        var _atkMagic:Number;
        var _def:Number;
        var _defRanged:Number;
        var _defMagic:Number;
        var _atkAdd:Number;
        var _defAdd:Number;
        var _atkRangedAdd:Number;
        var _defRangedAdd:Number;
        var _atkMagicAdd:Number;
        var _defMagicAdd:Number;
        var _atkSpeedLevel:Number = 0;
        var _atkSpeedLevelBuff:int = 0;
        var _atkSkill:Number;
        var _defSkill:Number;
        var _otheratk:int;
        var _otherdef:int;
        var _othermondef:int;
        var _monarr:Array;
        var _money1:Number;
        var _money2:Number;
        var _money3:Number;
        var _money4:Number;
        private var _gatherTime:Object;
        private var _gatherTimeCount:Object;
        private var _lucky:int;
        private var _comAtk:int;
        private var _comDef:int;
        private var _comAtkAdd:int;
        private var _comDefAdd:int;
        private var _comRate:int;
        private var _comEvade:int;
        private var _comSkillRate:int;
        private var _comSkillEvade:int;
        private var _comSkillAtk:int;
        private var _comSkillCriticalAdd:int;
        private var _comSkillCriticalDel:int;
        private var _comAtkCriticalAdd:int;
        private var _comAtkCriticalDel:int;
        private var _comSkillCritical:int;
        private var _comSkillCriticalDef:int;
        private var _comCritical:int;
        private var _comCriticalDef:int;
        private var _comBuffAtk1:int;
        private var _comBuffAtk2:int;
        private var _comBuffAtk3:int;
        private var _comBuffAtk4:int;
        private var _comBuffAtk5:int;
        private var _comBuffAtk6:int;
        private var _comBuffAtk7:int;
        private var _comBuffAtk8:int;
        private var _comBuffAtk9:int;
        private var _comBuffAtk10:int;
        private var _comBuffDef1:int;
        private var _comBuffDef2:int;
        private var _comBuffDef3:int;
        private var _comBuffDef4:int;
        private var _comBuffDef5:int;
        private var _comBuffDef6:int;
        private var _comBuffDef7:int;
        private var _comBuffDef8:int;
        private var _comBuffDef9:int;
        private var _comBuffDef10:int;
        private var _dispAtk:int;
        private var _dispDef:int;
        private var _dispDmgAdd:int;
        private var _dispDmgReduce:int;
        private var _dispAtkSpeed:int;
        private var _dispSkillAdd:int;
        private var _dispRate:int;
        private var _dispSkillRate:int;
        private var _dispEvade:int;
        private var _dispSkillEvade:int;
        private var _dispCriticalRate:int;
        private var _dispSkillCriticalRate:int;
        private var _dispCriticalEvade:int;
        private var _dispSkillCriticalEvade:int;
        private var _dispCriticalAdd:int;
        private var _dispSkillCriticalAdd:int;
        private var _dispCriticalReduce:int;
        private var _dispSkillCriticalReduce:int;
        private var _dispGodAtk:Object;
        private var _dispLuck:int;
        var _instanceSore:Number;
        var _honor:Number;
        private var _speedLevel:int;
        private var _dispSpeed:int;
        var _weaponId:Object;
        var _weaponElementID:int;
        var _weaponElementLevel:int;
        var _weaponModelId:int;
        var _clothId:Object;
        var _horseId:Object;
        var _horseH:uint = 28;
        var _wingId:Object;
        var _hairId:Object;
        private var _effectStack:Object;
        private var _effectTimer:Object;
        private var _pkState:uint = 0;
        private var _autoHp:uint = 0;
        private var _autoMp:uint = 0;
        var _stun:Boolean;
        var _silent:Boolean;
        var _taunt:Boolean;
        var _ice:Boolean;
        var _itemDisable:Boolean;
        var _stealth:Boolean;
        var _attackDisable:Boolean;
        public var _gildid:int = 0;
        public var _gilename:String = "";
        public var _gildpower:int = 6;
        public var _camp:int = 0;
        public var _gildTeam:int = 0;
        private var _warTeam:int = 0;
        var _buffClip:int = 0;
        var _buffClipHue:int = 0;
        var _forceClip:int = 0;
        var _forceClipHue:int = 0;
        public var _walkBlock:Object = true;
        public var _selectable:Boolean = true;
        public var _slipObj:Object;
        private var _playEffectTimer:Number;
        var _jumpWordStack:Array;
        var _jumpWordLock:Boolean = false;
        var _hitStateStack:Array;
        var _hitStateLock:Boolean = false;
        var _boothing:Boolean = false;
        var _boothAd:String = "";
        public var _binding:uint = 0;
        public var _bindingUnit:Unit;
        private var _resting:Boolean = false;
        var _skillAngle:Number;
        private var _belongPlayer:uint = 0;
        private var _belongTeam:uint = 0;
        var _fadeDeath:Boolean = false;
        var _appearance:Boolean = true;
        private var _chantEffectTarget:Unit;
        private var _fighting:Boolean = false;
        private var _horse:UnitClip;
        private var _horseObjIdle:Object;
        private var _horseObjWalk:Object;
        private var _horseObj:Object;
        private var _titleId:int = 0;
        public var _imgY:Number = 0;
        private var _toGifCount:int;
        private var _monsterCamp:int = 0;
        private var _gildCoin:int;
        private var _escortra:int;
        private var _escortrob:int;
        private var _escortstatus:int;
        private var _escortentryId:int;
        private var landWarBuf:Laba;
        public var _follower:Follower;
        public var _followerID:int = 0;
        private var _hideFollower:Boolean = false;
        static var _fullEffect:Boolean = true;
        static var _otherVisible:Boolean = true;
        public static var _allCount:int = 0;
        public static var _unitStack:Object = {};
        private static var _sayTxtDefaultTextFormat:TextFormat = new TextFormat(null, 12, null, null, null, null, null, null, null, null, null, null, 2);

        public function Unit(param1, param2, param3, param4, param5)
        {
            this._enterframeListenerArray = [];
            this._haloEffect = {};
            this._haloHEffect = {};
            this._haloEffectOther = {};
            this._buffEffect = {};
            this._sayBtnStack = [];
            this._effectStack = [];
            this._jumpWordStack = [];
            this._hitStateStack = [];
            var _loc_7:* = _allCount + 1;
            _allCount = _loc_7;
            this._data = param1;
            this._x = param2;
            this._y = param3;
            this._legalPt = {_x:param2, _y:param3};
            this._type = param4;
            this._id = param5;
            if (this._data != null)
            {
                if (this._data.normalAtkId != null)
                {
                    this.attackMode = Config._skillMap[this._data.normalAtkId];
                }
            }
            if (_unitStack[this._type] == null)
            {
                _unitStack[this._type] = {};
            }
            _unitStack[this._type][this._id] = this;
            this._stateBar = new StateBar(this);
            if (this._type == UNIT_TYPE_ENUM.TYPEID_PLAYER && this._forceClip == 0 && this._buffClip == 0)
            {
                this.clothId = this.clothId;
                this.hairId = this.hairId;
                this.horseId = this.horseId;
                this.wingId = this.wingId;
            }
            this.landWarBuf = new Laba();
            this.landWarBuf.fontSize = 20;
            return;
        }// end function

        function checkAddImg()
        {
            if (this._mc != null)
            {
                if (!_otherVisible)
                {
                    if (this._mc.parent != null)
                    {
                        this._mc.parent.removeChild(this._mc);
                    }
                }
                else if (this._mc.parent == null)
                {
                    this._map._rootMap.addChild(this._mc);
                }
            }
            this.setFollower(this._followerID);
            return;
        }// end function

        public function set belongPlayer(param1)
        {
            var _loc_2:* = undefined;
            this._belongPlayer = param1;
            if (Config.player != null)
            {
                if (Config.player.tracingTarget == this)
                {
                    _loc_2 = this._haloEffect[1177];
                    if (_loc_2 != null)
                    {
                        if (Config.player.testBelong(this))
                        {
                            _loc_2.filters = [];
                        }
                        else
                        {
                            _loc_2.filters = [UnitEffect._stoneCMF];
                        }
                    }
                }
            }
            return;
        }// end function

        public function get belongPlayer()
        {
            return this._belongPlayer;
        }// end function

        public function set belongTeam(param1)
        {
            var _loc_2:* = undefined;
            this._belongTeam = param1;
            if (Config.player != null)
            {
                if (Config.player.tracingTarget == this)
                {
                    _loc_2 = this._haloEffect[1177];
                    if (_loc_2 != null)
                    {
                        if (Config.player.testBelong(this))
                        {
                            _loc_2.filters = [];
                        }
                        else
                        {
                            _loc_2.filters = [UnitEffect._stoneCMF];
                        }
                    }
                }
            }
            return;
        }// end function

        public function get belongTeam()
        {
            return this._belongTeam;
        }// end function

        public function set boothing(param1:Boolean) : void
        {
            this._boothing = param1;
            if (this._boothing)
            {
                this.sitDown = true;
                this._stateBar.setstallpanel(this._boothAd);
                if (this._stateBar._stallpanel != null)
                {
                    this._stateBar._stallpanel.removeEventListener("click", this.testBoothDis);
                    this._stateBar._stallpanel.addEventListener("click", this.testBoothDis);
                }
            }
            else
            {
                this.sitDown = false;
                if (this._stateBar._stallpanel != null)
                {
                    this._stateBar._stallpanel.removeEventListener("click", this.testBoothDis);
                    this._stateBar.destroyStall();
                }
            }
            return;
        }// end function

        private function testBoothDis(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            if (Config.player != this)
            {
                _loc_2 = Config.player.testDistance(this);
                trace(_loc_2);
                if (_loc_2 < 140)
                {
                    this.handleBoothOpen(this.id, this._boothAd);
                }
                else
                {
                    _loc_3 = this._map.findNearPt(this, Config.player, 140);
                    _loc_4 = {_x:_loc_3._x, _y:_loc_3._y, booth:{unit:this, id:this.id, _boothAd:this._boothAd}};
                    Config.player.target = _loc_4;
                }
            }
            return;
        }// end function

        public function handleBoothOpen(param1, param2)
        {
            var _loc_3:* = null;
            if (param1 != Config.player.id)
            {
                Config.ui._boothUI.owner = param1;
                _loc_3 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, param1);
                Config.ui._boothUI._name = _loc_3.name;
                Config.ui._boothUI._boothAd = param2;
                Config.ui._boothUI.open();
            }
            return;
        }// end function

        public function get boothing() : Boolean
        {
            return this._boothing;
        }// end function

        public function set boothAd(param1:String) : void
        {
            this._boothAd = param1;
            return;
        }// end function

        public function get boothAd() : String
        {
            return this._boothAd;
        }// end function

        public function set horseId(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            this._horseId = param1;
            if (this._img != null)
            {
                if (this._buffClip == 0 && this._forceClip == 0)
                {
                    if (this._horseId != null && this._horseId.id != 0 && _fullEffect)
                    {
                        _loc_2 = Config._itemMap[this._horseId.id];
                        if (this.sex == 1)
                        {
                            _loc_4 = String(_loc_2.mModel);
                        }
                        else
                        {
                            _loc_4 = String(_loc_2.fModel);
                        }
                        if (_loc_4.indexOf("|") == -1)
                        {
                            _loc_3 = Config._model[Number(_loc_4)];
                        }
                        else
                        {
                            _loc_5 = _loc_4.split("|");
                            if (this._horseId.star < 10)
                            {
                                _loc_3 = Config._model[Number(_loc_5[0])];
                            }
                            else if (this._horseId.star < 20)
                            {
                                _loc_3 = Config._model[Number(_loc_5[1])];
                            }
                            else if (this._horseId.star < 30)
                            {
                                _loc_3 = Config._model[Number(_loc_5[2])];
                            }
                            else
                            {
                                _loc_3 = Config._model[Number(_loc_5[3])];
                            }
                        }
                        this.horse = _loc_3;
                    }
                    else
                    {
                        this.horse = null;
                    }
                }
                else
                {
                    this.horse = null;
                }
            }
            return;
        }// end function

        public function get horseId()
        {
            return this._horseId;
        }// end function

        public function set wingId(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            this._wingId = param1;
            if (this._img != null)
            {
                if (this._buffClip == 0 && this._forceClip == 0)
                {
                    if (this._wingId != null && this._wingId.id != 0 && _fullEffect)
                    {
                        _loc_2 = Config._itemMap[this._wingId.id];
                        if (this.sex == 1)
                        {
                            _loc_5 = String(_loc_2.mModel);
                        }
                        else
                        {
                            _loc_5 = String(_loc_2.fModel);
                        }
                        if (_loc_5.indexOf("|") == -1)
                        {
                            _loc_7 = _loc_5;
                        }
                        else
                        {
                            _loc_6 = _loc_5.split("|");
                            if (this._wingId.star < 10)
                            {
                                _loc_7 = String(_loc_6[0]);
                            }
                            else if (this._wingId.star < 20)
                            {
                                _loc_7 = String(_loc_6[1]);
                            }
                            else if (this._wingId.star < 30)
                            {
                                _loc_7 = String(_loc_6[2]);
                            }
                            else
                            {
                                _loc_7 = String(_loc_6[3]);
                            }
                        }
                        if (_loc_7.indexOf(";") == -1)
                        {
                            _loc_8 = _loc_7;
                        }
                        else
                        {
                            _loc_9 = _loc_7.split(";");
                            if (this.job == 1)
                            {
                                _loc_8 = String(_loc_9[0]);
                            }
                            else if (this.job == 4)
                            {
                                _loc_8 = String(_loc_9[1]);
                            }
                            else if (this.job == 10)
                            {
                                _loc_8 = String(_loc_9[2]);
                            }
                        }
                        _loc_10 = _loc_8.split(",");
                        _loc_3 = Config._model[Number(_loc_10[0])];
                        _loc_4 = Config._model[Number(_loc_10[1])];
                        this._img.lWing = _loc_3;
                        this._img.rWing = _loc_4;
                    }
                    else
                    {
                        this._img.lWing = null;
                        this._img.rWing = null;
                    }
                }
            }
            return;
        }// end function

        public function get wingId()
        {
            return this._wingId;
        }// end function

        public function set clothId(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (StateBar.inWar)
            {
                param1 = 0;
            }
            this._clothId = param1;
            if (this._img != null)
            {
                if (this._buffClip == 0 && this._forceClip == 0)
                {
                    if (this._clothId != null && this._clothId != 0)
                    {
                        _loc_2 = Config._itemMap[this._clothId];
                        if (this.sex == 1)
                        {
                            _loc_4 = String(_loc_2.mModel);
                        }
                        else
                        {
                            _loc_4 = String(_loc_2.fModel);
                        }
                        if (_loc_4.indexOf(":") == -1)
                        {
                            _loc_3 = Config._model[Number(_loc_4)];
                        }
                        else
                        {
                            _loc_5 = _loc_4.split(":");
                            if (this.job == 1)
                            {
                                _loc_3 = Config._model[Number(_loc_5[0])];
                            }
                            else if (this.job == 4)
                            {
                                _loc_3 = Config._model[Number(_loc_5[1])];
                            }
                            else if (this.job == 10)
                            {
                                _loc_3 = Config._model[Number(_loc_5[2])];
                            }
                        }
                        this._img.cloth = _loc_3;
                    }
                    else
                    {
                        this._img.cloth = Config._model[Number(this._data.cloth)];
                    }
                }
            }
            return;
        }// end function

        public function set hairId(param1)
        {
            var _loc_2:* = undefined;
            if (StateBar.inWar)
            {
                param1 = 0;
            }
            this._hairId = param1;
            if (this._img != null)
            {
                if (this._buffClip == 0 && this._forceClip == 0)
                {
                    if (this._hairId == null || this._hairId == 0)
                    {
                        this._hairId = 1;
                    }
                    if (this.job == 1)
                    {
                        if (this.sex == 1)
                        {
                            _loc_2 = Config._model[Number(Config._hairMap[this._hairId].fightMale)];
                        }
                        else
                        {
                            _loc_2 = Config._model[Number(Config._hairMap[this._hairId].fightFemale)];
                        }
                    }
                    else if (this.job == 4)
                    {
                        if (this.sex == 1)
                        {
                            _loc_2 = Config._model[Number(Config._hairMap[this._hairId].rangerMale)];
                        }
                        else
                        {
                            _loc_2 = Config._model[Number(Config._hairMap[this._hairId].rangerFemale)];
                        }
                    }
                    else if (this.job == 10)
                    {
                        if (this.sex == 1)
                        {
                            _loc_2 = Config._model[Number(Config._hairMap[this._hairId].magicMale)];
                        }
                        else
                        {
                            _loc_2 = Config._model[Number(Config._hairMap[this._hairId].magicFemale)];
                        }
                    }
                    this._img.hair = _loc_2;
                }
            }
            return;
        }// end function

        public function set fighting(param1:Boolean)
        {
            this._fighting = param1;
            return;
        }// end function

        public function get fighting()
        {
            return this._fighting;
        }// end function

        public function setWeaponElement(param1:int, param2:int)
        {
            this._weaponElementID = param1;
            this._weaponElementLevel = param2;
            this.startLoop(this.refreshWeapon);
            return;
        }// end function

        public function set weaponId(param1)
        {
            this._weaponId = param1;
            this.startLoop(this.refreshWeapon);
            return;
        }// end function

        private function refreshWeapon(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            this.stopLoop(this.refreshWeapon);
            if (this._buffClip == 0 && this._forceClip == 0)
            {
                if (this._weaponId != null && this._weaponId != 0)
                {
                    _loc_2 = Config._itemMap[this._weaponId];
                    if (this.sex == 1)
                    {
                        _loc_4 = String(_loc_2.mModel);
                    }
                    else
                    {
                        _loc_4 = String(_loc_2.fModel);
                    }
                    _loc_5 = _loc_4.split("|");
                    _loc_6 = int(_loc_5[0]);
                    if (this._weaponElementID > 0 && this._weaponElementLevel > 9)
                    {
                        if (this._weaponElementID < _loc_5.length)
                        {
                            _loc_8 = _loc_5[this._weaponElementID].split(",");
                            if (_loc_8.length == 1)
                            {
                                _loc_7 = int(_loc_8[0]);
                            }
                            else
                            {
                                _loc_7 = int(_loc_8[(int(this._weaponElementLevel / 10) - 1)]);
                            }
                            if (_loc_7 == 0)
                            {
                                _loc_7 = _loc_6;
                            }
                        }
                        else
                        {
                            _loc_7 = _loc_6;
                        }
                    }
                    else
                    {
                        _loc_7 = _loc_6;
                    }
                    _loc_3 = Config._model[_loc_7];
                    if (this._img != null)
                    {
                        this._img.weapon = _loc_3;
                    }
                }
                else if (this._img != null)
                {
                    this._img.weapon = null;
                }
            }
            return;
        }// end function

        public function get weaponId()
        {
            return this._weaponId;
        }// end function

        public function get clothId()
        {
            return this._clothId;
        }// end function

        public function get hairId()
        {
            return this._hairId;
        }// end function

        public function reDraw()
        {
            if (this._img != null)
            {
                this._img.removeEventListener("complete", this.handleImgRedraw);
                this._img.removeEventListener("weaponComplete", this.handleImgRedraw);
                this._img.destroy();
                if (this._img.parent != null)
                {
                    this._img.parent.removeChild(this._img);
                }
                this._img = null;
            }
            if (this._forceClip < 0)
            {
                return;
            }
            if (this._mc == null)
            {
                this._mc = new Sprite();
                this._mc.mouseEnabled = false;
                this._mc.mouseChildren = false;
            }
            if (this._buffClip != 0)
            {
                this._img = UnitClip.newUnitClip(Config._model[this._buffClip], false, this._buffClipHue);
                this.horse = null;
                if (this._img.ready)
                {
                    this.imgComplete();
                }
                else
                {
                    this._img.removeEventListener("complete", this.handleImgComplete);
                    this._img.addEventListener("complete", this.handleImgComplete);
                }
                if (this._die)
                {
                    this._img.filters = [UnitEffect._stoneCMF];
                }
            }
            else if (this._forceClip != 0)
            {
                this._img = UnitClip.newUnitClip(Config._model[this._forceClip], false, this._forceClipHue);
                this.horse = null;
                if (this._img.ready)
                {
                    this.imgComplete();
                }
                else
                {
                    this._img.removeEventListener("complete", this.handleImgComplete);
                    this._img.addEventListener("complete", this.handleImgComplete);
                }
                if (this._die)
                {
                    this._img.filters = [UnitEffect._stoneCMF];
                }
            }
            else
            {
                if (this.type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
                {
                    this._img = UnitClip.newUnitClip(Config._model[this._data.model], true, 0, 1, this._data.id);
                    this._img.removeEventListener("complete", this.handleImgRedraw);
                    this._img.removeEventListener("weaponComplete", this.handleImgRedraw);
                    this._img.addEventListener("complete", this.handleImgRedraw);
                    this._img.addEventListener("weaponComplete", this.handleImgRedraw);
                    this.weaponId = this.weaponId;
                    this.clothId = this.clothId;
                    this.hairId = this.hairId;
                    this.wingId = this.wingId;
                    this.horseId = this.horseId;
                }
                else
                {
                    if (this._data.model == -1)
                    {
                        this._img = UnitClip.newUnitClip();
                        this._walkBlock = false;
                    }
                    else
                    {
                        this._img = UnitClip.newUnitClip(Config._model[this._data.model]);
                    }
                    this._img.layerStack = null;
                }
                if (this._die)
                {
                    this._img.filters = [];
                }
            }
            this.actionLock = false;
            this.changeStateTo(this._state);
            this.directTo(this._angle);
            this._mc.addChild(this._img);
            this.sortEffect();
            if (this._img.ready)
            {
                this.imgComplete();
            }
            else
            {
                this._img.removeEventListener("complete", this.handleImgComplete);
                this._img.addEventListener("complete", this.handleImgComplete);
            }
            return;
        }// end function

        private function handleHorseComplete(param1)
        {
            if (this is Player)
            {
                Config.ui._charUI.drawHorseClip(param1.currentTarget);
            }
            return;
        }// end function

        public function get horse()
        {
            return this._horse;
        }// end function

        public function set horse(param1)
        {
            if (this._horse != null)
            {
                this._horse.removeEventListener(Event.COMPLETE, this.handleHorseComplete);
                this._horse.destroy();
                if (this._horse.parent != null)
                {
                    this._horse.parent.removeChild(this._horse);
                }
                this._horse = null;
            }
            if (param1 != null)
            {
                this._horse = UnitClip.newUnitClip(param1);
                if (this is Player)
                {
                    if (this._horse.ready)
                    {
                        Config.ui._charUI.drawHorseClip(this._horse);
                    }
                    else
                    {
                        this._horse.removeEventListener(Event.COMPLETE, this.handleHorseComplete);
                        this._horse.addEventListener(Event.COMPLETE, this.handleHorseComplete);
                    }
                }
                this._horse.changeStateTo("idle");
                this._mc.addChild(this._horse);
                this.horseZ = 0;
                if (this._state == "walk")
                {
                    this.changeStateTo("idle");
                }
                this._horse.directTo(this._angle);
                this._imgY = -this._horseH;
                this.sortEffect(true);
                this.initHorse();
            }
            else
            {
                if (this is Player)
                {
                    if (Config.ui != null)
                    {
                        Config.ui._charUI.drawHorseClip(null);
                    }
                }
                this._imgY = 0;
                this.sortEffect(true);
                if (this._img != null)
                {
                    this._img.y = 0;
                }
                this.clearHorse();
                if (this._moveFlag)
                {
                    this.changeStateTo("walk");
                }
                else
                {
                    this.changeStateTo(this._state);
                }
            }
            this.draw();
            return;
        }// end function

        private function initHorse()
        {
            if (this._horse._id >= 2133 && this._horse._id <= 2144)
            {
                this._horseObjIdle = {mode:2, frameSkip:3, decay:8, margin:10, glideProb:0};
                this._horseObjWalk = {mode:2, frameSkip:2, decay:8, margin:10, glideProb:0.1, glideFrameMin:20, glideFrameMax:40, glide:0, glideFrame:2};
            }
            else if (this._horse._id >= 2145 && this._horse._id <= 2152)
            {
                this._horseObjIdle = {mode:1, frameSkip:4, phase:-2, margin:3, glideProb:0};
                this._horseObjWalk = {mode:1, frameSkip:4, phase:-2, margin:3, glideProb:0.3, glideFrameMin:20, glideFrameMax:40, glide:0, glideFrame:2};
            }
            else if (this._horse._id >= 2124 && this._horse._id <= 2132)
            {
                this._horseObjIdle = {mode:1, frameSkip:3, phase:-2, margin:2, glideProb:0};
                this._horseObjWalk = {mode:1, frameSkip:3, phase:-2, margin:2, glideProb:0, glideFrameMin:0, glideFrameMax:0, glide:0, glideFrame:0};
            }
            else
            {
                this._horseObjIdle = {mode:4, frame:0, totalFrame:24, margin:2, glideProb:0};
                this._horseObjWalk = null;
            }
            this.horseLoop();
            this.startLoop(this.horseLoop);
            return;
        }// end function

        private function clearHorse()
        {
            this.stopLoop(this.horseLoop);
            return;
        }// end function

        private function horseLoop(param1 = null)
        {
            if (this._moveFlag && this._horseObjWalk != null)
            {
                if (this._horseObj != this._horseObjWalk)
                {
                    if (this._horseObj != null && this._horseObj.mode == 4)
                    {
                        this._horseObjWalk.frame = this._horseObj.frame;
                    }
                    this._horseObj = this._horseObjWalk;
                    this._horseObj.glide = 0;
                    this._horse.wakeAnimation();
                }
            }
            else if (this._horseObj != this._horseObjIdle)
            {
                if (this._horseObj != null && this._horseObj.mode == 4)
                {
                    this._horseObjIdle.frame = this._horseObj.frame;
                }
                this._horseObj = this._horseObjIdle;
                this._horseObj.glide = 0;
                this._horse.wakeAnimation();
            }
            var _loc_2:* = this._horseObj;
            if (_loc_2.frameSkip != null)
            {
                this._horse._frameSkip = _loc_2.frameSkip;
            }
            if (_loc_2.glide > 0)
            {
                var _loc_3:* = _loc_2;
                var _loc_4:* = _loc_2.glide - 1;
                _loc_3.glide = _loc_4;
                if (_loc_2.glide == 0)
                {
                    this._horse.wakeAnimation();
                }
            }
            else if (_loc_2.mode == 1)
            {
                if (this._horse._frameLeft == 0 && this._horse._currFrame == _loc_2.glideFrame && _loc_2.glideProb > 0)
                {
                    if (Math.random() < _loc_2.glideProb)
                    {
                        this._horse.sleepAnimation();
                        _loc_2.glide = _loc_2.glideFrameMin + Math.floor((_loc_2.glideFrameMax - _loc_2.glideFrameMin) * Math.random());
                        this.horseZ = (-Math.sin((this._horse.frame + _loc_2.phase) / this._horse.totalFrame * Math.PI * 2)) * _loc_2.margin;
                        return;
                    }
                }
                if (this._horse.totalFrame > 0 && this._horse.totalFrame > this._horse.frame)
                {
                    this.horseZ = (-Math.sin((this._horse.frame + _loc_2.phase) / this._horse.totalFrame * Math.PI * 2)) * _loc_2.margin;
                }
            }
            else if (_loc_2.mode == 2)
            {
                if (this._horse._frameLeft == 0 && this._horse._currFrame == _loc_2.glideFrame && _loc_2.glideProb > 0)
                {
                    if (Math.random() < _loc_2.glideProb)
                    {
                        this._horse.sleepAnimation();
                        _loc_2.glide = _loc_2.glideFrameMin + Math.floor((_loc_2.glideFrameMax - _loc_2.glideFrameMin) * Math.random());
                        return;
                    }
                }
                if (this._horse._currFrame == 1)
                {
                    this.horseZ = (-_loc_2.margin - this.horseZ) / _loc_2.decay + this.horseZ;
                }
                else if (this._horse._currFrame == 3)
                {
                    this.horseZ = (_loc_2.margin - this.horseZ) / _loc_2.decay + this.horseZ;
                }
            }
            else if (_loc_2.mode == 4)
            {
                this.horseZ = (-Math.sin(_loc_2.frame / _loc_2.totalFrame * Math.PI * 2)) * _loc_2.margin;
                var _loc_3:* = _loc_2;
                var _loc_4:* = _loc_2.frame + 1;
                _loc_3.frame = _loc_4;
                if (_loc_2.frame > _loc_2.totalFrame)
                {
                    _loc_2.frame = 0;
                }
            }
            return;
        }// end function

        private function set horseZ(param1)
        {
            if (this._horse != null)
            {
                this._horse.zoff = param1;
            }
            if (this._img != null)
            {
                this._img.y = -param1 - this._horseH;
            }
            return;
        }// end function

        private function get horseZ()
        {
            return this._horse.zoff;
        }// end function

        private function handleImgRedraw(param1)
        {
            dispatchEvent(new UnitEvent("redraw"));
            this.changeStateTo(this._state);
            return;
        }// end function

        public function free()
        {
            this.silent = false;
            this.stun = false;
            this.taunt = false;
            this.itemDisable = false;
            this.attackDisable = false;
            this.ice = false;
            this.stun = false;
            this.actionLock = false;
            return;
        }// end function

        public function set silent(param1)
        {
            this._silent = param1;
            return;
        }// end function

        public function get silent()
        {
            return this._silent;
        }// end function

        public function set stun(param1)
        {
            this._stun = param1;
            return;
        }// end function

        public function get stun()
        {
            return this._stun;
        }// end function

        public function set taunt(param1)
        {
            this._taunt = param1;
            return;
        }// end function

        public function get taunt()
        {
            return this._taunt;
        }// end function

        public function set itemDisable(param1)
        {
            this._itemDisable = param1;
            return;
        }// end function

        public function get itemDisable()
        {
            return this._itemDisable;
        }// end function

        public function set attackDisable(param1)
        {
            this._attackDisable = param1;
            return;
        }// end function

        public function get attackDisable()
        {
            return this._attackDisable;
        }// end function

        public function set stealth(param1)
        {
            if (param1)
            {
                UnitEffect.flash(this);
                if (this._mc != null)
                {
                    this._mc.alpha = 0.6;
                }
            }
            else if (this._mc != null)
            {
                this._mc.alpha = 1;
            }
            this._stealth = param1;
            return;
        }// end function

        public function get stealth()
        {
            return this._stealth;
        }// end function

        public function set ice(param1)
        {
            this._ice = param1;
            if (this._ice)
            {
                UnitEffect.freeze(this);
            }
            return;
        }// end function

        public function get ice()
        {
            return this._ice;
        }// end function

        public function set name(param1:String) : void
        {
            if (param1 == "0")
            {
                this._name = "";
            }
            else
            {
                this._name = param1;
            }
            if (this.type == UNIT_TYPE_ENUM.TYPEID_PLAYER && this.id == Player._playerId)
            {
                Player.name = this._name;
            }
            if (this._stateBar != null)
            {
                this._stateBar.name = this._name;
            }
            dispatchEvent(new UnitEvent("update", "name", this._name));
            return;
        }// end function

        public function set pkState(param1) : void
        {
            this._pkState = param1;
            if (Config.map != null)
            {
                if (Config.map._type != 11 || Config.map._type != 13 || this._camp == 0)
                {
                    this.changePkName();
                }
            }
            dispatchEvent(new UnitEvent("update", "pkState", param1));
            return;
        }// end function

        public function get pkState() : int
        {
            return this._pkState;
        }// end function

        private function warNameChange(param1:int = 1) : void
        {
            if (param1 == 1)
            {
                this._stateBar.nameColor = 1793259;
            }
            else if (param1 == 2)
            {
                this._stateBar.nameColor = 13767974;
            }
            else
            {
                this._stateBar.nameColor = 16777215;
            }
            return;
        }// end function

        private function gildWarName() : void
        {
            if (Config.map != null)
            {
                if (Config.map._type == 14 || Config.map._type == 24)
                {
                    this._stateBar.nameColor = 11344686;
                    return;
                }
                if (Config.map._type == 11 || Config.map._type == 13 || Config.map._type == 21)
                {
                    return;
                }
            }
            if (this._camp == 0)
            {
                if (this._pkState == 0)
                {
                    this._stateBar.nameColor = 65280;
                }
                else
                {
                    this._stateBar.nameColor = 11344686;
                }
            }
            else if (Config.player._camp == this._camp)
            {
                if (Config.player._gildTeam == this._gildTeam)
                {
                    this._stateBar.nameColor = 809678;
                }
                else
                {
                    this._stateBar.nameColor = 11344686;
                }
            }
            else if (this._pkState == 0)
            {
                this._stateBar.nameColor = 65280;
            }
            else
            {
                this._stateBar.nameColor = 11344686;
            }
            return;
        }// end function

        public function changePkName() : void
        {
            if (this._map != null)
            {
                if (this._map.hasOwnProperty("_data"))
                {
                    if (this._map._data != null)
                    {
                        if (this._map._data.hasOwnProperty("type"))
                        {
                            if (this._map._data.type == 14 || this._map._data.type == 24)
                            {
                                this._stateBar.nameColor = 11344686;
                                return;
                            }
                            if (this._map._data.type == 3 || this._map._data.type == 11 || this._map._data.type == 13 || this._map._data.type == 21)
                            {
                                return;
                            }
                        }
                    }
                }
            }
            if (this._pkState == 0)
            {
                this._stateBar.nameColor = 65280;
            }
            else
            {
                this._stateBar.nameColor = 11344686;
            }
            this.gildWarName();
            return;
        }// end function

        public function setNameColor(param1:int) : void
        {
            if (param1 == 0)
            {
                this._stateBar.nameColor = 16777215;
            }
            else if (param1 == 1)
            {
                this._stateBar.nameColor = 3196748;
            }
            else if (param1 == 2)
            {
                this._stateBar.nameColor = 11344686;
            }
            else if (param1 == 3)
            {
                this._stateBar.nameColor = 3295734;
            }
            return;
        }// end function

        public function get name() : String
        {
            if (this._name == "")
            {
                if (this._data == null)
                {
                    return "";
                }
                return String(this._data.name);
            }
            else
            {
                return this._name;
            }
        }// end function

        public function set titleId(param1) : void
        {
            if (this.type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
            {
                this._titleId = param1;
                this._stateBar.titleId = this._titleId;
            }
            return;
        }// end function

        public function get titleId()
        {
            return this._titleId;
        }// end function

        public function set title(param1:String) : void
        {
            if (param1 == "0")
            {
                this._title = "";
            }
            else
            {
                this._title = param1;
            }
            if (this.id == Player._playerId)
            {
                Player.title = this._title;
            }
            if (this._stateBar != null)
            {
                this._stateBar.title = this._title;
            }
            dispatchEvent(new UnitEvent("update", "title", this._title));
            return;
        }// end function

        public function get title() : String
        {
            return this._title;
        }// end function

        public function set publicCd(param1)
        {
            this._publicCd = param1;
            dispatchEvent(new UnitEvent("update", "publicCd", this._publicCd));
            return;
        }// end function

        public function get publicCd()
        {
            return this._publicCd;
        }// end function

        public function set normalRange(param1)
        {
            this._normalRange = param1;
            dispatchEvent(new UnitEvent("update", "normalRange", this._normalRange));
            return;
        }// end function

        public function get normalRange()
        {
            return this._normalRange;
        }// end function

        public function set sex(param1)
        {
            this._sex = param1;
            if (this.id == Player._playerId)
            {
                Player.sex = this._sex;
            }
            dispatchEvent(new UnitEvent("update", "sex", this._sex));
            return;
        }// end function

        public function get sex()
        {
            return this._sex;
        }// end function

        public function set job(param1)
        {
            this._job = param1;
            if (this.id == Player._playerId)
            {
                Player.job = this._job;
            }
            if (this._job == 1 || this._job == 13)
            {
                this.attackMode = Config._skillMap[5020];
            }
            else if (this._job == 4 || this._job == 16)
            {
                this.attackMode = Config._skillMap[5000];
            }
            else if (this._job == 7 || this._job == 19)
            {
                this.attackMode = Config._skillMap[5020];
            }
            else if (this._job == 10 || this._job == 22)
            {
                this.attackMode = Config._skillMap[5010];
            }
            dispatchEvent(new UnitEvent("update", "job", this._job));
            return;
        }// end function

        public function set baseData(param1)
        {
            this._data = param1;
            if (this._data != null)
            {
                if (this._data.normalAtkId != null)
                {
                    this.attackMode = Config._skillMap[this._data.normalAtkId];
                }
            }
            this.name = String(this._data.name);
            this.title = String(this._data.title);
            this.reDraw();
            return;
        }// end function

        public function set model(param1)
        {
            this.reDraw();
            return;
        }// end function

        public function get attackMode()
        {
            return this._attackMode;
        }// end function

        public function set attackMode(param1)
        {
            this._attackMode = param1;
            return;
        }// end function

        public function get job()
        {
            return this._job;
        }// end function

        public function set speed(param1)
        {
            this._speed = param1;
            dispatchEvent(new UnitEvent("update", "speed", this._speed));
            return;
        }// end function

        public function get speed()
        {
            return this._speed;
        }// end function

        public function set level(param1)
        {
            this._level = param1;
            dispatchEvent(new UnitEvent("update", "level", this._level));
            return;
        }// end function

        public function get level()
        {
            return this._level;
        }// end function

        public function set id(param1)
        {
            delete _unitStack[this._type][this._id];
            this._id = param1;
            _unitStack[this._type][this._id] = this;
            return;
        }// end function

        public function get id()
        {
            return this._id;
        }// end function

        public function set type(param1)
        {
            delete _unitStack[this._type][this._id];
            this._type = param1;
            if (_unitStack[this._type] == null)
            {
                _unitStack[this._type] = {};
            }
            _unitStack[this._type][this._id] = this;
            return;
        }// end function

        public function get type()
        {
            return this._type;
        }// end function

        public function setTypeId(param1, param2)
        {
            delete _unitStack[this._type][this._id];
            this._type = param1;
            this._id = param2;
            if (_unitStack[this._type] == null)
            {
                _unitStack[this._type] = {};
            }
            _unitStack[this._type][this._id] = this;
            return;
        }// end function

        public function startGather(param1, param2, param3 = 0)
        {
            this.stopLoop(this.gatherLoop);
            this._gatherTime = param2;
            this._gatherTimeCount = param2 - param1;
            this.startLoop(this.gatherLoop);
            return;
        }// end function

        private function gatherLoop(param1)
        {
            this._gatherTimeCount = this._gatherTimeCount + 1000 / Config.fps;
            this._stateBar.gather = this._gatherTimeCount / this._gatherTime;
            if (this._gatherTimeCount >= this._gatherTime)
            {
                this._stateBar.gather = -1;
                this.stopLoop(this.gatherLoop);
            }
            return;
        }// end function

        public function stopGather()
        {
            this._stateBar.gather = -1;
            this.stopLoop(this.gatherLoop);
            return;
        }// end function

        public function set stamina(param1)
        {
            this._stamina = param1;
            dispatchEvent(new UnitEvent("update", "stamina", this._stamina));
            return;
        }// end function

        public function get stamina()
        {
            return this._stamina;
        }// end function

        public function set hp(param1)
        {
            this._hp = param1;
            if (this._stateBar != null)
            {
                this._stateBar.hp = this._hp / this._hpMax;
            }
            this._stateBar.check();
            dispatchEvent(new UnitEvent("update", "hp", this._hp));
            if (this._hp <= 0)
            {
                dispatchEvent(new UnitEvent("die"));
                dispatchEvent(new UnitEvent("update", "die"));
            }
            return;
        }// end function

        public function set warTeam(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            this._warTeam = param1;
            if (Config.map != null)
            {
                if (Config.map._type == 11)
                {
                    if (Config.player.warTeam == this.warTeam)
                    {
                        this.name = Config.language("Unit", 8);
                        this._stateBar.nameColor = 809678;
                    }
                    else
                    {
                        this.name = Config.language("Unit", 9);
                        this._stateBar.nameColor = 11344686;
                    }
                }
                if (this.id == Config.player.id)
                {
                    _loc_2 = Unit.getPlayerlist();
                    for (_loc_3 in _loc_2)
                    {
                        
                        if (_loc_2[_loc_3].id != Config.player.id)
                        {
                            _loc_2[_loc_3].warTeam = _loc_2[_loc_3].warTeam;
                        }
                    }
                }
            }
            return;
        }// end function

        public function set monsterCamp(param1)
        {
            this._monsterCamp = param1;
            Config.ui._radar.addUnit(this);
            return;
        }// end function

        public function get monsterCamp()
        {
            return this._monsterCamp;
        }// end function

        public function get warTeam() : int
        {
            return this._warTeam;
        }// end function

        public function set gildid(param1:int) : void
        {
            this._gildid = param1;
            return;
        }// end function

        public function get gildid() : int
        {
            return this._gildid;
        }// end function

        public function set guildInfo(param1)
        {
            this.setgildinfor(param1[0], param1[1], param1[2], param1[3], param1[4]);
            return;
        }// end function

        public function setgildinfor(param1:int, param2:String, param3:int, param4:int, param5:int) : void
        {
            this._gildid = param1;
            this._gilename = param2;
            this._gildpower = param3;
            this._camp = param4;
            this._gildTeam = param5;
            var _loc_6:* = "";
            switch(this._gildpower)
            {
                case 1:
                {
                    _loc_6 = Config.language("Unit", 3);
                    break;
                }
                case 2:
                {
                    _loc_6 = Config.language("Unit", 4);
                    break;
                }
                case 3:
                {
                    _loc_6 = Config.language("Unit", 5);
                    break;
                }
                case 4:
                {
                    _loc_6 = "";
                    break;
                }
                case 5:
                {
                    _loc_6 = "";
                    break;
                }
                case 6:
                {
                    _loc_6 = "";
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (Config.player == null)
            {
                return;
            }
            if (param1 == 0)
            {
                this._stateBar.setgild(this._gilename, "#e4fa8b", "");
                this._gildpower = 0;
                this._gilename = "";
                if (this._map != null && this._map._data != null && this._map._data.type == 3)
                {
                    this.warNameChange(3);
                }
                else
                {
                    this.gildWarName();
                }
                return;
            }
            if (this._gildid == Config.player.gildid)
            {
                if (this._stateBar != null)
                {
                    this._stateBar.setgild(this._gilename, "#e4fa8b", _loc_6);
                }
                if (this._map != null && this._map._data != null && this._map._data.type == 3)
                {
                    this.warNameChange(1);
                }
                else
                {
                    this.gildWarName();
                }
            }
            else if (this._stateBar != null)
            {
                if (Config.ui._gangs.inGild(this._gildid))
                {
                    this._stateBar.setgild(this._gilename, "#006600", _loc_6);
                    if (this._map != null && this._map._data != null && this._map._data.type == 3)
                    {
                        this.warNameChange(1);
                    }
                    else
                    {
                        this.gildWarName();
                    }
                }
                else
                {
                    this._stateBar.setgild(this._gilename, "#ffffff", _loc_6);
                    if (this._map != null && this._map._data != null && this._map._data.type == 3)
                    {
                        this.warNameChange(2);
                    }
                    else
                    {
                        this.gildWarName();
                    }
                }
            }
            return;
        }// end function

        public function get hp()
        {
            return this._hp;
        }// end function

        public function set hpMax(param1)
        {
            this._hpMax = param1;
            if (this._stateBar != null)
            {
                this._stateBar.hp = this._hp / this._hpMax;
            }
            dispatchEvent(new UnitEvent("update", "hpMax", this._hpMax));
            return;
        }// end function

        public function get hpMax()
        {
            return this._hpMax;
        }// end function

        public function set mp(param1)
        {
            this._mp = param1;
            dispatchEvent(new UnitEvent("update", "mp", this._mp));
            return;
        }// end function

        public function get mp()
        {
            return this._mp;
        }// end function

        public function set mpMax(param1)
        {
            this._mpMax = param1;
            dispatchEvent(new UnitEvent("update", "mpMax", this._mpMax));
            return;
        }// end function

        public function get mpMax()
        {
            return this._mpMax;
        }// end function

        public function set exp(param1)
        {
            this._exp = param1;
            dispatchEvent(new UnitEvent("update", "exp", this._exp));
            return;
        }// end function

        public function get exp()
        {
            return this._exp;
        }// end function

        public function set expUpdate(param1)
        {
            this._expUpdate = param1;
            dispatchEvent(new UnitEvent("update", "expUpdate", this._expUpdate));
            return;
        }// end function

        public function get expUpdate()
        {
            return this._expUpdate;
        }// end function

        public function set evade(param1)
        {
            this._evade = param1;
            dispatchEvent(new UnitEvent("update", "evade", param1));
            return;
        }// end function

        public function get evade()
        {
            return this._evade;
        }// end function

        public function set rate(param1)
        {
            this._rate = param1;
            dispatchEvent(new UnitEvent("update", "rate", param1));
            return;
        }// end function

        public function get rate()
        {
            return this._rate;
        }// end function

        public function set skillEvade(param1)
        {
            this._skillEvade = param1;
            dispatchEvent(new UnitEvent("update", "skillEvade", param1));
            return;
        }// end function

        public function get skillEvade()
        {
            return this._skillEvade;
        }// end function

        public function set skillRate(param1)
        {
            this._skillRate = param1;
            dispatchEvent(new UnitEvent("update", "skillRate", param1));
            return;
        }// end function

        public function get skillRate()
        {
            return this._skillRate;
        }// end function

        public function set criticalRate(param1)
        {
            this._criticalRate = param1;
            dispatchEvent(new UnitEvent("update", "criticalRate", param1));
            return;
        }// end function

        public function get criticalRate()
        {
            return this._criticalRate;
        }// end function

        public function set criticalEvade(param1)
        {
            this._criticalEvade = param1;
            dispatchEvent(new UnitEvent("update", "criticalEvade", param1));
            return;
        }// end function

        public function get criticalEvade()
        {
            return this._criticalEvade;
        }// end function

        public function set criticalMulti(param1)
        {
            this._criticalMulti = param1;
            dispatchEvent(new UnitEvent("update", "criticalMulti", param1));
            return;
        }// end function

        public function get criticalMulti()
        {
            return this._criticalMulti;
        }// end function

        public function set criticalResist(param1)
        {
            this._criticalResist = param1;
            dispatchEvent(new UnitEvent("update", "criticalResist", param1));
            return;
        }// end function

        public function get criticalResist()
        {
            return this._criticalResist;
        }// end function

        public function set skillCriticalRate(param1)
        {
            this._skillCriticalRate = param1;
            dispatchEvent(new UnitEvent("update", "skillCriticalRate", param1));
            return;
        }// end function

        public function get skillCriticalRate()
        {
            return this._skillCriticalRate;
        }// end function

        public function set skillCriticalEvade(param1)
        {
            this._skillCriticalEvade = param1;
            dispatchEvent(new UnitEvent("update", "skillCriticalEvade", param1));
            return;
        }// end function

        public function get skillCriticalEvade()
        {
            return this._skillCriticalEvade;
        }// end function

        public function set skillCriticalMulti(param1)
        {
            this._skillCriticalMulti = param1;
            dispatchEvent(new UnitEvent("update", "skillCriticalMulti", param1));
            return;
        }// end function

        public function get skillCriticalMulti()
        {
            return this._skillCriticalMulti;
        }// end function

        public function set skillCriticalResist(param1)
        {
            this._skillCriticalResist = param1;
            dispatchEvent(new UnitEvent("update", "skillCriticalResist", param1));
            return;
        }// end function

        public function get skillCriticalResist()
        {
            return this._skillCriticalResist;
        }// end function

        public function set criticalAdd(param1)
        {
            this._criticalAdd = param1;
            dispatchEvent(new UnitEvent("update", "criticalAdd", param1));
            return;
        }// end function

        public function get criticalAdd()
        {
            return this._criticalAdd;
        }// end function

        public function set criticalMinus(param1)
        {
            this._criticalMinus = param1;
            dispatchEvent(new UnitEvent("update", "criticalMinus", param1));
            return;
        }// end function

        public function get criticalMinus()
        {
            return this._criticalMinus;
        }// end function

        public function set atk(param1)
        {
            this._atk = param1;
            dispatchEvent(new UnitEvent("update", "atk", param1));
            return;
        }// end function

        public function get atk()
        {
            return this._atk;
        }// end function

        public function set atkRanged(param1)
        {
            this._atkRanged = param1;
            dispatchEvent(new UnitEvent("update", "atkRanged", param1));
            return;
        }// end function

        public function get atkRanged()
        {
            return this._atkRanged;
        }// end function

        public function set atkMagic(param1)
        {
            this._atkMagic = param1;
            dispatchEvent(new UnitEvent("update", "atkMagic", param1));
            return;
        }// end function

        public function get atkMagic()
        {
            return this._atkMagic;
        }// end function

        public function set def(param1)
        {
            this._def = param1;
            dispatchEvent(new UnitEvent("update", "def", param1));
            return;
        }// end function

        public function get def()
        {
            return this._def;
        }// end function

        public function set defRanged(param1)
        {
            this._defRanged = param1;
            dispatchEvent(new UnitEvent("update", "defRanged", param1));
            return;
        }// end function

        public function get defRanged()
        {
            return this._defRanged;
        }// end function

        public function set defMagic(param1)
        {
            this._defMagic = param1;
            dispatchEvent(new UnitEvent("update", "defMagic", param1));
            return;
        }// end function

        public function get defMagic()
        {
            return this._defMagic;
        }// end function

        public function set atkAdd(param1)
        {
            this._atkAdd = param1;
            dispatchEvent(new UnitEvent("update", "atkAdd", param1));
            return;
        }// end function

        public function get atkAdd()
        {
            return this._atkAdd;
        }// end function

        public function set defAdd(param1)
        {
            this._defAdd = param1;
            dispatchEvent(new UnitEvent("update", "defAdd", param1));
            return;
        }// end function

        public function get defAdd()
        {
            return this._defAdd;
        }// end function

        public function set atkRangedAdd(param1)
        {
            this._atkRangedAdd = param1;
            dispatchEvent(new UnitEvent("update", "atkRangedAdd", param1));
            return;
        }// end function

        public function get atkRangedAdd()
        {
            return this._atkRangedAdd;
        }// end function

        public function set defRangedAdd(param1)
        {
            this._defRangedAdd = param1;
            dispatchEvent(new UnitEvent("update", "defRangedAdd", param1));
            return;
        }// end function

        public function get defRangedAdd()
        {
            return this._defRangedAdd;
        }// end function

        public function set atkMagicAdd(param1)
        {
            this._atkMagicAdd = param1;
            dispatchEvent(new UnitEvent("update", "atkMagicAdd", param1));
            return;
        }// end function

        public function get atkMagicAdd()
        {
            return this._atkMagicAdd;
        }// end function

        public function set defMagicAdd(param1)
        {
            this._defMagicAdd = param1;
            dispatchEvent(new UnitEvent("update", "defMagicAdd", param1));
            return;
        }// end function

        public function get defMagicAdd()
        {
            return this._defMagicAdd;
        }// end function

        public function set atkSpeedLevel(param1)
        {
            this._atkSpeedLevel = param1;
            dispatchEvent(new UnitEvent("update", "atkSpeedLevel", param1));
            return;
        }// end function

        public function get atkSpeedLevel()
        {
            return this._atkSpeedLevel;
        }// end function

        public function get money1()
        {
            return this._money1;
        }// end function

        public function get money2()
        {
            return this._money2;
        }// end function

        public function get money3()
        {
            return this._money3;
        }// end function

        public function get money4()
        {
            return this._money4;
        }// end function

        public function get instanceSore()
        {
            return this._instanceSore;
        }// end function

        public function get honor()
        {
            return this._honor;
        }// end function

        public function set money1(param1)
        {
            this._money1 = param1;
            dispatchEvent(new UnitEvent("update", "money1", param1));
            return;
        }// end function

        public function set money2(param1)
        {
            if (this._money2 == 0 && param1 > 0)
            {
                GuideUI.testDoId(62, Config.ui._radar._mallBtn);
            }
            else if (this._money2 < 50 && param1 >= 50)
            {
                if (GuideUI.testId(64))
                {
                    GuideUI.doId(64, Config.ui._radar._mallBtn);
                    ShopMall._preGuideTime = getTimer();
                }
            }
            else if (this._money2 < 100 && param1 >= 100)
            {
                if (GuideUI.testId(65))
                {
                    GuideUI.doId(65, Config.ui._radar._mallBtn);
                    ShopMall._preGuideTime = getTimer();
                }
            }
            else if (this._money2 < 200 && param1 >= 200)
            {
                if (GuideUI.testId(66))
                {
                    GuideUI.doId(66, Config.ui._radar._mallBtn);
                    ShopMall._preGuideTime = getTimer();
                }
            }
            this._money2 = param1;
            dispatchEvent(new UnitEvent("update", "money2", param1));
            return;
        }// end function

        public function set money3(param1)
        {
            this._money3 = param1;
            dispatchEvent(new UnitEvent("update", "money3", param1));
            return;
        }// end function

        public function set money4(param1)
        {
            this._money4 = param1;
            dispatchEvent(new UnitEvent("update", "money4", param1));
            return;
        }// end function

        public function set instanceSore(param1)
        {
            this._instanceSore = param1;
            dispatchEvent(new UnitEvent("update", "instanceSore", param1));
            return;
        }// end function

        public function set honor(param1)
        {
            this._honor = param1;
            dispatchEvent(new UnitEvent("update", "honor", param1));
            return;
        }// end function

        public function get die() : Boolean
        {
            return this._hp <= 0;
        }// end function

        public function faceTo(param1)
        {
            if (param1 != null && param1 != this)
            {
                this._angle = Math.atan2(param1._y - this._y, param1._x - this._x);
                this.directTo(this._angle);
            }
            return;
        }// end function

        function startLoop(param1:Function)
        {
            if (this._mc != null)
            {
                this.stopLoop(param1);
                this._enterframeListenerArray.push(param1);
                if (this._enterframeListenerArray.length == 1)
                {
                    this._mc.addEventListener(Event.ENTER_FRAME, this.enterframeLoop);
                }
            }
            return;
        }// end function

        function stopLoop(param1:Function)
        {
            var _loc_2:* = undefined;
            if (this._mc != null)
            {
                _loc_2 = 0;
                while (_loc_2 < this._enterframeListenerArray.length)
                {
                    
                    if (this._enterframeListenerArray[_loc_2] == param1)
                    {
                        this._enterframeListenerArray.splice(_loc_2, 1);
                        break;
                    }
                    _loc_2 = _loc_2 + 1;
                }
                if (this._enterframeListenerArray.length == 0)
                {
                    this._mc.removeEventListener(Event.ENTER_FRAME, this.enterframeLoop);
                }
            }
            return;
        }// end function

        private function enterframeLoop(param1)
        {
            var _loc_2:* = undefined;
            if (!Config.paused)
            {
                for (_loc_2 in this._enterframeListenerArray)
                {
                    
                    var _loc_5:* = this._enterframeListenerArray;
                    _loc_5.this._enterframeListenerArray[_loc_2](param1);
                }
            }
            if (this._enterframeListenerArray.length == 0)
            {
                this._mc.removeEventListener(Event.ENTER_FRAME, this.enterframeLoop);
            }
            return;
        }// end function

        function clearEnterframeLoop()
        {
            var _loc_1:* = undefined;
            this._enterframeListenerArray = [];
            if (this._mc != null)
            {
                this._mc.removeEventListener(Event.ENTER_FRAME, this.enterframeLoop);
            }
            return;
        }// end function

        public function set fadeDeath(param1)
        {
            this._fadeDeath = param1;
            this.changeStateTo(this._state);
            return;
        }// end function

        public function destroy()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            this.clearFollower();
            this._forceIdleAct = "";
            if (this._stateBar._stallpanel != null)
            {
                this._stateBar._stallpanel.removeEventListener("click", this.testBoothDis);
            }
            this._monsterCamp = 0;
            this._gildid = 0;
            this._gilename = "";
            this._gildpower = 6;
            this._camp = 0;
            this._gildTeam = 0;
            this._imgY = 0;
            this.titleId = 0;
            this.horse = null;
            var _loc_7:* = _allCount - 1;
            _allCount = _loc_7;
            this._appearance = true;
            this._buffClip = 0;
            this._forceClip = 0;
            this.stopLoop(this.subDisplay);
            this.belongTeam = 0;
            this.belongPlayer = 0;
            this.stopBinding();
            this.fadeDeath = false;
            this.clearEnterframeLoop();
            if (this._map != null)
            {
                this._map.removeEventListener("complete", this.handleMapComplete);
            }
            if (this._img != null)
            {
                this._img.removeEventListener("complete", this.handleImgComplete);
            }
            this.removeBorder();
            clearTimeout(this._playEffectTimer);
            clearTimeout(this._playHurtTimer);
            clearTimeout(this._releaseHurtTimer);
            this.stopSlip();
            this.say("");
            for (_loc_1 in this._haloEffect)
            {
                
                this.removeHalo(_loc_1);
            }
            this._haloEffect = {};
            for (_loc_1 in this._buffEffect)
            {
                
                this.removeBuff(_loc_1, true);
            }
            this._buffEffect = {};
            if (this._effect != null)
            {
                if (this._effect.parent != null)
                {
                    this._effect.parent.removeChild(this._effect);
                }
                this._effect.destroy();
                this._effect = null;
            }
            _loc_4 = false;
            delete _unitStack[this._type][this._id];
            if (this._currTile != null)
            {
                this._currTile.removeUnit(this);
                this._currTile = null;
            }
            if (Config.ui != null)
            {
                Config.ui._teamUI.teamlen(this._id, false);
            }
            dispatchEvent(new Event("destroy"));
            this.visible = false;
            this._stateBar.destroy();
            if (this._img != null)
            {
                this._img.removeEventListener("complete", this.handleImgRedraw);
                this._img.removeEventListener("weaponComplete", this.handleImgRedraw);
                this._img.destroy();
                if (this._img.parent != null)
                {
                    this._img.parent.removeChild(this._img);
                }
                this._img = null;
            }
            this._state = "idle";
            Config.clearDisplayList(this._mc);
            this._die = false;
            clearTimeout(this._visibleTimer);
            return;
        }// end function

        public function display(param1)
        {
            if (this._sayRect == null)
            {
                this._sayRect = new Sprite();
            }
            if (this._sayTxt == null)
            {
                this._sayTxt = new RichTextField(200, 20);
                this._sayTxt.defaultTextFormat = _sayTxtDefaultTextFormat;
            }
            this._sayTxt.selectable = false;
            this._sayRect.addChild(this._sayTxt);
            if (this._preSayTxt == null)
            {
                this._preSayTxt = new RichTextField(200, 300);
                this._preSayTxt.defaultTextFormat = _sayTxtDefaultTextFormat;
            }
            this._preSayTxt.selectable = false;
            if (this._mc == null)
            {
                this._mc = new Sprite();
                this._mc.mouseEnabled = false;
                this._mc.mouseChildren = false;
            }
            if (this._type == UNIT_TYPE_ENUM.TYPEID_PLAYER || this._type == UNIT_TYPE_ENUM.TYPEID_NPC)
            {
                if (this.name != null)
                {
                    this._stateBar.name = this.name;
                }
            }
            this._map = param1;
            if (this._map._state == "ready")
            {
                this.subDisplay();
            }
            else
            {
                this._map.removeEventListener("complete", this.handleMapComplete);
                this._map.addEventListener("complete", this.handleMapComplete);
            }
            if (this._follower != null)
            {
                this._follower.display(this._map);
            }
            return;
        }// end function

        private function handleMapComplete(param1)
        {
            this._map.removeEventListener("complete", this.handleMapComplete);
            this.draw();
            this.startLoop(this.subDisplay);
            return;
        }// end function

        public function set hue(param1)
        {
            if (this._img != null)
            {
                this._img.setHue(param1);
            }
            return;
        }// end function

        public function set forceHue(param1)
        {
            this._forceClipHue = param1;
            if (this._buffClip == 0 && this._forceClip != 0)
            {
                if (this._img != null)
                {
                    this._img.setHue(this._forceClipHue);
                }
            }
            return;
        }// end function

        protected function imgComplete()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            if (this._img == null)
            {
                return;
            }
            this._img.removeEventListener("complete", this.handleImgComplete);
            if (this._data.hue != null)
            {
                this._img.setHue(this._data.hue);
            }
            this._stateBar.check();
            if (this._img != null)
            {
                this._stateBar.setPos(this._mc.x, this._mc.y - this._img._bitmapRectY + this._imgY, this._img._bitmapRectY - this._imgY);
            }
            return;
        }// end function

        private function handleImgComplete(param1)
        {
            param1.target.removeEventListener("complete", this.handleImgComplete);
            this.imgComplete();
            return;
        }// end function

        function subDisplay(param1 = null)
        {
            if (this._img == null)
            {
                this.reDraw();
            }
            this.stopLoop(this.subDisplay);
            this.visible = true;
            this.draw();
            var _loc_2:* = this._map.mapToTile({_x:this._x, _y:this._y});
            if (_loc_2 != this._currTile)
            {
                this._currTile = _loc_2;
                this._currTile.addUnit(this);
                this.swapDepthTile();
            }
            this._stateBar.check();
            if (this._img != null)
            {
                this._stateBar.setPos(this._mc.x, this._mc.y - this._img._bitmapRectY + this._imgY, this._img._bitmapRectY - this._imgY);
            }
            dispatchEvent(new Event("move"));
            dispatchEvent(new Event("pass"));
            return;
        }// end function

        private function clearClipFilter()
        {
            return;
        }// end function

        public function set buffClip(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = this._buffClip;
            if (param1 == null || param1 == 0)
            {
                this._buffClip = 0;
                this._buffClipHue = 0;
            }
            else
            {
                _loc_3 = String(param1).split("_");
                if (_loc_3.length == 0)
                {
                    this._buffClip = Number(param1);
                    this._buffClipHue = 0;
                }
                else
                {
                    this._buffClip = Number(_loc_3[0]);
                    this._buffClipHue = Number(_loc_3[1]);
                }
            }
            if (_loc_2 != this._buffClip)
            {
                this.changeClip();
            }
            return;
        }// end function

        public function set forceClip(param1)
        {
            var _loc_2:* = this._forceClip;
            if (param1 == null)
            {
                this._forceClip = 0;
            }
            else
            {
                this._forceClip = param1;
            }
            if (_loc_2 != this._forceClip)
            {
                this.changeClip();
            }
            return;
        }// end function

        function changeClip()
        {
            if (this._forceClip < 0)
            {
                this._selectable = false;
                this._walkBlock = false;
                this._stateBar.visible = false;
            }
            else
            {
                this._selectable = true;
                this._walkBlock = true;
                this._stateBar.check();
            }
            if (this._map == null || this._map._state == "ready")
            {
                this.reDraw();
            }
            else
            {
                this._map.removeEventListener("complete", this.handleMapComplete);
                this._map.addEventListener("complete", this.handleMapComplete);
            }
            return;
        }// end function

        public function get forceClip()
        {
            return this._forceClip;
        }// end function

        public function get buffClip()
        {
            return this._buffClip;
        }// end function

        private function sortEffect(param1 = false)
        {
            var _loc_2:* = undefined;
            if (this._mc == null)
            {
                return;
            }
            var _loc_3:* = [];
            var _loc_4:* = [];
            var _loc_5:* = {};
            var _loc_6:* = {};
            for (_loc_2 in this._buffEffect)
            {
                
                if (this._buffEffect[_loc_2].effect != null)
                {
                    if (this._buffEffect[_loc_2].effect._destroyed)
                    {
                        continue;
                    }
                    if (Number(this._buffEffect[_loc_2].effect._data.under) == 1)
                    {
                        _loc_3.push(this._buffEffect[_loc_2].effect);
                        if (param1)
                        {
                            if (Number(this._buffEffect[_loc_2].effect._data.autoHeight) == 1 && this._img != null)
                            {
                                _loc_5[(_loc_3.length - 1)] = -this._img._bitmapRectY;
                            }
                        }
                        continue;
                    }
                    _loc_4.push(this._buffEffect[_loc_2].effect);
                    if (param1)
                    {
                        if (Number(this._buffEffect[_loc_2].effect._data.autoHeight) == 1 && this._img != null)
                        {
                            _loc_6[(_loc_4.length - 1)] = -this._img._bitmapRectY;
                        }
                    }
                }
            }
            for (_loc_2 in this._haloEffect)
            {
                
                if (this._haloEffect[_loc_2] != null)
                {
                    if (this._haloEffect[_loc_2]._destroyed || this._haloEffect[_loc_2].parent != this._mc)
                    {
                        continue;
                    }
                    if (Number(this._haloEffect[_loc_2]._data.under) == 1)
                    {
                        _loc_3.push(this._haloEffect[_loc_2]);
                        if (param1)
                        {
                            if (this._haloHEffect[_loc_2] != null)
                            {
                                _loc_5[(_loc_3.length - 1)] = this._haloHEffect[_loc_2];
                            }
                        }
                        continue;
                    }
                    _loc_4.push(this._haloEffect[_loc_2]);
                    if (param1)
                    {
                        if (this._haloHEffect[_loc_2] != null)
                        {
                            _loc_6[(_loc_4.length - 1)] = this._haloHEffect[_loc_2];
                        }
                    }
                }
            }
            if (this._effect != null)
            {
                if (this._effect._destroyed)
                {
                    this._effect = null;
                }
                else if (Number(this._effect._data.under) == 1)
                {
                    _loc_3.push(this._effect);
                }
                else
                {
                    _loc_4.push(this._effect);
                }
            }
            _loc_2 = 0;
            while (_loc_2 < _loc_3.length)
            {
                
                this._mc.addChild(_loc_3[_loc_2]);
                if (param1)
                {
                    if (_loc_5[_loc_2] == null)
                    {
                        _loc_3[_loc_2].y = this._imgY;
                    }
                    else
                    {
                        _loc_3[_loc_2].y = this._imgY + _loc_5[_loc_2];
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            if (this._img != null)
            {
                this._mc.addChild(this._img);
            }
            _loc_2 = 0;
            while (_loc_2 < _loc_4.length)
            {
                
                this._mc.addChild(_loc_4[_loc_2]);
                if (param1)
                {
                    if (_loc_6[_loc_2] == null)
                    {
                        _loc_4[_loc_2].y = this._imgY;
                    }
                    else
                    {
                        _loc_4[_loc_2].y = this._imgY + _loc_6[_loc_2];
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function addHalo(param1, param2 = 0, param3 = 0, param4 = null)
        {
            var _loc_5:* = null;
            if (this._map == null || this._mc == null)
            {
                return;
            }
            if (this._haloEffect[param1] == null)
            {
                _loc_5 = UnitClip.newUnitClip(Config._model[param1]);
                _loc_5.shadow = false;
                _loc_5.changeStateTo("idle");
                _loc_5.y = param2 + this._imgY;
                this._haloEffect[param1] = _loc_5;
                if (param2 != 0)
                {
                    this._haloHEffect[param1] = param2;
                }
                if (param4 != null)
                {
                    _loc_5.filters = param4;
                }
                if (param3 == 0)
                {
                    this._mc.addChild(_loc_5);
                    this.sortEffect();
                }
                else
                {
                    if (param3 == 1)
                    {
                        this._map._textMap.addChild(_loc_5);
                    }
                    else
                    {
                        this._map._footMap.addChild(_loc_5);
                    }
                    this._haloEffectOther[param1] = {effect:_loc_5, y:param2};
                    _loc_5.x = this._mc.x;
                    _loc_5.y = this._mc.y + param2 + this._imgY;
                }
            }
            return;
        }// end function

        public function removeHalo(param1)
        {
            if (this._haloEffect[param1] != null)
            {
                if (this._haloEffect[param1].parent != null)
                {
                    this._haloEffect[param1].parent.removeChild(this._haloEffect[param1]);
                }
                this._haloEffect[param1].destroy();
                delete this._haloEffect[param1];
                delete this._haloHEffect[param1];
            }
            if (this._haloEffectOther[param1] != null)
            {
                delete this._haloEffectOther[param1];
            }
            return;
        }// end function

        public function addBuff(param1, param2 = 1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            if (this._buffEffect[param1] == null)
            {
                if (Config._buffMap[param1] != null)
                {
                    if (String(Config._buffMap[param1].buffEffect) != "0")
                    {
                        this.addEffect(String(Config._buffMap[param1].buffEffect));
                    }
                    this._buffEffect[param1] = {};
                    this._buffEffect[param1].count = param2;
                    if (Number(Config._buffMap[param1].changeImg) != 0)
                    {
                        this.buffClip = String(Config._buffMap[param1].changeImg);
                        this._buffEffect[param1].buffClip = String(Config._buffMap[param1].changeImg);
                    }
                    _loc_4 = String(Config._buffMap[param1].lastingEffect);
                    if (_loc_4 != "0")
                    {
                        _loc_5 = _loc_4.split("_");
                        _loc_6 = UnitClip.newUnitClip(Config._model[Number(_loc_5[0])]);
                        _loc_6.shadow = false;
                        if (Number(Config._model[Number(_loc_5[0])].autoHeight) == 1 && this._img != null)
                        {
                            _loc_6.y = -this._img._bitmapRectY + this._imgY;
                        }
                        if (_loc_5.length == 2)
                        {
                            _loc_6.setHue(Number(_loc_5[1]));
                        }
                        this._buffEffect[param1].effect = _loc_6;
                        if (this._mc != null)
                        {
                            this._mc.addChild(_loc_6);
                        }
                        this.sortEffect();
                        _loc_6.changeStateTo("idle");
                        _loc_6.directTo(this._angle);
                    }
                    if (String(Config._buffMap[param1].lastingEffectSize) != "0")
                    {
                        _loc_7 = String(Config._buffMap[param1].lastingEffectSize).split("|");
                        _loc_3 = 0;
                        while (_loc_3 < _loc_7.length)
                        {
                            
                            _loc_8 = _loc_7[_loc_3].split(":");
                            switch(Number(_loc_8[0]))
                            {
                                case 2:
                                {
                                    UnitEffect.afterimage(this, 0, 15);
                                    break;
                                }
                                case 6:
                                {
                                    UnitEffect.whirl(this, 0);
                                    break;
                                }
                                case 12:
                                {
                                    UnitEffect.freeze(this);
                                    break;
                                }
                                case 17:
                                {
                                    UnitEffect.poison(this);
                                    break;
                                }
                                case 18:
                                {
                                    UnitEffect.stone(this);
                                    break;
                                }
                                case 20:
                                {
                                    UnitEffect.bleed(this);
                                    break;
                                }
                                case 24:
                                {
                                    UnitEffect.curse(this);
                                    break;
                                }
                                case 25:
                                {
                                    this.fadeDeath = true;
                                    break;
                                }
                                case 26:
                                {
                                    UnitEffect.cold(this);
                                    break;
                                }
                                case 29:
                                {
                                    if (_loc_8.length > 1)
                                    {
                                        this._forceIdleAct = _loc_8[1];
                                        if (this._img != null)
                                        {
                                            if (this._state == "idle")
                                            {
                                                this.changeStateTo("idle");
                                            }
                                        }
                                    }
                                    break;
                                }
                                case 30:
                                {
                                    if (_loc_8.length > 1)
                                    {
                                        SoundManager.play("stuff/sound/mp3/" + _loc_8[1] + ".mp3");
                                    }
                                    break;
                                }
                                case 31:
                                {
                                    UnitEffect.avatar(this);
                                    break;
                                }
                                case 33:
                                {
                                    UnitEffect.vampire(this);
                                    break;
                                }
                                case 34:
                                {
                                    if (_loc_8.length > 1)
                                    {
                                        this._atkSpeedLevelBuff = int(_loc_8[1]);
                                    }
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                            _loc_3 = _loc_3 + 1;
                        }
                    }
                }
            }
            else
            {
                this._buffEffect[param1].count = this._buffEffect[param1].count + param2;
            }
            return;
        }// end function

        public function removeBuff(param1, param2 = false)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            if (this._buffEffect[param1] != null)
            {
                if (this._buffEffect[param1].count > 1)
                {
                    var _loc_6:* = this._buffEffect[param1];
                    var _loc_7:* = this._buffEffect[param1].count - 1;
                    _loc_6.count = _loc_7;
                    return;
                }
                if (this._buffEffect[param1].buffClip != null)
                {
                    this.buffClip = 0;
                    delete this._buffEffect[param1].buffClip;
                }
                if (this._buffEffect[param1].effect != null)
                {
                    if (this._buffEffect[param1].effect.parent != null)
                    {
                        this._buffEffect[param1].effect.parent.removeChild(this._buffEffect[param1].effect);
                    }
                    this._buffEffect[param1].effect.destroy();
                    delete this._buffEffect[param1].effect;
                }
                if (String(Config._buffMap[param1].lastingEffectSize) != "0")
                {
                    _loc_4 = String(Config._buffMap[param1].lastingEffectSize).split("|");
                    _loc_3 = 0;
                    while (_loc_3 < _loc_4.length)
                    {
                        
                        _loc_5 = _loc_4[_loc_3].split(":");
                        switch(Number(_loc_5[0]))
                        {
                            case 2:
                            {
                                UnitEffect.killAfterimageLoop(this, param2);
                                break;
                            }
                            case 6:
                            {
                                UnitEffect.killWhirl(this);
                                break;
                            }
                            case 12:
                            {
                                UnitEffect.killFreeze(this, param2);
                                break;
                            }
                            case 17:
                            {
                                UnitEffect.killPoison(this, param2);
                                break;
                            }
                            case 18:
                            {
                                UnitEffect.killStone(this, param2);
                                break;
                            }
                            case 20:
                            {
                                UnitEffect.killBleed(this, param2);
                                break;
                            }
                            case 24:
                            {
                                UnitEffect.killCurse(this, param2);
                                break;
                            }
                            case 25:
                            {
                                this.fadeDeath = false;
                                break;
                            }
                            case 26:
                            {
                                UnitEffect.killCold(this, param2);
                                break;
                            }
                            case 29:
                            {
                                if (_loc_5.length > 0)
                                {
                                    this._forceIdleAct = "";
                                    if (this._img != null)
                                    {
                                        if (this._state == "idle")
                                        {
                                            this.changeStateTo("idle");
                                        }
                                    }
                                }
                                break;
                            }
                            case 31:
                            {
                                UnitEffect.killAvatar(this);
                                break;
                            }
                            case 33:
                            {
                                UnitEffect.killVampire(this);
                                break;
                            }
                            case 34:
                            {
                                this._atkSpeedLevelBuff = 0;
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                }
                delete this._buffEffect[param1];
            }
            return;
        }// end function

        public function removeEffect(param1 = null)
        {
            if (this._effect != null)
            {
                if (this._effect.parent != null)
                {
                    this._effect.parent.removeChild(this._effect);
                }
                this._effect.destroy();
                this._effect = null;
            }
            if (param1 != null)
            {
                this.param1();
            }
            return;
        }// end function

        public function addEffect(param1 = null, param2 = 1, param3 = null, param4 = null)
        {
            var data:*;
            var arr:*;
            var hue:*;
            var effectStr:* = param1;
            var loop:* = param2;
            var func:* = param3;
            var angle:* = param4;
            if (effectStr != null)
            {
                if (this._effect != null && this._effect._data == Config._model[Number(effectStr.split("_")[0])])
                {
                    return;
                }
            }
            if (this._effect != null)
            {
                if (this._effect.parent != null)
                {
                    this._effect.parent.removeChild(this._effect);
                }
                this._effect.destroy();
                this._effect = null;
            }
            if (effectStr != null && this._mc != null)
            {
                arr = effectStr.split("_");
                data = Config._model[Number(arr[0])];
                if (data.targetColor != null)
                {
                    UnitEffect.colorTransform(this, data.targetColor, data.effectStarting, data.effectEnding);
                }
                this._effect = UnitClip.newUnitClip(data);
                this._effect.shadow = false;
                if (Number(data.autoHeight) == 1 && this._img != null)
                {
                    this._effect.y = -this._img._bitmapRectY + this._imgY;
                }
                else
                {
                    this._effect.y = this._imgY;
                }
                if (arr.length == 2)
                {
                    this._effect.setHue(arr[1]);
                }
                this._mc.addChild(this._effect);
                this.sortEffect();
                if (loop < 1)
                {
                    this._effect.changeStateTo("idle");
                    if (angle == null)
                    {
                        this._effect.directTo(this._angle);
                    }
                    else
                    {
                        this._effect.directTo(angle);
                    }
                }
                else
                {
                    var after:* = function ()
            {
                removeEffect(func);
                return;
            }// end function
            ;
                    this._effect.changeStateTo("idle", after);
                    if (angle == null)
                    {
                        this._effect.directTo(this._angle);
                    }
                    else
                    {
                        this._effect.directTo(angle);
                    }
                }
            }
            return;
        }// end function

        public function forcePosition(param1)
        {
            var _loc_2:* = undefined;
            this._x = param1._x;
            this._y = param1._y;
            if (this._map != null && this._map._state == "ready")
            {
                param1 = this._map.mapToTile({_x:this._x, _y:this._y});
                _loc_2 = this._map._logicalTile[param1._x][param1._y];
                if (_loc_2 != this._currTile)
                {
                    if (this._currTile != null)
                    {
                        this._currTile.removeUnit(this);
                    }
                    this._currTile = _loc_2;
                    this._currTile.addUnit(this);
                    this.swapDepthTile();
                }
                this.draw();
            }
            return;
        }// end function

        public function slip(param1, param2, param3 = 10)
        {
            var _loc_5:* = undefined;
            if (this._map == null)
            {
                return;
            }
            this.stopSlip();
            var _loc_4:* = Math.atan2(param1._y - this._y, param1._x - this._x);
            this._slipObj = {x1:this._x, y1:this._y, x2:param1._x, y2:param1._y, count:0, time:param3, slipAngle:_loc_4, angle:param2};
            this._x = param1._x;
            this._y = param1._y;
            if (this._map._state == "ready")
            {
                param1 = this._map.mapToTile({_x:this._x, _y:this._y});
                _loc_5 = this._map._logicalTile[param1._x][param1._y];
                if (_loc_5 != this._currTile)
                {
                    if (this._currTile != null)
                    {
                        this._currTile.removeUnit(this);
                    }
                    this._currTile = _loc_5;
                    this._currTile.addUnit(this);
                    this.swapDepthTile();
                }
                this.actionLock = true;
                this.subSlip();
                this.startLoop(this.subSlip);
            }
            return;
        }// end function

        function stopSlip()
        {
            this._slipObj = null;
            this.stopLoop(this.subSlip);
            this.actionLock = false;
            return;
        }// end function

        private function subSlip(param1 = null)
        {
            if (this._slipObj == null)
            {
                return;
            }
            var _loc_3:* = this._slipObj;
            var _loc_4:* = this._slipObj.count + 1;
            _loc_3.count = _loc_4;
            this._x = (this._slipObj.x2 - this._slipObj.x1) * this._slipObj.count / this._slipObj.time + this._slipObj.x1;
            this._y = (this._slipObj.y2 - this._slipObj.y1) * this._slipObj.count / this._slipObj.time + this._slipObj.y1;
            var _loc_2:* = Math.atan2(this._slipObj.y2 - this._y, this._slipObj.x2 - this._x);
            this.directTo(_loc_2);
            if (this._img != null)
            {
                this._img.directTo(_loc_2);
            }
            this.draw();
            if (this._slipObj.count == this._slipObj.time)
            {
                this.directTo(this._slipObj.angle);
                this.stopSlip();
            }
            return;
        }// end function

        public function addBorder()
        {
            if (this.type == UNIT_TYPE_ENUM.TYPEID_UNIT)
            {
                if (this.testPk())
                {
                    this.addColorBorder(13369344);
                }
                else
                {
                    this.addColorBorder(204);
                }
            }
            else if (this.type == UNIT_TYPE_ENUM.TYPEID_NPC)
            {
                this.addColorBorder(204);
            }
            else if (this.type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
            {
                if (this.boothing)
                {
                    this.addColorBorder(52224);
                }
                else if (this.testPk())
                {
                    this.addColorBorder(13369344);
                }
                else
                {
                    this.addColorBorder(204);
                }
            }
            else if (this.type == UNIT_TYPE_ENUM.TYPEID_GATHER)
            {
                this.addColorBorder(204);
            }
            return;
        }// end function

        public function testPk()
        {
            if (this.type == UNIT_TYPE_ENUM.TYPEID_UNIT)
            {
                if (int(this._data._type) == 12)
                {
                    if (Config.ui._yabiao.defFlag())
                    {
                        return true;
                    }
                    return false;
                }
                if (int(this._data._type) == 11)
                {
                    if (Config.ui._yabiao.defFlag())
                    {
                        return false;
                    }
                    return true;
                }
                if (!Config.ui._gangs.inGild(this._gildid) && this._monsterCamp != 1)
                {
                    return true;
                }
            }
            if (this is Player)
            {
                return false;
            }
            if (this.type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
            {
                if (this._map._type == 14 || this._map._type == 18 || this._map._type == 22 || this._map._type == 24)
                {
                    return true;
                }
                if (this._map._type == 11)
                {
                    if (Config.player.warTeam != this.warTeam)
                    {
                        return true;
                    }
                }
                else if (this._map._type == 13)
                {
                    if (Config.ui._yabiao.defFlag() && !Config.ui._yabiao.defFlag(this.gildid))
                    {
                        return true;
                    }
                    if (!Config.ui._yabiao.defFlag() && Config.ui._yabiao.defFlag(this.gildid))
                    {
                        return true;
                    }
                }
                else if (this._map._type == 15)
                {
                    if (Config.player.pkState == 3 && this.pkState == 3 && !Config.ui._gangs.inGild(this._gildid))
                    {
                        return true;
                    }
                }
                else if (this._map._type == 21)
                {
                    if (Config.player._gildid != this._gildid)
                    {
                        return true;
                    }
                }
                else
                {
                    trace(Config.player._gildid, Config.player.gildid, this._gildid);
                    if ((this._map._type == 1 && Config.ui._gangs.inCamp(this._gildid, this._camp, this._gildTeam) || this._map._type == 1 && Config.player.pkState == 3 && this.pkState == 3 && Config.ui._gangs.inPkCamp(this._gildid, this._camp, this._gildTeam) && !Config.ui._gangs.inGild(this._gildid) || this._map._type > 1 && !Config.ui._gangs.inGild(this._gildid)) && !Config.ui._teamUI.inTeam(this.id))
                    {
                        return true;
                    }
                }
            }
            return false;
        }// end function

        public function addColorBorder(param1:uint = 16711680)
        {
            var _loc_2:* = 1;
            var _loc_3:* = 5;
            var _loc_4:* = 5;
            var _loc_5:* = 2;
            var _loc_6:* = false;
            var _loc_7:* = false;
            var _loc_8:* = BitmapFilterQuality.LOW;
            var _loc_9:* = new GlowFilter(param1, _loc_2, _loc_3, _loc_4, _loc_5, _loc_8, _loc_6, _loc_7);
            var _loc_10:* = new Array();
            new Array().push(_loc_9);
            this._mc.filters = _loc_10;
            return;
        }// end function

        public function removeBorder()
        {
            if (this._mc != null)
            {
                this._mc.filters = [];
            }
            return;
        }// end function

        public function swapDepthTile()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (this._currTile == null)
            {
                return;
            }
            if (this._focus)
            {
                _loc_5 = 3;
            }
            else
            {
                _loc_5 = 2;
            }
            _loc_3 = 0;
            while (_loc_3 < _loc_5)
            {
                
                _loc_4 = 0;
                while (_loc_4 < _loc_5)
                {
                    
                    if (this._currTile._x - _loc_3 >= 0 && this._currTile._y - _loc_4 >= 0)
                    {
                        _loc_1 = this._map._logicalTile[this._currTile._x - _loc_3][this._currTile._y - _loc_4];
                        _loc_2 = _loc_1.getMaxCurrDepthUnit(this);
                        if (_loc_2 != null)
                        {
                            if (_loc_2._mc.parent == this._map._rootMap && this._mc.parent == this._map._rootMap)
                            {
                                if (_loc_2._mc.y < this._mc.y)
                                {
                                    if (this._map._rootMap.getChildIndex(_loc_2._mc) > this._map._rootMap.getChildIndex(this._mc))
                                    {
                                        this._map._rootMap.swapChildren(_loc_2._mc, this._mc);
                                    }
                                }
                            }
                        }
                    }
                    _loc_4 = _loc_4 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            _loc_3 = 0;
            while (_loc_3 < _loc_5)
            {
                
                _loc_4 = 0;
                while (_loc_4 < _loc_5)
                {
                    
                    if (this._currTile._x < this._map._logicalWidth - _loc_3 && this._currTile._y < this._map._logicalHeight - _loc_4)
                    {
                        _loc_1 = this._map._logicalTile[this._currTile._x + _loc_3][this._currTile._y + _loc_4];
                        _loc_2 = _loc_1.getMinCurrDepthUnit(this);
                        if (_loc_2 != null)
                        {
                            if (_loc_2._mc.parent == this._map._rootMap && this._mc.parent == this._map._rootMap)
                            {
                                if (_loc_2._mc.y > this._mc.y)
                                {
                                    if (this._map._rootMap.getChildIndex(_loc_2._mc) < this._map._rootMap.getChildIndex(this._mc))
                                    {
                                        this._map._rootMap.swapChildren(_loc_2._mc, this._mc);
                                    }
                                }
                            }
                        }
                    }
                    _loc_4 = _loc_4 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        function swapDepth(param1)
        {
            if (param1 != null && param1._mc != null && this._mc != null && this._map != null && this._map._rootMap != null && param1._mc.parent == this._map._rootMap && this._mc.parent == this._map._rootMap)
            {
                if (param1._mc.y > this._mc.y)
                {
                    if (this._map._rootMap.getChildIndex(param1._mc) < this._map._rootMap.getChildIndex(this._mc))
                    {
                        this._map._rootMap.swapChildren(param1._mc, this._mc);
                    }
                }
                else if (this._map._rootMap.getChildIndex(param1._mc) > this._map._rootMap.getChildIndex(this._mc))
                {
                    this._map._rootMap.swapChildren(param1._mc, this._mc);
                }
            }
            return;
        }// end function

        public function testTileDistance(param1)
        {
            var _loc_2:* = this._map.mapToTile(param1);
            if (this._currTile != null && _loc_2 != null)
            {
                return Math.max(Math.abs(this._currTile._x - _loc_2._x), Math.abs(this._currTile._y - _loc_2._y));
            }
            return Number.MAX_VALUE;
        }// end function

        public function testDistance(param1)
        {
            return Math.sqrt(Math.pow(this._x - param1._x, 2) + Math.pow(this._y - param1._y, 2));
        }// end function

        function getNearUnitArr(param1, param2, param3 = 1)
        {
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_4:* = this._map.mapToTile({_x:param1, _y:param2});
            var _loc_5:* = [];
            _loc_7 = -param3;
            while (_loc_7 < (param3 + 1))
            {
                
                _loc_8 = -param3;
                while (_loc_8 < (param3 + 1))
                {
                    
                    param1 = _loc_4._x + _loc_7;
                    param2 = _loc_4._y + _loc_8;
                    if (param1 >= 0 && param1 < this._map._logicalWidth)
                    {
                        if (param2 >= 0 && param2 < this._map._logicalHeight)
                        {
                            _loc_6 = this._map._logicalTile[param1][param2]._currUnit;
                            _loc_5 = _loc_5.concat(_loc_6);
                        }
                    }
                    _loc_8 = _loc_8 + 1;
                }
                _loc_7 = _loc_7 + 1;
            }
            return _loc_5;
        }// end function

        public function draw()
        {
            var _loc_1:* = null;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            if (this._map == null)
            {
                return;
            }
            if (this._focus)
            {
                this._map.scrollTo(this._x, this._y);
                if (this._mc != null && this._map._mc != null)
                {
                    this._mc.x = this._map.width / 2 / this._map.zoom - this._map._rootMap.x - this._map._mc.x / this._map.zoom;
                    this._mc.y = this._map.height / 2 / this._map.zoom - this._map._rootMap.y - this._map._mc.y / this._map.zoom;
                }
                this._map.setHalo(this, 256, this._mc.x, this._mc.y);
            }
            else
            {
                _loc_1 = this._map.mapToUnit(this);
                this._mc.x = _loc_1._x;
                this._mc.y = _loc_1._y;
                _loc_3 = Number(this._data.type);
                if (_loc_3 == 1 || _loc_3 == 2)
                {
                    this._map.setHalo(this, 48, this._mc.x, this._mc.y);
                }
                else if (_loc_3 == 3)
                {
                    this._map.setHalo(this, 64, this._mc.x, this._mc.y);
                }
                else if (_loc_3 == 4)
                {
                    this._map.setHalo(this, 112, this._mc.x, this._mc.y);
                }
            }
            if (this._img != null)
            {
                this._stateBar.setPos(this._mc.x, this._mc.y - this._img._bitmapRectY + this._imgY - 5, this._img._bitmapRectY - this._imgY + 5);
            }
            for (_loc_2 in this._haloEffectOther)
            {
                
                this._haloEffectOther[_loc_2].effect.x = this._mc.x;
                if (this._haloEffectOther[_loc_2].effect.parent == this._map._footMap)
                {
                    this._haloEffectOther[_loc_2].effect.y = this._mc.y + this._haloEffectOther[_loc_2].y;
                    continue;
                }
                this._haloEffectOther[_loc_2].effect.y = this._mc.y + this._haloEffectOther[_loc_2].y + this._imgY;
            }
            if (this._sayRect != null && this._sayRect.parent == this._map._textMap && this._img != null)
            {
                this._sayRect.x = this._mc.x;
                this._sayRect.y = this._mc.y - this._img._bitmapRectY - this._sayRect.height + this._imgY;
            }
            return;
        }// end function

        public function get visible()
        {
            if (this._map != null && this._mc != null && this._mc.parent != null && this._currTile != null)
            {
                return true;
            }
            return false;
        }// end function

        public function set visible(param1:Boolean)
        {
            var _loc_2:* = undefined;
            if (this._mc == null)
            {
                return;
            }
            if (param1)
            {
                if (Config.ui != null)
                {
                    if (Config.ui._radar != null)
                    {
                        Config.ui._radar.addUnit(this);
                    }
                }
                if (this._mc.parent == null)
                {
                    this._map._rootMap.addChild(this._mc);
                }
                if (!this._stateBar.visible)
                {
                    this._stateBar.check();
                }
            }
            else
            {
                if (Config.ui != null)
                {
                    if (Config.ui._radar != null)
                    {
                        Config.ui._radar.removeUnit(this);
                    }
                }
                if (this._mc.parent != null)
                {
                    this._mc.parent.removeChild(this._mc);
                }
                this._stateBar.visible = false;
                this.clearEnterframeLoop();
                if (EventMouse._hoverUnit == this)
                {
                    EventMouse._hoverUnit = null;
                }
                if (this._map != null)
                {
                    this._map.removeHalo(this);
                }
            }
            return;
        }// end function

        function checkVisible()
        {
            var _loc_1:* = 100;
            clearTimeout(this._visibleTimer);
            if (this._mc != null && (this._mc.x + this._map._rootMap.x < -_loc_1 || this._mc.y + this._map._rootMap.y < -_loc_1 || this._mc.x + this._map._rootMap.x > this._map._mapWidth + _loc_1 || this._mc.y + this._map._rootMap.y > this._map._mapHeight + _loc_1))
            {
                this.visible = false;
            }
            else
            {
                this.visible = true;
            }
            return;
        }// end function

        public function getFocus()
        {
            this._focus = true;
            return;
        }// end function

        public function loseFocus()
        {
            this._focus = false;
            return;
        }// end function

        public function set angle(param1)
        {
            this._angle = param1;
            this.directTo(param1);
            return;
        }// end function

        public function directTo(param1)
        {
            var _loc_2:* = undefined;
            if (isNaN(param1))
            {
                return;
            }
            if (!this.actionLock)
            {
                if (param1 == undefined || param1 == null)
                {
                    param1 = this._angle;
                }
                if (this._img != null)
                {
                    this._img.directTo(param1);
                }
                for (_loc_2 in this._buffEffect)
                {
                    
                    if (this._buffEffect[_loc_2].effect != null)
                    {
                        this._buffEffect[_loc_2].effect.directTo(param1);
                    }
                }
                if (this._horse != null)
                {
                    this._horse.directTo(param1);
                }
                dispatchEvent(new Event("angle"));
            }
            return;
        }// end function

        public function set actionLock(param1)
        {
            this._actionLock = param1;
            return;
        }// end function

        public function get actionLock()
        {
            return this._actionLock;
        }// end function

        public function rightSkillCancel()
        {
            this.addEffect(null);
            if (this._chantEffectTarget != null)
            {
                if (this._chantEffectTarget is Unit)
                {
                    this._chantEffectTarget.addEffect(null);
                    this._chantEffectTarget = null;
                }
            }
            Skill.selectedSkill = null;
            return;
        }// end function

        public function rightSkillPrepare(param1, param2, param3 = null, param4 = null, param5 = null, param6 = 0)
        {
            var lockObj:*;
            var owner:*;
            var unit:*;
            var pt:*;
            var i:*;
            var arr:*;
            var missle:*;
            var temp:*;
            var skill:*;
            var fullEffectLock:Boolean;
            var arr1:Array;
            var arr2:*;
            var typeId:* = param1;
            var skillId:* = param2;
            var param1:* = param3;
            var param2:* = param4;
            var type:* = param5;
            var count:* = param6;
            try
            {
                this._chantEffectTarget = null;
                lockObj;
                owner;
                skill = Config._skillMap[skillId];
                fullEffectLock;
                if (param1 is Unit)
                {
                    pt = param1;
                    if (pt != null && skill.isSilent != 1)
                    {
                        if (!_fullEffect || !_otherVisible)
                        {
                            if (!(this is Player) && !(pt is Player))
                            {
                                fullEffectLock;
                            }
                        }
                        this._skillAngle = Math.atan2(pt._y - this._y, pt._x - this._x);
                        this.directTo(this._skillAngle);
                    }
                    else
                    {
                        return;
                    }
                }
                else if (type == SKILL_TYPE_ENUM.SKILL_PLAYER)
                {
                    pt = Unit.getUnit(param1, param2);
                    if (pt != null && skill.isSilent != 1)
                    {
                        if (!_fullEffect || !_otherVisible)
                        {
                            if (!(this is Player) && !(pt is Player))
                            {
                                fullEffectLock;
                            }
                        }
                        this._skillAngle = Math.atan2(pt._y - this._y, pt._x - this._x);
                        this.directTo(this._skillAngle);
                    }
                    else
                    {
                        return;
                    }
                }
                else if (type == SKILL_TYPE_ENUM.SKILL_POSITON)
                {
                    pt = this._map.tileToMap({_x:param1, _y:param2});
                    if (!_fullEffect || !_otherVisible)
                    {
                        if (!(this is Player) && !this.testPk())
                        {
                            fullEffectLock;
                        }
                    }
                    this._skillAngle = Math.atan2(param2 - this._y, param1 - this._x);
                    this.directTo(this._skillAngle);
                }
                skill = Config._skillMap[skillId];
                if (Number(skill.chantAct) > 0)
                {
                    var after1:* = function ()
            {
                var _loc_1:* = false;
                actionLock = false;
                changeStateTo("idle");
                return;
            }// end function
            ;
                    if (Number(skill.chantAct) == 1)
                    {
                        this.changeStateTo("attack", after1);
                    }
                    else if (Number(skill.chantAct) == 2)
                    {
                        if (this._img != null && this._img.testAction("cast"))
                        {
                            this.changeStateTo("cast", after1);
                        }
                        else
                        {
                            this.changeStateTo("attack", after1);
                        }
                    }
                    else if (Number(skill.chantAct) == 3)
                    {
                        if (this._img != null && this._img.testAction("shoot"))
                        {
                            this.changeStateTo("shoot", after1);
                        }
                        else
                        {
                            this.changeStateTo("attack", after1);
                        }
                    }
                    this.actionLock = true;
                }
                if (String(skill.chantEffectId) != "0" && !fullEffectLock)
                {
                    if (String(skill.chantEffectId).indexOf("#") == 0)
                    {
                        arr = String(skill.chantEffectId).substring(1).split("|");
                        i;
                        while (i < arr.length)
                        {
                            
                            arr1 = arr[i].split(":");
                            switch(Number(arr1[0]))
                            {
                                case 1:
                                {
                                    if (arr1.length == 1)
                                    {
                                        UnitEffect.jump(this);
                                    }
                                    else
                                    {
                                        arr2 = String(arr1[1]).split("_");
                                        if (arr2.length == 1)
                                        {
                                            UnitEffect.jump(pt, Number(arr2[0]));
                                        }
                                        else
                                        {
                                            UnitEffect.jump(pt, Number(arr2[0]), Number(arr2[1]));
                                        }
                                    }
                                    break;
                                }
                                case 2:
                                {
                                    if (arr1.length == 1)
                                    {
                                        UnitEffect.afterimage(this);
                                    }
                                    else
                                    {
                                        UnitEffect.afterimage(this, Number(arr1[1]));
                                    }
                                    break;
                                }
                                case 3:
                                {
                                    UnitEffect.flash(pt);
                                    break;
                                }
                                case 4:
                                {
                                    break;
                                }
                                case 5:
                                {
                                    if (arr1.length == 1)
                                    {
                                        MapEffect.zoom(this._map);
                                    }
                                    else
                                    {
                                        MapEffect.zoom(this._map, Number(arr1[1]));
                                    }
                                    break;
                                }
                                case 6:
                                {
                                    break;
                                }
                                case 7:
                                {
                                    break;
                                }
                                case 8:
                                {
                                    break;
                                }
                                case 9:
                                {
                                    if (arr1.length == 1)
                                    {
                                        UnitEffect.stiff(this);
                                    }
                                    else
                                    {
                                        UnitEffect.stiff(this, Number(arr1[1]));
                                    }
                                    break;
                                }
                                case 10:
                                {
                                    if (arr1.length == 1)
                                    {
                                    }
                                    else
                                    {
                                        UnitEffect.motionEffectParam(this._map, this, pt, String(arr1[1]));
                                    }
                                    break;
                                }
                                case 14:
                                {
                                    if (arr1.length == 1)
                                    {
                                        UnitEffect.burst(this);
                                    }
                                    else
                                    {
                                        UnitEffect.burst(this, Number(arr1[1]));
                                    }
                                    break;
                                }
                                case 15:
                                {
                                    if (arr1.length == 1)
                                    {
                                        UnitEffect.stiff(this, 12, "attack", 1, 1);
                                    }
                                    else
                                    {
                                        UnitEffect.stiff(this, Number(arr1[1]), "attack", 1, 1);
                                    }
                                    break;
                                }
                                case 21:
                                {
                                    if (arr1.length == 1)
                                    {
                                    }
                                    else
                                    {
                                        var _loc_8:* = String(arr1[1]).split("_");
                                        arr2 = String(arr1[1]).split("_");
                                        UnitEffect.twitch(this, "attack", Number(arr2[0]), Number(arr2[1]), Number(arr2[2]), Number(arr2[3]), Number(arr2[4]));
                                    }
                                    break;
                                }
                                case 28:
                                {
                                    if (arr1.length == 1)
                                    {
                                    }
                                    else
                                    {
                                        this.say(String(arr1[1]), 2);
                                    }
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                            i = (i + 1);
                        }
                    }
                    else
                    {
                        this.addEffect(String(skill.chantEffectId), 0);
                    }
                }
                if (String(skill.chantEffectSize) != "0" && !fullEffectLock)
                {
                    if (String(skill.chantEffectSize).indexOf("#") == 0)
                    {
                        arr = String(skill.chantEffectSize).substring(1).split("|");
                        i;
                        while (i < arr.length)
                        {
                            
                            var _loc_8:* = arr[i].split(":");
                            arr1 = arr[i].split(":");
                            switch(Number(arr1[0]))
                            {
                                case 1:
                                {
                                    if (arr1.length == 1)
                                    {
                                        UnitEffect.jump(pt);
                                    }
                                    else
                                    {
                                        var _loc_8:* = String(arr1[1]).split("_");
                                        arr2 = String(arr1[1]).split("_");
                                        if (arr2.length == 1)
                                        {
                                            UnitEffect.jump(pt, Number(arr2[0]));
                                        }
                                        else
                                        {
                                            UnitEffect.jump(pt, Number(arr2[0]), Number(arr2[1]));
                                        }
                                    }
                                    break;
                                }
                                case 2:
                                {
                                    if (arr1.length == 1)
                                    {
                                        UnitEffect.afterimage(pt);
                                    }
                                    else
                                    {
                                        UnitEffect.afterimage(pt, Number(arr1[1]));
                                    }
                                    break;
                                }
                                case 3:
                                {
                                    UnitEffect.flash(pt);
                                    break;
                                }
                                case 4:
                                {
                                    break;
                                }
                                case 5:
                                {
                                    if (arr1.length == 1)
                                    {
                                        MapEffect.zoom(this._map);
                                    }
                                    else
                                    {
                                        MapEffect.zoom(this._map, Number(arr1[1]));
                                    }
                                    break;
                                }
                                case 6:
                                {
                                    break;
                                }
                                case 7:
                                {
                                    break;
                                }
                                case 8:
                                {
                                    break;
                                }
                                case 9:
                                {
                                    if (arr1.length == 1)
                                    {
                                        UnitEffect.stiff(pt);
                                    }
                                    else
                                    {
                                        UnitEffect.stiff(pt, Number(arr1[1]));
                                    }
                                    break;
                                }
                                case 10:
                                {
                                    if (arr1.length == 1)
                                    {
                                    }
                                    else
                                    {
                                        UnitEffect.motionEffectParam(this._map, pt, this, String(arr1[1]));
                                    }
                                    break;
                                }
                                case 14:
                                {
                                    if (arr1.length == 1)
                                    {
                                        UnitEffect.burst(pt);
                                    }
                                    else
                                    {
                                        UnitEffect.burst(pt, Number(arr1[1]));
                                    }
                                    break;
                                }
                                case 15:
                                {
                                    if (arr1.length == 1)
                                    {
                                        UnitEffect.stiff(pt, 12, "attack", 1, 1);
                                    }
                                    else
                                    {
                                        UnitEffect.stiff(pt, Number(arr1[1]), "attack", 1, 1);
                                    }
                                    break;
                                }
                                case 21:
                                {
                                    if (arr1.length == 1)
                                    {
                                    }
                                    else
                                    {
                                        var _loc_8:* = String(arr1[1]).split("_");
                                        arr2 = String(arr1[1]).split("_");
                                        UnitEffect.twitch(pt, "attack", Number(arr2[0]), Number(arr2[1]), Number(arr2[2]), Number(arr2[3]), Number(arr2[4]));
                                    }
                                    break;
                                }
                                case 28:
                                {
                                    if (arr1.length == 1)
                                    {
                                    }
                                    else
                                    {
                                        this.say(String(arr1[1]), 2);
                                    }
                                    break;
                                }
                                case 30:
                                {
                                    if (arr1.length > 1)
                                    {
                                        SoundManager.play("stuff/sound/mp3/" + arr1[1] + ".mp3");
                                    }
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                            i = (i + 1);
                        }
                    }
                    else
                    {
                        var _loc_8:* = pt;
                        this._chantEffectTarget = pt;
                        pt.addEffect(String(skill.chantEffectSize), 0);
                    }
                }
                if (Config.player == this)
                {
                    Skill.startChant(Skill._skillMap[skillId]);
                }
            }
            catch (e)
            {
            }
            return;
        }// end function

        private function subEffect()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            var _loc_16:* = undefined;
            var _loc_17:* = undefined;
            var _loc_18:* = 2;
            _loc_1 = 0;
            while (_loc_1 < this._effectStack.length)
            {
                
                var _loc_19:* = this._effectStack[_loc_1];
                _loc_2 = this._effectStack[_loc_1];
                if (_loc_2.type == "blade")
                {
                    var _loc_19:* = _loc_2.range;
                    _loc_3 = _loc_2.range;
                    var _loc_19:* = _loc_2.angle;
                    _loc_4 = _loc_2.angle;
                    var _loc_19:* = _loc_2.arc;
                    _loc_5 = _loc_2.arc;
                    var _loc_19:* = _loc_2.step;
                    _loc_7 = _loc_2.step;
                    var _loc_19:* = _loc_2.way;
                    _loc_6 = _loc_2.way;
                    var _loc_19:* = _loc_4 + _loc_5 * _loc_6 * ((Math.max(_loc_18, _loc_7) - _loc_18) / _loc_18 * 2 - 1);
                    _loc_13 = _loc_4 + _loc_5 * _loc_6 * ((Math.max(_loc_18, _loc_7) - _loc_18) / _loc_18 * 2 - 1);
                    var _loc_19:* = {_x:this._x + _loc_3 * Math.cos(_loc_13), _y:this._y + _loc_3 * Math.sin(_loc_13)};
                    _loc_8 = {_x:this._x + _loc_3 * Math.cos(_loc_13), _y:this._y + _loc_3 * Math.sin(_loc_13)};
                    var _loc_19:* = this._map.mapToUnit(_loc_8);
                    _loc_8 = this._map.mapToUnit(_loc_8);
                    var _loc_19:* = {_x:_loc_8._x - this._mc.x, _y:_loc_8._y - this._mc.y};
                    _loc_8 = {_x:_loc_8._x - this._mc.x, _y:_loc_8._y - this._mc.y};
                    var _loc_19:* = _loc_4 + _loc_5 * _loc_6 * Math.min(1, _loc_7 / _loc_18 * 0.8);
                    _loc_14 = _loc_4 + _loc_5 * _loc_6 * Math.min(1, _loc_7 / _loc_18 * 0.8);
                    var _loc_19:* = {_x:this._x + _loc_3 * Math.cos(_loc_14), _y:this._y + _loc_3 * Math.sin(_loc_14)};
                    _loc_9 = {_x:this._x + _loc_3 * Math.cos(_loc_14), _y:this._y + _loc_3 * Math.sin(_loc_14)};
                    var _loc_19:* = this._map.mapToUnit(_loc_9);
                    _loc_9 = this._map.mapToUnit(_loc_9);
                    var _loc_19:* = {_x:_loc_9._x - this._mc.x, _y:_loc_9._y - this._mc.y};
                    _loc_9 = {_x:_loc_9._x - this._mc.x, _y:_loc_9._y - this._mc.y};
                    var _loc_19:* = (_loc_13 + _loc_14) / 2;
                    _loc_15 = (_loc_13 + _loc_14) / 2;
                    var _loc_19:* = {_x:this._x + _loc_3 * Math.cos(_loc_15), _y:this._y + _loc_3 * Math.sin(_loc_15)};
                    _loc_10 = {_x:this._x + _loc_3 * Math.cos(_loc_15), _y:this._y + _loc_3 * Math.sin(_loc_15)};
                    var _loc_19:* = this._map.mapToUnit(_loc_10);
                    _loc_10 = this._map.mapToUnit(_loc_10);
                    var _loc_19:* = {_x:_loc_10._x - this._mc.x, _y:_loc_10._y - this._mc.y};
                    _loc_10 = {_x:_loc_10._x - this._mc.x, _y:_loc_10._y - this._mc.y};
                    var _loc_19:* = {_x:this._x + _loc_3 / 3 * Math.cos(_loc_13), _y:this._y + _loc_3 / 3 * Math.sin(_loc_13)};
                    _loc_11 = {_x:this._x + _loc_3 / 3 * Math.cos(_loc_13), _y:this._y + _loc_3 / 3 * Math.sin(_loc_13)};
                    var _loc_19:* = this._map.mapToUnit(_loc_11);
                    _loc_11 = this._map.mapToUnit(_loc_11);
                    var _loc_19:* = {_x:_loc_11._x - this._mc.x, _y:_loc_11._y - this._mc.y};
                    _loc_11 = {_x:_loc_11._x - this._mc.x, _y:_loc_11._y - this._mc.y};
                    var _loc_19:* = {_x:this._x + _loc_3 / 3 * Math.cos(_loc_14), _y:this._y + _loc_3 / 3 * Math.sin(_loc_14)};
                    _loc_12 = {_x:this._x + _loc_3 / 3 * Math.cos(_loc_14), _y:this._y + _loc_3 / 3 * Math.sin(_loc_14)};
                    var _loc_19:* = this._map.mapToUnit(_loc_12);
                    _loc_12 = this._map.mapToUnit(_loc_12);
                    var _loc_19:* = {_x:_loc_12._x - this._mc.x, _y:_loc_12._y - this._mc.y};
                    _loc_12 = {_x:_loc_12._x - this._mc.x, _y:_loc_12._y - this._mc.y};
                    _loc_2.mc.graphics.clear();
                    _loc_2.mc.graphics.lineStyle(0, 0, 0);
                    var _loc_19:* = new Matrix();
                    _loc_16 = new Matrix();
                    _loc_16.createGradientBox(Math.abs(_loc_10._x), Math.abs(_loc_10._y), _loc_15 + Math.PI / 2 * _loc_6, Math.min(0, _loc_10._x), Math.min(0, _loc_10._y));
                    _loc_2.mc.graphics.beginGradientFill(GradientType.LINEAR, [16777215, 16777215], [0, 1], [0, 255], _loc_16);
                    _loc_2.mc.graphics.moveTo(_loc_11._x, _loc_11._y);
                    _loc_2.mc.graphics.lineTo(_loc_8._x, _loc_8._y);
                    _loc_2.mc.graphics.curveTo(_loc_10._x, _loc_10._y, _loc_9._x, _loc_9._y);
                    _loc_2.mc.graphics.lineTo(_loc_12._x, _loc_12._y);
                    _loc_2.mc.graphics.lineTo(_loc_11._x, _loc_11._y);
                    _loc_2.mc.graphics.endFill();
                    var _loc_19:* = this._mc.x;
                    _loc_2.mc.x = this._mc.x;
                    var _loc_19:* = this._mc.y;
                    _loc_2.mc.y = this._mc.y;
                    if (_loc_2.step >= _loc_18 * 2)
                    {
                        _loc_2.mc.graphics.clear();
                        if (_loc_2.mc.parent == this._map._textMap)
                        {
                            this._map._textMap.removeChild(_loc_2.mc);
                        }
                        this._effectStack.splice(_loc_1, 1);
                    }
                    else
                    {
                        var _loc_19:* = _loc_2;
                        _loc_19.step = _loc_2.step + 1;
                    }
                }
                else if (_loc_2.type == "jumpWord")
                {
                    var _loc_19:* = _loc_2.mc.y - _loc_2.ySpeed;
                    _loc_2.mc.y = _loc_2.mc.y - _loc_2.ySpeed;
                    var _loc_19:* = _loc_2.ySpeed - _loc_2.gravity;
                    _loc_2.ySpeed = _loc_2.ySpeed - _loc_2.gravity;
                    var _loc_19:* = _loc_2.mc.x + _loc_2.xSpeed;
                    _loc_2.mc.x = _loc_2.mc.x + _loc_2.xSpeed;
                    if (_loc_2.mc.y > _loc_2.upY && _loc_2.ySpeed < 0)
                    {
                        var _loc_19:* = (_loc_2.downY - _loc_2.mc.y) / (_loc_2.downY - _loc_2.upY) * _loc_2.alpha;
                        _loc_2.mc.alpha = (_loc_2.downY - _loc_2.mc.y) / (_loc_2.downY - _loc_2.upY) * _loc_2.alpha;
                    }
                    if (_loc_2.mc.y >= _loc_2.downY)
                    {
                        if (_loc_2.mc.parent == this._map._textMap)
                        {
                            this._map._textMap.removeChild(_loc_2.mc);
                            _loc_2.mc.bitmapData.dispose();
                        }
                        this._effectStack.splice(_loc_1, 1);
                    }
                }
                else if (_loc_2.type == "burstWord")
                {
                    if (_loc_2.ySpeed <= 0)
                    {
                        if (_loc_2.mc.alpha > 0)
                        {
                            var _loc_19:* = _loc_2.mc.alpha - 0.2;
                            _loc_2.mc.alpha = _loc_2.mc.alpha - 0.2;
                        }
                        else
                        {
                            if (_loc_2.mc.parent == this._map._textMap)
                            {
                                this._map._textMap.removeChild(_loc_2.mc);
                                _loc_2.mc.bitmapData.dispose();
                            }
                            this._effectStack.splice(_loc_1, 1);
                        }
                    }
                    else
                    {
                        var _loc_19:* = _loc_2.mc.y - _loc_2.ySpeed;
                        _loc_2.mc.y = _loc_2.mc.y - _loc_2.ySpeed;
                        var _loc_19:* = Math.max(0, _loc_2.ySpeed - _loc_2.gravity);
                        _loc_2.ySpeed = Math.max(0, _loc_2.ySpeed - _loc_2.gravity);
                    }
                }
                _loc_1 = _loc_1 + 1;
            }
            clearTimeout(this._effectTimer);
            if (this._effectStack.length > 0)
            {
                var _loc_19:* = setTimeout(this.subEffect, 30);
                this._effectTimer = setTimeout(this.subEffect, 30);
            }
            return;
        }// end function

        public function burstWord(param1, param2 = null, param3 = 200, param4 = 16711680, param5 = 12, param6 = 1, param7 = 0.8)
        {
            var _loc_8:* = undefined;
            if (this._map != null && this._map._textMap != null && this._mc != null && this._img != null)
            {
                _loc_8 = new Bitmap(Text2Bitmap.toBmp(param1, param4, param5, Text2Bitmap.SMASH, true));
                this._map._textMap.addChild(_loc_8);
                var _loc_9:* = this._mc.x - _loc_8.width / 2;
                _loc_8.x = this._mc.x - _loc_8.width / 2;
                var _loc_9:* = this._mc.y - this._img._bitmapRectY;
                _loc_8.y = this._mc.y - this._img._bitmapRectY;
                var _loc_9:* = param6;
                _loc_8.alpha = param6;
                this._effectStack.push({type:"burstWord", gravity:param7, alpha:_loc_8.alpha, mc:_loc_8, ySpeed:8, centerX:this._mc.x});
                this.subEffect();
            }
            return;
        }// end function

        public function hitState(param1, param2 = 200, param3 = false, param4 = "0", param5 = null)
        {
            var _loc_6:* = false;
            if (this._hitStateLock)
            {
                if (this._hitStateStack.length < 5)
                {
                    this._hitStateStack.push({unit:param1, delay:param2, quake:param3, effect:param4});
                }
                else
                {
                    this._hitStateStack.push({unit:param1, delay:Math.floor(param2 / (this._hitStateStack.length - 3)), quake:param3, effect:param4});
                }
            }
            else
            {
                if (param3)
                {
                    MapEffect.quake(this._map);
                }
                if (param4 != "0")
                {
                    _loc_6 = false;
                    if (!_fullEffect || !_otherVisible)
                    {
                        if (!(param1 is Player) && !(this is Player))
                        {
                            var _loc_7:* = true;
                            _loc_6 = true;
                        }
                    }
                    if (!_loc_6)
                    {
                        this.addEffect(param4, 1, null, param5);
                    }
                }
                UnitEffect.colorTransform(this, 10027008, 0, 5);
                if (param1 != null)
                {
                    UnitEffect.shock(this, this.getScreenAngle(param1));
                }
                var _loc_7:* = true;
                this._hitStateLock = true;
                if (this._img != null)
                {
                    if (this._img.testAction("hurt"))
                    {
                        if (this._state == "hurt")
                        {
                            this.changeStateTo("idle");
                            clearTimeout(this._playHurtTimer);
                            var _loc_7:* = setTimeout(this.playHurt, 20);
                            this._playHurtTimer = setTimeout(this.playHurt, 20);
                        }
                        else
                        {
                            this.changeStateTo("hurt");
                        }
                        clearTimeout(this._releaseHurtTimer);
                        var _loc_7:* = setTimeout(this.releaseHurt, 500);
                        this._releaseHurtTimer = setTimeout(this.releaseHurt, 500);
                    }
                }
                setTimeout(this.subHitState, param2);
            }
            return;
        }// end function

        private function playHurt()
        {
            clearTimeout(this._playHurtTimer);
            this.changeStateTo("hurt");
            return;
        }// end function

        private function releaseHurt()
        {
            clearTimeout(this._releaseHurtTimer);
            if (this._state == "hurt")
            {
                if (this._moveFlag)
                {
                    this.changeStateTo("walk");
                }
                else
                {
                    this.changeStateTo("idle");
                }
            }
            return;
        }// end function

        private function subHitState()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = false;
            this._hitStateLock = false;
            if (this._hitStateStack.length > 0)
            {
                _loc_1 = this._hitStateStack.shift();
                this.hitState(_loc_1.unit, _loc_1.delay, _loc_1.quake, _loc_1.effect);
            }
            return;
        }// end function

        public function jumpWord(param1, param2 = null, param3 = 200, param4 = 16711680, param5 = 12, param6 = 1, param7 = 0.8, param8 = null, param9 = null, param10 = null)
        {
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            if (this._map != null && this._map._textMap != null && this._mc != null && this._img != null)
            {
                if (this._jumpWordLock)
                {
                    if (this._jumpWordStack.length < 5)
                    {
                        this._jumpWordStack.push({str:param1, delay:param3, unit:param2, color:param4, size:param5, alpha:param6, gravity:param7, mcX:this._mc.x, mcY:this._mc.y, imgH:this._img._bitmapRectY});
                    }
                    else
                    {
                        this._jumpWordStack.push({str:param1, delay:Math.floor(param3 / (this._jumpWordStack.length - 3)), unit:param2, color:param4, size:param5, alpha:param6, gravity:param7, mcX:this._mc.x, mcY:this._mc.y, imgH:this._img._bitmapRectY});
                    }
                }
                else
                {
                    _loc_11 = new Bitmap(Text2Bitmap.toBmp(param1, param4, param5, Text2Bitmap.SMASH, true));
                    this._map._textMap.addChild(_loc_11);
                    if (param8 == null)
                    {
                        var _loc_13:* = this._mc.x - _loc_11.width / 2;
                        _loc_11.x = this._mc.x - _loc_11.width / 2;
                        var _loc_13:* = this._mc.y - this._img._bitmapRectY;
                        _loc_11.y = this._mc.y - this._img._bitmapRectY;
                    }
                    else
                    {
                        var _loc_13:* = param8 - _loc_11.width / 2;
                        _loc_11.x = param8 - _loc_11.width / 2;
                        var _loc_13:* = param9 - param10;
                        _loc_11.y = param9 - param10;
                    }
                    var _loc_13:* = param6;
                    _loc_11.alpha = param6;
                    if (param2 != null)
                    {
                        _loc_12 = this.getScreenAngle(param2);
                        this._effectStack.push({type:"jumpWord", gravity:param7, alpha:_loc_11.alpha, mc:_loc_11, upY:_loc_11.y - 20, downY:this._mc.y - 20, ySpeed:Math.random() * 1 + 7 - Math.sin(_loc_12) * 0.5, xSpeed:Math.cos(_loc_12) * (Math.random() * 2 + 3)});
                    }
                    else
                    {
                        this._effectStack.push({type:"jumpWord", gravity:param7, alpha:_loc_11.alpha, mc:_loc_11, upY:_loc_11.y - 20, downY:this._mc.y - 20, ySpeed:Math.random() * 2 + 7, xSpeed:Math.random() * 8 - 4});
                    }
                    this.subEffect();
                    var _loc_13:* = true;
                    this._jumpWordLock = true;
                    setTimeout(this.subJumpWord, param3);
                }
            }
            return;
        }// end function

        function subJumpWord()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = false;
            this._jumpWordLock = false;
            if (this._jumpWordStack.length > 0)
            {
                _loc_1 = this._jumpWordStack.shift();
                this.jumpWord(_loc_1.str, _loc_1.unit, _loc_1.delay, _loc_1.color, _loc_1.size, _loc_1.alpha, _loc_1.gravity, _loc_1.mcX, _loc_1.mcY, _loc_1.imgH);
            }
            return;
        }// end function

        public function blade(param1, param2, param3)
        {
            var _loc_5:* = undefined;
            var _loc_4:* = new Shape();
            this._map._textMap.addChild(_loc_4);
            if (Math.random() < 0.5)
            {
                var _loc_6:* = -1;
                _loc_5 = -1;
            }
            else
            {
                var _loc_6:* = 1;
                _loc_5 = 1;
            }
            this._effectStack.push({type:"blade", step:0, mc:_loc_4, range:param1, angle:param2, arc:param3, way:_loc_5});
            this.subEffect();
            return;
        }// end function

        public function rightCastSkill(param1, param2, param3 = null, param4 = null, param5 = null, param6 = 0)
        {
            var skill:*;
            var lockObj:*;
            var owner:*;
            var unit:*;
            var pt:*;
            var i:*;
            var arr:*;
            var missle:*;
            var temp:*;
            var fullEffectLock:Boolean;
            var after3:*;
            var dis:*;
            var typeId:* = param1;
            var skillId:* = param2;
            var param1:* = param3;
            var param2:* = param4;
            var type:* = param5;
            var count:* = param6;
            try
            {
                if (skillId == 0)
                {
                    return;
                }
                skill = Config._skillMap[skillId];
                if (Recorder.recording)
                {
                    Recorder.castSkill();
                }
                var _loc_8:* = false;
                this.actionLock = false;
                lockObj;
                owner;
                fullEffectLock;
                if (param1 is Unit)
                {
                    var _loc_8:* = param1;
                    pt = param1;
                    if (pt != null && skill.isSilent != 1)
                    {
                        if (!_fullEffect || !_otherVisible)
                        {
                            if (!(this is Player) && !(pt is Player))
                            {
                                var _loc_8:* = true;
                                fullEffectLock;
                            }
                        }
                        var _loc_8:* = Math.atan2(pt._y - this._y, pt._x - this._x);
                        this._skillAngle = Math.atan2(pt._y - this._y, pt._x - this._x);
                        if (!(this is Player || this is FlyProp))
                        {
                            var _loc_8:* = this._skillAngle;
                            this._angle = this._skillAngle;
                        }
                        this.directTo(this._skillAngle);
                    }
                    if (Number(this._attackMode.flyEffectId) != 0 && Number(this._attackMode.flySpeed) != 0)
                    {
                        dispatchEvent(new MissleEvent(Config._model[Number(this._attackMode.flyEffectId)], Number(this._attackMode.flySpeed), param1, false, 0, this._img.y));
                    }
                    if (String(skill.chantEffectSize) != "0")
                    {
                        if (String(skill.chantEffectSize).indexOf("#") == -1)
                        {
                            if (pt != null && pt is Unit)
                            {
                                pt.addEffect(null);
                            }
                            var _loc_8:* = null;
                            this._chantEffectTarget = null;
                        }
                    }
                    else
                    {
                        return;
                    }
                }
                else if (type == SKILL_TYPE_ENUM.SKILL_PLAYER)
                {
                    var _loc_8:* = Unit.getUnit(param1, param2);
                    pt = Unit.getUnit(param1, param2);
                    if (pt != null && skill.isSilent != 1)
                    {
                        if (Number(this._attackMode.flyEffectId) != 0 && Number(this._attackMode.flySpeed) != 0)
                        {
                            dispatchEvent(new MissleEvent(Config._model[Number(this._attackMode.flyEffectId)], Number(this._attackMode.flySpeed), pt, false, 0, this._img.y));
                        }
                        if (!_fullEffect || !_otherVisible)
                        {
                            if (!(this is Player) && !(pt is Player))
                            {
                                var _loc_8:* = true;
                                fullEffectLock;
                            }
                        }
                        var _loc_8:* = Math.atan2(pt._y - this._y, pt._x - this._x);
                        this._skillAngle = Math.atan2(pt._y - this._y, pt._x - this._x);
                        if (!(this is Player || this is FlyProp))
                        {
                            var _loc_8:* = this._skillAngle;
                            this._angle = this._skillAngle;
                        }
                        this.directTo(this._skillAngle);
                    }
                    else
                    {
                        return;
                    }
                }
                else if (type == SKILL_TYPE_ENUM.SKILL_POSITON)
                {
                    var _loc_8:* = {_x:param1, _y:param2};
                    pt;
                    if (Number(this._attackMode.flyEffectId) != 0 && Number(this._attackMode.flySpeed) != 0)
                    {
                        dispatchEvent(new MissleEvent(Config._model[Number(this._attackMode.flyEffectId)], Number(this._attackMode.flySpeed), pt, false, 0, this._img.y));
                    }
                    if (!_fullEffect || !_otherVisible)
                    {
                        if (!(this is Player) && !this.testPk())
                        {
                            var _loc_8:* = true;
                            fullEffectLock;
                        }
                    }
                    var _loc_8:* = Math.atan2(param2 - this._y, param1 - this._x);
                    this._skillAngle = Math.atan2(param2 - this._y, param1 - this._x);
                    if (!(this is Player || this is FlyProp))
                    {
                        var _loc_8:* = this._skillAngle;
                        this._angle = this._skillAngle;
                    }
                    if (Number(skill.reqJob) != 0)
                    {
                        this.directTo(this._skillAngle);
                    }
                }
                if (String(skill.chantEffectId) != "0")
                {
                    if (String(skill.chantEffectId).indexOf("#") == -1)
                    {
                        this.addEffect(null);
                    }
                }
                if (pt != null && pt is Unit && String(skill.chantEffectSize) != "0")
                {
                    if (String(skill.chantEffectSize).indexOf("#") == -1)
                    {
                        pt.addEffect(null);
                    }
                }
                if (String(skill.targetEffectSize) != "0" && !fullEffectLock)
                {
                    after3 = function (param1 = null)
            {
                var _loc_2:* = undefined;
                var _loc_5:* = undefined;
                var _loc_6:* = undefined;
                if (param1 != null)
                {
                    param1.target.removeEventListener("over", after3);
                }
                if (param1 == null)
                {
                    var _loc_7:* = pt;
                    _loc_2 = pt;
                }
                else
                {
                    var _loc_7:* = param1.target;
                    _loc_2 = param1.target;
                }
                var _loc_3:* = String(skill.targetEffectSize).split("|");
                var _loc_4:* = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    _loc_5 = _loc_3[_loc_4].split(":");
                    switch(Number(_loc_5[0]))
                    {
                        case 1:
                        {
                            if (_loc_5.length == 1)
                            {
                                UnitEffect.jump(_loc_2);
                            }
                            else
                            {
                                var _loc_7:* = String(_loc_5[1]).split("_");
                                _loc_6 = String(_loc_5[1]).split("_");
                                if (_loc_6.length == 1)
                                {
                                    UnitEffect.jump(pt, Number(_loc_6[0]));
                                }
                                else
                                {
                                    UnitEffect.jump(pt, Number(_loc_6[0]), Number(_loc_6[1]));
                                }
                            }
                            break;
                        }
                        case 4:
                        {
                            if (_loc_5.length == 1)
                            {
                                MapEffect.quake(Config.map);
                            }
                            else
                            {
                                var _loc_7:* = String(_loc_5[1]).split("_");
                                _loc_6 = String(_loc_5[1]).split("_");
                                if (_loc_6.length == 1)
                                {
                                    MapEffect.quake(Config.map, Number(_loc_6[0]));
                                }
                                else
                                {
                                    MapEffect.quake(Config.map, Number(_loc_6[0]), Number(_loc_6[1]));
                                }
                            }
                            break;
                        }
                        case 6:
                        {
                            if (_loc_5.length == 1)
                            {
                                UnitEffect.whirl(_loc_2);
                            }
                            else
                            {
                                UnitEffect.whirl(_loc_2, Number(_loc_5[1]));
                            }
                            break;
                        }
                        case 10:
                        {
                            if (_loc_5.length == 1)
                            {
                            }
                            else
                            {
                                UnitEffect.motionEffectParam(_map, _loc_2, pt, String(_loc_5[1]));
                            }
                            break;
                        }
                        case 13:
                        {
                            UnitEffect.smash(_loc_2);
                            break;
                        }
                        case 30:
                        {
                            if (_loc_5.length > 0)
                            {
                                SoundManager.play("stuff/sound/mp3/" + _loc_5[1] + ".mp3");
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    _loc_4 = _loc_4 + 1;
                }
                return;
            }// end function
            ;
                }
                var _loc_8:* = true;
                this.actionLock = true;
                if (pt != null && String(skill.flyEffectId) != "0" && !fullEffectLock)
                {
                    var after2:* = function ()
            {
                var fpierce:*;
                var farr:*;
                var fstr:*;
                var after4:*;
                playEffect(skill, pt, lockObj);
                if (Number(skill.isFly) == 0)
                {
                    if (Number(skill.flySpeed) == 0)
                    {
                        after4 = function (param1)
                {
                    if (param1 != null)
                    {
                        param1.target.removeEventListener("over", after4);
                        param1.target.destroy();
                    }
                    if (after3 != null)
                    {
                        after3();
                    }
                    return;
                }// end function
                ;
                        var _loc_2:* = String(skill.flyEffectId);
                        fstr = String(skill.flyEffectId);
                        var _loc_2:* = fstr.split("_");
                        farr = fstr.split("_");
                        if (farr.length == 0)
                        {
                            var _loc_2:* = Effect.newEffect(Config._model[Number(farr[0])], pt._x, pt._y, 2, 0, 0);
                            missle = Effect.newEffect(Config._model[Number(farr[0])], pt._x, pt._y, 2, 0, 0);
                        }
                        else
                        {
                            var _loc_2:* = Effect.newEffect(Config._model[Number(farr[0])], pt._x, pt._y, 2, 0, 0, Number(farr[1]));
                            missle = Effect.newEffect(Config._model[Number(farr[0])], pt._x, pt._y, 2, 0, 0, Number(farr[1]));
                        }
                        missle.display(_map);
                        missle.addEventListener("over", after4);
                    }
                    else
                    {
                        if (String(skill.flyEffectId).substring(0, 1) == "@")
                        {
                            var _loc_2:* = true;
                            fpierce;
                            var _loc_2:* = String(skill.flyEffectId).substring(1);
                            fstr = String(skill.flyEffectId).substring(1);
                        }
                        else
                        {
                            var _loc_2:* = String(skill.flyEffectId);
                            fstr = String(skill.flyEffectId);
                        }
                        var _loc_2:* = fstr.split("_");
                        farr = fstr.split("_");
                        if (farr.length == 0)
                        {
                            var _loc_2:* = Missle.newMissle(Config._model[Number(farr[0])], _map, _x, _y, Number(skill.flySpeed), pt, fpierce, 0, _img.y);
                            missle = Missle.newMissle(Config._model[Number(farr[0])], _map, _x, _y, Number(skill.flySpeed), pt, fpierce, 0, _img.y);
                        }
                        else
                        {
                            var _loc_2:* = Missle.newMissle(Config._model[Number(farr[0])], _map, _x, _y, Number(skill.flySpeed), pt, fpierce, Number(farr[1]), _img.y);
                            missle = Missle.newMissle(Config._model[Number(farr[0])], _map, _x, _y, Number(skill.flySpeed), pt, fpierce, Number(farr[1]), _img.y);
                        }
                        if (String(skill.targetEffectSize) != "0")
                        {
                            missle.addEventListener("over", after3, false, 0, true);
                        }
                    }
                }
                var preLock:* = actionLock;
                var _loc_2:* = false;
                actionLock = false;
                changeStateTo("idle");
                if (lockObj.lock == 1)
                {
                    var _loc_2:* = false;
                    actionLock = false;
                }
                else
                {
                    var _loc_2:* = 1;
                    lockObj.lock = 1;
                    var _loc_2:* = preLock;
                    actionLock = preLock;
                }
                return;
            }// end function
            ;
                    var _loc_8:* = false;
                    this.actionLock = false;
                    if (Number(skill.castAct) > 0)
                    {
                        if (Number(skill.castAct) == 1)
                        {
                            this.changeStateTo("attack", after2);
                        }
                        else if (Number(skill.castAct) == 2)
                        {
                            if (this._img != null && this._img.testAction("cast"))
                            {
                                this.changeStateTo("cast", after2);
                            }
                            else
                            {
                                this.changeStateTo("attack", after2);
                            }
                        }
                        else if (Number(skill.castAct) == 3)
                        {
                            if (this._img != null && this._img.testAction("shoot"))
                            {
                                this.changeStateTo("shoot", after2);
                            }
                            else
                            {
                                this.changeStateTo("attack", after2);
                            }
                        }
                        var _loc_8:* = true;
                        this.actionLock = true;
                    }
                    else if (after2 != null)
                    {
                        this.after2();
                    }
                }
                else if (Number(skill.castAct) > 0)
                {
                    var after1:* = function ()
            {
                if (pt != null && pt is Unit)
                {
                    if (String(skill.targetEffectId) != "0")
                    {
                        pt.addEffect(String(skill.targetEffectId), 1, null, Math.atan2(pt._y - _y, pt._x - _x));
                    }
                }
                var _loc_1:* = actionLock;
                var _loc_2:* = false;
                actionLock = false;
                changeStateTo("idle");
                if (lockObj.lock == 1)
                {
                    var _loc_2:* = false;
                    actionLock = false;
                }
                else
                {
                    var _loc_2:* = 1;
                    lockObj.lock = 1;
                    var _loc_2:* = _loc_1;
                    actionLock = _loc_1;
                }
                return;
            }// end function
            ;
                    var _loc_8:* = false;
                    this.actionLock = false;
                    if (Number(skill.castAct) == 1)
                    {
                        this.changeStateTo("attack", after1);
                    }
                    else if (Number(skill.castAct) == 2)
                    {
                        if (this._img != null && this._img.testAction("cast"))
                        {
                            this.changeStateTo("cast", after1);
                        }
                        else
                        {
                            this.changeStateTo("attack", after1);
                        }
                    }
                    else if (Number(skill.castAct) == 3)
                    {
                        if (this._img != null && this._img.testAction("shoot"))
                        {
                            this.changeStateTo("cast", after1);
                        }
                        else
                        {
                            this.changeStateTo("shoot", after1);
                        }
                    }
                    var _loc_8:* = true;
                    this.actionLock = true;
                    if (!fullEffectLock)
                    {
                        this.playEffect(skill, pt, lockObj);
                    }
                }
                else
                {
                    var _loc_8:* = 1;
                    lockObj.lock = 1;
                    if (pt != null && pt is Unit)
                    {
                        if (String(skill.targetEffectId) != "0")
                        {
                            pt.addEffect(String(skill.targetEffectId), 1, null, Math.atan2(pt._y - this._y, pt._x - this._x));
                        }
                    }
                    if (!fullEffectLock)
                    {
                        this.playEffect(skill, pt, lockObj);
                    }
                }
                if (pt != null && Number(skill.flyEffectId) == 0)
                {
                    if (Number(skill.targetEffectSize) != 0)
                    {
                        if (Number(skill.flySpeed) > 0)
                        {
                            dis = Math.sqrt(Math.pow(pt._y - this._y, 2) + Math.pow(pt._x - this._x, 2));
                            setTimeout(after3, dis / Number(skill.flySpeed) * 1000);
                        }
                        else if (after3 != null)
                        {
                            this.after3();
                        }
                    }
                }
            }
            catch (e)
            {
            }
            return;
        }// end function

        public function rightAttack(param1)
        {
            var _loc_3:* = false;
            this.actionLock = false;
            var _loc_2:* = {lock:0};
            this.directTo(param1);
            this.rightCastSkill(0, Number(this.attackMode.id), param1);
            return;
        }// end function

        public function playEffect(param1, param2, param3)
        {
            var i:*;
            var timeout:*;
            var arr:*;
            var arr1:Array;
            var arr2:*;
            var maxFrame:*;
            var shell:Shell;
            var skill:* = param1;
            var pt:* = param2;
            var lockObj:* = param3;
            try
            {
                timeout;
                if (String(skill.castEffectSize) != "0")
                {
                    arr = String(skill.castEffectSize).split("|");
                    i;
                    while (i < arr.length)
                    {
                        
                        var _loc_5:* = arr[i].split(":");
                        arr1 = arr[i].split(":");
                        switch(Number(arr1[0]))
                        {
                            case 1:
                            {
                                if (arr1.length == 1)
                                {
                                    var _loc_5:* = UnitEffect.jump(this);
                                    timeout = UnitEffect.jump(this);
                                }
                                else
                                {
                                    var _loc_5:* = String(arr1[1]).split("_");
                                    arr2 = String(arr1[1]).split("_");
                                    if (arr2.length == 1)
                                    {
                                        var _loc_5:* = UnitEffect.jump(pt, Number(arr2[0]));
                                        timeout = UnitEffect.jump(pt, Number(arr2[0]));
                                    }
                                    else
                                    {
                                        var _loc_5:* = UnitEffect.jump(pt, Number(arr2[0]), Number(arr2[1]));
                                        timeout = UnitEffect.jump(pt, Number(arr2[0]), Number(arr2[1]));
                                    }
                                }
                                break;
                            }
                            case 2:
                            {
                                if (arr1.length == 1)
                                {
                                    UnitEffect.afterimage(this);
                                }
                                else
                                {
                                    UnitEffect.afterimage(this, Number(arr1[1]));
                                }
                                break;
                            }
                            case 3:
                            {
                                UnitEffect.flash(this);
                                break;
                            }
                            case 4:
                            {
                                break;
                            }
                            case 5:
                            {
                                if (arr1.length == 1)
                                {
                                    MapEffect.zoom(this._map);
                                }
                                else
                                {
                                    MapEffect.zoom(this._map, Number(arr1[1]));
                                }
                                break;
                            }
                            case 6:
                            {
                                break;
                            }
                            case 7:
                            {
                                break;
                            }
                            case 8:
                            {
                                break;
                            }
                            case 9:
                            {
                                if (arr1.length == 1)
                                {
                                    UnitEffect.stiff(this);
                                }
                                else
                                {
                                    UnitEffect.stiff(this, Number(arr1[1]));
                                }
                                break;
                            }
                            case 14:
                            {
                                if (arr1.length == 1)
                                {
                                    UnitEffect.burst(this);
                                }
                                else
                                {
                                    UnitEffect.burst(this, Number(arr1[1]));
                                }
                                break;
                            }
                            case 15:
                            {
                                if (this._img != null && this._img.ready)
                                {
                                    if (this._img.testAction("attack"))
                                    {
                                        maxFrame = this._img._unitObj["attack"][0].length;
                                        if (arr1.length == 1)
                                        {
                                            UnitEffect.stiff(this, 12, "attack", 1, 1);
                                            var _loc_5:* = ((maxFrame - 4) * (this._img._frameSkip + 1) + 12) * 1000 / Config.fps;
                                            timeout = ((maxFrame - 4) * (this._img._frameSkip + 1) + 12) * 1000 / Config.fps;
                                        }
                                        else
                                        {
                                            UnitEffect.stiff(this, Number(arr1[1]), "attack", 1, 1);
                                            var _loc_5:* = ((maxFrame - 4) * (this._img._frameSkip + 1) + Number(arr1[1])) * 1000 / Config.fps;
                                            timeout = ((maxFrame - 4) * (this._img._frameSkip + 1) + Number(arr1[1])) * 1000 / Config.fps;
                                        }
                                    }
                                }
                                break;
                            }
                            case 21:
                            {
                                if (arr1.length == 1)
                                {
                                }
                                else
                                {
                                    var _loc_5:* = String(arr1[1]).split("_");
                                    arr2 = String(arr1[1]).split("_");
                                    UnitEffect.twitch(this, "attack", Number(arr2[0]), Number(arr2[1]), Number(arr2[2]), Number(arr2[3]), Number(arr2[4]));
                                }
                                break;
                            }
                            case 23:
                            {
                                if (arr1.length == 1)
                                {
                                }
                                else
                                {
                                    UnitEffect.chain(this, pt, Number(arr1[1]));
                                }
                                break;
                            }
                            case 27:
                            {
                                if (arr1.length == 1)
                                {
                                }
                                else if (pt != null)
                                {
                                    var _loc_5:* = String(arr1[1]).split("_");
                                    arr2 = String(arr1[1]).split("_");
                                    shell = new Shell(Config._model[Number(arr2[0])], Config.map, this._x + Number(arr2[1]), this._y + Number(arr2[2]), Number(arr2[3]), pt._x, pt._y, skill.flySpeed, Number(arr2[4]));
                                }
                                break;
                            }
                            case 28:
                            {
                                if (arr1.length == 1)
                                {
                                }
                                else if (pt != null)
                                {
                                    this.say(String(arr1[1]), 2);
                                }
                                break;
                            }
                            case 30:
                            {
                                if (arr1.length > 0)
                                {
                                    SoundManager.play("stuff/sound/mp3/" + arr1[1] + ".mp3");
                                }
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        i = (i + 1);
                    }
                }
                var _loc_5:* = Math.max(0, timeout);
                timeout = Math.max(0, timeout);
                if (timeout == 0)
                {
                    this.subPlayEffect(skill, pt, lockObj);
                }
                else
                {
                    clearTimeout(this._playEffectTimer);
                    var _loc_5:* = setTimeout(this.subPlayEffect, Math.floor(timeout), skill, pt, lockObj);
                    this._playEffectTimer = setTimeout(this.subPlayEffect, Math.floor(timeout), skill, pt, lockObj);
                }
            }
            catch (e)
            {
            }
            return;
        }// end function

        private function subPlayEffect(param1, param2, param3)
        {
            var i:*;
            var arr:*;
            var arr1:*;
            var arr2:*;
            var maxFrame:*;
            var skill:* = param1;
            var pt:* = param2;
            var lockObj:* = param3;
            try
            {
                clearTimeout(this._playEffectTimer);
                if (String(skill.flyEffectSize) != "0")
                {
                    var _loc_5:* = String(skill.flyEffectSize).split("|");
                    arr = String(skill.flyEffectSize).split("|");
                    i;
                    while (i < arr.length)
                    {
                        
                        var _loc_5:* = arr[i].split(":");
                        arr1 = arr[i].split(":");
                        switch(Number(arr1[0]))
                        {
                            case 10:
                            {
                                if (arr1.length == 1)
                                {
                                }
                                else
                                {
                                    UnitEffect.motionEffectParam(this._map, pt, this, String(arr1[1]));
                                }
                                break;
                            }
                            case 11:
                            {
                                if (arr1.length == 1)
                                {
                                }
                                else if (pt != null)
                                {
                                    var _loc_5:* = String(arr1[1]).split("_");
                                    arr2 = String(arr1[1]).split("_");
                                    if (arr2.length == 4)
                                    {
                                        this.rightRocket(pt, Number(arr2[1]), Config._model[Number(arr2[0])], Number(arr2[2]), Number(arr2[3]));
                                    }
                                    else if (arr2.length == 5)
                                    {
                                        this.rightRocket(pt, Number(arr2[1]), Config._model[Number(arr2[0])], Number(arr2[2]), Number(arr2[3]), Number(arr2[4]));
                                    }
                                }
                                break;
                            }
                            case 19:
                            {
                                if (arr1.length == 1)
                                {
                                }
                                else if (pt != null)
                                {
                                    var _loc_5:* = String(arr1[1]).split("_");
                                    arr2 = String(arr1[1]).split("_");
                                    UnitEffect.tileEffect(this._map, pt, Number(arr2[0]), Number(arr2[1]), Number(arr2[2]));
                                }
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        i = (i + 1);
                    }
                }
                if (Number(skill.castEffectSize) != 0)
                {
                    var _loc_5:* = String(skill.castEffectSize).split("|");
                    arr = String(skill.castEffectSize).split("|");
                    i;
                    while (i < arr.length)
                    {
                        
                        var _loc_5:* = arr[i].split(":");
                        arr1 = arr[i].split(":");
                        switch(Number(arr1[0]))
                        {
                            case 4:
                            {
                                if (arr1.length == 1)
                                {
                                    MapEffect.quake(Config.map);
                                }
                                else
                                {
                                    var _loc_5:* = String(arr1[1]).split("_");
                                    arr2 = String(arr1[1]).split("_");
                                    if (arr2.length == 1)
                                    {
                                        MapEffect.quake(Config.map, Number(arr2[0]));
                                    }
                                    else
                                    {
                                        MapEffect.quake(Config.map, Number(arr2[0]), Number(arr2[1]));
                                    }
                                }
                                break;
                            }
                            case 6:
                            {
                                if (arr1.length == 1)
                                {
                                    UnitEffect.whirl(this);
                                }
                                else
                                {
                                    UnitEffect.whirl(this, Number(arr1[1]));
                                }
                                break;
                            }
                            case 10:
                            {
                                if (arr1.length == 1)
                                {
                                }
                                else
                                {
                                    UnitEffect.motionEffectParam(this._map, this, pt, String(arr1[1]));
                                }
                                break;
                            }
                            case 16:
                            {
                                if (this._img != null && this._img.ready)
                                {
                                    if (this._img.testAction("attack"))
                                    {
                                        maxFrame = this._img._unitObj["attack"][0].length;
                                        if (arr1.length == 1)
                                        {
                                            UnitEffect.stiff(this, 12, "attack", maxFrame - 2, this._img._currFrame);
                                        }
                                        else
                                        {
                                            UnitEffect.stiff(this, Number(arr1[1]), "attack", (maxFrame - 1), this._img._currFrame);
                                        }
                                    }
                                }
                                break;
                            }
                            case 22:
                            {
                                if (arr1.length == 1)
                                {
                                }
                                else if (pt != null)
                                {
                                    var _loc_5:* = String(arr1[1]).split("_");
                                    arr2 = String(arr1[1]).split("_");
                                    if (arr2.length == 6)
                                    {
                                        UnitEffect.runEffect(this._map, this, Number(arr2[0]), Number(arr2[1]), Number(arr2[2]), Number(arr2[3]), Number(arr2[4]), Number(arr2[5]));
                                    }
                                    else
                                    {
                                        UnitEffect.runEffect(this._map, this, Number(arr2[0]), Number(arr2[1]), Number(arr2[2]), Number(arr2[3]), Number(arr2[4]), Number(arr2[5]), Number(arr2[6]));
                                    }
                                }
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        i = (i + 1);
                    }
                }
                if (String(skill.castEffectId) != "0")
                {
                    this.addEffect(String(skill.castEffectId));
                }
                if (lockObj.lock == 1)
                {
                    var _loc_5:* = false;
                    this.actionLock = false;
                }
                else
                {
                    var _loc_5:* = 1;
                    lockObj.lock = 1;
                }
            }
            catch (e)
            {
            }
            return;
        }// end function

        public function rightRocket(param1, param2:uint, param3, param4, param5, param6 = 0)
        {
            var i:*;
            var angle:*;
            var ran:*;
            var faceAngle:*;
            var unit:* = param1;
            var num:* = param2;
            var xml:* = param3;
            var startAngle:* = param4;
            var interval:* = param5;
            var hue:* = param6;
            try
            {
                if (this._img == null)
                {
                    return;
                }
                if (!_fullEffect || !_otherVisible)
                {
                    if (!(this is Player) && !(unit is Player))
                    {
                        return;
                    }
                }
                faceAngle = Math.atan2(unit._y - this._y, unit._x - this._x);
                if (isNaN(startAngle) || startAngle == null)
                {
                    var _loc_8:* = Math.PI / 2;
                    startAngle = Math.PI / 2;
                }
                if (isNaN(interval) || interval == null)
                {
                    var _loc_8:* = 0;
                    interval;
                }
                if (interval == 0)
                {
                    i;
                    while (i < num)
                    {
                        
                        if (i % 2 == 0)
                        {
                            var _loc_8:* = faceAngle + startAngle + Math.PI / 4 * Math.random();
                            angle = faceAngle + startAngle + Math.PI / 4 * Math.random();
                        }
                        else
                        {
                            var _loc_8:* = faceAngle - startAngle - Math.PI / 4 * Math.random();
                            angle = faceAngle - startAngle - Math.PI / 4 * Math.random();
                        }
                        Rocket.newRocket(xml, this._map, this._x, this._y, Math.random() * 200 + 100, angle, 100, 0.95, unit, this._img.y, hue);
                        i = (i + 1);
                    }
                }
                else
                {
                    if (i % 2 == 0)
                    {
                        var _loc_8:* = faceAngle + startAngle + Math.PI / 4 * Math.random();
                        angle = faceAngle + startAngle + Math.PI / 4 * Math.random();
                    }
                    else
                    {
                        var _loc_8:* = faceAngle - startAngle - Math.PI / 4 * Math.random();
                        angle = faceAngle - startAngle - Math.PI / 4 * Math.random();
                    }
                    Rocket.newRocket(xml, this._map, this._x, this._y, Math.random() * 200 + 100, angle, 100, 0.95, unit, this._img.y, hue);
                    var _loc_8:* = true;
                    this.actionLock = true;
                    i;
                    while (i < num)
                    {
                        
                        if (i % 2 == 0)
                        {
                            var _loc_8:* = faceAngle + startAngle + Math.PI / 4 * Math.random();
                            angle = faceAngle + startAngle + Math.PI / 4 * Math.random();
                        }
                        else
                        {
                            var _loc_8:* = faceAngle - startAngle - Math.PI / 4 * Math.random();
                            angle = faceAngle - startAngle - Math.PI / 4 * Math.random();
                        }
                        setTimeout(this.handleRocketInterval, interval * i, unit, xml, angle, i == (num - 1), hue);
                        i = (i + 1);
                    }
                }
            }
            catch (e)
            {
            }
            return;
        }// end function

        private function handleRocketInterval(param1, param2, param3, param4 = false, param5 = 0)
        {
            var unit:* = param1;
            var xml:* = param2;
            var angle:* = param3;
            var last:* = param4;
            var hue:* = param5;
            try
            {
                Rocket.newRocket(xml, this._map, this._x, this._y, Math.random() * 200 + 100, angle, 100, 0.95, unit, this._img.y, hue);
                if (last)
                {
                    var _loc_7:* = false;
                    this.actionLock = false;
                }
            }
            catch (e)
            {
                var _loc_8:* = false;
                actionLock = false;
            }
            return;
        }// end function

        public function changeStateTo(param1:String, param2:Function = null, param3 = false)
        {
            clearTimeout(this._playHurtTimer);
            var _loc_4:* = param1;
            this._state = param1;
            if (param1 == "attack")
            {
                if (this._follower != null)
                {
                    this._follower.playAttack();
                }
            }
            if (!this.actionLock)
            {
                if (this._img != null)
                {
                    if (this._type == UNIT_TYPE_ENUM.TYPEID_PLAYER || this._type == UNIT_TYPE_ENUM.TYPEID_UNIT)
                    {
                        if (param1 == "attack")
                        {
                            if (this._type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
                            {
                                if (this._atkSpeedLevel > 1000)
                                {
                                    var _loc_4:* = 0;
                                    this._img._frameSkip = 0;
                                }
                                else if (this._atkSpeedLevel > 500)
                                {
                                    var _loc_4:* = 1;
                                    this._img._frameSkip = 1;
                                }
                                else if (this._atkSpeedLevel >= 0)
                                {
                                    var _loc_4:* = 2;
                                    this._img._frameSkip = 2;
                                }
                                else
                                {
                                    var _loc_4:* = 3;
                                    this._img._frameSkip = 3;
                                }
                            }
                            else if (this._type == UNIT_TYPE_ENUM.TYPEID_UNIT)
                            {
                                var _loc_4:* = 100;
                                this._atkSpeedLevelBuff = 100;
                                if (this._atkSpeedLevelBuff <= 0)
                                {
                                    if (this._img._data != null)
                                    {
                                        var _loc_4:* = this._img._data.frameSkip;
                                        this._img._frameSkip = this._img._data.frameSkip;
                                    }
                                }
                                else
                                {
                                    var _loc_4:* = Math.round((Math.max(1, 1 / (1 / (this._img._data.frameSkip + 1) * (1 + this._atkSpeedLevelBuff / 100))) - 1));
                                    this._img._frameSkip = Math.round((Math.max(1, 1 / (1 / (this._img._data.frameSkip + 1) * (1 + this._atkSpeedLevelBuff / 100))) - 1));
                                }
                            }
                        }
                        else if (this._horse == null && param1 == "walk" && !((this._fadeDeath || this._die) && this._img.testAction("crawl")))
                        {
                            if (this.speed >= 250)
                            {
                                var _loc_4:* = 0;
                                this._img._frameSkip = 0;
                            }
                            else if (this.speed >= 200)
                            {
                                var _loc_4:* = 1;
                                this._img._frameSkip = 1;
                            }
                            else if (this.speed >= 150)
                            {
                                var _loc_4:* = 2;
                                this._img._frameSkip = 2;
                            }
                            else
                            {
                                var _loc_4:* = 3;
                                this._img._frameSkip = 3;
                            }
                        }
                        else
                        {
                            var _loc_4:* = 2;
                            this._img._frameSkip = 2;
                        }
                    }
                    if (param1 == "idle" && (this._fadeDeath || this._die) && this._img.testAction("death"))
                    {
                        this._img.changeStateTo("death", param2, param3);
                    }
                    else if (param1 == "idle" && this._forceIdleAct != "")
                    {
                        this._img.changeStateTo(this._forceIdleAct, param2, param3);
                    }
                    else if (param1 == "walk" && (this._fadeDeath || this._die) && this._img.testAction("crawl"))
                    {
                        if (this._horse != null)
                        {
                            this._img.changeStateTo("death", param2, param3);
                        }
                        else
                        {
                            this._img.changeStateTo("crawl", param2, param3);
                        }
                    }
                    else if (this._horse != null && param1 == "walk" && !(this._fadeDeath || this._die))
                    {
                        this._img.changeStateTo("idle", param2, param3);
                    }
                    else if (param1 == "death" && !this._img.testAction("death"))
                    {
                        this._img.changeStateTo("idle", param2, param3);
                    }
                    else if (this._img.testAction(param1))
                    {
                        this._img.changeStateTo(param1, param2, param3);
                    }
                }
            }
            dispatchEvent(new Event("action"));
            return;
        }// end function

        public function sayArr(param1)
        {
            var _loc_2:* = undefined;
            _loc_2 = param1.split(";");
            if (_loc_2.length > 1)
            {
                var _loc_3:* = _loc_2;
                this._sayArr = _loc_2;
                var _loc_3:* = 0;
                this._sayArrIndex = 0;
                clearTimeout(this._sayTimer);
                this.sayArrLoop();
            }
            else if (_loc_2.length == 1)
            {
                this.say(_loc_2[0]);
            }
            return;
        }// end function

        private function sayArrLoop()
        {
            var _loc_1:* = null;
            var _loc_2:* = undefined;
            clearTimeout(this._sayTimer);
            _loc_1 = this._sayArr[this._sayArrIndex];
            _loc_2 = 3 + Math.floor(_loc_1.length / 2);
            this.say(this._sayArr[this._sayArrIndex], _loc_2, null, true);
            var _loc_3:* = this;
            _loc_3._sayArrIndex = this._sayArrIndex + 1;
            if (this._sayArrIndex < this._sayArr.length)
            {
                var _loc_3:* = setTimeout(this.sayArrLoop, _loc_2 * 1000);
                this._sayTimer = setTimeout(this.sayArrLoop, _loc_2 * 1000);
            }
            return;
        }// end function

        public function say(param1 = "", param2 = 10, param3:Array = null, param4 = false)
        {
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            if (!param4)
            {
                clearTimeout(this._sayTimer);
            }
            if (this._map == null || this._map._textMap == null || this._sayRect == null || this._mc == null || this._img == null)
            {
                return;
            }
            _loc_5 = 0;
            while (_loc_5 < this._sayBtnStack.length)
            {
                
                this._sayRect.removeChild(this._sayBtnStack[_loc_5]);
                this._sayBtnStack[_loc_5].destroy();
                _loc_5 = _loc_5 + 1;
            }
            var _loc_11:* = [];
            this._sayBtnStack = [];
            if (this._sayTxt != null && this._sayTxt.parent == this._sayRect)
            {
                this._sayRect.removeChild(this._sayTxt);
            }
            if (param1.length > 0 || param3 != null && param3.length > 0)
            {
                this._map._textMap.addChild(this._sayRect);
                this._sayRect.addChild(this._sayTxt);
                var _loc_11:* = 0;
                this._sayTxt.x = 0;
                var _loc_11:* = 0;
                this._sayTxt.y = 0;
                var _loc_11:* = false;
                this._sayTxt.selectable = false;
                this._preSayTxt.clear();
                this._preSayTxt.appendUbbText(param1);
                var _loc_11:* = this._preSayTxt.snapRect;
                _loc_8 = this._preSayTxt.snapRect;
                this._sayTxt.clear();
                this._sayTxt.resize(200, _loc_8.height + 5);
                this._sayTxt.appendUbbText(param1);
                var _loc_11:* = this._sayTxt.snapRect;
                _loc_8 = this._sayTxt.snapRect;
                var _loc_11:* = _loc_8.width + 5;
                _loc_8.width = _loc_8.width + 5;
                var _loc_11:* = (-_loc_8.width) / 2 + 10;
                this._sayTxt.x = (-_loc_8.width) / 2 + 10;
                var _loc_11:* = 0;
                this._sayTxt.y = 0;
                var _loc_11:* = new Rectangle(this._sayTxt.x - 2, this._sayTxt.y, _loc_8.width + 6, _loc_8.height + 6);
                _loc_7 = new Rectangle(this._sayTxt.x - 2, this._sayTxt.y, _loc_8.width + 6, _loc_8.height + 6);
                this._sayRect.graphics.clear();
                this._sayRect.graphics.lineStyle(0, 0, 0.2, true);
                this._sayRect.graphics.beginFill(16777215, 0.8);
                this._sayRect.graphics.drawRoundRect(_loc_7.x, _loc_7.y, _loc_7.width, _loc_7.height, 6, 6);
                this._sayRect.graphics.endFill();
                this._sayRect.graphics.lineStyle(0, 0, 0, true);
                this._sayRect.graphics.beginFill(16777215, 0.8);
                this._sayRect.graphics.moveTo(0, 5 + _loc_7.y + _loc_7.height);
                this._sayRect.graphics.lineTo(5, 0 + _loc_7.y + _loc_7.height);
                this._sayRect.graphics.lineTo(15, 0 + _loc_7.y + _loc_7.height);
                this._sayRect.graphics.lineTo(0, 5 + _loc_7.y + _loc_7.height);
                this._sayRect.graphics.endFill();
                this._sayRect.graphics.lineStyle(0, 0, 0.2, true);
                this._sayRect.graphics.moveTo(5, 0 + _loc_7.y + _loc_7.height);
                this._sayRect.graphics.lineTo(0, 5 + _loc_7.y + _loc_7.height);
                this._sayRect.graphics.lineTo(15, 0 + _loc_7.y + _loc_7.height);
                var _loc_11:* = this._mc.x;
                this._sayRect.x = this._mc.x;
                var _loc_11:* = this._mc.y - this._img._bitmapRectY - this._sayRect.height + this._imgY;
                this._sayRect.y = this._mc.y - this._img._bitmapRectY - this._sayRect.height + this._imgY;
                clearTimeout(this._sayInterval);
                if (param2 > 0)
                {
                    var _loc_11:* = setTimeout(this.closeSay, param2 * 1000);
                    this._sayInterval = setTimeout(this.closeSay, param2 * 1000);
                }
            }
            else
            {
                clearTimeout(this._sayInterval);
                this.closeSay();
            }
            return;
        }// end function

        private function closeSay()
        {
            if (this._sayRect != null && this._map != null && this._map._textMap != null)
            {
                if (this._sayRect.parent == this._map._textMap)
                {
                    this._map._textMap.removeChild(this._sayRect);
                }
            }
            return;
        }// end function

        public function getScreenAngle(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            if (this._map != null)
            {
                _loc_2 = this._map.mapToUnit(this);
                _loc_3 = this._map.mapToUnit(param1);
                return Math.atan2(_loc_2._y - _loc_3._y, _loc_2._x - _loc_3._x);
            }
            return 0;
        }// end function

        public function dyingState()
        {
            return;
        }// end function

        public function set resting(param1)
        {
            var _loc_2:* = param1;
            this._resting = param1;
            var _loc_2:* = this._resting;
            this.sitDown = this._resting;
            if (this._resting)
            {
                this.addHalo(1014, 0, 2);
            }
            else
            {
                this.removeHalo(1014);
            }
            return;
        }// end function

        public function set sitDown(param1)
        {
            if (param1)
            {
                this.changeStateTo("meditation");
            }
            else if (this._moveFlag)
            {
                this.changeStateTo("move");
            }
            else
            {
                this.changeStateTo("idle");
            }
            return;
        }// end function

        public function get resting()
        {
            return this._resting;
        }// end function

        public function set teamflag(param1:Boolean) : void
        {
            var _loc_2:* = param1;
            this._stateBar.teamflag = param1;
            if (this is Player)
            {
                Config.ui._fbEntranceUI.setBackToHallPB();
            }
            return;
        }// end function

        public function get teamflag() : Boolean
        {
            return this._stateBar.teamflag;
        }// end function

        public function beBinding(param1)
        {
            var _loc_2:* = 1;
            this._binding = 1;
            var _loc_2:* = param1;
            this._bindingUnit = param1;
            return;
        }// end function

        public function binding(param1)
        {
            var _loc_2:* = 2;
            this._binding = 2;
            var _loc_2:* = param1;
            this._bindingUnit = param1;
            if (this._bindingUnit != null)
            {
                UnitEffect.chain(this, this._bindingUnit);
            }
            return;
        }// end function

        public function stopBinding(param1 = null)
        {
            var _loc_2:* = 0;
            this._binding = 0;
            UnitEffect.killChain(this);
            if (this._bindingUnit != null)
            {
                var _loc_2:* = null;
                this._bindingUnit = null;
            }
            return;
        }// end function

        public function get otheratk() : int
        {
            return this._otheratk;
        }// end function

        public function set otheratk(param1:int) : void
        {
            var _loc_2:* = param1;
            this._otheratk = param1;
            dispatchEvent(new UnitEvent("update", "otheratk", param1));
            return;
        }// end function

        public function get otherdef() : int
        {
            return this._otherdef;
        }// end function

        public function set otherdef(param1:int) : void
        {
            var _loc_2:* = param1;
            this._otherdef = param1;
            dispatchEvent(new UnitEvent("update", "otherdef", param1));
            return;
        }// end function

        public function get othermondef() : int
        {
            return this._othermondef;
        }// end function

        public function set othermondef(param1:int) : void
        {
            var _loc_2:* = param1;
            this._othermondef = param1;
            dispatchEvent(new UnitEvent("update", "othermondef", param1));
            return;
        }// end function

        public function get atkSkill() : int
        {
            return this._atkSkill;
        }// end function

        public function set atkSkill(param1:int) : void
        {
            var _loc_2:* = param1;
            this._atkSkill = param1;
            dispatchEvent(new UnitEvent("update", "atkSkill", param1));
            return;
        }// end function

        public function get defSkill() : int
        {
            return this._defSkill;
        }// end function

        public function set defSkill(param1:int) : void
        {
            var _loc_2:* = param1;
            this._defSkill = param1;
            dispatchEvent(new UnitEvent("update", "defSkill", param1));
            return;
        }// end function

        public function get monarr() : Array
        {
            return this._monarr;
        }// end function

        public function set monarr(param1:Array) : void
        {
            var _loc_2:* = param1;
            this._monarr = param1;
            return;
        }// end function

        public function get lucky() : int
        {
            return this._lucky;
        }// end function

        public function set lucky(param1:int) : void
        {
            var _loc_2:* = param1;
            this._lucky = param1;
            dispatchEvent(new UnitEvent("update", "lucky", param1));
            return;
        }// end function

        public function get comAtk() : int
        {
            return this._comAtk;
        }// end function

        public function set comAtk(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comAtk = param1;
            dispatchEvent(new UnitEvent("update", "comAtk", param1));
            return;
        }// end function

        public function get comDef() : int
        {
            return this._comDef;
        }// end function

        public function set comDef(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comDef = param1;
            dispatchEvent(new UnitEvent("update", "comDef", param1));
            return;
        }// end function

        public function get comRate() : int
        {
            return this._comRate;
        }// end function

        public function set comRate(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comRate = param1;
            dispatchEvent(new UnitEvent("update", "comRate", param1));
            return;
        }// end function

        public function get comEvade() : int
        {
            return this._comEvade;
        }// end function

        public function set comEvade(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comEvade = param1;
            dispatchEvent(new UnitEvent("update", "comEvade", param1));
            return;
        }// end function

        public function get comSkillRate() : int
        {
            return this._comSkillRate;
        }// end function

        public function set comSkillRate(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comSkillRate = param1;
            dispatchEvent(new UnitEvent("update", "comSkillRate", param1));
            return;
        }// end function

        public function get comSkillEvade() : int
        {
            return this._comSkillEvade;
        }// end function

        public function set comSkillEvade(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comSkillEvade = param1;
            dispatchEvent(new UnitEvent("update", "comSkillEvade", param1));
            return;
        }// end function

        public function get comSkillAtk() : int
        {
            return this._comSkillAtk;
        }// end function

        public function set comSkillAtk(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comSkillAtk = param1;
            dispatchEvent(new UnitEvent("update", "comSkillAtk", param1));
            return;
        }// end function

        public function get comSkillCriticalAdd() : int
        {
            return this._comSkillCriticalAdd;
        }// end function

        public function set comSkillCriticalAdd(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comSkillCriticalAdd = param1;
            dispatchEvent(new UnitEvent("update", "comSkillCriticalAdd", param1));
            return;
        }// end function

        public function get comSkillCriticalDel() : int
        {
            return this._comSkillCriticalDel;
        }// end function

        public function set comSkillCriticalDel(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comSkillCriticalDel = param1;
            dispatchEvent(new UnitEvent("update", "comSkillCriticalDel", param1));
            return;
        }// end function

        public function get comAtkCriticalAdd() : int
        {
            return this._comAtkCriticalAdd;
        }// end function

        public function set comAtkCriticalAdd(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comAtkCriticalAdd = param1;
            dispatchEvent(new UnitEvent("update", "comAtkCriticalAdd", param1));
            return;
        }// end function

        public function get comAtkCriticalDel() : int
        {
            return this._comAtkCriticalDel;
        }// end function

        public function set comAtkCriticalDel(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comAtkCriticalDel = param1;
            dispatchEvent(new UnitEvent("update", "comAtkCriticalDel", param1));
            return;
        }// end function

        public function get comBuffAtk1() : int
        {
            return this._comBuffAtk1;
        }// end function

        public function set comBuffAtk1(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffAtk1 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffAtk1", param1));
            return;
        }// end function

        public function get comBuffAtk2() : int
        {
            return this._comBuffAtk2;
        }// end function

        public function set comBuffAtk2(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffAtk2 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffAtk2", param1));
            return;
        }// end function

        public function get comBuffAtk3() : int
        {
            return this._comBuffAtk3;
        }// end function

        public function set comBuffAtk3(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffAtk3 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffAtk3", param1));
            return;
        }// end function

        public function get comBuffAtk4() : int
        {
            return this._comBuffAtk4;
        }// end function

        public function set comBuffAtk4(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffAtk4 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffAtk4", param1));
            return;
        }// end function

        public function get comBuffAtk5() : int
        {
            return this._comBuffAtk5;
        }// end function

        public function set comBuffAtk5(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffAtk5 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffAtk5", param1));
            return;
        }// end function

        public function get comBuffAtk6() : int
        {
            return this._comBuffAtk6;
        }// end function

        public function set comBuffAtk6(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffAtk6 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffAtk6", param1));
            return;
        }// end function

        public function get comBuffAtk7() : int
        {
            return this._comBuffAtk7;
        }// end function

        public function set comBuffAtk7(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffAtk7 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffAtk7", param1));
            return;
        }// end function

        public function get comBuffAtk8() : int
        {
            return this._comBuffAtk8;
        }// end function

        public function set comBuffAtk8(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffAtk8 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffAtk8", param1));
            return;
        }// end function

        public function get comBuffAtk9() : int
        {
            return this._comBuffAtk9;
        }// end function

        public function set comBuffAtk9(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffAtk9 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffAtk9", param1));
            return;
        }// end function

        public function get comBuffAtk10() : int
        {
            return this._comBuffAtk10;
        }// end function

        public function set comBuffAtk10(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffAtk10 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffAtk10", param1));
            return;
        }// end function

        public function get comBuffDef1() : int
        {
            return this._comBuffDef1;
        }// end function

        public function set comBuffDef1(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffDef1 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffDef1", param1));
            return;
        }// end function

        public function get comBuffDef2() : int
        {
            return this._comBuffDef2;
        }// end function

        public function set comBuffDef2(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffDef2 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffDef2", param1));
            return;
        }// end function

        public function get comBuffDef3() : int
        {
            return this._comBuffDef3;
        }// end function

        public function set comBuffDef3(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffDef3 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffDef3", param1));
            return;
        }// end function

        public function get comBuffDef4() : int
        {
            return this._comBuffDef4;
        }// end function

        public function set comBuffDef4(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffDef4 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffDef4", param1));
            return;
        }// end function

        public function get comBuffDef5() : int
        {
            return this._comBuffDef5;
        }// end function

        public function set comBuffDef5(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffDef5 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffDef5", param1));
            return;
        }// end function

        public function get comBuffDef6() : int
        {
            return this._comBuffDef6;
        }// end function

        public function set comBuffDef6(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffDef6 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffDef6", param1));
            return;
        }// end function

        public function get comBuffDef7() : int
        {
            return this._comBuffDef7;
        }// end function

        public function set comBuffDef7(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffDef7 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffDef7", param1));
            return;
        }// end function

        public function get comBuffDef8() : int
        {
            return this._comBuffDef8;
        }// end function

        public function set comBuffDef8(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffDef8 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffDef8", param1));
            return;
        }// end function

        public function get comBuffDef9() : int
        {
            return this._comBuffDef9;
        }// end function

        public function set comBuffDef9(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffDef9 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffDef9", param1));
            return;
        }// end function

        public function get comBuffDef10() : int
        {
            return this._comBuffDef10;
        }// end function

        public function set comBuffDef10(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comBuffDef10 = param1;
            dispatchEvent(new UnitEvent("update", "comBuffDef10", param1));
            return;
        }// end function

        public function get comSkillCritical() : int
        {
            return this._comSkillCritical;
        }// end function

        public function set comSkillCritical(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comSkillCritical = param1;
            dispatchEvent(new UnitEvent("update", "comSkillCritical", param1));
            return;
        }// end function

        public function get comSkillCriticalDef() : int
        {
            return this._comSkillCriticalDef;
        }// end function

        public function set comSkillCriticalDef(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comSkillCriticalDef = param1;
            dispatchEvent(new UnitEvent("update", "comSkillCriticalDef", param1));
            return;
        }// end function

        public function get comCritical() : int
        {
            return this._comCritical;
        }// end function

        public function set comCritical(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comCritical = param1;
            dispatchEvent(new UnitEvent("update", "comCritical", param1));
            return;
        }// end function

        public function get comCriticalDef() : int
        {
            return this._comCriticalDef;
        }// end function

        public function set comCriticalDef(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comCriticalDef = param1;
            dispatchEvent(new UnitEvent("update", "comCriticalDef", param1));
            return;
        }// end function

        public function get comAtkAdd() : int
        {
            return this._comAtkAdd;
        }// end function

        public function set comAtkAdd(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comAtkAdd = param1;
            dispatchEvent(new UnitEvent("update", "comAtkAdd", param1));
            return;
        }// end function

        public function get comDefAdd() : int
        {
            return this._comDefAdd;
        }// end function

        public function set comDefAdd(param1:int) : void
        {
            var _loc_2:* = param1;
            this._comDefAdd = param1;
            dispatchEvent(new UnitEvent("update", "comDefAdd", param1));
            return;
        }// end function

        public function get dispAtk() : int
        {
            return this._dispAtk;
        }// end function

        public function set dispAtk(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispAtk = param1;
            dispatchEvent(new UnitEvent("update", "dispAtk", param1));
            return;
        }// end function

        public function get dispDef() : int
        {
            return this._dispDef;
        }// end function

        public function set dispDef(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispDef = param1;
            dispatchEvent(new UnitEvent("update", "dispDef", param1));
            return;
        }// end function

        public function get dispDmgAdd() : int
        {
            return this._dispDmgAdd;
        }// end function

        public function set dispDmgAdd(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispDmgAdd = param1;
            dispatchEvent(new UnitEvent("update", "dispDmgAdd", param1));
            return;
        }// end function

        public function get dispDmgReduce() : int
        {
            return this._dispDmgReduce;
        }// end function

        public function set dispDmgReduce(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispDmgReduce = param1;
            dispatchEvent(new UnitEvent("update", "dispDmgReduce", param1));
            return;
        }// end function

        public function get dispAtkSpeed() : int
        {
            return this._dispAtkSpeed;
        }// end function

        public function set dispAtkSpeed(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispAtkSpeed = param1;
            dispatchEvent(new UnitEvent("update", "dispAtkSpeed", param1));
            return;
        }// end function

        public function get dispSkillAdd() : int
        {
            return this._dispSkillAdd;
        }// end function

        public function set dispSkillAdd(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispSkillAdd = param1;
            dispatchEvent(new UnitEvent("update", "dispSkillAdd", param1));
            return;
        }// end function

        public function get dispRate() : int
        {
            return this._dispRate;
        }// end function

        public function set dispRate(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispRate = param1;
            dispatchEvent(new UnitEvent("update", "dispRate", param1));
            return;
        }// end function

        public function get dispSkillRate() : int
        {
            return this._dispSkillRate;
        }// end function

        public function set dispSkillRate(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispSkillRate = param1;
            dispatchEvent(new UnitEvent("update", "dispSkillRate", param1));
            return;
        }// end function

        public function get dispEvade() : int
        {
            return this._dispEvade;
        }// end function

        public function set dispEvade(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispEvade = param1;
            dispatchEvent(new UnitEvent("update", "dispEvade", param1));
            return;
        }// end function

        public function get dispSkillEvade() : int
        {
            return this._dispSkillEvade;
        }// end function

        public function set dispSkillEvade(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispSkillEvade = param1;
            dispatchEvent(new UnitEvent("update", "dispSkillEvade", param1));
            return;
        }// end function

        public function get dispCriticalRate() : int
        {
            return this._dispCriticalRate;
        }// end function

        public function set dispCriticalRate(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispCriticalRate = param1;
            dispatchEvent(new UnitEvent("update", "dispCriticalRate", param1));
            return;
        }// end function

        public function get dispSkillCriticalRate() : int
        {
            return this._dispSkillCriticalRate;
        }// end function

        public function set dispSkillCriticalRate(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispSkillCriticalRate = param1;
            dispatchEvent(new UnitEvent("update", "dispSkillCriticalRate", param1));
            return;
        }// end function

        public function get dispCriticalEvade() : int
        {
            return this._dispCriticalEvade;
        }// end function

        public function set dispCriticalEvade(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispCriticalEvade = param1;
            dispatchEvent(new UnitEvent("update", "dispCriticalEvade", param1));
            return;
        }// end function

        public function get dispSkillCriticalEvade() : int
        {
            return this._dispSkillCriticalEvade;
        }// end function

        public function set dispSkillCriticalEvade(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispSkillCriticalEvade = param1;
            dispatchEvent(new UnitEvent("update", "dispSkillCriticalEvade", param1));
            return;
        }// end function

        public function get dispCriticalAdd() : int
        {
            return this._dispCriticalAdd;
        }// end function

        public function set dispCriticalAdd(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispCriticalAdd = param1;
            dispatchEvent(new UnitEvent("update", "dispCriticalAdd", param1));
            return;
        }// end function

        public function get dispSkillCriticalAdd() : int
        {
            return this._dispSkillCriticalAdd;
        }// end function

        public function set dispSkillCriticalAdd(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispSkillCriticalAdd = param1;
            dispatchEvent(new UnitEvent("update", "dispSkillCriticalAdd", param1));
            return;
        }// end function

        public function get dispCriticalReduce() : int
        {
            return this._dispCriticalReduce;
        }// end function

        public function set dispCriticalReduce(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispCriticalReduce = param1;
            dispatchEvent(new UnitEvent("update", "dispCriticalReduce", param1));
            return;
        }// end function

        public function get dispSkillCriticalReduce() : int
        {
            return this._dispSkillCriticalReduce;
        }// end function

        public function set dispSkillCriticalReduce(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispSkillCriticalReduce = param1;
            dispatchEvent(new UnitEvent("update", "dispSkillCriticalReduce", param1));
            return;
        }// end function

        public function get dispGodAtk()
        {
            return this._dispGodAtk;
        }// end function

        public function set dispGodAtk(param1) : void
        {
            var _loc_2:* = param1;
            this._dispGodAtk = param1;
            dispatchEvent(new UnitEvent("update", "dispGodAtk", param1));
            return;
        }// end function

        public function get dispLuck() : int
        {
            return this._dispLuck;
        }// end function

        public function set dispLuck(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispLuck = param1;
            dispatchEvent(new UnitEvent("update", "dispLuck", param1));
            return;
        }// end function

        public function toGif()
        {
            var _loc_1:* = null;
            _loc_1 = Config.gEncoder;
            _loc_1.start();
            _loc_1.setQuality(1);
            _loc_1.setRepeat(0);
            _loc_1.setDelay(60);
            var _loc_2:* = 16;
            this._toGifCount = 16;
            this.startLoop(this.toGifLoop);
            return;
        }// end function

        private function toGifLoop(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            _loc_6 = Config.gEncoder;
            _loc_8 = 120;
            _loc_9 = 120;
            var _loc_13:* = new BitmapData(_loc_8, _loc_9, true, 0);
            _loc_4 = new BitmapData(_loc_8, _loc_9, true, 0);
            if (this._horse != null)
            {
                var _loc_13:* = new Matrix();
                _loc_7 = new Matrix();
                _loc_7.translate(_loc_8 / 2, 100 + this._horse.y);
                _loc_4.draw(this._horse, _loc_7);
            }
            if (this._img != null)
            {
                var _loc_13:* = new Matrix();
                _loc_7 = new Matrix();
                _loc_7.translate(_loc_8 / 2, 100 + this._img.y);
                _loc_4.draw(this._img, _loc_7);
            }
            _loc_6.addFrame(_loc_4);
            _loc_4.dispose();
            var _loc_13:* = this;
            _loc_13._toGifCount = this._toGifCount - 1;
            if (this._toGifCount <= 0)
            {
                _loc_6.finish();
                _loc_10 = _loc_6.stream;
                this.stopLoop(this.toGifLoop);
                _loc_11 = new URLRequest(Config.replayURL + "file_download.php?name=test.gif");
                var _loc_13:* = _loc_10;
                _loc_11.data = _loc_10;
                var _loc_13:* = URLRequestMethod.POST;
                _loc_11.method = URLRequestMethod.POST;
                var _loc_13:* = "application/octet-stream";
                _loc_11.contentType = "application/octet-stream";
                _loc_12 = new URLLoader();
                _loc_12.load(_loc_11);
            }
            return;
        }// end function

        public function get speedLevel() : int
        {
            return this._speedLevel;
        }// end function

        public function set speedLevel(param1:int) : void
        {
            var _loc_2:* = param1;
            this._speedLevel = param1;
            dispatchEvent(new UnitEvent("update", "speedLevel", param1));
            return;
        }// end function

        public function get dispSpeed() : int
        {
            return this._dispSpeed;
        }// end function

        public function set dispSpeed(param1:int) : void
        {
            var _loc_2:* = param1;
            this._dispSpeed = param1;
            dispatchEvent(new UnitEvent("update", "dispSpeed", param1));
            return;
        }// end function

        public function get autoHp() : uint
        {
            return this._autoHp;
        }// end function

        public function set autoHp(param1:uint) : void
        {
            if (AutoDrug.canBuy && param1 == 0 && this._autoHp > 0)
            {
                GuideUI.testDoId(56, Config.ui._playerHead._autoHpBar, Config.ui._autoDrug);
            }
            var _loc_2:* = param1;
            this._autoHp = param1;
            dispatchEvent(new UnitEvent("update", "autoHp", param1));
            return;
        }// end function

        public function get autoMp() : uint
        {
            return this._autoMp;
        }// end function

        public function set autoMp(param1:uint) : void
        {
            if (AutoDrug.canBuy && param1 == 0 && this._autoMp > 0)
            {
                GuideUI.testDoId(59, Config.ui._playerHead._autoMpBar, Config.ui._autoDrug);
            }
            var _loc_2:* = param1;
            this._autoMp = param1;
            dispatchEvent(new UnitEvent("update", "autoMp", param1));
            return;
        }// end function

        public function get gildCoin() : int
        {
            return this._gildCoin;
        }// end function

        public function set gildCoin(param1:int) : void
        {
            var _loc_2:* = param1;
            this._gildCoin = param1;
            dispatchEvent(new UnitEvent("update", "gildcoin", param1));
            Config.ui._gangs.setGildCoin();
            return;
        }// end function

        public function set escortra(param1:int)
        {
            var _loc_2:* = param1;
            this._escortra = param1;
            dispatchEvent(new UnitEvent("update", "escortra", param1));
            return;
        }// end function

        public function get escortra() : int
        {
            return this._escortra;
        }// end function

        public function set escortrob(param1:int)
        {
            var _loc_2:* = param1;
            this._escortrob = param1;
            dispatchEvent(new UnitEvent("update", "escortrob", param1));
            return;
        }// end function

        public function get escortrob() : int
        {
            return this._escortrob;
        }// end function

        public function set escortstatus(param1:int)
        {
            var _loc_2:* = param1;
            this._escortstatus = param1;
            dispatchEvent(new UnitEvent("update", "escortstatus", param1));
            return;
        }// end function

        public function get escortstatus() : int
        {
            return this._escortstatus;
        }// end function

        public function set escortentryId(param1:int)
        {
            var _loc_2:* = param1;
            this._escortentryId = param1;
            dispatchEvent(new UnitEvent("update", "escortentryId", param1));
            return;
        }// end function

        public function get escortentryId()
        {
            return this._escortentryId;
        }// end function

        public function set LandLife(param1:int) : void
        {
            var _loc_2:* = null;
            if (param1 > 0)
            {
                if (this.landWarBuf.parent == null)
                {
                    this._stateBar._hpBar.addChild(this.landWarBuf);
                }
                _loc_2 = String(param1);
                this.landWarBuf.setLetter(_loc_2);
                var _loc_3:* = 60;
                this.landWarBuf.x = 60;
                var _loc_3:* = -10;
                this.landWarBuf.y = -10;
                if (Config.player.gildid == this.gildid)
                {
                    var _loc_3:* = [new GlowFilter(16777215, 1, 1.2, 1.2, 2, 3), new GlowFilter(16777215, 1, 8, 8, 2, 3, true, true)];
                    this.landWarBuf.filters = [new GlowFilter(16777215, 1, 1.2, 1.2, 2, 3), new GlowFilter(16777215, 1, 8, 8, 2, 3, true, true)];
                }
                else
                {
                    var _loc_3:* = [new GlowFilter(11344686, 1, 1.2, 1.2, 2, 3), new GlowFilter(11344686, 1, 8, 8, 2, 3, true, true)];
                    this.landWarBuf.filters = [new GlowFilter(11344686, 1, 1.2, 1.2, 2, 3), new GlowFilter(11344686, 1, 8, 8, 2, 3, true, true)];
                }
            }
            else if (this.landWarBuf != null)
            {
                if (this.landWarBuf.parent != null)
                {
                    this.landWarBuf.parent.removeChild(this.landWarBuf);
                }
            }
            return;
        }// end function

        public function setFollower(param1:int)
        {
            if (this._follower != null)
            {
                this._follower.destroy();
                var _loc_2:* = null;
                this._follower = null;
            }
            var _loc_2:* = param1;
            this._followerID = param1;
            if (this is Player)
            {
                Config.ui._charUI.redrawFollower();
            }
            if (!this._hideFollower && param1 != 0 && (_otherVisible || this is Player))
            {
                var _loc_2:* = Follower.newFollower(param1, this._x, this._y, UNIT_TYPE_ENUM.TYPEID_FOLLOWER, this._id);
                this._follower = Follower.newFollower(param1, this._x, this._y, UNIT_TYPE_ENUM.TYPEID_FOLLOWER, this._id);
                if (this._map != null)
                {
                    this._follower.display(this._map);
                }
                this._follower.setMaster(this);
            }
            return;
        }// end function

        public function clearFollower()
        {
            this.setFollower(0);
            return;
        }// end function

        public function set hideFollower(param1:Boolean) : void
        {
            var _loc_2:* = param1;
            this._hideFollower = param1;
            this.setFollower(this._followerID);
            return;
        }// end function

        public static function set fullEffect(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            if (_fullEffect != param1)
            {
                _fullEffect = param1;
                if (_fullEffect)
                {
                    Config.message(Config.language("Unit", 6));
                }
                else
                {
                    Config.message(Config.language("Unit", 7));
                }
                _loc_3 = _unitStack[UNIT_TYPE_ENUM.TYPEID_PLAYER];
                for (_loc_2 in _loc_3)
                {
                    
                    _loc_3[_loc_2].wingId = _loc_3[_loc_2].wingId;
                    _loc_3[_loc_2].horseId = _loc_3[_loc_2].horseId;
                }
                if (Config.ui != null)
                {
                    Config.ui._gamesystem._otherVisibleCB.selected = !_otherVisible;
                    Config.ui._mesHistoryPanel.setShowHide();
                }
            }
            return;
        }// end function

        public static function get fullEffect()
        {
            return _fullEffect;
        }// end function

        public static function set otherVisible(param1)
        {
            var _loc_2:* = undefined;
            _otherVisible = param1;
            if (_otherVisible)
            {
                Config.message(Config.language("Unit", 1));
            }
            else
            {
                Config.message(Config.language("Unit", 2));
            }
            var _loc_3:* = _unitStack[UNIT_TYPE_ENUM.TYPEID_PLAYER];
            for (_loc_2 in _loc_3)
            {
                
                if (_loc_3[_loc_2] != Config.player)
                {
                    _loc_3[_loc_2].checkAddImg();
                    if (!_otherVisible)
                    {
                        if (Config.player != null)
                        {
                            if (_loc_3[_loc_2] == Config.player.target)
                            {
                                Config.player.target = null;
                            }
                            if (_loc_3[_loc_2] == Config.player.tracingTarget)
                            {
                                Config.player.tracingTarget = null;
                            }
                        }
                    }
                }
            }
            if (Config.ui != null)
            {
                Config.ui._gamesystem._otherVisibleCB.selected = !_otherVisible;
                Config.ui._mesHistoryPanel.setShowHide();
            }
            return;
        }// end function

        public static function get otherVisible()
        {
            return _otherVisible;
        }// end function

        public static function getUnitList(param1)
        {
            return _unitStack[param1];
        }// end function

        public static function getGameObject(param1)
        {
            var _loc_2:* = getUnit(UNIT_TYPE_ENUM.TYPEID_NPC, param1);
            if (_loc_2 == null)
            {
                _loc_2 = getUnit(UNIT_TYPE_ENUM.TYPEID_GATHER, param1);
            }
            if (_loc_2 == null)
            {
                _loc_2 = getUnit(UNIT_TYPE_ENUM.TYPEID_DOOR, param1);
            }
            return _loc_2;
        }// end function

        public static function getUnit(param1, param2)
        {
            if (_unitStack[param1] != null)
            {
                if (_unitStack[param1][param2] != null)
                {
                    return _unitStack[param1][param2];
                }
            }
            return null;
        }// end function

        public static function getTaskUnit(param1, param2) : Unit
        {
            var _loc_3:* = undefined;
            if (_unitStack[param1] != null)
            {
                for (_loc_3 in _unitStack[param1])
                {
                    
                    if (int(_unitStack[param1][_loc_3]._data.id) == param2)
                    {
                        return _unitStack[param1][_loc_3];
                    }
                }
            }
            return null;
        }// end function

        public static function get unitArray()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = [];
            for (_loc_1 in _unitStack)
            {
                
                for (_loc_2 in _unitStack[_loc_1])
                {
                    
                    _loc_3.push(_unitStack[_loc_1][_loc_2]);
                }
            }
            return _loc_3;
        }// end function

        public static function destroyAll(param1 = null, param2 = null, param3 = null)
        {
            var _loc_4:* = unitArray;
            var _loc_5:* = [];
            var _loc_6:* = 0;
            while (_loc_6 < _loc_4.length)
            {
                
                if (_loc_4[_loc_6].type != param1 && _loc_4[_loc_6] != param2 && (param3 == null || param3 == _loc_4[_loc_6]._map))
                {
                    _loc_4[_loc_6].destroy();
                }
                _loc_6 = _loc_6 + 1;
            }
            return;
        }// end function

        public static function getPlayerlist() : Object
        {
            return _unitStack[UNIT_TYPE_ENUM.TYPEID_PLAYER];
        }// end function

        public static function getNpclist() : Object
        {
            return _unitStack[UNIT_TYPE_ENUM.TYPEID_NPC];
        }// end function

    }
}
