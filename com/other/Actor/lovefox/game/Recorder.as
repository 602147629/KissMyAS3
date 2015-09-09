package lovefox.game
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import lovefox.unit.*;

    public class Recorder extends EventDispatcher
    {
        private var _type:int;
        private var _startTimer:Number;
        private var _recording:Boolean = false;
        private var _recordObj:Object;
        private var _frame:Object = 0;
        private var _snap:Object = 0;
        private var _keyFrameSkip:Object = 300;
        private var _score:Object = 0;
        private var _averPlayer:Object = 0;
        private var _averMonster:Object = 0;
        private var _maxUnit:Object = 0;
        private var _averSkill:Object = 0;
        private var _maxSkillCount:Object = 0;
        private var _maxSkill:Object = 0;
        private var _hasBoss:Object = 0;
        private var _cover:ByteArray;
        public static var _ver:Number = 1.3;
        public static var _stack:Object = {};

        public function Recorder()
        {
            return;
        }// end function

        private function castSkill()
        {
            var _loc_1:* = this;
            var _loc_2:* = this._averSkill + 1;
            _loc_1._averSkill = _loc_2;
            var _loc_1:* = this;
            var _loc_2:* = this._maxSkillCount + 1;
            _loc_1._maxSkillCount = _loc_2;
            return;
        }// end function

        public function start(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = null;
            trace("recorder.start");
            this._type = param1;
            this._startTimer = getTimer();
            this._recording = true;
            this._recordObj = {};
            this._recordObj.head = {};
            this._recordObj.head.time = Config.now.getTime();
            this._recordObj.head.player = Config.player.id;
            this._recordObj.head.keyFrame = this._keyFrameSkip;
            this._recordObj.timeLine = {};
            this._recordObj.points = [];
            this._frame = 0;
            this._score = 0;
            this._snap = 0;
            this._averPlayer = 0;
            this._averMonster = 0;
            this._maxUnit = 0;
            this._averSkill = 0;
            this._maxSkillCount = 0;
            this._maxSkill = 0;
            this._hasBoss = 0;
            Config.startLoop(this.enterFrame);
            this.enterFrame();
            if (this._cover != null)
            {
                this._cover.clear();
                this._cover = null;
            }
            var _loc_5:* = 120;
            var _loc_6:* = 90;
            var _loc_7:* = new BitmapData(_loc_5, _loc_6, false, 0);
            var _loc_8:* = new Matrix();
            new Matrix().scale(0.5, 0.5);
            _loc_8.translate((-(Config.map.width - _loc_5 * 2)) / 4, (-(Config.map.height - _loc_6 * 2)) / 4);
            _loc_7.draw(Config.map, _loc_8);
            this._cover = Config.jEncoder.encode(_loc_7);
            _loc_7.dispose();
            return;
        }// end function

        private function enterFrame(param1 = null)
        {
            if (this._frame % this._keyFrameSkip == 0)
            {
                this._recordObj.points.push(this.getSnap());
            }
            var _loc_2:* = this;
            var _loc_3:* = this._frame + 1;
            _loc_2._frame = _loc_3;
            return;
        }// end function

        private function getSnap()
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_6:* = new Date();
            var _loc_7:* = {};
            {}.date = _loc_6.getTime();
            _loc_7.frame = this._frame;
            _loc_7.map = Config.map.id;
            _loc_7.units = [];
            var _loc_8:* = Unit.unitArray;
            for (_loc_3 in _loc_8)
            {
                
                _loc_4 = _loc_8[_loc_3];
                if (_loc_4._data != null)
                {
                    if (_loc_4.horseId == null || _loc_4.horseId.id == 0)
                    {
                        _loc_9 = null;
                    }
                    else
                    {
                        _loc_9 = _loc_4.horseId.id + "_" + _loc_4.horseId.star;
                    }
                    if (_loc_4.wingId == null || _loc_4.wingId.id == 0)
                    {
                        _loc_10 = null;
                    }
                    else
                    {
                        _loc_10 = _loc_4.wingId.id + "_" + _loc_4.wingId.star;
                    }
                    if (_loc_4.type == UNIT_TYPE_ENUM.TYPEID_DOOR)
                    {
                        _loc_11 = Number(_loc_4._data.model);
                    }
                    else
                    {
                        _loc_11 = Number(_loc_4._data.id);
                    }
                    _loc_7.units.push({type:_loc_4.type, n:_loc_4.name, id:_loc_4.id, bid:_loc_11, s:_loc_4._state, a:_loc_4._angle, x:_loc_4._x, y:_loc_4._y, spd:_loc_4.speed, job:_loc_4.job, sex:_loc_4.sex, hp:_loc_4.hp, mhp:_loc_4.hpMax, wid:_loc_4.weaponId, cid:_loc_4.clothId, hid:_loc_4.hairId, horse:_loc_9, wing:_loc_10, bc:_loc_4.buffClip, fc:_loc_4.forceClip});
                }
                if (_loc_4.type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
                {
                    _loc_1 = _loc_1 + 1;
                    continue;
                }
                if (_loc_4.type == UNIT_TYPE_ENUM.TYPEID_UNIT)
                {
                    if (Number(_loc_4._data.type) == 1 || Number(_loc_4._data.type) == 2 || Number(_loc_4._data.type) == 3)
                    {
                        _loc_2 = _loc_2 + 2;
                        continue;
                    }
                    if (Number(_loc_4._data.type) == 4)
                    {
                        _loc_2 = _loc_2 + 10;
                        this._hasBoss = 1;
                        continue;
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            this._averPlayer = this._averPlayer + _loc_1;
            this._averMonster = this._averMonster + _loc_2;
            this._maxUnit = Math.max(this._maxUnit, _loc_1 + _loc_2);
            this._maxSkill = Math.max(this._maxSkill, this._maxSkillCount);
            this._maxSkillCount = 0;
            var _loc_12:* = this;
            var _loc_13:* = this._snap + 1;
            _loc_12._snap = _loc_13;
            _loc_7.items = [];
            for (_loc_3 in Item.itemArray)
            {
                
                _loc_5 = Item.itemArray[_loc_3];
                if (_loc_5._map != null)
                {
                    _loc_7.items.push({type:_loc_5.type, id:_loc_5.id, bid:Number(_loc_5._data.id), x:_loc_5._x, y:_loc_5._y});
                }
            }
            return _loc_7;
        }// end function

        public function stop()
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            this._score = 0;
            var _loc_1:* = Math.floor(this._frame / Config.fps);
            if (_loc_1 < 30)
            {
            }
            else if (_loc_1 < 60)
            {
                this._score = this._score + Math.min((_loc_1 - 30) / 30 * 10, 10);
            }
            else
            {
                this._score = this._score + Math.min((_loc_1 - 60) / 240 * 10 + 10, 20);
            }
            trace("时间分20", this._score);
            if (this._snap > 0)
            {
                _loc_3 = this._averPlayer / this._snap;
                this._score = this._score + Math.min(_loc_3 / 20 * 10, 10);
                trace("平均玩家10", Math.min(_loc_3 / 20 * 10, 10));
                _loc_4 = this._averMonster / this._snap;
                this._score = this._score + Math.min(_loc_4 / 30 * 10, 10);
                trace("平均怪物10", Math.min(_loc_4 / 30 * 10, 10));
                this._score = this._score + Math.min(this._maxUnit / 50 * 10, 10);
                trace("最高单位10", Math.min(this._maxUnit / 50 * 10, 10));
                this._score = this._score + Math.min(this._averSkill / Math.max(_loc_1, 1) / 40 * 20, 20);
                trace("平均技能20", Math.min(this._averSkill / Math.max(_loc_1, 1) / 40 * 20, 20));
                this._score = this._score + Math.min(this._maxSkill / this._keyFrameSkip * 30 / 100 * 20, 20);
                trace("最高技能20", Math.min(this._maxSkill / this._keyFrameSkip * 30 / 100 * 20, 20));
                this._score = this._score + this._hasBoss * 10;
                trace("是否有BOSS 10", this._hasBoss * 10);
            }
            trace("总分", this._score);
            Config.stopLoop(this.enterFrame);
            trace("recorder.stop");
            this._recording = false;
            this._recordObj.head.totalFrame = this._frame;
            this._recordObj.head.ver = _ver;
            var _loc_2:* = new ByteArray();
            _loc_2.writeObject(this._recordObj);
            _loc_2.position = 0;
            _loc_2.compress();
            return _loc_2;
        }// end function

        private function pushAction(param1:ByteArray)
        {
            var _loc_2:* = undefined;
            if (this._recording)
            {
                _loc_2 = this._frame;
                if (this._recordObj.timeLine[_loc_2] == null)
                {
                    this._recordObj.timeLine[_loc_2] = [];
                }
                this._recordObj.timeLine[_loc_2].push(param1);
            }
            return;
        }// end function

        public static function castSkill()
        {
            var _loc_1:* = undefined;
            for (_loc_1 in _stack)
            {
                
                _stack[_loc_1].castSkill();
            }
            return;
        }// end function

        public static function getCover(param1)
        {
            if (_stack[param1] != null)
            {
                return _stack[param1]._cover;
            }
            return null;
        }// end function

        public static function clearCover(param1)
        {
            if (_stack[param1] != null)
            {
                _stack[param1]._cover.clear();
                _stack[param1]._cover = null;
                delete _stack[param1];
            }
            return;
        }// end function

        public static function getFrame(param1)
        {
            if (_stack[param1] != null)
            {
                return _stack[param1]._frame;
            }
            return 0;
        }// end function

        public static function getScore(param1)
        {
            if (_stack[param1] != null)
            {
                return _stack[param1]._score;
            }
            return 0;
        }// end function

        public static function start(param1)
        {
            if (_stack[param1] == null)
            {
                _stack[param1] = new Recorder;
                _stack[param1].start(param1);
            }
            return;
        }// end function

        public static function stop(param1)
        {
            if (_stack[param1] != null)
            {
                return _stack[param1].stop();
            }
            return;
        }// end function

        public static function pushAction(param1:ByteArray)
        {
            var _loc_2:* = undefined;
            for (_loc_2 in _stack)
            {
                
                _stack[_loc_2].pushAction(param1);
            }
            return;
        }// end function

        public static function get recording() : Boolean
        {
            var _loc_1:* = undefined;
            for (_loc_1 in _stack)
            {
                
                if (_stack[_loc_1]._recording)
                {
                    return true;
                }
            }
            return false;
        }// end function

    }
}
