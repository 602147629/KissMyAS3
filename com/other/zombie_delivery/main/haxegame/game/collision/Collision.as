package haxegame.game.collision
{
    import flash.*;
    import haxegame.game.character.*;
    import haxegame.game.coin.*;
    import haxegame.game.goal.*;
    import haxegame.game.human.*;
    import haxegame.game.life.*;
    import haxegame.game.pointer.*;
    import haxegame.game.score.*;
    import haxegame.game.wall.*;
    import haxegame.game.zombie.*;
    import nape.geom.*;
    import nape.phys.*;
    import zpp_nape.geom.*;
    import zpp_nape.util.*;

    public class Collision extends Object
    {
        public var wallMap:IMap;
        public var successPointSet:Array;
        public var successCharacterTypeSet:Array;
        public var score:Score;
        public var pointer:Pointer;
        public var missPointSet:Array;
        public var life:Life;
        public var goalZombie:GoalZombie;
        public var goalHuman:GoalHuman;
        public var goal:Goal;
        public var collisionListener:CollisionListener;
        public var coinRunner:CoinRunner;
        public var characterRunner:CharacterRunner;
        public var bloodPointSet:Array;

        public function Collision(param1:CollisionListener = undefined, param2:CharacterRunner = undefined, param3:CoinRunner = undefined, param4:IMap = undefined, param5:Pointer = undefined, param6:Goal = undefined, param7:Score = undefined, param8:Life = undefined, param9:GoalZombie = undefined, param10:GoalHuman = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            life = param8;
            score = param7;
            goal = param6;
            characterRunner = param2;
            collisionListener = param1;
            wallMap = param4;
            pointer = param5;
            goalZombie = param9;
            goalHuman = param10;
            coinRunner = param3;
            return;
        }// end function

        public function executeCoinAndBackground() : void
        {
            var _loc_3:* = null as CollisionPair;
            var _loc_4:* = 0;
            var _loc_5:* = null as Coin;
            var _loc_1:* = 0;
            var _loc_2:* = collisionListener.coinAndBackgroundSet;
            while (_loc_1 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_1];
                _loc_1++;
                if (_loc_3.id1 in coinRunner.napeMap.map.h)
                {
                    _loc_4 = _loc_3.id1;
                }
                else
                {
                    _loc_4 = _loc_3.id2;
                }
                _loc_5 = coinRunner.map.h[_loc_4];
                _loc_5.playSound();
            }
            return;
        }// end function

        public function executeCharacterAndWall() : void
        {
            var _loc_3:* = null as CollisionPair;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null as Body;
            var _loc_7:* = null as Wall;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = NaN;
            var _loc_10:* = null as Vec2;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = NaN;
            var _loc_13:* = false;
            var _loc_14:* = null as Vec2;
            var _loc_15:* = NaN;
            var _loc_16:* = null as Character;
            var _loc_17:* = null as Vec2;
            var _loc_18:* = null as ZPP_Vec2;
            var _loc_1:* = 0;
            var _loc_2:* = collisionListener.characterAndWallSet;
            while (_loc_1 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_1];
                _loc_1++;
                _loc_4 = -1;
                _loc_5 = -1;
                if (_loc_3.id1 in characterRunner.napeMap.map.h)
                {
                    _loc_4 = _loc_3.id1;
                    _loc_5 = _loc_3.id2;
                }
                else
                {
                    _loc_4 = _loc_3.id2;
                    _loc_5 = _loc_3.id1;
                }
                _loc_6 = characterRunner.napeMap.map.h[_loc_4];
                _loc_7 = wallMap.h[_loc_5];
                if (_loc_7 == null)
                {
                    continue;
                }
                if (_loc_6.zpp_inner.wrap_vel == null)
                {
                    _loc_6.zpp_inner.setupVelocity();
                }
                _loc_10 = _loc_6.zpp_inner.wrap_vel;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_9 = _loc_10.zpp_inner.x;
                if (_loc_6.zpp_inner.wrap_vel == null)
                {
                    _loc_6.zpp_inner.setupVelocity();
                }
                _loc_10 = _loc_6.zpp_inner.wrap_vel;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_12 = _loc_10.zpp_inner.y;
                if (_loc_9 == _loc_9)
                {
                }
                if (_loc_12 != _loc_12)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_10 = new Vec2();
                }
                else
                {
                    _loc_10 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_10.zpp_pool;
                    _loc_10.zpp_pool = null;
                    _loc_10.zpp_disp = false;
                    if (_loc_10 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_10.zpp_inner == null)
                {
                    _loc_13 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_11 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_11 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_11.next;
                        _loc_11.next = null;
                    }
                    _loc_11.weak = false;
                    _loc_11._immutable = _loc_13;
                    _loc_11.x = _loc_9;
                    _loc_11.y = _loc_12;
                    _loc_10.zpp_inner = _loc_11;
                    _loc_10.zpp_inner.outer = _loc_10;
                }
                else
                {
                    if (_loc_10 != null)
                    {
                    }
                    if (_loc_10.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_10.zpp_inner;
                    if (_loc_11._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_11._isimmutable != null)
                    {
                        _loc_11._isimmutable();
                    }
                    if (_loc_9 == _loc_9)
                    {
                    }
                    if (_loc_12 != _loc_12)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_10 != null)
                    {
                    }
                    if (_loc_10.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_10.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                    if (_loc_10.zpp_inner.x == _loc_9)
                    {
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_11 = _loc_10.zpp_inner;
                        if (_loc_11._validate != null)
                        {
                            _loc_11._validate();
                        }
                    }
                    if (_loc_10.zpp_inner.y != _loc_12)
                    {
                        _loc_10.zpp_inner.x = _loc_9;
                        _loc_10.zpp_inner.y = _loc_12;
                        _loc_11 = _loc_10.zpp_inner;
                        if (_loc_11._invalidate != null)
                        {
                            _loc_11._invalidate(_loc_11);
                        }
                    }
                }
                _loc_10.zpp_inner.weak = true;
                _loc_8 = _loc_10;
                _loc_10 = _loc_8;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_9 = Math.sqrt(_loc_10.zpp_inner.x * _loc_10.zpp_inner.x + _loc_10.zpp_inner.y * _loc_10.zpp_inner.y) * _loc_7.restitution;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_9 != _loc_9)
                {
                    throw "Error: Vec2::length cannot be NaN";
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10.zpp_inner.x * _loc_10.zpp_inner.x + _loc_10.zpp_inner.y * _loc_10.zpp_inner.y == 0)
                {
                    throw "Error: Cannot set length of a zero vector";
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_12 = _loc_9 / Math.sqrt(_loc_10.zpp_inner.x * _loc_10.zpp_inner.x + _loc_10.zpp_inner.y * _loc_10.zpp_inner.y);
                _loc_14 = _loc_10;
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_15 = _loc_14.zpp_inner.x * _loc_12;
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_14.zpp_inner.x != _loc_15)
                {
                    if (_loc_15 != _loc_15)
                    {
                        throw "Error: Vec2::" + "x" + " cannot be NaN";
                    }
                    _loc_14.zpp_inner.x = _loc_15;
                    _loc_11 = _loc_14.zpp_inner;
                    if (_loc_11._invalidate != null)
                    {
                        _loc_11._invalidate(_loc_11);
                    }
                }
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_14 = _loc_10;
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_15 = _loc_14.zpp_inner.y * _loc_12;
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_14.zpp_inner.y != _loc_15)
                {
                    if (_loc_15 != _loc_15)
                    {
                        throw "Error: Vec2::" + "y" + " cannot be NaN";
                    }
                    _loc_14.zpp_inner.y = _loc_15;
                    _loc_11 = _loc_14.zpp_inner;
                    if (_loc_11._invalidate != null)
                    {
                        _loc_11._invalidate(_loc_11);
                    }
                }
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._invalidate != null)
                {
                    _loc_11._invalidate(_loc_11);
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                Math.sqrt(_loc_10.zpp_inner.x * _loc_10.zpp_inner.x + _loc_10.zpp_inner.y * _loc_10.zpp_inner.y);
                _loc_16 = characterRunner.map.h[_loc_4];
                _loc_10 = _loc_8;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (!(_loc_16.weight is Number))
                {
                    throw "Class cast error";
                }
                _loc_9 = Math.sqrt(_loc_10.zpp_inner.x * _loc_10.zpp_inner.x + _loc_10.zpp_inner.y * _loc_10.zpp_inner.y) / _loc_16.weight;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_9 != _loc_9)
                {
                    throw "Error: Vec2::length cannot be NaN";
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10.zpp_inner.x * _loc_10.zpp_inner.x + _loc_10.zpp_inner.y * _loc_10.zpp_inner.y == 0)
                {
                    throw "Error: Cannot set length of a zero vector";
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_12 = _loc_9 / Math.sqrt(_loc_10.zpp_inner.x * _loc_10.zpp_inner.x + _loc_10.zpp_inner.y * _loc_10.zpp_inner.y);
                _loc_14 = _loc_10;
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_15 = _loc_14.zpp_inner.x * _loc_12;
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_14.zpp_inner.x != _loc_15)
                {
                    if (_loc_15 != _loc_15)
                    {
                        throw "Error: Vec2::" + "x" + " cannot be NaN";
                    }
                    _loc_14.zpp_inner.x = _loc_15;
                    _loc_11 = _loc_14.zpp_inner;
                    if (_loc_11._invalidate != null)
                    {
                        _loc_11._invalidate(_loc_11);
                    }
                }
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_14 = _loc_10;
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_15 = _loc_14.zpp_inner.y * _loc_12;
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_14.zpp_inner.y != _loc_15)
                {
                    if (_loc_15 != _loc_15)
                    {
                        throw "Error: Vec2::" + "y" + " cannot be NaN";
                    }
                    _loc_14.zpp_inner.y = _loc_15;
                    _loc_11 = _loc_14.zpp_inner;
                    if (_loc_11._invalidate != null)
                    {
                        _loc_11._invalidate(_loc_11);
                    }
                }
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_14.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._invalidate != null)
                {
                    _loc_11._invalidate(_loc_11);
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                Math.sqrt(_loc_10.zpp_inner.x * _loc_10.zpp_inner.x + _loc_10.zpp_inner.y * _loc_10.zpp_inner.y);
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                if (_loc_8 == null)
                {
                    throw "Error: Body::" + "velocity" + " cannot be null";
                }
                if (_loc_6.zpp_inner.wrap_vel == null)
                {
                    _loc_6.zpp_inner.setupVelocity();
                }
                _loc_10 = _loc_6.zpp_inner.wrap_vel;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_8 == null)
                {
                    throw "Error: Cannot assign null Vec2";
                }
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_8.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_9 = _loc_8.zpp_inner.x;
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_8.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_12 = _loc_8.zpp_inner.y;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_9 == _loc_9)
                {
                }
                if (_loc_12 != _loc_12)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_10.zpp_inner.x == _loc_9)
                {
                    if (_loc_10 != null)
                    {
                    }
                    if (_loc_10.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_10.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                }
                if (_loc_10.zpp_inner.y != _loc_12)
                {
                    _loc_10.zpp_inner.x = _loc_9;
                    _loc_10.zpp_inner.y = _loc_12;
                    _loc_11 = _loc_10.zpp_inner;
                    if (_loc_11._invalidate != null)
                    {
                        _loc_11._invalidate(_loc_11);
                    }
                }
                _loc_14 = _loc_10;
                if (_loc_8.zpp_inner.weak)
                {
                    if (_loc_8 != null)
                    {
                    }
                    if (_loc_8.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_8.zpp_inner;
                    if (_loc_11._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_11._isimmutable != null)
                    {
                        _loc_11._isimmutable();
                    }
                    if (_loc_8.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_11 = _loc_8.zpp_inner;
                    _loc_8.zpp_inner.outer = null;
                    _loc_8.zpp_inner = null;
                    _loc_17 = _loc_8;
                    _loc_17.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_17;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_17;
                    }
                    ZPP_PubPool.nextVec2 = _loc_17;
                    _loc_17.zpp_disp = true;
                    _loc_18 = _loc_11;
                    if (_loc_18.outer != null)
                    {
                        _loc_18.outer.zpp_inner = null;
                        _loc_18.outer = null;
                    }
                    _loc_18._isimmutable = null;
                    _loc_18._validate = null;
                    _loc_18._invalidate = null;
                    _loc_18.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_18;
                }
                else
                {
                }
                if (_loc_6.zpp_inner.wrap_vel == null)
                {
                    _loc_6.zpp_inner.setupVelocity();
                }
                pointer.clearLine(_loc_7.lineId);
                WallMap.delete(wallMap, _loc_5);
                if (_loc_6.zpp_inner.wrap_pos == null)
                {
                    _loc_6.zpp_inner.setupPosition();
                }
                _loc_10 = _loc_6.zpp_inner.wrap_pos;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_9 = _loc_10.zpp_inner.x;
                if (_loc_6.zpp_inner.wrap_pos == null)
                {
                    _loc_6.zpp_inner.setupPosition();
                }
                _loc_10 = _loc_6.zpp_inner.wrap_pos;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_12 = _loc_10.zpp_inner.y;
                bloodPointSet.push({x:_loc_9, y:_loc_12});
            }
            return;
        }// end function

        public function executeCharacterAndGoal() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null as Body;
            var _loc_4:* = null as Character;
            var _loc_5:* = null as Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as CharacterType;
            var _loc_1:* = characterRunner.napeMap.map.keys();
            
            if (_loc_1.hasNext())
            {
                _loc_2 = _loc_1.next();
                _loc_3 = characterRunner.napeMap.map.h[_loc_2];
                _loc_4 = characterRunner.map.h[_loc_2];
                if (_loc_3.zpp_inner.wrap_pos == null)
                {
                    _loc_3.zpp_inner.setupPosition();
                }
                _loc_5 = _loc_3.zpp_inner.wrap_pos;
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_5.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_5.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (goal.leftArea.hitTestPoint(_loc_5.zpp_inner.x, _loc_5.zpp_inner.y))
                {
                    _loc_7 = _loc_4.type;
                    switch(_loc_7.index) branch count is:<1>[60, 15] default offset is:<11>;
                    ;
                    goalZombie.setSuccess();
                    contactSuccess(_loc_5, _loc_2, _loc_4.weight, CharacterType.ZOMBIE);
                    score.addZombieCount();
                    ;
                    goalZombie.setMiss();
                    contactMiss(_loc_5, _loc_2);
                }
                else
                {
                    if (_loc_5 != null)
                    {
                    }
                    if (_loc_5.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_5.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                    if (_loc_5 != null)
                    {
                    }
                    if (_loc_5.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_5.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                    if (goal.rightArea.hitTestPoint(_loc_5.zpp_inner.x, _loc_5.zpp_inner.y))
                    {
                        _loc_7 = _loc_4.type;
                        switch(_loc_7.index) branch count is:<1>[39, 15] default offset is:<11>;
                        ;
                        goalHuman.setMiss();
                        contactMiss(_loc_5, _loc_2);
                        ;
                        goalHuman.setSuccess();
                        contactSuccess(_loc_5, _loc_2, _loc_4.weight, CharacterType.HUMAN);
                        score.addHumanCount();
                    }
                }
                ;
            }
            return;
        }// end function

        public function executeCharacterAndFloor() : void
        {
            var _loc_3:* = null as CollisionPair;
            var _loc_4:* = 0;
            var _loc_5:* = null as Body;
            var _loc_1:* = 0;
            var _loc_2:* = collisionListener.characterAndFloorSet;
            while (_loc_1 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_1];
                _loc_1++;
                if (_loc_3.id1 in characterRunner.napeMap.map.h)
                {
                    _loc_4 = _loc_3.id1;
                }
                else
                {
                    _loc_4 = _loc_3.id2;
                }
                _loc_5 = characterRunner.napeMap.map.h[_loc_4];
                if (_loc_5.zpp_inner.wrap_pos == null)
                {
                    _loc_5.zpp_inner.setupPosition();
                }
                contactMiss(_loc_5.zpp_inner.wrap_pos, _loc_4);
            }
            if (collisionListener.characterAndFloorSet.length > 0)
            {
                goalZombie.setMiss();
                goalHuman.setMiss();
            }
            return;
        }// end function

        public function execute() : void
        {
            successPointSet = [];
            missPointSet = [];
            bloodPointSet = [];
            successCharacterTypeSet = [];
            executeCharacterAndWall();
            executeCharacterAndFloor();
            executeCharacterAndGoal();
            executeCoinAndBackground();
            collisionListener.reset();
            return;
        }// end function

        public function contactSuccess(param1:Vec2, param2:int, param3:Number, param4:CharacterType) : void
        {
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            var _loc_6:* = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            var _loc_5:* = param1.zpp_inner.x;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            var _loc_7:* = param1.zpp_inner.y;
            successPointSet.push({x:_loc_5, y:_loc_7});
            successCharacterTypeSet.push(param4);
            characterRunner.delete(param2);
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            var _loc_8:* = coinRunner.create(param1.zpp_inner.x, param1.zpp_inner.y, param3);
            score.add(_loc_8);
            return;
        }// end function

        public function contactMiss(param1:Vec2, param2:int) : void
        {
            life.decrement();
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            var _loc_4:* = param1.zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            var _loc_3:* = param1.zpp_inner.x;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_4 = param1.zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            var _loc_5:* = param1.zpp_inner.y;
            missPointSet.push({x:_loc_3, y:_loc_5});
            characterRunner.delete(param2);
            return;
        }// end function

    }
}
