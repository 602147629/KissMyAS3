package lovefox.unit
{
    import flash.events.*;

    public class Dummy extends Unit
    {
        private var _poolPushed:Boolean = false;
        private var _pushPoolTimer:Object;
        private var _modifiedX:Object;
        private var _modifiedY:Object;
        private var _finalAngle:Object;
        private var _finalPt:Object;
        private var _initModifiedYTime:Object = 1;
        private var _modifiedYTime:Object;
        private var _moveState:Object = 0;
        public var rename:String = "";
        public var nowname:String = "";
        private var _talkTimer:Object;
        private var _talkMode:Object;
        private var _talkInterval:Object;
        private var _talkProb:Object;
        private var _talkRandom:Object;
        private var _talkIndex:Object = 0;
        private var _talkArr:Array;
        public var _dying:Boolean = false;
        private var _hangError:Boolean = false;
        private var _hangErrorTimer:uint;
        private var _hangErrorCount:uint;
        public static var _deadMonsterPosBuff:Object = {};
        public static var _objectPool:Array = [];

        public function Dummy(param1, param2, param3, param4, param5)
        {
            super(param1, param2, param3, param4, param5);
            return;
        }// end function

        function onDieAnimationOver()
        {
            return;
        }// end function

        override public function set hp(param1)
        {
            var _loc_2:* = _hp;
            super.hp = param1;
            if (_type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
            {
                if (_loc_2 > 0 && param1 <= 0)
                {
                    this.dying();
                }
                else if (_loc_2 <= 0 && param1 > 0)
                {
                    this.revive();
                }
            }
            return;
        }// end function

        override public function set baseData(param1)
        {
            super.baseData = param1;
            var _loc_2:* = Number(_data.type);
            var _loc_3:* = Number(_data.hp);
            hpMax = Number(_data.hp);
            this.hp = _loc_3;
            removeHalo(1176);
            removeHalo(1160);
            removeHalo(1159);
            if (_loc_2 == 1)
            {
                addHalo(1176);
            }
            else if (_loc_2 == 2)
            {
                addHalo(1160, 0, 2);
            }
            else if (_loc_2 == 3)
            {
                addHalo(1159, 0, 2);
            }
            return;
        }// end function

        public function set hangErrorCount(param1)
        {
            this._hangErrorCount = param1;
            return;
        }// end function

        public function get hangErrorCount()
        {
            return this._hangErrorCount;
        }// end function

        public function set hangError(param1)
        {
            this.hangErrorCount = 0;
            this._hangError = param1;
            clearTimeout(this._hangErrorTimer);
            if (this._hangError)
            {
                this._hangErrorTimer = setTimeout(this.releaseHangError, 5000);
            }
            return;
        }// end function

        public function get hangError()
        {
            return this._hangError;
        }// end function

        private function releaseHangError()
        {
            clearTimeout(this._hangErrorTimer);
            this.hangError = false;
            return;
        }// end function

        public function dying()
        {
            if (_type == UNIT_TYPE_ENUM.TYPEID_UNIT)
            {
                _deadMonsterPosBuff[id] = {_x:_x, _y:_y};
            }
            if (Hang._preSkillTargetId == id)
            {
                Hang._preSkillTargetId = null;
                Config.player.attacked = false;
            }
            _die = true;
            free();
            changeStateTo("idle");
            if (_img != null)
            {
                _img.shadow = false;
            }
            stopLoop(this.move);
            _moveFlag = false;
            this._dying = true;
            if (_type == UNIT_TYPE_ENUM.TYPEID_UNIT)
            {
                if (_data.type == 3)
                {
                    GuideUI.testDoId(21, this);
                }
                this.subDying();
            }
            else if (_type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
            {
                _die = true;
                if (_buffClip > 0 || _forceClip > 0)
                {
                    if (_img != null)
                    {
                        _img.filters = [UnitEffect._stoneCMF];
                    }
                }
                else
                {
                    changeStateTo("death");
                }
            }
            return;
        }// end function

        private function subDying()
        {
            if (!_jumpWordLock)
            {
                this.dieEffect();
            }
            return;
        }// end function

        override function subJumpWord()
        {
            super.subJumpWord();
            if (this._dying && _jumpWordStack.length == 0)
            {
                if (_type == UNIT_TYPE_ENUM.TYPEID_UNIT)
                {
                    this.dieEffect();
                }
            }
            return;
        }// end function

        public function revive()
        {
            _die = false;
            this._dying = false;
            if (_img != null)
            {
                _img.shadow = true;
            }
            if (_buffClip > 0 || _forceClip > 0)
            {
                if (_img != null)
                {
                    _img.filters = [];
                }
            }
            else
            {
                changeStateTo("idle");
            }
            return;
        }// end function

        private function dieEffect()
        {
            UnitEffect.smash(this);
            this.destroy();
            return;
        }// end function

        private function handleDieEffect()
        {
            this.destroy();
            return;
        }// end function

        override public function display(param1)
        {
            super.display(param1);
            return;
        }// end function

        override function subDisplay(param1 = null)
        {
            super.subDisplay();
            var _loc_2:* = Number(_data.type);
            if (_loc_2 == 1)
            {
                addHalo(1176);
            }
            else if (_loc_2 == 2)
            {
                addHalo(1160, 0, 2);
            }
            else if (_loc_2 == 3)
            {
                addHalo(1159, 0, 2);
            }
            return;
        }// end function

        override public function destroy()
        {
            this.hangErrorCount = 0;
            this.hangError = false;
            super.destroy();
            _weaponId = null;
            _weaponElementID = 0;
            _weaponElementLevel = 0;
            _weaponId = null;
            _clothId = null;
            _hairId = null;
            _horseId = null;
            _wingId = null;
            _focus = false;
            clearTimeout(this._pushPoolTimer);
            if (!this._poolPushed)
            {
                this._poolPushed = true;
                this._pushPoolTimer = setTimeout(this.pushPool, 1000);
            }
            return;
        }// end function

        private function pushPool()
        {
            clearTimeout(this._pushPoolTimer);
            _objectPool.push(this);
            return;
        }// end function

        private function subDestroy()
        {
            this.destroy();
            return;
        }// end function

        public function go(param1, param2, param3)
        {
            var _loc_4:* = undefined;
            if (_speed > 0)
            {
                this._moveState = 1;
                this._modifiedYTime = Math.min(this._initModifiedYTime, Math.sqrt(Math.pow(param3._y - param1._y, 2) + Math.pow(param3._x - param1._x, 2)) / _speed);
                _angle = param2;
                _loc_4 = this._modifiedYTime * _speed;
                this._modifiedX = param1._x + Math.cos(param2) * _loc_4;
                this._modifiedY = param1._y + Math.sin(param2) * _loc_4;
                changeStateTo("walk", null);
                startLoop(this.move);
                _moveFlag = true;
            }
            this._finalPt = param3;
            this._finalAngle = param2;
            return;
        }// end function

        public function stop(param1 = null, param2 = null)
        {
            if (param1 == null)
            {
                _angle = param2;
                directTo(_angle);
                changeStateTo("idle", null);
                stopLoop(this.move);
                _moveFlag = false;
                return;
            }
            this._moveState = 0;
            this._finalAngle = param2;
            this._finalPt = param1;
            var _loc_3:* = _currTile;
            var _loc_4:* = _currTile;
            if (_map != null)
            {
                _loc_4 = _map.mapToTile(this._finalPt);
            }
            if (_loc_4 != _currTile)
            {
                if (_currTile != null)
                {
                    _currTile.removeUnit(this);
                }
                _currTile = _loc_4;
                if (_currTile != null)
                {
                    _currTile.addUnit(this);
                }
                dispatchEvent(new Event("pass"));
            }
            if (Math.abs(param1._x - _x) < 4 && Math.abs(param1._y - _y) < 4)
            {
                _angle = param2;
                directTo(_angle);
                changeStateTo("idle", null);
                stopLoop(this.move);
                _moveFlag = false;
            }
            else
            {
                this._modifiedYTime = Math.sqrt(Math.pow(param1._x - _x, 2) + Math.pow(param1._y - _y, 2)) / _speed / 4 * 3 + 1 / Config.fps;
                _angle = Math.atan2(param1._y - _y, param1._x - _x);
                this._modifiedX = param1._x;
                this._modifiedY = param1._y;
                draw();
            }
            return;
        }// end function

        function move(event:Event)
        {
            var pt:*;
            var footon:*;
            var iPt:*;
            var dis90:*;
            var angle:*;
            var dis0:*;
            var aa:*;
            var event:* = event;
            if (this._modifiedYTime > 1 / Config.fps)
            {
                iPt = PointLine.intersect({_x:_x, _y:_y, _a:_angle + Math.PI / 2}, {_x:this._modifiedX, _y:this._modifiedY, _a:_angle});
                dis90 = PointLine.distance({_x:_x, _y:_y}, iPt);
                if (Math.pow(this._modifiedY - _y, 2) + Math.pow(this._modifiedX - _x, 2) <= (Math.pow(dis90, 2) + 1))
                {
                    pt;
                }
                else
                {
                    dis0 = Math.sqrt(Math.pow(this._modifiedY - _y, 2) + Math.pow(this._modifiedX - _x, 2) - Math.pow(dis90, 2));
                    aa = Math.atan2(this._modifiedY - _y, this._modifiedX - _x);
                    if (Math.cos(aa - _angle) < 0)
                    {
                        dis0 = -dis0;
                    }
                    pt;
                }
                pt = PointLine.leash(iPt, pt, dis90 / 10);
                angle = Math.atan2(pt._y - _y, pt._x - _x);
                directTo(angle);
                _x = pt._x;
                _y = pt._y;
                this._modifiedYTime = this._modifiedYTime - 1 / Config.fps;
            }
            else
            {
                if (this._moveState == 0 || Math.abs(this._finalPt._x - _x) < 2 && Math.abs(this._finalPt._y - _y) < 2)
                {
                    _angle = this._finalAngle;
                    forcePosition(this._finalPt);
                    directTo(_angle);
                    changeStateTo("idle", null);
                    stopLoop(this.move);
                    _moveFlag = false;
                    footon = _map.mapToTile(this._finalPt);
                    if (footon != _currTile)
                    {
                        if (_currTile != null)
                        {
                            _currTile.removeUnit(this);
                        }
                        _currTile = footon;
                        if (_currTile != null)
                        {
                            _currTile.addUnit(this);
                        }
                        dispatchEvent(new Event("pass"));
                    }
                    return;
                }
                directTo(_angle);
                _x = _x + Math.cos(_angle) * _speed / Config.fps;
                _y = _y + Math.sin(_angle) * _speed / Config.fps;
            }
            draw();
            footon = _map.mapToTile({_x:_x, _y:_y});
            if (footon != _currTile)
            {
                if (_currTile != null)
                {
                    _currTile.removeUnit(this);
                }
                _currTile = footon;
                if (_currTile != null)
                {
                    _currTile.addUnit(this);
                    try
                    {
                        swapDepthTile();
                    }
                    catch (e)
                    {
                        trace("swapDepthTile" + e);
                    }
                }
                dispatchEvent(new Event("pass"));
            }
            dispatchEvent(new Event("move"));
            return;
        }// end function

        override public function get level()
        {
            if (_level == null)
            {
                return Number(_data.level);
            }
            return _level;
        }// end function

        private function handleActionEnd()
        {
            changeStateTo("idle");
            return;
        }// end function

        public function testTalk()
        {
            var _loc_1:* = _data;
            if (this._talkMode == 1)
            {
                return;
            }
            var _loc_2:* = false;
            if (this._talkArr == null)
            {
                _loc_2 = true;
                this._talkMode = Number(_loc_1.talkMode);
                this._talkArr = String(_loc_1.talkText).split("|");
                this._talkInterval = Number(_loc_1.talkInterval);
                this._talkProb = Number(_loc_1.talkProb);
                this._talkRandom = Number(_loc_1.talkRandom);
            }
            if (this._talkMode != 4 && this._talkMode != 5)
            {
                return;
            }
            clearTimeout(this._talkTimer);
            var _loc_3:* = "";
            if (!_loc_2)
            {
                if (this._talkRandom == 0)
                {
                    if (this._talkIndex >= this._talkArr.length)
                    {
                        this._talkIndex = 0;
                    }
                    _loc_3 = this._talkArr[this._talkIndex];
                }
                else
                {
                    _loc_3 = this._talkArr[Math.floor(Math.random() * this._talkArr.length)];
                }
                say(_loc_3, _loc_3.length * 0.4);
            }
            this._talkTimer = setTimeout(this.testTalk, Math.floor((this._talkInterval + _loc_3.length * 0.4) * 1000));
            return;
        }// end function

        override public function set visible(param1:Boolean)
        {
            var _loc_2:* = undefined;
            if (_mc == null || _map == null || _map._rootMap == null)
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
                if (_mc.parent == null && !(_type == UNIT_TYPE_ENUM.TYPEID_PLAYER && !_otherVisible))
                {
                    if (_data.taskMonster == null || _data.taskMonster == 0)
                    {
                        _map._rootMap.addChild(_mc);
                    }
                    else if (_data.taskMonster == 1)
                    {
                        _map._textMap.addChild(_mc);
                    }
                }
                if (!_stateBar.visible)
                {
                    _stateBar.check();
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
                if (_mc.parent != null)
                {
                    _mc.parent.removeChild(_mc);
                }
                _stateBar.visible = false;
                clearEnterframeLoop();
                if (EventMouse._hoverUnit == this)
                {
                    EventMouse._hoverUnit = null;
                }
                _map.removeHalo(this);
                for (_loc_2 in _buffEffect)
                {
                    
                    removeBuff(_loc_2, true);
                }
            }
            return;
        }// end function

        public static function newDummy(param1, param2, param3, param4, param5)
        {
            var _loc_6:* = null;
            if (_objectPool.length == 0)
            {
                return new Dummy(param1, param2, param3, param4, param5);
            }
            _loc_6 = _objectPool.shift();
            _loc_6._poolPushed = false;
            _loc_6._data = param1;
            _loc_6._level = null;
            _loc_6._x = param2;
            _loc_6._y = param3;
            _loc_6._dying = false;
            _loc_6._moveFlag = false;
            _loc_6._forceClip = 0;
            _loc_6._dying = false;
            _loc_6._focus = false;
            if (_loc_6._legalPt == null)
            {
                _loc_6._legalPt = {_x:param2, _y:param3};
            }
            else
            {
                _loc_6._legalPt._x = param2;
                _loc_6._legalPt._y = param3;
            }
            _loc_6._type = param4;
            _loc_6._id = param5;
            if (_loc_6._data != null)
            {
                if (_loc_6._data.normalAtkId != null)
                {
                    _loc_6.attackMode = Config._skillMap[_loc_6._data.normalAtkId];
                }
            }
            if (_unitStack[_loc_6._type] == null)
            {
                _unitStack[_loc_6._type] = {};
            }
            _unitStack[_loc_6._type][_loc_6._id] = _loc_6;
            _loc_6._enterframeListenerArray = [];
            _loc_6._stateBar.check();
            if (_loc_6._type == UNIT_TYPE_ENUM.TYPEID_PLAYER && _loc_6._forceClip == 0 && _loc_6._buffClip == 0)
            {
                _loc_6.clothId = _loc_6.clothId;
                _loc_6.hairId = _loc_6.hairId;
                _loc_6.wingId = _loc_6.wingId;
                _loc_6.horseId = _loc_6.horseId;
            }
            var _loc_8:* = _allCount + 1;
            _allCount = _loc_8;
            _loc_6.visible = true;
            return _loc_6;
        }// end function

    }
}
