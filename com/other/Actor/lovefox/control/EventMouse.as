package lovefox.control
{
    import flash.events.*;

    public class EventMouse extends Object
    {
        public static var _hoverUnit:Object;
        private static var _preTargetPos:Object = {_x:null, _y:null};
        private static var _justMove:Boolean = false;
        private static var _mouseDown:Boolean = false;
        private static var _lock:Object;
        private static var _preConversionMode:Object;
        private static var _imeEnabled:Boolean = true;
        public static var _imeEnabledPre:Boolean = false;
        private static var _circle:Circle;
        private static var _circleStack:Array = [];
        public static var _Keyobj:Object = new Object();
        public static var _tabTargetIndex:int = 0;

        public function EventMouse()
        {
            return;
        }// end function

        public static function setCircle(param1 = null, param2 = 0, param3 = 0)
        {
            if (param1 != null)
            {
                if (_circle == null)
                {
                    _circle = new Circle();
                }
                _circle.form = param1;
                _circle.param1 = param2;
                _circle.param2 = param3;
                _circle.start();
                Config.map._footMap.addChild(_circle);
            }
            else if (_circle != null)
            {
                _circle.clear();
                if (_circle.parent != null)
                {
                    _circle.parent.removeChild(_circle);
                }
            }
            return;
        }// end function

        static function startLoop(param1:Function)
        {
            stopLoop(param1);
            Config.stage.addEventListener(Event.ENTER_FRAME, param1);
            return;
        }// end function

        static function stopLoop(param1:Function)
        {
            Config.stage.removeEventListener(Event.ENTER_FRAME, param1);
            return;
        }// end function

        public static function init()
        {
            startLoop(enterFrameDo);
            Config.stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
            Config.stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
            Config.stage.addEventListener(MouseEvent.MOUSE_WHEEL, handleMouseWheel);
            Config.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
            Config.stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
            return;
        }// end function

        private static function handleMouseWheel(event:MouseEvent)
        {
            return;
        }// end function

        private static function handleKeyUp(event:KeyboardEvent) : void
        {
            switch(event.keyCode)
            {
                case 16:
                {
                    _Keyobj["Shift"] = false;
                    break;
                }
                case 17:
                {
                    _Keyobj["Ctrl"] = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private static function handleKeyDown(event:KeyboardEvent)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = Config.stage.focus;
            if (_loc_2 == null || !(_loc_2 is TextField && _loc_2.selectable && _loc_2.type == TextFieldType.INPUT))
            {
                if (event.keyCode == 229)
                {
                    if (IME.enabled)
                    {
                        _imeEnabledPre = true;
                        IME.enabled = false;
                    }
                }
            }
            else if (_imeEnabledPre)
            {
                _imeEnabledPre = false;
                IME.enabled = true;
            }
            switch(event.keyCode)
            {
                case 16:
                {
                    _Keyobj["Shift"] = true;
                    break;
                }
                case 17:
                {
                    _Keyobj["Ctrl"] = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (Config.ui != null && !Config.ui._chatUI.focus && Config.map._state == "ready" && !(_loc_2 is TextField && _loc_2.selectable && _loc_2.type == TextFieldType.INPUT))
            {
                if (event.keyCode == 13)
                {
                    Config.ui._chatUI.focus = true;
                }
                else if (event.keyCode == 32)
                {
                    if (Config.player != null && Config.player._currTile != null)
                    {
                        _loc_3 = Hang.findNearItem(6);
                        if (_loc_3 != null)
                        {
                            Config.player.target = _loc_3;
                        }
                        Config.player.autoPickPath = true;
                        Config.player.autoPick();
                    }
                }
                else if (event.keyCode >= 49 && event.keyCode <= 59)
                {
                    if (!(_loc_2 is TextField && _loc_2.selectable && _loc_2.type == TextFieldType.INPUT))
                    {
                        if (Config.ui != null && Config.player != null)
                        {
                            Config.ui._quickUI.handleKey(event.keyCode - 49);
                        }
                    }
                }
                else if (event.keyCode == 90)
                {
                    if (Config.player != null)
                    {
                        if (!Config.player.resting)
                        {
                            Config.player.startRest();
                        }
                        else
                        {
                            Config.player.stopRest();
                        }
                    }
                }
                else if (event.keyCode == 67)
                {
                    Config.ui._charUI.switchOpen();
                }
                else if (event.keyCode == 66)
                {
                    Config.ui._bagUI.switchOpen();
                }
                else if (event.keyCode == 75)
                {
                    Config.ui._skillUI.switchOpen();
                }
                else if (event.keyCode == 70)
                {
                    Config.ui._friendUI.switchOpen();
                }
                else if (event.keyCode == 68)
                {
                    Config.ui._petPanel.switchOpen();
                }
                else if (event.keyCode == 69)
                {
                    Config.ui._mailpanel.switchOpen();
                }
                else if (event.keyCode == 71)
                {
                    Config.ui._gangs.switchOpen();
                }
                else if (event.keyCode == 72)
                {
                    Unit.otherVisible = !Unit.otherVisible;
                }
                else if (event.keyCode == 76 || event.keyCode == 81)
                {
                    Config.ui._taskpanel.switchOpen();
                }
                else if (event.keyCode == 78)
                {
                    Config.ui._monsterIndexUI.switchOpen();
                }
                else if (event.keyCode == 80)
                {
                    Config.ui._blackmarket.switchOpen();
                }
                else if (event.keyCode == 77)
                {
                    Config.ui._zoommap.switchOpen();
                }
                else if (event.keyCode == 87)
                {
                    Config.ui._producepanel.switchOpen();
                }
                else if (event.keyCode == 89)
                {
                    if (Config.ui._systemUI._followerPB.visible)
                    {
                        Config.ui._followcharui.switchOpen();
                    }
                }
                else if (event.keyCode == 192)
                {
                    Config.ui._quickUI.changeRow();
                }
                else if (event.keyCode == 65)
                {
                    if (MonsterIndexUI.isCanHang())
                    {
                        if (!Config.ui._monsterIndexUI.hanging)
                        {
                            if (!Config.ui._monsterIndexUI._hangMode1.selected)
                            {
                                Config.ui._monsterIndexUI.flagAllMonster();
                            }
                            Config.ui._monsterIndexUI.hanging = true;
                        }
                        else
                        {
                            Config.ui._monsterIndexUI.hanging = false;
                        }
                    }
                }
                else if (event.keyCode == 27)
                {
                    Window.closeOne();
                }
                else if (event.keyCode == 82)
                {
                    Config.ui._recomPanel.switchOpen();
                }
                else if (event.keyCode == 84)
                {
                    Config.ui._teamUI.switchOpen();
                }
                else if (event.keyCode == 191)
                {
                }
                else if (event.keyCode == 9)
                {
                    findNextTarget();
                }
                else if (event.keyCode == 85)
                {
                    if (Config.ui._bagUI.godopen == 1)
                    {
                        Config.ui._godmade.switchOpen();
                    }
                }
                else if (event.keyCode == 86)
                {
                    Config.ui._interPkPanel.switchOpen();
                }
                else if (event.keyCode == 88)
                {
                    Config.ui._fbEntranceUI.switchOpen();
                }
                else if (event.keyCode == 74)
                {
                    Config.ui._activePanel.switchOpen();
                }
                else if (event.keyCode == 83)
                {
                    Config.ui._shopmail.switchOpen();
                }
                else if (event.keyCode == 79)
                {
                    Config.ui._gamesystem.switchOpen();
                }
                else if (event.keyCode == 73)
                {
                    Config.ui._activePanel.opengiftdare();
                }
            }
            else if (Config.ui != null)
            {
                if (_loc_2 == Config.ui._chatUI._sayText._textfield)
                {
                    if (event.keyCode == 13)
                    {
                        Config.ui._chatUI.say();
                    }
                    else if (event.keyCode == 38)
                    {
                        Config.ui._chatUI.upPreSay();
                    }
                    else if (event.keyCode == 40)
                    {
                        Config.ui._chatUI.downPreSay();
                    }
                }
            }
            return;
        }// end function

        private static function findNextTarget()
        {
            var _loc_3:* = undefined;
            var _loc_5:* = undefined;
            if (Config.player == null)
            {
                return;
            }
            var _loc_1:* = Unit.getUnitList(UNIT_TYPE_ENUM.TYPEID_UNIT);
            var _loc_2:* = Unit.getUnitList(UNIT_TYPE_ENUM.TYPEID_PLAYER);
            var _loc_4:* = [];
            for (_loc_3 in _loc_1)
            {
                
                if (_loc_1[_loc_3].testPk())
                {
                    _loc_5 = Config.player.testDistance(_loc_1[_loc_3]);
                    if (_loc_5 < Config.map.width / 4 + Config.map.height / 4)
                    {
                        _loc_4.push({unit:_loc_1[_loc_3], d:_loc_5});
                    }
                }
            }
            for (_loc_3 in _loc_2)
            {
                
                if (_loc_2[_loc_3].testPk())
                {
                    _loc_5 = Config.player.testDistance(_loc_2[_loc_3]);
                    if (_loc_5 < Config.map.width / 4 + Config.map.height / 4)
                    {
                        _loc_4.push({unit:_loc_2[_loc_3], d:_loc_5});
                    }
                }
            }
            if (_loc_4.length > 0)
            {
                _loc_4.sortOn("d", Array.NUMERIC);
                if (_tabTargetIndex >= _loc_4.length)
                {
                    _tabTargetIndex = 0;
                }
                if (_loc_4.length > 1)
                {
                    if (_loc_4[_tabTargetIndex].unit == Config.player.tracingTarget)
                    {
                        var _loc_7:* = _tabTargetIndex + 1;
                        _tabTargetIndex = _loc_7;
                        if (_tabTargetIndex >= _loc_4.length)
                        {
                            _tabTargetIndex = 0;
                        }
                    }
                }
                Config.player.tracingTarget = _loc_4[_tabTargetIndex].unit;
                var _loc_7:* = _tabTargetIndex + 1;
                _tabTargetIndex = _loc_7;
            }
            else
            {
                _tabTargetIndex = 0;
            }
            return;
        }// end function

        private static function getTileUnit(param1, param2)
        {
            var i:*;
            var j:*;
            var k:*;
            var unit:*;
            var clickedUnit:*;
            var tile:*;
            var tileUnit:*;
            var nearUnit:*;
            var xx:*;
            var yy:*;
            var bmpd:*;
            var xxx:*;
            var yyy:*;
            var temp1:*;
            var temp2:*;
            var x:*;
            var y:*;
            var aa:*;
            var xm:* = param1;
            var ym:* = param2;
            var aimPt:Object;
            aimPt = Config.map.screenToMap(aimPt);
            var aim:* = Config.map.mapToTile(aimPt);
            var unitArr:Array;
            var tempUnitArr:Array;
            i;
            while (i < 4)
            {
                
                j;
                while (j < 4)
                {
                    
                    x = aim._x + i;
                    y = aim._y + j;
                    if (x >= 0 && x < Config.map._logicalWidth)
                    {
                        if (y >= 0 && y < Config.map._logicalHeight)
                        {
                            tempUnitArr = Config.map._logicalTile[x][y]._currUnit;
                            k;
                            while (k < tempUnitArr.length)
                            {
                                
                                if (!(tempUnitArr[k] is Follower) && !(tempUnitArr[k] is Effect) && !(tempUnitArr[k] is Door) && tempUnitArr[k].visible && (tempUnitArr[k]._data != null && tempUnitArr[k]._data.model >= 0) && tempUnitArr[k]._selectable && tempUnitArr[k]._mc != null && tempUnitArr[k]._mc.parent != null)
                                {
                                    if (Skill.selectedSkill != null && (Skill.selectedSkill._skillData.camp == 1 || Skill.selectedSkill._skillData.camp == 2))
                                    {
                                        unitArr.push({unit:tempUnitArr[k], z:tempUnitArr[k]._mc.parent.getChildIndex(tempUnitArr[k]._mc)});
                                    }
                                    else if (tempUnitArr[k] != Config.player)
                                    {
                                        unitArr.push({unit:tempUnitArr[k], z:tempUnitArr[k]._mc.parent.getChildIndex(tempUnitArr[k]._mc)});
                                    }
                                }
                                k = (k + 1);
                            }
                            tempUnitArr = Config.map._logicalTile[x][y]._currItem;
                            k;
                            while (k < tempUnitArr.length)
                            {
                                
                                if (tempUnitArr[k]._mc != null && tempUnitArr[k]._mc.parent != null)
                                {
                                    unitArr.push({unit:tempUnitArr[k], z:tempUnitArr[k]._mc.parent.getChildIndex(tempUnitArr[k]._mc)});
                                }
                                k = (k + 1);
                            }
                        }
                    }
                    j = (j + 1);
                }
                i = (i + 1);
            }
            unitArr.sortOn(["z"], Array.NUMERIC | Array.DESCENDING);
            i;
            while (i < unitArr.length)
            {
                
                unit = unitArr[i].unit;
                if (unit._type != UNIT_TYPE_ENUM.TYPEID_PET && unit != null && unit._img != null && unit._img._bitmap != null)
                {
                    if (unit._img._bitmap.bitmapData != null)
                    {
                        try
                        {
                            bmpd = unit._img._bitmap.bitmapData;
                            if (bmpd != null)
                            {
                                xxx = -Config.map._rootMap.x + xm / Config.map._zoom * 100 - unit._mc.x - Config.map._mc.x / Config.map._zoom * 100;
                                xx = xxx - unit._img._bitmap.x;
                                yyy = -(Config.map._rootMap.y - ym / Config.map._zoom * 100 + (unit._mc.y + unit._img.y)) - Config.map._mc.y / Config.map._zoom * 100;
                                yy = yyy - unit._img._bitmap.y;
                                aa = bmpd.getPixel32(Math.floor(xx * unit._img._bitmap.scaleX), Math.floor(yy * unit._img._bitmap.scaleY)) >> 24 & 255;
                                if (aa > 0)
                                {
                                    clickedUnit = unit;
                                    break;
                                }
                                else if (Math.abs(xxx) <= 32 && Math.abs(yyy) <= unit._img._bitmapRectY)
                                {
                                    unitArr[i].dis = Math.abs(unit._img._width / 2 - xx * unit._img._bitmap.scaleX);
                                }
                                else
                                {
                                    unitArr.splice(i, 1);
                                    i = (i - 1);
                                }
                            }
                        }
                        catch (e)
                        {
                        }
                    }
                }
                i = (i + 1);
            }
            if (clickedUnit == null)
            {
                if (unitArr.length == 0)
                {
                    return null;
                }
                unitArr.sortOn(["dis"], Array.NUMERIC);
                return unitArr[0].unit;
            }
            else
            {
                return clickedUnit;
            }
        }// end function

        private static function enterFrameDo(event:Event)
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
            if (Config.map != null && Config.map._state == "ready" && Config.player != null)
            {
                if (_circle != null && _circle.parent != null)
                {
                    if (_circle.form == 1)
                    {
                        _loc_5 = {_x:Config.main.mouseX - Config.map.x, _y:Config.main.mouseY - Config.map.y};
                        _loc_5 = Config.map.screenToMap(_loc_5);
                        _loc_6 = Config.map.mapToUnit(_loc_5);
                        if (Skill.chanting)
                        {
                            if (Config.player != null && Config.player.target != null)
                            {
                                _loc_6 = Config.map.mapToUnit(Config.player.target);
                            }
                        }
                        _circle.x = _loc_6._x;
                        _circle.y = _loc_6._y;
                    }
                    else if (_circle.form == 2 || _circle.form == 3 || _circle.form == 4)
                    {
                        _loc_6 = Config.map.mapToUnit(Config.player);
                        _circle.x = _loc_6._x;
                        _circle.y = _loc_6._y;
                        if (_circle.form == 3 || _circle.form == 4)
                        {
                            _loc_5 = {_x:Config.main.mouseX - Config.map.x, _y:Config.main.mouseY - Config.map.y};
                            _loc_5 = Config.map.screenToMap(_loc_5);
                            _circle.angle = Math.atan2(_loc_5._y - Config.player._y, _loc_5._x - Config.player._x);
                        }
                    }
                }
            }
            if (Config.stageMouseOver && Config.map != null && Config.map._state == "ready" && Config.player != null)
            {
                if (_justMove)
                {
                    _loc_5 = {_x:Config.main.mouseX - Config.map.x, _y:Config.main.mouseY - Config.map.y};
                    _loc_5 = Config.map.screenToMap(_loc_5);
                    if (_preTargetPos._x != _loc_5._x || _preTargetPos._y != _loc_5._y)
                    {
                        if (Config.player.target == null)
                        {
                            Config.player.go(_loc_5, false, true);
                            Config.player.autoPickPath = false;
                        }
                        _preTargetPos._x = _loc_5._x;
                        _preTargetPos._y = _loc_5._y;
                    }
                    Config.MouseShape = "";
                }
                else
                {
                    _loc_10 = getTileUnit(Config.main.mouseX - Config.map.x, Config.main.mouseY);
                    if (_loc_10 != null)
                    {
                        if (_hoverUnit != _loc_10)
                        {
                            if (_hoverUnit != null)
                            {
                                _hoverUnit.removeBorder();
                                _loc_7 = _hoverUnit;
                            }
                            _hoverUnit = _loc_10;
                            if (_loc_7 != null && _loc_7 is Unit)
                            {
                                _loc_7._stateBar.check();
                                _loc_7 = null;
                            }
                            _hoverUnit.addBorder();
                            if (_hoverUnit is Unit)
                            {
                                _hoverUnit._stateBar.check();
                            }
                        }
                        if (Config.ui == null || !Config.ui.hitTestPoint(Config.stage.mouseX, Config.stage.mouseY, true) || !Config.ui._chatUI._channelBg.visible && Config.ui._chatUI.hitTestPoint(Config.stage.mouseX, Config.stage.mouseY, true))
                        {
                            if (Skill.selectedSkill != null)
                            {
                                if (Skill.selectedSkill._skillData.targetType == 2)
                                {
                                    Config.MouseShape = "skillwalk";
                                }
                                else if (Skill.selectedSkill._skillData.targetType == 3)
                                {
                                    Config.MouseShape = "skill";
                                }
                            }
                            else if (_hoverUnit._type == UNIT_TYPE_ENUM.TYPEID_UNIT)
                            {
                                if (_hoverUnit.testPk())
                                {
                                    Config.MouseShape = "attack";
                                }
                            }
                            else if (_hoverUnit._type == UNIT_TYPE_ENUM.TYPEID_ITEM_MAP)
                            {
                                Config.MouseShape = "pick";
                            }
                            else if (_hoverUnit._type == UNIT_TYPE_ENUM.TYPEID_GATHER)
                            {
                                Config.MouseShape = "pick";
                            }
                            else if (_hoverUnit._type == UNIT_TYPE_ENUM.TYPEID_NPC)
                            {
                                Config.MouseShape = "talk";
                            }
                            else if (_hoverUnit._type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
                            {
                                if (_hoverUnit.testPk())
                                {
                                    Config.MouseShape = "attack";
                                }
                            }
                        }
                    }
                    else
                    {
                        if (_hoverUnit != null)
                        {
                            _hoverUnit.removeBorder();
                            _loc_7 = _hoverUnit;
                        }
                        _hoverUnit = null;
                        if (_loc_7 != null && _loc_7 is Unit)
                        {
                            _loc_7._stateBar.check();
                            _loc_7 = null;
                        }
                        _loc_5 = {_x:Config.main.mouseX - Config.map.x, _y:Config.main.mouseY - Config.map.y};
                        _loc_5 = Config.map.screenToMap(_loc_5);
                        _loc_6 = Config.map.mapToTile(_loc_5);
                        _loc_7 = Config.eventStack[_loc_6._x + "_" + _loc_6._y];
                        if (Config.ui == null || !Config.ui.hitTestPoint(Config.stage.mouseX, Config.stage.mouseY, true) || !Config.ui._chatUI._channelBg.visible && Config.ui._chatUI.hitTestPoint(Config.stage.mouseX, Config.stage.mouseY, true))
                        {
                            if (Skill.selectedSkill != null)
                            {
                                if (Skill.selectedSkill._skillData.targetType == 2)
                                {
                                    if (_loc_7 != null && String(_loc_7.type) == "jump_map")
                                    {
                                        Config.MouseShape = "jump";
                                        if (Config._mapMap[Number(_loc_7.mapId)] != null)
                                        {
                                            Config.ui._mousepointer.mouseTip = String(Config._mapMap[Number(_loc_7.mapId)].mapData.name);
                                        }
                                    }
                                    else if (_loc_7 != null && String(_loc_7.type) == "fb_exit" && _loc_6.terrainwalkable)
                                    {
                                        Config.MouseShape = "jump";
                                        Config.ui._mousepointer.mouseTip = Config.language("EventMouse", 2);
                                    }
                                    else if (_loc_7 != null && String(_loc_7.type) == "jump_battle_field" && _loc_6.terrainwalkable)
                                    {
                                        Config.MouseShape = "jump";
                                        Config.ui._mousepointer.mouseTip = Config.language("EventMouse", 3);
                                    }
                                    else
                                    {
                                        Config.MouseShape = "skillwalk";
                                    }
                                }
                                else if (Skill.selectedSkill._skillData.targetType == 3)
                                {
                                    Config.MouseShape = "skill";
                                }
                            }
                            else if (_loc_7 != null && String(_loc_7.type) == "jump_map")
                            {
                                Config.MouseShape = "jump";
                                if (Config._mapMap[Number(_loc_7.mapId)] != null)
                                {
                                    Config.ui._mousepointer.mouseTip = String(Config._mapMap[Number(_loc_7.mapId)].mapData.name);
                                }
                            }
                            else if (_loc_7 != null && String(_loc_7.type) == "fb_exit")
                            {
                                Config.MouseShape = "jump";
                                Config.ui._mousepointer.mouseTip = Config.language("EventMouse", 2);
                            }
                            else if (_loc_7 != null && String(_loc_7.type) == "jump_battle_field" && _loc_6.terrainwalkable)
                            {
                                Config.MouseShape = "jump";
                                Config.ui._mousepointer.mouseTip = Config.language("EventMouse", 3);
                            }
                            else
                            {
                                Config.MouseShape = "";
                            }
                        }
                        else
                        {
                            Config.MouseShape = "";
                        }
                    }
                }
            }
            else
            {
                Config.MouseShape = "";
            }
            return;
        }// end function

        private static function handleMouseUp(event:MouseEvent)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            _preTargetPos = {_x:null, _y:null};
            _justMove = false;
            _mouseDown = false;
            if (Holder.item != null || Holder.other != null)
            {
                _loc_2 = false;
                _loc_3 = event.target;
                while (_loc_3 != null)
                {
                    
                    if (_loc_3 == Config.map)
                    {
                        _loc_2 = true;
                        break;
                    }
                    _loc_3 = _loc_3.parent;
                }
                if (_loc_2)
                {
                    if (Holder.item != null)
                    {
                        if (Holder.item._drawer == Config.ui._charUI._slotArray)
                        {
                            Config.ui._bagUI.drop(Holder.item);
                            Holder.item.backToSlot();
                            Holder.item = null;
                        }
                        else
                        {
                            Holder.item.backToSlot();
                            Holder.item = null;
                        }
                    }
                    else if (Holder.other != null)
                    {
                        if (!(Holder.other is Skill) && Holder.other.item != null)
                        {
                            Config.ui._stallUI.checkStall(Holder.other.item);
                        }
                        Holder.other = null;
                    }
                }
            }
            return;
        }// end function

        private static function handleMouseDown(event:MouseEvent)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = null;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            if (Config.buttonLock || Config.player == null)
            {
                return;
            }
            Config.player.clearHate();
            var _loc_2:* = false;
            var _loc_3:* = event.target;
            while (_loc_3 != null)
            {
                
                if (_loc_3 == Config.map)
                {
                    _loc_2 = true;
                    break;
                }
                _loc_3 = _loc_3.parent;
            }
            if (_loc_2)
            {
                if (Holder.item != null)
                {
                    if (Holder.item._drawer == Config.ui._charUI._slotArray)
                    {
                        Config.ui._bagUI.drop(Holder.item);
                        Holder.item.backToSlot();
                        Holder.item = null;
                    }
                    else
                    {
                        Holder.item.backToSlot();
                        Holder.item = null;
                    }
                }
                else if (Holder.other != null)
                {
                    if (!(Holder.other is Skill) && Holder.other.item != null)
                    {
                        Config.ui._stallUI.checkStall(Holder.other.item);
                    }
                    Holder.other = null;
                }
                else
                {
                    _mouseDown = true;
                    _loc_11 = {_x:Config.main.mouseX - Config.map.x, _y:Config.main.mouseY - Config.map.y};
                    _loc_11 = Config.map.screenToMap(_loc_11);
                    _loc_12 = Config.map.mapToTile(_loc_11);
                    Config.stopAuto();
                    if (Skill.chanting)
                    {
                        Skill.castChant();
                    }
                    else if (_hoverUnit == null)
                    {
                        if (Skill.selectedSkill == null)
                        {
                            _loc_8 = Config.eventStack[_loc_12._x + "_" + _loc_12._y];
                            if (_loc_8 != null && String(_loc_8.type) == "jump_map")
                            {
                                Config.player.target = {_x:_loc_11._x, _y:_loc_11._y, jump:_loc_8};
                            }
                            else if (_loc_8 != null && String(_loc_8.type) == "fb_exit")
                            {
                                Config.player.target = {_x:_loc_11._x, _y:_loc_11._y, fb_exit:_loc_8};
                            }
                            else if (_loc_8 != null && String(_loc_8.type) == "jump_battle_field")
                            {
                                Config.player.target = {_x:_loc_11._x, _y:_loc_11._y, jump_battle_field:_loc_8};
                            }
                            else
                            {
                                _preTargetPos = {_x:null, _y:null};
                                _justMove = true;
                                Config.player.go(_loc_11, false, true);
                                Config.player.autoPickPath = false;
                            }
                        }
                        else
                        {
                            _loc_8 = Config.eventStack[_loc_12._x + "_" + _loc_12._y];
                            if (_loc_8 != null && String(_loc_8.type) == "jump_map")
                            {
                                Config.message(Config.language("EventMouse", 1));
                            }
                            Config.player.target = _loc_11;
                        }
                    }
                    else if (_hoverUnit is Dummy)
                    {
                        if (Skill.selectedSkill != null)
                        {
                            if (Skill.selectedSkill._skillData.isNeedTarget == 3 && (_hoverUnit._data.type == 11 && Config.ui._yabiao.defFlag() || _hoverUnit._data.type == 12 && !Config.ui._yabiao.defFlag()))
                            {
                                Config.player.target = _hoverUnit;
                            }
                            else
                            {
                                _loc_13 = Skill.selectedSkill._skillData.camp;
                                if (_loc_13 == 2 || _loc_13 == 3 || _loc_13 == 0 && _hoverUnit.testPk() || _loc_13 == 1 && !_hoverUnit.testPk())
                                {
                                    Config.player.target = _hoverUnit;
                                }
                                else
                                {
                                    Config.player.tracingTarget = _hoverUnit;
                                }
                            }
                        }
                        else if (Config.ui._quickUI._mouseSlot.skill == null)
                        {
                            Config.player.tracingTarget = _hoverUnit;
                        }
                        else if (Config.ui._quickUI._mouseSlot.skill._skillData.id == Config.player.attackMode.id)
                        {
                            _loc_13 = Config.ui._quickUI._mouseSlot.skill._skillData.camp;
                            if (_loc_13 == 2 || _loc_13 == 3 || _loc_13 == 0 && _hoverUnit.testPk() || _loc_13 == 1 && !_hoverUnit.testPk())
                            {
                                Config.player.target = _hoverUnit;
                            }
                            else
                            {
                                Config.player.tracingTarget = _hoverUnit;
                            }
                        }
                        else
                        {
                            Config.player.target = null;
                            Config.player.tracingTarget = null;
                            _loc_13 = Config.ui._quickUI._mouseSlot.skill._skillData.camp;
                            if (_loc_13 == 2 || _loc_13 == 3 || _loc_13 == 0 && _hoverUnit.testPk() || _loc_13 == 1 && !_hoverUnit.testPk())
                            {
                                if (Config.ui._quickUI._mouseSlot.skill.select())
                                {
                                    Config.player.target = _hoverUnit;
                                }
                                else
                                {
                                    Config.player.target = _hoverUnit;
                                }
                            }
                            else
                            {
                                Config.player.tracingTarget = _hoverUnit;
                            }
                        }
                        if (Number(_hoverUnit._data.id) == 70001 && GuideUI.testId(26))
                        {
                            GuideUI.doId(26, _hoverUnit);
                        }
                        else if (Number(_hoverUnit._data.type) == 3 && GuideUI.testId(20))
                        {
                            GuideUI.doId(20, _hoverUnit);
                        }
                        else if (Number(_hoverUnit._data.id) == 50003 && GuideUI.testId(138))
                        {
                            GuideUI.doId(138, Config.ui._quickUI._goldhandSlot);
                        }
                    }
                    else
                    {
                        Config.player.target = _hoverUnit;
                        if (_hoverUnit is Gather)
                        {
                            GuideUI.testDoId(14, _hoverUnit);
                        }
                    }
                }
            }
            return;
        }// end function

    }
}
