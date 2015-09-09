package lovefox.unit
{
    import com.bit101.components.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import lovefox.game.*;
    import lovefox.gameUI.*;
    import lovefox.gui.*;
    import lovefox.isometric.*;
    import lovefox.socket.*;

    public class Player extends Unit
    {
        private var _modifiedX:Object;
        private var _modifiedY:Object;
        private var _finalAngle:Object;
        private var _finalPt:Object;
        private var _initModifiedYTime:Object = 1;
        private var _modifiedYTime:Object;
        private var _moveState:Object = 0;
        private var _actionLockReleaseTimer:uint;
        private var _preFixPositionDistance:Object;
        private var _legalPosition:Boolean = true;
        private var _legalPath:Object;
        private var _legalPathAngle:Object;
        private var _legalStopTimer:Object;
        private var _legalDistance:Object;
        private var _legalNode:Object;
        private var _legalTime:Object;
        private var _moveBCTimer:Object;
        public var _skillShareLock:Boolean;
        var _path:Array;
        public var _desTile:Object;
        public var _desPt:Object;
        public var _buffPt:Object;
        public var _buffFromMouse:Object;
        public var _gatherFlag:Boolean = false;
        private var _preStopTile:Object;
        private var _preStopTime:Object;
        private var _preMoveTime:Object;
        var _moveLock:Boolean;
        var _thinkLock:Boolean = false;
        var _thinkTimer:uint;
        var _moveLockInterval:Number;
        private var _startMoveTime:int = -1;
        private var _target:Object;
        private var _tracingTarget:Unit;
        private var _dyingAlert:AlertUI;
        private var _gatherbar:GatherBar;
        private var _dyingClock:uint;
        private var _dyingTimer:uint;
        private var _dyingTimerObj:uint;
        private var _dyingHalo:Boolean;
        private var _attacked:Boolean = false;
        private var _attackedTimer:Number;
        public var _equiplucky:Number;
        private var _lock:Object = false;
        private var _preMapTarget:Object;
        private var _reEnterMapTimer:Object;
        private var dieBtn1:PushButton;
        private var dieBtn2:PushButton;
        private var dieBtn3:PushButton;
        private var dieNum:int = 0;
        private var dieTime:Timer;
        public var moneyLifeNum:int = 0;
        public var moneyLifeTime:int = 0;
        public var _hateStatePrepare:Boolean = false;
        private var _hateStateTimer:Number;
        private var _hateClearTimer:Number;
        private var _hatePickTimer:Number;
        public var _hateState:Boolean = false;
        private var _hateList:Object;
        private var _hateTarget:Dummy;
        private var _hateThinkTimer:Number;
        private var _itemLockMap:Object;
        private var shelterBuf:Laba;
        private var shelterBufFilter:int = 0;
        private var shelterBufFilter1:Array;
        private var shelterBufFilter2:Array;
        private var _effectTime:int = 0;
        private var _autoPickPath:Boolean = false;
        private static var _playerUnit:Player;
        private static var _name:String;
        private static var _title:String;
        private static var _job:uint;
        private static var _sex:uint;
        private static var _level:uint;
        public static var _buffJump:Object;
        public static var _player:Object;
        private static var playerId:Object;
        public static var _playerName:Object;
        public static var _playerX:Object;
        public static var _playerY:Object;
        public static var _playerHC:Object;
        public static var _playerBC:Object;
        public static var _playerAttackMode:Object;
        private static var _playerProp:Object = {};
        public static var _syncModifiedTime:Object;
        public static var _syncInterval:Object;

        public function Player(param1, param2, param3, param4, param5)
        {
            this._path = [];
            this._hateList = {};
            this._itemLockMap = {};
            this.shelterBufFilter1 = [new GlowFilter(16777215, 1, 1.2, 1.2, 2, 3), new GlowFilter(16777215, 1, 8, 8, 2, 3, true, true)];
            this.shelterBufFilter2 = [new GlowFilter(16777215, 1, 1.2, 1.2, 2, 3), new GlowFilter(16777215, 1, 8, 8, 2, 3, true, true), new GlowFilter(16711680, 1, 4, 4, 2, 3)];
            super(param1, param2, param3, param4, param5);
            _walkBlock = false;
            _player = this;
            this._startMoveTime = -1;
            this._moveLock = false;
            _actionLock = false;
            _moveFlag = false;
            this._skillShareLock = false;
            getFocus();
            this.attackMode = _playerAttackMode;
            this.dieinit();
            this.shelterBuf = new Laba();
            return;
        }// end function

        public function addHate(param1:Dummy)
        {
            if (this._hateList[param1.id] == null)
            {
                this._hateList[param1.id] = param1;
                param1.removeEventListener("die", this.handleHateUnitDestroy);
                param1.removeEventListener("destroy", this.handleHateUnitDestroy);
                param1.addEventListener("die", this.handleHateUnitDestroy);
                param1.addEventListener("destroy", this.handleHateUnitDestroy);
                if (this._hateTarget == null)
                {
                    this.hateNext();
                }
            }
            return;
        }// end function

        public function removeHate(param1:Dummy)
        {
            param1.removeEventListener("die", this.handleHateUnitDestroy);
            param1.removeEventListener("destroy", this.handleHateUnitDestroy);
            delete this._hateList[param1.id];
            if (this._hateTarget == param1)
            {
                this._hateTarget = null;
                this.hateNext();
            }
            return;
        }// end function

        private function handleHateUnitDestroy(param1)
        {
            var _loc_2:* = param1.currentTarget;
            this.removeHate(_loc_2);
            return;
        }// end function

        public function getBestHateUnit()
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            var _loc_1:* = [];
            for (_loc_3 in this._hateList)
            {
                
                _loc_2 = this._hateList[_loc_3];
                _loc_1.push({unit:_loc_2, dis:this.testDistance(_loc_2)});
            }
            if (_loc_1.length == 0)
            {
                return null;
            }
            _loc_1.sortOn("dis", Array.NUMERIC);
            return _loc_1[0].unit;
        }// end function

        private function hateNext()
        {
            if (this._hateState)
            {
                this._hateTarget = this.getBestHateUnit();
                if (this._hateTarget != null)
                {
                    clearTimeout(this._hatePickTimer);
                    startLoop(this.subHateNext);
                }
                else
                {
                    this._hateClearTimer = setTimeout(this.clearHate, 15000);
                    this._hatePickTimer = setTimeout(this.hatePickLoop, 1000);
                    this.hatePickLoop();
                }
            }
            return;
        }// end function

        private function subHateNext(param1)
        {
            stopLoop(this.subHateNext);
            if (this._hateTarget != null)
            {
                this.target = this._hateTarget;
            }
            return;
        }// end function

        public function clearHate()
        {
            var _loc_1:* = undefined;
            clearTimeout(this._hatePickTimer);
            clearTimeout(this._hateClearTimer);
            clearTimeout(this._hateStateTimer);
            stopLoop(this.subHateNext);
            this._hateState = false;
            this._hateTarget = null;
            this._hateStatePrepare = false;
            for (_loc_1 in this._hateList)
            {
                
                this.removeHate(this._hateList[_loc_1]);
            }
            return;
        }// end function

        public function clearHatePrepare()
        {
            var _loc_1:* = undefined;
            if (!this._hateState && this._hateStatePrepare)
            {
                clearTimeout(this._hateStateTimer);
                this._hateState = false;
                this._hateStatePrepare = false;
                for (_loc_1 in this._hateList)
                {
                    
                    this.removeHate(this._hateList[_loc_1]);
                }
            }
            return;
        }// end function

        private function hatePickLoop()
        {
            var _loc_1:* = null;
            clearTimeout(this._hatePickTimer);
            if (this.target == null)
            {
                _loc_1 = Hang.findNearItem();
                if (_loc_1 != null)
                {
                    this.target = _loc_1;
                }
            }
            this._hatePickTimer = setTimeout(this.hatePickLoop, 1000);
            return;
        }// end function

        private function setHate()
        {
            clearTimeout(this._hateStateTimer);
            this._hateState = true;
            if (this._hateTarget == null)
            {
                this.hateNext();
            }
            return;
        }// end function

        private function lockItem(param1)
        {
            this.releaseItemLock(param1);
            this._itemLockMap[param1] = setTimeout(this.releaseItemLock, 5000, param1);
            return;
        }// end function

        private function releaseItemLock(param1)
        {
            clearTimeout(this._itemLockMap[param1]);
            delete this._itemLockMap[param1];
            return;
        }// end function

        public function testPositionLegal()
        {
            var _loc_2:* = null;
            var _loc_1:* = false;
            if (_x < 0 || _y < 0 || _x > _map._logicalWidth * Map._ptPerTile / 2 || _y > _map._logicalHeight * Map._ptPerTile / 2)
            {
                _loc_1 = true;
            }
            if (!_loc_1)
            {
                _loc_2 = _map.mapToTile(this);
                if (!_loc_2.terrainwalkable)
                {
                    _loc_1 = true;
                }
            }
            return !_loc_1;
        }// end function

        override public function set hp(param1)
        {
            super.hp = param1;
            if (hp == hpMax && mp == mpMax && resting)
            {
                this.stopRest();
            }
            if (GuideUI.testId(11) && hp < hpMax * 0.9)
            {
                GuideUI.doId(11, Config.ui._quickUI._restSlot);
            }
            else if (GuideUI.testId(12) && hp < hpMax * 0.5)
            {
                GuideUI.doId(12);
            }
            return;
        }// end function

        override public function set mp(param1)
        {
            super.mp = param1;
            if (hp == hpMax && mp == mpMax && resting)
            {
                this.stopRest();
            }
            return;
        }// end function

        public function set lock(param1)
        {
            this._lock = param1;
            if (this._lock)
            {
                this.stop(false, true);
            }
            return;
        }// end function

        public function get lock()
        {
            return this._lock;
        }// end function

        public function set attacked(param1)
        {
            this._attacked = param1;
            clearTimeout(this._attackedTimer);
            if (this._attacked)
            {
                this._attackedTimer = setTimeout(this.attackedOver, 2000);
                if (!this._hateStatePrepare && !_moveFlag && !Config.ui._monsterIndexUI.hanging)
                {
                    this._hateStatePrepare = true;
                    clearTimeout(this._hatePickTimer);
                    clearTimeout(this._hateClearTimer);
                    clearTimeout(this._hateStateTimer);
                    this._hateStateTimer = setTimeout(this.setHate, 10000);
                }
            }
            return;
        }// end function

        private function attackedOver()
        {
            clearTimeout(this._attackedTimer);
            this.attacked = false;
            return;
        }// end function

        public function get attacked()
        {
            return this._attacked;
        }// end function

        public function set die(param1:Boolean)
        {
            if (Config.ui._dealUI._opening)
            {
                Config.ui._dealUI.closedealpanel();
                Config.ui._dealUI.close();
            }
            _die = param1;
            return;
        }// end function

        public function dying(param1:uint, param2:int, param3:int, param4:int)
        {
            if (param2 == 0 || param2 == 1 || param2 == 2 || param2 == 3)
            {
                this.die = true;
                if (Config.map._type != 27)
                {
                    if (Config.map._type != 25)
                    {
                        this.stop(false, true);
                        if (_buffClip > 0 || _forceClip > 0)
                        {
                            _img.filters = [UnitEffect._stoneCMF];
                        }
                        else
                        {
                            changeStateTo("death");
                        }
                        if (_img != null)
                        {
                            _img.shadow = false;
                        }
                        Hang.currTarget = null;
                        this.target = null;
                        this.attacked = false;
                        this.free();
                        this.dieNum = param1;
                        this.dieTime.start();
                        this.dieBtn1.filters = [new ColorMatrixFilter([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0])];
                        if (param3 > 0)
                        {
                            this.dieBtn2.filters = [new ColorMatrixFilter([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0])];
                        }
                        if (param4 > 0)
                        {
                            this.dieBtn3.filters = [new ColorMatrixFilter([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0])];
                        }
                        this.dieBtn1.mouseEnabled = false;
                        this.dieBtn1.mouseChildren = false;
                        this.dieBtn2.setCd(param3 * 1000, 60000);
                        this.dieBtn3.setCd(param4 * 1000, 300000);
                        if (Config.map != null)
                        {
                            if (Config.map._type == 0 || Config.map._type == 1 || Config.map._type == 2 || Config.map._type == 7 || Config.map._type == 8 || Config.map._type == 12 || Config.map._type == 13 || Config.map._type == 14 || Config.map._type == 15 || Config.map._type == 16 || Config.map._type == 17 || Config.map._type == 26 || Config.mapId >= 1000000000)
                            {
                                this.btnTypeFuc(1);
                            }
                            else if (Config.map._type == 11)
                            {
                                this.btnTypeFuc(3);
                            }
                            else
                            {
                                this.btnTypeFuc(2);
                            }
                        }
                        else
                        {
                            this.btnTypeFuc(2);
                        }
                    }
                }
            }
            return;
        }// end function

        private function dieinit() : void
        {
            this.dieBtn1 = new PushButton(null, 0, 0, Config.language("Player", 1), Config.create(this.getLife, 1));
            this.dieBtn1.setTable("table30", "table30");
            this.dieBtn1.width = 84;
            this.dieBtn1.height = 35;
            this.dieBtn2 = new PushButton(null, 0, 0, Config.language("Player", 2), Config.create(this.getLife, 2));
            this.dieBtn2.setTable("table30", "table30");
            this.dieBtn2.width = 84;
            this.dieBtn2.height = 35;
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                this.dieBtn3 = new PushButton(null, 0, 0, Config.language("Player", 26), Config.create(this.getLife, 3));
            }
            else
            {
                this.dieBtn3 = new PushButton(null, 0, 0, Config.language("Player", 3), Config.create(this.getLife, 3));
            }
            this.dieBtn3.setTable("table30", "table30");
            this.dieBtn3.width = 84;
            this.dieBtn3.height = 35;
            this.dieBtn1.textColor = 16777215;
            this.dieBtn2.textColor = 16777215;
            this.dieBtn3.textColor = 16777215;
            this.dieBtn3.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.handlerroll, 1, 3));
            this.dieBtn3.addEventListener(MouseEvent.ROLL_OUT, Config.create(this.handlerroll, 0, 3));
            this.dieBtn2.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.handlerroll, 1, 2));
            this.dieBtn2.addEventListener(MouseEvent.ROLL_OUT, Config.create(this.handlerroll, 0, 2));
            this.dieBtn1.addEventListener(MouseEvent.ROLL_OVER, Config.create(this.handlerroll, 1, 1));
            this.dieBtn1.addEventListener(MouseEvent.ROLL_OUT, Config.create(this.handlerroll, 0, 1));
            this.dieBtn2.addEventListener("cd_stop", Config.create(this.handlerroll, 2, 2));
            this.dieBtn3.addEventListener("cd_stop", Config.create(this.handlerroll, 2, 3));
            this.dieTime = new Timer(1000);
            this.dieTime.addEventListener(TimerEvent.TIMER, this.dieTimeRun);
            return;
        }// end function

        private function handlerroll(event:Event, param2:int, param3:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            if (param2 == 1)
            {
                _loc_4 = event.currentTarget.filters;
                _loc_4.push(new GlowFilter());
                event.currentTarget.filters = _loc_4;
                switch(param3)
                {
                    case 1:
                    {
                        _loc_5 = Config.language("Player", 4);
                        _loc_6 = this.dieBtn1;
                        break;
                    }
                    case 2:
                    {
                        if (this.dieBtn2.cd > 0)
                        {
                            _loc_5 = Config.language("Player", 5);
                        }
                        else
                        {
                            _loc_5 = Config.language("Player", 4);
                        }
                        _loc_6 = this.dieBtn2;
                        break;
                    }
                    case 3:
                    {
                        if (this.dieBtn3.cd > 0)
                        {
                            _loc_5 = Config.language("Player", 6);
                        }
                        else
                        {
                            _loc_5 = Config.language("Player", 4);
                        }
                        _loc_6 = this.dieBtn3;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_7 = _loc_6.parent.localToGlobal(new Point(_loc_6.x, _loc_6.y));
                Holder.showInfo(_loc_5, new Rectangle(_loc_7.x, _loc_7.y, 60, 40), true, 0, 220);
            }
            else if (param2 == 0)
            {
                _loc_4 = event.currentTarget.filters;
                _loc_4.pop();
                event.currentTarget.filters = _loc_4;
                Holder.closeInfo();
            }
            else
            {
                event.currentTarget.filters = [];
                Holder.closeInfo();
            }
            return;
        }// end function

        private function btnTypeFuc(param1:int = 1) : void
        {
            if (param1 == 1)
            {
                Config.ui._layer4.addChild(this.dieBtn1);
                this.dieBtn1.x = (Config.stage.stageWidth - 200) / 2;
                this.dieBtn1.y = Config.stage.stageHeight - 130;
                Config.ui._layer4.addChild(this.dieBtn2);
                this.dieBtn2.x = this.dieBtn1.x + 90;
                this.dieBtn2.y = this.dieBtn1.y;
                Config.ui._layer4.addChild(this.dieBtn3);
                this.dieBtn3.x = this.dieBtn2.x + 90;
                this.dieBtn3.y = this.dieBtn1.y;
            }
            else if (param1 == 3)
            {
            }
            else
            {
                Config.ui.addChild(this.dieBtn1);
                this.dieBtn1.x = (Config.stage.stageWidth - 200) / 2;
                this.dieBtn1.y = Config.stage.stageHeight - 130;
            }
            return;
        }// end function

        public function reSizeBtn() : void
        {
            this.dieBtn1.x = (Config.stage.stageWidth - 200) / 2;
            this.dieBtn1.y = Config.stage.stageHeight - 130;
            this.dieBtn2.x = this.dieBtn1.x + 90;
            this.dieBtn2.y = this.dieBtn1.y;
            this.dieBtn3.x = this.dieBtn2.x + 90;
            this.dieBtn3.y = this.dieBtn1.y;
            return;
        }// end function

        private function getLife(event:MouseEvent, param2:int = 1) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = false;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (param2 == 1)
            {
                if (this.dieNum > 0)
                {
                    Config.message(Config.language("Player", 7));
                    return;
                }
                if (Config.map._type == 21)
                {
                    Config.message(Config.language("Player", 25));
                    return;
                }
            }
            else if (param2 == 2)
            {
                if (this.dieBtn2.cd > 0)
                {
                    Config.message(Config.language("Player", 8));
                }
                else if (!AlertUI._ui._opening)
                {
                    AlertUI.alert(Config.language("Player", 9), Config.language("Player", 10, Config._ListExp[Config.player.level].reliveMoney), [Config.language("Player", 11), Config.language("Player", 12)], [this.checkalert, null], {tp:param2});
                }
                return;
            }
            else
            {
                if (this.dieBtn3.cd > 0)
                {
                    Config.message(Config.language("Player", 8));
                }
                else
                {
                    _loc_3 = 0;
                    if (Config.player.moneyLifeNum <= 4)
                    {
                        _loc_3 = Config.player.moneyLifeNum + 1;
                    }
                    else
                    {
                        _loc_3 = 5;
                    }
                    _loc_4 = false;
                    _loc_5 = Config.ui._charUI.getItemAmount(80100);
                    _loc_6 = Config.ui._charUI.getItemAmount(80110);
                    _loc_7 = Config.ui._charUI.getItemAmount(880100);
                    if (_loc_5 + _loc_6 + _loc_7 >= _loc_3)
                    {
                        _loc_4 = true;
                    }
                    if (money1 >= _loc_3 * 20 || _loc_4)
                    {
                        _loc_8 = "<font color=\'" + Style.FONT_5_Green + "\'>" + 20 * _loc_3 + "</font>";
                        _loc_9 = "<font color=\'" + Style.FONT_5_Green + "\'>" + _loc_3 + "</font>";
                        if (!AlertUI._ui._opening)
                        {
                            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
                            {
                                AlertUI.alert(Config.language("Player", 9), Config.language("Player", 27, Style.FONT_5_Green, int((Config.player.moneyLifeNum + 1)), _loc_9, _loc_8), [Config.language("Player", 11), Config.language("Player", 12)], [this.checkalert, null], {tp:param2});
                            }
                            else
                            {
                                AlertUI.alert(Config.language("Player", 9), Config.language("Player", 13, Style.FONT_5_Green, int((Config.player.moneyLifeNum + 1)), _loc_9, _loc_8), [Config.language("Player", 11), Config.language("Player", 12)], [this.checkalert, null], {tp:param2});
                            }
                        }
                    }
                    else
                    {
                        Config.message(Config.language("Player", 17));
                    }
                }
                return;
            }
            this.moneyLife(param2);
            return;
        }// end function

        private function checkalert(param1) : void
        {
            this.moneyLife(param1.tp);
            return;
        }// end function

        private function dieTimeRun(event:TimerEvent) : void
        {
            if (this.dieNum > 0)
            {
                var _loc_2:* = this;
                var _loc_3:* = this.dieNum - 1;
                _loc_2.dieNum = _loc_3;
                Neon.show(String(this.dieNum));
                if (this.dieBtn2.cd == 0)
                {
                    this.dieBtn2.filters = [];
                }
                if (this.dieBtn3.cd == 0)
                {
                    this.dieBtn3.filters = [];
                }
            }
            else
            {
                this.dieTime.stop();
                if (Hang.hanging)
                {
                    this.moneyLife(1);
                }
                this.dieBtn1.filters = [];
                this.dieBtn1.mouseEnabled = true;
                this.dieBtn1.mouseChildren = true;
                if (Config.map._type == 11)
                {
                    Neon.show(Config.language("Player", 18));
                }
            }
            return;
        }// end function

        public function hangLife()
        {
            if (this.dieNum <= 0)
            {
                this.moneyLife(1);
            }
            return;
        }// end function

        private function moneyLife(param1:int = 1) : void
        {
            var _loc_2:* = null;
            if (die)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_RELIFE);
                _loc_2.add8(param1);
                ClientSocket.send(_loc_2);
            }
            return;
        }// end function

        public function revive()
        {
            this.die = false;
            if (_buffClip > 0 || _forceClip > 0)
            {
                _img.filters = [];
            }
            else if (_moveFlag)
            {
                changeStateTo("walk");
            }
            else
            {
                changeStateTo("idle");
            }
            if (_img != null)
            {
                _img.shadow = true;
            }
            this.free();
            clearTimeout(this._dyingTimer);
            AlertUI.close();
            if (this.dieBtn1.parent != null)
            {
                this.dieBtn1.parent.removeChild(this.dieBtn1);
            }
            if (this.dieBtn2.parent != null)
            {
                this.dieBtn2.parent.removeChild(this.dieBtn2);
            }
            if (this.dieBtn3.parent != null)
            {
                this.dieBtn3.parent.removeChild(this.dieBtn3);
            }
            this.dieNum = 0;
            return;
        }// end function

        override public function free()
        {
            super.free();
            this._moveLock = false;
            _moveFlag = false;
            this._skillShareLock = false;
            this.think();
            return;
        }// end function

        public function set thinkLock(param1)
        {
            this._thinkLock = param1;
            return;
        }// end function

        public function get thinkLock()
        {
            return this._thinkLock;
        }// end function

        private function sendokmsg(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_PLAYER_REVIVE);
            _loc_2.add16(1);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function sendcancelmsg(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.CMSG_PLAYER_REVIVE);
            _loc_2.add16(2);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        function onDieAnimationOver()
        {
            return;
        }// end function

        override function changeClip()
        {
            if (_forceClip < 0)
            {
                _selectable = false;
                _stateBar.visible = false;
            }
            else
            {
                _selectable = true;
                _stateBar.check();
            }
            reDraw();
            return;
        }// end function

        override public function set attackMode(param1)
        {
            var _loc_2:* = super.attackMode;
            super.attackMode = param1;
            if (Config.ui != null)
            {
                Config.ui._quickUI.setAttackMode(param1, _loc_2);
                Config.startLoop(this.delayAttackMode);
            }
            return;
        }// end function

        private function delayAttackMode(param1)
        {
            Config.stopLoop(this.delayAttackMode);
            Config.ui._quickUI.freshSlotList();
            Config.ui._monsterIndexUI._setupPanel.freshSlotList();
            return;
        }// end function

        private function handleUpdate(event:UnitEvent)
        {
            return;
        }// end function

        public function resetPlayerProp()
        {
            var _loc_1:* = undefined;
            for (_loc_1 in _playerProp)
            {
                
                this[_loc_1] = _playerProp[_loc_1];
            }
            return;
        }// end function

        override public function set level(param1)
        {
            super.level = param1;
            if (Config.ui != null)
            {
                if (param1 >= 96)
                {
                    Config.ui._followcharui.hasUpPB = true;
                }
                else
                {
                    Config.ui._followcharui.hasUpPB = false;
                }
                if (param1 >= 80)
                {
                    Config.ui._systemUI.followerOpen();
                }
            }
            if (Player.level != param1)
            {
                if (Player.level != 0)
                {
                    if (param1 == 10)
                    {
                        GuideUI.testDoId(200, Config.ui._systemUI._bagPB, Config.ui._bagUI);
                    }
                    else if (param1 == 20)
                    {
                        GuideUI.testDoId(193, Config.ui._systemUI._bagPB, Config.ui._bagUI);
                    }
                    Billboard.show(Config.language("Player", 19));
                    if (_map != null)
                    {
                        UnitEffect.motionEffectParam(_map, this, null, "1065_3_0_100_5_20_20_-1_1_0.2_0_0_0_1_0_0_0_0_0_1_0.5_0_0_0_0_0");
                    }
                }
                Player.level = param1;
                Config.ui._fbEntranceUI.selectInfo();
            }
            Config.ui._charUI.setLevel(param1);
            Config.ui._skillUI.refreshAllSkillPanel();
            return;
        }// end function

        override public function set silent(param1)
        {
            _silent = param1;
            if (_silent)
            {
            }
            return;
        }// end function

        override public function set stun(param1)
        {
            _stun = param1;
            if (_stun)
            {
                this.stop(true);
            }
            return;
        }// end function

        override public function set taunt(param1)
        {
            _taunt = param1;
            if (_taunt)
            {
                this.stop(true);
            }
            else
            {
                this.actionLock = false;
            }
            return;
        }// end function

        override public function set itemDisable(param1)
        {
            _itemDisable = param1;
            if (_itemDisable)
            {
            }
            return;
        }// end function

        override public function set attackDisable(param1)
        {
            _attackDisable = param1;
            if (_attackDisable)
            {
            }
            return;
        }// end function

        override public function set ice(param1)
        {
            super.ice = param1;
            if (_ice)
            {
                this.stop(true);
            }
            else
            {
                this.actionLock = false;
            }
            return;
        }// end function

        override public function set job(param1)
        {
            _job = param1;
            if (_playerAttackMode == null)
            {
                if (_job == 1 || _job == 13)
                {
                    this.attackMode = Config._skillMap[5020];
                }
                else if (_job == 4 || _job == 16)
                {
                    this.attackMode = Config._skillMap[5000];
                }
                else if (_job == 7 || _job == 19)
                {
                    this.attackMode = Config._skillMap[5020];
                }
                else if (_job == 10 || _job == 22)
                {
                    this.attackMode = Config._skillMap[5010];
                }
            }
            else
            {
                this.attackMode = _playerAttackMode;
            }
            dispatchEvent(new UnitEvent("update", "job", _job));
            return;
        }// end function

        public function stop(param1 = false, param2 = false)
        {
            if (!param1 && _moveFlag && (this._preStopTile == null || this._preStopTile != _currTile))
            {
                this._preStopTile = _currTile;
                if (this._legalPosition)
                {
                    this.stopBC(this, _angle);
                }
                else
                {
                    this.stopBC(_legalPt, _legalAngle);
                }
            }
            stopLoop(this.move);
            this._desTile = null;
            this._desPt = null;
            this._buffPt = null;
            _moveFlag = false;
            changeStateTo("idle", null);
            if (!param2)
            {
                this.think();
            }
            return;
        }// end function

        public function go(param1, param2 = false, param3 = false)
        {
            Config.player.autoPickPath = false;
            if (visible && _binding != 1)
            {
                this.target = null;
                this.goto(param1, param2, param3);
            }
            return;
        }// end function

        public function unLockMove(param1 = null)
        {
            clearTimeout(this._moveLockInterval);
            this._moveLock = false;
            return;
        }// end function

        override public function set actionLock(param1)
        {
            clearTimeout(this._actionLockReleaseTimer);
            super.actionLock = param1;
            if (param1)
            {
                this._actionLockReleaseTimer = setTimeout(this.releaseActionLock, 1000);
            }
            return;
        }// end function

        private function releaseActionLock()
        {
            this.actionLock = false;
            return;
        }// end function

        public function lockMove()
        {
            this._moveLock = true;
            clearTimeout(this._moveLockInterval);
            this._moveLockInterval = setTimeout(this.unLockMove, 200);
            return;
        }// end function

        private function handleFootEffectOver(param1)
        {
            param1.target.removeEventListener("over", this.handleFootEffectOver);
            param1.target.destroy();
            return;
        }// end function

        public function goto(param1, param2 = false, param3 = false, param4 = false)
        {
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            if (this._autoPickPath)
            {
                this.autoPick();
            }
            if (!this._lock && _binding != 1 && (param4 || !this._moveLock) && !actionLock && !_ice && !_stun)
            {
                _loc_5 = _map.mapToTile(param1);
                _loc_6 = _map.mapToTile({_x:_x, _y:_y});
                if (_loc_5 == null || !_loc_5.terrainwalkable)
                {
                    return;
                }
                this._buffPt = null;
                this._buffFromMouse = false;
                this.lockMove();
                _loc_7 = _loc_5.modifyPt(param1);
                if (!_map._logicalTile[_loc_6._x][_loc_6._y].walkable)
                {
                    _loc_6._x = _currTile._x;
                    _loc_6._y = _currTile._y;
                }
                if (!DistrictMap.testSame(_map.id, param1._x, param1._y))
                {
                    this.unLockMove();
                    DistrictMap.goMap(_map.id, param1._x, param1._y);
                    return true;
                }
                _loc_8 = _map.findPath(_loc_6, _loc_5, param2);
                if (_loc_8.length != 0)
                {
                    this._desTile = _loc_5;
                    this._desPt = _loc_7;
                    this.movePath(_loc_8);
                    _moveFlag = true;
                    this.clearHatePrepare();
                    if (param3)
                    {
                        _loc_9 = Effect.newEffect(Config._model[1016], param1._x, param1._y, 2, 0, 0);
                        _loc_9.display(_map);
                        _loc_9.addEventListener("over", this.handleFootEffectOver);
                    }
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                this._buffPt = param1;
                this._buffFromMouse = param3;
                return false;
            }
        }// end function

        public function movePath(param1)
        {
            changeStateTo("walk", null);
            this._path = param1;
            if (param1.length != 0)
            {
                param1.shift();
                if (param1.length == 1)
                {
                    this.moveSection(this, this._desPt);
                }
                else
                {
                    this.moveSection(this, _map.tileToMap(param1[0]));
                }
            }
            return;
        }// end function

        public function legalClear()
        {
            clearTimeout(this._legalStopTimer);
            this._legalNode = null;
            this._legalTime = 0;
            this._legalPosition = true;
            return;
        }// end function

        override public function destroy()
        {
            this.clearHate();
            this.legalClear();
            clearTimeout(this._reEnterMapTimer);
            clearTimeout(this._moveBCTimer);
            clearTimeout(this._moveLockInterval);
            clearTimeout(this._thinkTimer);
            super.destroy();
            _playerUnit = this;
            return;
        }// end function

        public function moveSection(param1, param2)
        {
            _angle = Math.atan2(param2._y - param1._y, param2._x - param1._x);
            if (this._legalPosition)
            {
                this.moveBC(param1, param2, _angle, 10);
            }
            else
            {
                this.fixPosition(_legalPt);
            }
            this._startMoveTime = getTimer();
            directTo(null);
            startLoop(this.move);
            return;
        }// end function

        public function moveBC(param1, param2, param3 = null, param4 = 0)
        {
            if (Math.abs(param1._x - param2._x) < 2 && Math.abs(param1._y - param2._y) < 2)
            {
                return;
            }
            var _loc_5:* = param3;
            if (param3 == null)
            {
                _loc_5 = Math.atan2(param2._y - param1._y, param2._x - param1._x);
            }
            clearTimeout(this._moveBCTimer);
            var _loc_6:* = new DataSet();
            new DataSet().addHead(CONST_ENUM.CMSG_MOVE);
            _loc_6.add16(Math.round(param1._x));
            _loc_6.add16(Math.round(param1._y));
            _loc_6.addFloat(_loc_5);
            _loc_6.add16(Math.round(param2._x));
            _loc_6.add16(Math.round(param2._y));
            ClientSocket.send(_loc_6);
            return;
        }// end function

        private function stopBC(param1, param2)
        {
            clearTimeout(this._moveBCTimer);
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.CMSG_STOP);
            _loc_3.add16(Math.round(param1._x));
            _loc_3.add16(Math.round(param1._y));
            _loc_3.addFloat(param2);
            ClientSocket.send(_loc_3);
            return;
        }// end function

        override function stopSlip()
        {
            var _loc_1:* = true;
            if (_slipObj == null)
            {
                _loc_1 = false;
            }
            super.stopSlip();
            if (_loc_1)
            {
                this.think();
            }
            return;
        }// end function

        public function fixPosition(param1, param2 = false)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            if (param1 == null)
            {
                return;
            }
            this._legalPosition = false;
            if (_x < 0 || _x > _map._logicalWidth * Map._ptPerTile / 2 - 1 || _y < 0 || _y > _map._logicalHeight * Map._ptPerTile / 2 - 1)
            {
                if (param1 != null)
                {
                    forcePosition(param1);
                    this.confirmPosition();
                    if (this._desTile != null && this._desTile != _currTile)
                    {
                        this.goto(this._desPt);
                    }
                    return;
                }
            }
            this._legalDistance = Math.floor(Math.sqrt(Math.pow(_y - _legalPt._y, 2) + Math.pow(_x - _legalPt._x, 2)));
            if (_speed == 0 || this._legalDistance > 300 || param2 || this._legalTime > 20)
            {
                forcePosition(param1);
                this.confirmPosition();
                if (this._desTile != null && this._desTile != _currTile)
                {
                    this.goto(this._desPt);
                }
                this._legalTime = 0;
                return;
            }
            if (this._preFixPositionDistance == this._legalDistance)
            {
                return;
            }
            var _loc_8:* = this;
            var _loc_9:* = this._legalTime + 1;
            _loc_8._legalTime = _loc_9;
            this._preFixPositionDistance = this._legalDistance;
            if (this._desPt != null)
            {
                _loc_5 = _map.mapToTile(_legalPt);
                _loc_6 = _map.mapToTile(this._desPt);
                this._legalPath = _map.findPath(_loc_5, _loc_6, true);
                if (this._legalPath.length < 2)
                {
                    forcePosition(param1);
                    this.confirmPosition();
                    if (this._desTile != null && this._desTile != _currTile)
                    {
                        this.goto(this._desPt);
                    }
                    return;
                }
                this._legalPath.shift();
                this._legalNode = this._legalPath[0];
                _loc_4 = _map.tileToMap(this._legalPath[0]);
                _loc_3 = Math.sqrt(Math.pow(_loc_4._y - _legalPt._y, 2) + Math.pow(_loc_4._x - _legalPt._x, 2));
                this._legalPathAngle = Math.atan2(_loc_4._y - _legalPt._y, _loc_4._x - _legalPt._x);
                this.moveBC(_legalPt, _loc_4, this._legalPathAngle, 1);
                clearTimeout(this._legalStopTimer);
                this._legalStopTimer = setTimeout(this.legalStop, Math.floor(_loc_3 / _speed * 1000));
            }
            else
            {
                _loc_5 = _map.mapToTile(_legalPt);
                _loc_6 = _map.mapToTile(this);
                this._legalPath = _map.findPath(_loc_5, _loc_6, true);
                if (this._legalPath.length < 2)
                {
                    forcePosition(param1);
                    this.confirmPosition();
                    if (this._desTile != null && this._desTile != _currTile)
                    {
                        this.goto(this._desPt);
                    }
                    return;
                }
                this._legalPath.shift();
                this._legalNode = this._legalPath[0];
                _loc_4 = _map.tileToMap(this._legalPath[0]);
                _loc_3 = Math.sqrt(Math.pow(_loc_4._y - _legalPt._y, 2) + Math.pow(_loc_4._x - _legalPt._x, 2));
                this._legalPathAngle = Math.atan2(_loc_4._y - _legalPt._y, _loc_4._x - _legalPt._x);
                this.moveBC(_legalPt, _loc_4, this._legalPathAngle, 2);
                clearTimeout(this._legalStopTimer);
                this._legalStopTimer = setTimeout(this.legalStop, Math.floor(_loc_3 / _speed * 1000));
            }
            return;
        }// end function

        private function legalStop()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            clearTimeout(this._legalStopTimer);
            if (this._legalPath.length > 2)
            {
                _loc_3 = _map.tileToMap(this._legalPath.shift());
                this.stopBC(_loc_3, this._legalPathAngle);
                _loc_2 = _map.tileToMap(this._legalPath[0]);
                _loc_1 = Math.sqrt(Math.pow(_loc_2._y - _loc_3._y, 2) + Math.pow(_loc_2._x - _loc_3._x, 2));
                this._legalPathAngle = Math.atan2(_loc_2._y - _loc_3._y, _loc_2._x - _loc_3._x);
                this.moveBC(_loc_3, _loc_2, this._legalPathAngle, 3);
                clearTimeout(this._legalStopTimer);
                this._legalStopTimer = setTimeout(this.legalStop, Math.floor(_loc_1 / _speed * 1000));
            }
            else
            {
                this.stopBC(this, _angle);
            }
            return;
        }// end function

        public function confirmPosition(param1 = false)
        {
            this._legalNode = null;
            this._legalTime = 0;
            clearTimeout(this._legalStopTimer);
            this._legalPosition = true;
            this._preFixPositionDistance = null;
            this._legalDistance = null;
            return;
        }// end function

        function move(param1)
        {
            this.moveLoop();
            return;
        }// end function

        function moveLoop()
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
            if (this._legalPosition)
            {
                _loc_7 = _speed / Config.fps;
            }
            else
            {
                _loc_8 = Math.floor(Math.sqrt(Math.pow(_y - _legalPt._y, 2) + Math.pow(_x - _legalPt._x, 2)));
                _loc_7 = _speed * Math.max(0.1, 0.8 - _loc_8 / 300) / Config.fps;
            }
            if (this._path.length < 2)
            {
                _angle = Math.atan2(this._desPt._y - _y, this._desPt._x - _x);
                if (testDistance(this._desPt) < _loc_7)
                {
                    _x = this._desPt._x;
                    _y = this._desPt._y;
                    draw();
                    dispatchEvent(new Event("move"));
                    _loc_6 = _map.mapToTile(this._desPt);
                    if (_loc_6 != _currTile)
                    {
                        _currTile.removeUnit(this);
                        _currTile = _loc_6;
                        _currTile.addUnit(this);
                        swapDepthTile();
                        dispatchEvent(new Event("pass"));
                    }
                    this.stop();
                    dispatchEvent(new Event("arrive"));
                    return;
                }
            }
            else
            {
                _loc_9 = _map.tileToMap(this._path[0]);
                _angle = Math.atan2(_loc_9._y - _y, _loc_9._x - _x);
                if (testDistance(_loc_9) < _loc_7)
                {
                    this._path.shift();
                    if (!_die && _currTile.jumpTile != null && Math.abs(this._desTile._x - _currTile._x) + Math.abs(this._desTile._y - _currTile._y) > 5)
                    {
                        _loc_10 = Config.eventStack[_currTile._x + "_" + _currTile._y];
                        _loc_11 = this._desPt;
                        this.actionLock = true;
                        this.thinkLock = true;
                        this.stop(false, true);
                        _buffJump = _loc_11;
                        trace("C2G_MAP_CHANGE", this.target);
                        _loc_12 = new DataSet();
                        _loc_12.addHead(CONST_ENUM.C2G_MAP_CHANGE);
                        _loc_12.add32(Number(_loc_10.id));
                        ClientSocket.send(_loc_12);
                        return;
                    }
                    _x = _loc_9._x;
                    _y = _loc_9._y;
                    draw();
                    dispatchEvent(new Event("move"));
                    _loc_6 = _map.mapToTile(_loc_9);
                    if (_loc_6 != _currTile)
                    {
                        _currTile.removeUnit(this);
                        _currTile = _loc_6;
                        _currTile.addUnit(this);
                        swapDepthTile();
                        dispatchEvent(new Event("pass"));
                    }
                    this.moveSection(_map.tileToMap(_currTile), _map.tileToMap(this._path[0]));
                    return;
                }
            }
            _loc_4 = _x + Math.cos(_angle) * _loc_7;
            _loc_5 = _y + Math.sin(_angle) * _loc_7;
            if (_loc_4 < 0)
            {
                _loc_4 = 0;
            }
            else if (_loc_4 > _map._logicalWidth * Map._ptPerTile / 2 - 1)
            {
                _loc_4 = _map._logicalWidth * Map._ptPerTile / 2 - 1;
            }
            if (_loc_5 < 0)
            {
                _loc_5 = 0;
            }
            else if (_loc_5 > _map._logicalHeight * Map._ptPerTile / 2 - 1)
            {
                _loc_5 = _map._logicalHeight * Map._ptPerTile / 2 - 1;
            }
            _loc_6 = _map.mapToTile({_x:_loc_4, _y:_loc_5});
            if (_loc_6 != _currTile)
            {
                if (_currTile.terrainwalkable && !_loc_6.terrainwalkable)
                {
                    _loc_13 = this._desPt;
                    this.stop(false, true);
                    this.goto(_loc_13);
                    return;
                }
            }
            _x = _loc_4;
            _y = _loc_5;
            draw();
            if (_loc_6 != _currTile)
            {
                _currTile.removeUnit(this);
                _currTile = _loc_6;
                _currTile.addUnit(this);
                swapDepthTile();
                dispatchEvent(new Event("pass"));
            }
            dispatchEvent(new Event("move"));
            return;
        }// end function

        public function set target(param1)
        {
            this.autoPickPath = false;
            clearTimeout(this._thinkTimer);
            if (param1 != this._target)
            {
                if (this._target != null)
                {
                    if (this._target is Dummy)
                    {
                        this._target.removeEventListener("pass", this.handleTargetPass);
                        this._target.removeEventListener("die", this.handleTargetDestroy);
                        this._target.removeEventListener("destroy", this.handleTargetDestroy);
                    }
                }
                this._target = param1;
                if (this._target != null)
                {
                    if (this._target is Dummy)
                    {
                        this.tracingTarget = this.target;
                        this._target.removeEventListener("pass", this.handleTargetPass);
                        this._target.removeEventListener("die", this.handleTargetDestroy);
                        this._target.removeEventListener("destroy", this.handleTargetDestroy);
                        this._target.addEventListener("pass", this.handleTargetPass);
                        this._target.addEventListener("die", this.handleTargetDestroy);
                        this._target.addEventListener("destroy", this.handleTargetDestroy);
                    }
                    if (_moveFlag)
                    {
                        this.stop(false, true);
                    }
                    this.think();
                }
            }
            else
            {
                this.think();
            }
            return;
        }// end function

        public function get target()
        {
            return this._target;
        }// end function

        public function testBelong(param1)
        {
            return param1.belongPlayer == 0 && param1.belongTeam == 0 || param1.belongPlayer == id || param1.belongTeam != 0 && param1.belongTeam == Config.ui._teamUI.teamId;
        }// end function

        public function set tracingTarget(param1)
        {
            var _loc_2:* = undefined;
            if (this._tracingTarget != param1)
            {
                _loc_2 = this._tracingTarget;
                this._tracingTarget = param1;
                if (this._tracingTarget != null)
                {
                    if (this.testBelong(this._tracingTarget))
                    {
                        if (this._tracingTarget._img != null)
                        {
                            this._tracingTarget.addHalo(1177, -this._tracingTarget._img._bitmapRectY - 20, 1);
                        }
                    }
                    else if (this._tracingTarget._img != null)
                    {
                        this._tracingTarget.addHalo(1177, -this._tracingTarget._img._bitmapRectY - 20, 1, [UnitEffect._stoneCMF]);
                    }
                    this._tracingTarget._stateBar.check();
                }
                else
                {
                    EventMouse._tabTargetIndex = 0;
                }
                if (_loc_2 != null)
                {
                    _loc_2.removeHalo(1177);
                    _loc_2._stateBar.check();
                }
                Config.ui._targetHead.unit = this._tracingTarget;
            }
            return;
        }// end function

        public function get tracingTarget() : Unit
        {
            return this._tracingTarget;
        }// end function

        public function think()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = null;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = null;
            clearTimeout(this._thinkTimer);
            if (!this._thinkLock && this.target != null && _map._state == "ready")
            {
                if (this.target._type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
                {
                    if (Skill.chanting)
                    {
                        _img.changeDirectionTo(UnitClip.angleToDirection(Math.atan2(this.target._y - _y, this.target._x - _x), _img._directions, _img._a4));
                    }
                    else if (Skill.selectedSkill == null)
                    {
                        _loc_8 = Config.ui._monsterIndexUI._setupPanel.getNoAutoJustUse();
                        if (_loc_8 != null && _buffClip != 2607)
                        {
                            _loc_3 = _loc_8;
                            _loc_4 = Skill.getSkillRange(_loc_3._skillData);
                            if (testDistance(this.target) < _loc_4 - 24)
                            {
                                this.castSkill(_loc_3, this.target);
                            }
                            else
                            {
                                _loc_1 = _map.findNearPt(this.target, this, Math.max(24, _loc_4 - 48));
                                this.goto(_loc_1, false, false, true);
                            }
                        }
                        else
                        {
                            if (normalRange != null)
                            {
                                _loc_4 = normalRange;
                            }
                            else
                            {
                                _loc_4 = Skill.getSkillRange(attackMode);
                            }
                            _loc_7 = testDistance(this.target);
                            if (_loc_7 < Math.max(48, _loc_4 - 24))
                            {
                                if (_loc_7 < 96 || _map.testFlyStraight(this, this.target))
                                {
                                    this.normalAttack(this.target);
                                }
                            }
                            else
                            {
                                _loc_1 = _map.findNearPt(this.target, this, Math.max(24, _loc_4 - 48));
                                this.goto(_loc_1, false, false, true);
                            }
                        }
                    }
                    else
                    {
                        _loc_3 = Skill.selectedSkill;
                        if (_loc_3 != null)
                        {
                            _loc_4 = Skill.getSkillRange(_loc_3._skillData);
                            if (testDistance(this.target) < _loc_4 - 24)
                            {
                                this.castSkill(_loc_3, this.target);
                            }
                            else
                            {
                                _loc_1 = _map.findNearPt(this.target, this, Math.max(24, _loc_4 - 48));
                                this.goto(_loc_1, false, false, true);
                            }
                        }
                    }
                }
                else if (this.target._type == UNIT_TYPE_ENUM.TYPEID_UNIT)
                {
                    if (Skill.chanting)
                    {
                        _img.changeDirectionTo(UnitClip.angleToDirection(Math.atan2(this.target._y - _y, this.target._x - _x), _img._directions, _img._a4));
                    }
                    else if (Skill.selectedSkill == null)
                    {
                        if (this._hateState)
                        {
                            if (!Config.player.resting)
                            {
                                _loc_9 = false;
                                if (Config.ui._monsterIndexUI._setupPanel.findRest())
                                {
                                    if (!Config.player.attacked)
                                    {
                                        Config.player.startRest();
                                        _loc_9 = true;
                                    }
                                }
                                if (!_loc_9)
                                {
                                    _loc_10 = Config.ui._monsterIndexUI._setupPanel.findRecoverItem();
                                    _loc_11 = 0;
                                    while (_loc_11 < _loc_10.length)
                                    {
                                        
                                        if (this._itemLockMap[_loc_10[_loc_11].id] == null)
                                        {
                                            Config.ui._charUI.useItem(_loc_10[_loc_11].item);
                                            this.lockItem(_loc_10[_loc_11].id);
                                        }
                                        _loc_11 = _loc_11 + 1;
                                    }
                                }
                            }
                            _loc_8 = Config.ui._monsterIndexUI._setupPanel.findPrimarySkill();
                        }
                        else
                        {
                            _loc_8 = Config.ui._monsterIndexUI._setupPanel.getNoAutoJustUse();
                        }
                        if (_loc_8 != null && _buffClip != 2607)
                        {
                            _loc_3 = _loc_8;
                            _loc_4 = Skill.getSkillRange(_loc_3._skillData);
                            if (testDistance(this.target) < _loc_4 - 24)
                            {
                                this.castSkill(_loc_3, this.target);
                            }
                            else
                            {
                                _loc_1 = _map.findNearPt(this.target, this, Math.max(24, _loc_4 - 48));
                                if (!this.goto(_loc_1, false, false, true))
                                {
                                    if (!this.goto(_loc_1, true, false, true))
                                    {
                                        if (Hang.hanging)
                                        {
                                            if (this.target.hangErrorCount >= 3)
                                            {
                                                this.target.hangError = true;
                                                if (Hang.currTarget == this.target)
                                                {
                                                    this.target = null;
                                                    Hang.currTarget = null;
                                                }
                                            }
                                            else
                                            {
                                                var _loc_16:* = this.target;
                                                var _loc_17:* = this.target.hangErrorCount + 1;
                                                _loc_16.hangErrorCount = _loc_17;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            if (normalRange != null)
                            {
                                _loc_4 = normalRange;
                            }
                            else
                            {
                                _loc_4 = Skill.getSkillRange(attackMode);
                            }
                            _loc_7 = testDistance(this.target);
                            if (_loc_7 < Math.max(48, _loc_4 - 24))
                            {
                                if (this.target.rename != "" && this.target.nowname == "" && this.target._hp == 0)
                                {
                                }
                                else if (Hang.hanging || (_loc_7 < 96 || _map.testFlyStraight(this, this.target)))
                                {
                                    this.normalAttack(this.target);
                                }
                                else if (this.target.hangErrorCount >= 3)
                                {
                                    this.target.hangError = true;
                                    if (Hang.currTarget == this.target)
                                    {
                                        this.target = null;
                                        Hang.currTarget = null;
                                    }
                                }
                                else
                                {
                                    var _loc_16:* = this.target;
                                    var _loc_17:* = this.target.hangErrorCount + 1;
                                    _loc_16.hangErrorCount = _loc_17;
                                }
                            }
                            else
                            {
                                _loc_1 = _map.findNearPt(this.target, this, Math.max(24, _loc_4 - 72));
                                if (!this.goto(_loc_1, false, false, true))
                                {
                                    if (!this.goto(_loc_1, true, false, true))
                                    {
                                        if (Hang.hanging)
                                        {
                                            if (this.target.hangErrorCount >= 3)
                                            {
                                                this.target.hangError = true;
                                                if (Hang.currTarget == this.target)
                                                {
                                                    this.target = null;
                                                    Hang.currTarget = null;
                                                }
                                            }
                                            else
                                            {
                                                var _loc_16:* = this.target;
                                                var _loc_17:* = this.target.hangErrorCount + 1;
                                                _loc_16.hangErrorCount = _loc_17;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        _loc_3 = Skill.selectedSkill;
                        if (_loc_3 != null)
                        {
                            _loc_4 = Skill.getSkillRange(_loc_3._skillData);
                            if (testDistance(this.target) < _loc_4 - 24)
                            {
                                this.castSkill(_loc_3, this.target);
                            }
                            else
                            {
                                _loc_1 = _map.findNearPt(this.target, this, Math.max(24, _loc_4 - 48));
                                if (!this.goto(_loc_1, false, false, true))
                                {
                                    if (!this.goto(_loc_1, true, false, true))
                                    {
                                        if (Hang.hanging)
                                        {
                                            if (this.target.hangErrorCount >= 3)
                                            {
                                                this.target.hangError = true;
                                                if (Hang.currTarget == this.target)
                                                {
                                                    this.target = null;
                                                    Hang.currTarget = null;
                                                }
                                            }
                                            else
                                            {
                                                var _loc_16:* = this.target;
                                                var _loc_17:* = this.target.hangErrorCount + 1;
                                                _loc_16.hangErrorCount = _loc_17;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else if (this.target._type == UNIT_TYPE_ENUM.TYPEID_ITEM)
                {
                }
                else if (this.target._type == UNIT_TYPE_ENUM.TYPEID_ITEM_MAP)
                {
                    if (testTileDistance(this.target) <= 3)
                    {
                        if (this.target._itemData.type == 13)
                        {
                            if (GuideUI.testId(127))
                            {
                                GuideUI.doId(127, this.target);
                            }
                        }
                        if (Config.ui._playerHead.fcmstatus > 0)
                        {
                            Config.message(Config.language("Player", 20));
                            return;
                        }
                        _loc_12 = new DataSet();
                        _loc_12.addHead(CONST_ENUM.CMSG_ITEM_PICKUP);
                        _loc_12.add32(this.target._id);
                        ClientSocket.send(_loc_12);
                    }
                    else
                    {
                        _loc_2 = _map.findNearWalkable(this.target._currTile, this, 2);
                        this.goto(_map.tileToMap(_loc_2), false, false, true);
                    }
                }
                else if (this.target._type == UNIT_TYPE_ENUM.TYPEID_NPC)
                {
                    if (this.target._sky)
                    {
                        if (testTileDistance(this.target) <= 1)
                        {
                            if (Config.map._type == 25)
                            {
                                Hang._preExpCopyHanging = Config.ui._monsterIndexUI.hanging;
                            }
                            Hang.stop();
                            this.stop(false, true);
                            if (Config.map._type == 25)
                            {
                                _loc_12 = new DataSet();
                                _loc_12.addHead(CONST_ENUM.C2G_EXPCOPY_CHANGEMAP);
                                _loc_12.add32(this.target.id);
                                ClientSocket.send(_loc_12);
                            }
                            else
                            {
                                _loc_12 = new DataSet();
                                _loc_12.addHead(CONST_ENUM.C2G_SKYTOWER_CHANGEMAP);
                                _loc_12.add32(this.target.id);
                                ClientSocket.send(_loc_12);
                            }
                            this.target = null;
                        }
                        else if (!_moveFlag)
                        {
                            _loc_2 = _map.findNearWalkable(this.target._currTile, this, 1);
                            if (_loc_2 != null)
                            {
                                this.goto(_map.fixPtByTarget(this.target, _loc_2, 24), false, false, true);
                            }
                        }
                    }
                    else if (testTileDistance(this.target) <= 2)
                    {
                        Hang.stop();
                        this.stop(false, true);
                        this.target.openMenu();
                        this.target = null;
                    }
                    else if (!_moveFlag)
                    {
                        _loc_2 = _map.findNearWalkable(this.target._currTile, this, 2);
                        if (_loc_2 != null)
                        {
                            this.goto(_map.fixPtByTarget(this.target, _loc_2, 48), false, false, true);
                        }
                    }
                }
                else if (this.target._type == UNIT_TYPE_ENUM.TYPEID_GATHER)
                {
                    if (testTileDistance(this.target) <= 1)
                    {
                        if (!this._gatherFlag)
                        {
                            if (int(this.target._data.needTask) == 0)
                            {
                                if (int(this.target._data.id) >= 2000 && int(this.target._data.id) <= 2596)
                                {
                                    if (Config.ui._charUI.firenum >= 10)
                                    {
                                        Config.message(Config.language("Player", 21));
                                        this.target = null;
                                        return;
                                    }
                                    if (Config.ui._playerHead.fcmstatus > 0)
                                    {
                                        Config.message(Config.language("Player", 20));
                                        return;
                                    }
                                }
                                if (int(this.target._data.id) == 7034 && (Config._flagList[Config.player.id] == null || Config._flagList[Config.player.id] == 0))
                                {
                                    Config.message("无法采集");
                                    return;
                                }
                                if (!(_stun || _ice))
                                {
                                    this.target.sendgather(this.target._id);
                                }
                                this.target = null;
                            }
                            else if (Config.ui._taskpanel.gatherfind(int(this.target._data.itemId)))
                            {
                                if (Config.ui._playerHead.fcmstatus > 0)
                                {
                                    Config.message(Config.language("Player", 22));
                                    return;
                                }
                                if (Config.map._type == 3 && (Config.player.gildid == 0 || Config.player.gildid > 0 && Config.player._gildpower >= 3))
                                {
                                    Config.message(Config.language("Player", 23));
                                    return;
                                }
                                if (!(_stun || _ice))
                                {
                                    this.target.sendgather(this.target._id);
                                }
                                this.target = null;
                            }
                            else
                            {
                                Config.message(Config.language("Player", 24));
                                this.target = null;
                            }
                        }
                    }
                    else if (!_moveFlag && this.target._currTile != null)
                    {
                        _loc_2 = _map.findNearWalkable(this.target._currTile, this, 1);
                        if (_loc_2 != null)
                        {
                            this.goto(_map.fixPtByTarget(this.target, _loc_2, 48), false, false, true);
                        }
                    }
                }
                else if (this.target._type == UNIT_TYPE_ENUM.TYPEID_ACTOR)
                {
                    this.target.interact();
                }
                else if (this.target._type == UNIT_TYPE_ENUM.TYPEID_DOOR)
                {
                }
                else if (this.target._type == UNIT_TYPE_ENUM.TYPEID_SHOPITEM || this.target._type == UNIT_TYPE_ENUM.TYPEID_ITEMCLONE || this.target._type == UNIT_TYPE_ENUM.TYPEID_SHOPITEM || this.target._type == UNIT_TYPE_ENUM.TYPEID_ITEM_SALE || this.target._type == UNIT_TYPE_ENUM.TYPEID_ITEM_AUCTION || this.target._type == UNIT_TYPE_ENUM.TYPEID_ITEM_BLACK || this.target._type == UNIT_TYPE_ENUM.TYPEID_ITEM_SHOP)
                {
                }
                else
                {
                    _loc_13 = _map.mapToTile(this.target);
                    if (this.target.jump != null)
                    {
                        if (!_die && _currTile == _loc_13)
                        {
                            this.actionLock = true;
                            this.thinkLock = true;
                            this.stop(false, true);
                            _loc_12 = new DataSet();
                            _loc_12.addHead(CONST_ENUM.C2G_MAP_CHANGE);
                            _loc_12.add32(this.target.jump.id);
                            ClientSocket.send(_loc_12);
                            this._preMapTarget = this.target;
                            this.target = null;
                        }
                        else if (!_moveFlag && _currTile != _loc_13)
                        {
                            this.goto(this.target, false, false, true);
                        }
                    }
                    else if (this.target.fb_exit != null)
                    {
                        if (!_die && _currTile == _loc_13)
                        {
                            this.actionLock = true;
                            this.thinkLock = true;
                            this.stop(false, true);
                            _loc_12 = new DataSet();
                            _loc_12.addHead(CONST_ENUM.C2G_INSTANCE_CHANGEMAP);
                            _loc_12.add32(this.target.fb_exit.id);
                            ClientSocket.send(_loc_12);
                            this._preMapTarget = this.target;
                            this.target = null;
                        }
                        else if (!_moveFlag && _currTile != _loc_13)
                        {
                            this.goto(this.target, false, false, true);
                        }
                    }
                    else if (this.target.jump_battle_field != null)
                    {
                        if (!_die && _currTile == _loc_13)
                        {
                            this.actionLock = true;
                            this.thinkLock = true;
                            this.stop(false, true);
                            _loc_12 = new DataSet();
                            _loc_12.addHead(CONST_ENUM.C2G_GUILDVS_CHANGEMAP);
                            ClientSocket.send(_loc_12);
                            this._preMapTarget = this.target;
                            this.target = null;
                        }
                        else if (!_moveFlag && _currTile != _loc_13)
                        {
                            this.goto(this.target, false, false, true);
                        }
                    }
                    else if (this.target.portal)
                    {
                        if (!_die && _currTile == _loc_13)
                        {
                            _loc_14 = Npc.findNpcId(this.target.npcid);
                            _loc_15 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_NPC, _loc_14);
                            if (_loc_15 != null)
                            {
                                if (_loc_15.autoPortal(Number(this.target.portal.id)))
                                {
                                    Config.player.actionLock = true;
                                    Config.player.thinkLock = true;
                                    Config.ui._dialogue.closedialogue();
                                    this._preMapTarget = this.target;
                                    this.target = null;
                                }
                            }
                        }
                        else if (!_moveFlag && _currTile != _loc_13)
                        {
                            this.goto(this.target, false, false, true);
                        }
                    }
                    else if (this.target.booth != null)
                    {
                        if (_currTile == _loc_13)
                        {
                            if (this.target.booth != null)
                            {
                                if (this.target.booth.unit != null)
                                {
                                    this.target.booth.unit.handleBoothOpen(this.target.booth.id, this.target.booth._boothAd);
                                }
                            }
                            this.target = null;
                        }
                        else if (!_moveFlag)
                        {
                            this.goto(this.target, false, false, true);
                        }
                    }
                    else if (Skill.selectedSkill != null)
                    {
                        _loc_3 = Skill.selectedSkill;
                        if (_loc_3 != null)
                        {
                            if (_loc_3._skillData.targetType == 2)
                            {
                                this.go(this.target);
                            }
                            else if (_loc_3._skillData.targetType == 3)
                            {
                                _loc_4 = Skill.getSkillRange(_loc_3._skillData);
                                if (testDistance(this.target) < _loc_4)
                                {
                                    this.castSkill(_loc_3, this.target);
                                    this.target = null;
                                }
                                else
                                {
                                    _loc_1 = _map.findNearPt(this.target, this, Math.max(24, _loc_4 - 24));
                                    this.goto(_loc_1, false, false, true);
                                }
                            }
                        }
                    }
                    else
                    {
                        this.stop(false, true);
                    }
                }
                if (!Skill.chanting)
                {
                    if (this.target != null)
                    {
                        this._thinkTimer = setTimeout(this.think, 2000);
                    }
                }
            }
            return;
        }// end function

        public function clearEnterMap()
        {
            clearTimeout(this._reEnterMapTimer);
            return;
        }// end function

        public function reEnterMap()
        {
            trace("reEnterMap", this._preMapTarget);
            if (this._preMapTarget != null)
            {
                clearTimeout(this._reEnterMapTimer);
                this._reEnterMapTimer = setTimeout(this.subReEnterMap, 1000);
            }
            return;
        }// end function

        private function subReEnterMap()
        {
            trace("subReEnterMap", this._preMapTarget);
            clearTimeout(this._reEnterMapTimer);
            if (this._preMapTarget != null)
            {
                this.fixPosition(_legalPt, false);
                this.target = this._preMapTarget;
            }
            return;
        }// end function

        private function handleTargetDestroy(param1)
        {
            this.target = null;
            return;
        }// end function

        private function handleTargetPass(param1)
        {
            this.think();
            return;
        }// end function

        private function handleThisArrive(param1)
        {
            this.think();
            return;
        }// end function

        public function normalAttack(param1)
        {
            var _loc_2:* = undefined;
            if (!this._lock && !actionLock && !_die && !_ice && !_stun)
            {
                this.clearHatePrepare();
                faceTo(param1);
                this.stop(false, true);
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_ATTACK_OBJ);
                _loc_2.add32(param1._type);
                _loc_2.add32(param1._id);
                ClientSocket.send(_loc_2);
            }
            return;
        }// end function

        private function handleActionEnd()
        {
            changeStateTo("idle");
            return;
        }// end function

        override public function rightAttack(param1)
        {
            this.stop(false, true);
            super.rightAttack(param1);
            return;
        }// end function

        public function castSkill(param1:Skill, param2 = null)
        {
            var _loc_3:* = undefined;
            trace(param1._id, param2, param1.relatedItemId);
            if (!this._lock && !_die && !_ice && !_stun)
            {
                if (param1._skillData.castAct > 0 || param1._skillData.targetType != 1)
                {
                    if (param2 != null)
                    {
                        faceTo(param2);
                    }
                    this.stop(false, true);
                    this.actionLock = true;
                }
                this.clearHatePrepare();
                if (!Skill.chanting && param1.cd <= 0)
                {
                    if (param1._data == Skill._goldhandSkill)
                    {
                        Config.ui._quickUI._goldhandSlot.selected = false;
                        _loc_3 = new DataSet();
                        _loc_3.addHead(CONST_ENUM.C2G_GOLDHAND);
                        _loc_3.add32(param2._id);
                        ClientSocket.send(_loc_3);
                    }
                    else if (param1._data == Skill._petPickSkill)
                    {
                        Config.ui._petPanel.checkPick();
                    }
                    else if (param1._data == Skill._petChangeSkill)
                    {
                        Config.ui._petPanel.petTOPlayer();
                    }
                    else if (param1._data == Skill._petBackSkill)
                    {
                        Config.ui._petPanel.palyerBack();
                    }
                    else if (param1._skillData.targetType == 0)
                    {
                    }
                    else if (param1._skillData.targetType == SKILL_TYPE_ENUM.SKILL_NO_TARGET)
                    {
                        trace("C2G_SKILL_CAST1", param1._skillData.id, param1.relatedItemId);
                        _loc_3 = new DataSet();
                        _loc_3.addHead(CONST_ENUM.C2G_SKILL_CAST);
                        _loc_3.add32(param1._skillData.id);
                        _loc_3.add32(param1.relatedItemId);
                        _loc_3.add8(SKILL_TYPE_ENUM.SKILL_NO_TARGET);
                        ClientSocket.send(_loc_3);
                        param1.locked = true;
                    }
                    else if (param1._skillData.targetType == SKILL_TYPE_ENUM.SKILL_PLAYER)
                    {
                        trace("C2G_SKILL_CAST2", param1._skillData.id, param1.relatedItemId);
                        if (param1._skillData.specialLogicId == 1)
                        {
                            if (Number(param2._data.id) != param1._skillData.param1)
                            {
                                return;
                            }
                        }
                        trace("C2G_SKILL_CASTok", param2._type, param2._id);
                        _loc_3 = new DataSet();
                        _loc_3.addHead(CONST_ENUM.C2G_SKILL_CAST);
                        _loc_3.add32(param1._skillData.id);
                        _loc_3.add32(param1.relatedItemId);
                        _loc_3.add8(SKILL_TYPE_ENUM.SKILL_PLAYER);
                        _loc_3.add32(param2._type);
                        _loc_3.add32(param2._id);
                        ClientSocket.send(_loc_3);
                        param1.locked = true;
                    }
                    else if (param1._skillData.targetType == SKILL_TYPE_ENUM.SKILL_POSITON)
                    {
                        _loc_3 = new DataSet();
                        _loc_3.addHead(CONST_ENUM.C2G_SKILL_CAST);
                        _loc_3.add32(param1._skillData.id);
                        _loc_3.add32(param1.relatedItemId);
                        _loc_3.add8(SKILL_TYPE_ENUM.SKILL_POSITON);
                        _loc_3.add16(param2._x);
                        _loc_3.add16(param2._y);
                        ClientSocket.send(_loc_3);
                        param1.locked = true;
                    }
                }
            }
            return;
        }// end function

        override public function set gildid(param1:int) : void
        {
            var _loc_3:* = undefined;
            super._gildid = param1;
            var _loc_2:* = Unit.getPlayerlist();
            for (_loc_3 in _loc_2)
            {
                
                _loc_2[_loc_3].setgildinfor(_loc_2[_loc_3].gildid, _loc_2[_loc_3]._gilename, _loc_2[_loc_3]._gildpower, _loc_2[_loc_3]._camp, _loc_2[_loc_3]._gildTeam);
            }
            return;
        }// end function

        override public function startGather(param1, param2, param3 = 0)
        {
            super.startGather(param1, param2);
            this._gatherFlag = true;
            return;
        }// end function

        override public function stopGather()
        {
            super.stopGather();
            this._gatherFlag = false;
            return;
        }// end function

        public function startRest()
        {
            var _loc_1:* = null;
            if (!(_stun || _ice))
            {
                this.stop(false, true);
                _loc_1 = new DataSet();
                _loc_1.addHead(CONST_ENUM.C2G_REST);
                _loc_1.add8(0);
                ClientSocket.send(_loc_1);
            }
            return;
        }// end function

        public function stopRest()
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_REST);
            _loc_1.add8(1);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        public function get equiplucky()
        {
            return this._equiplucky;
        }// end function

        public function set equiplucky(param1:Number)
        {
            this._equiplucky = param1;
            return;
        }// end function

        public function dummyGo(param1, param2, param3)
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
                startLoop(this.dummyMove);
                _moveFlag = true;
            }
            this._finalPt = param3;
            this._finalAngle = param2;
            return;
        }// end function

        public function dummyStop(param1 = null, param2 = null)
        {
            if (param1 == null)
            {
                _angle = param2;
                directTo(_angle);
                changeStateTo("idle", null);
                stopLoop(this.dummyMove);
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
                stopLoop(this.dummyMove);
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

        function dummyMove(event:Event)
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
                    stopLoop(this.dummyMove);
                    _moveFlag = false;
                    footon = _map.mapToTile(this._finalPt);
                    if (footon != _currTile)
                    {
                        if (_currTile != null)
                        {
                            _currTile.removeUnit(this);
                        }
                        _currTile = footon;
                        _currTile.addUnit(this);
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

        override public function beBinding(param1)
        {
            super.beBinding(param1);
            this.stop(false, true);
            this.lock = true;
            return;
        }// end function

        override public function stopBinding(param1 = null)
        {
            super.stopBinding(param1);
            stopLoop(this.dummyMove);
            this.lock = false;
            return;
        }// end function

        override public function set titleId(param1) : void
        {
            super.titleId = param1;
            if (Config.ui != null)
            {
                Config.ui._charUI.titleIdChange(param1);
            }
            return;
        }// end function

        public function set qiuBuf(param1:int) : void
        {
            var _loc_2:* = null;
            if (param1 > 0)
            {
                if (this.shelterBuf.parent == null)
                {
                    this._stateBar.addChild(this.shelterBuf);
                }
                _loc_2 = "×" + param1;
                this.shelterBuf.setLetter(_loc_2);
                this.shelterBuf.x = this.shelterBuf.width / 2 - 4;
                this.shelterBuf.y = -70;
                if (param1 < 10)
                {
                    if (this.shelterBufFilter != 1)
                    {
                        this.shelterBufFilter = 1;
                        this.shelterBuf.filters = this.shelterBufFilter1;
                    }
                }
                else if (this.shelterBufFilter != 2)
                {
                    this.shelterBufFilter = 2;
                    this.shelterBuf.filters = this.shelterBufFilter2;
                }
            }
            else if (this.shelterBuf.parent != null)
            {
                this.shelterBuf.parent.removeChild(this.shelterBuf);
            }
            return;
        }// end function

        public function get effectTime() : int
        {
            return this._effectTime;
        }// end function

        public function set effectTime(param1:int) : void
        {
            this._effectTime = param1;
            return;
        }// end function

        public function set autoPickPath(param1:Boolean) : void
        {
            this._autoPickPath = param1;
            this.removeEventListener("pass", this.autoPick);
            if (this._autoPickPath || Config.ui._monsterIndexUI.hanging)
            {
                this.addEventListener("pass", this.autoPick);
            }
            return;
        }// end function

        public function get autoPickPath() : Boolean
        {
            return this._autoPickPath;
        }// end function

        public function autoPick(param1 = null) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            if (_currTile != null)
            {
                _loc_2 = Math.max(0, _currTile._x - 3);
                while (_loc_2 < Math.min(_map._logicalWidth, _currTile._x + 4))
                {
                    
                    _loc_3 = Math.max(0, _currTile._y - 3);
                    while (_loc_3 < Math.min(_map._logicalHeight, _currTile._y + 4))
                    {
                        
                        _loc_4 = _map._logicalTile[_loc_2][_loc_3];
                        _loc_5 = 0;
                        while (_loc_5 < _loc_4._currItem.length)
                        {
                            
                            _loc_6 = _loc_4._currItem[_loc_5];
                            if (Config.ui._monsterIndexUI.hanging && !Config.ui._monsterIndexUI._setupPanel.getItemPick(_loc_6._itemData.id))
                            {
                            }
                            else if (!_loc_6.pickDisable)
                            {
                                _loc_7 = new DataSet();
                                _loc_7.addHead(CONST_ENUM.CMSG_ITEM_PICKUP);
                                _loc_7.add32(_loc_6._id);
                                ClientSocket.send(_loc_7);
                            }
                            _loc_5++;
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            return;
        }// end function

        public static function set _playerId(param1:uint)
        {
            playerId = param1;
            return;
        }// end function

        public static function get _playerId()
        {
            if (Config.serverID == 0)
            {
                return playerId;
            }
            return Config.serverID << 25 | playerId;
        }// end function

        public static function set name(param1:String) : void
        {
            _name = param1;
            return;
        }// end function

        public static function get name() : String
        {
            return _name;
        }// end function

        public static function set title(param1:String) : void
        {
            _title = param1;
            return;
        }// end function

        public static function get title() : String
        {
            return _title;
        }// end function

        public static function set job(param1:uint) : void
        {
            _job = param1;
            return;
        }// end function

        public static function get job() : uint
        {
            return _job;
        }// end function

        public static function set sex(param1:uint) : void
        {
            _sex = param1;
            return;
        }// end function

        public static function get sex() : uint
        {
            return _sex;
        }// end function

        public static function set level(param1:uint) : void
        {
            _level = param1;
            if (Config.ui != null)
            {
                Config.ui._taskpanel.levelupfuc();
                Config.ui._producepanel.reFreshTree();
            }
            return;
        }// end function

        public static function get level() : uint
        {
            return _level;
        }// end function

    }
}
