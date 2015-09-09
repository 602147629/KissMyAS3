package lovefox.gameUI
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class SlotList extends Sprite
    {
        public var _selectedItem:Object;
        private var _container:Object;
        private var _slotArray:Array;
        private var _slotMap:Object;
        private var _closeExcepts:Array;

        public function SlotList(param1, param2 = null)
        {
            this._slotArray = [];
            this._slotMap = {};
            this._closeExcepts = [];
            if (param2 != null)
            {
                if (param2 is Array)
                {
                    this._closeExcepts = param2;
                }
                else
                {
                    this._closeExcepts = [param2];
                }
            }
            this._container = param1;
            this.cacheAsBitmap = true;
            this.filters = [new DropShadowFilter(4, 45, 0, 0.5, 4, 4, 1, 3)];
            return;
        }// end function

        public function set itemList(param1)
        {
            var _loc_2:* = undefined;
            var _loc_6:* = undefined;
            this.cacheAsBitmap = false;
            var _loc_3:* = {};
            var _loc_4:* = param1[0] == 0;
            var _loc_5:* = [];
            _loc_2 = 0;
            while (_loc_2 < param1.length)
            {
                
                if (param1[_loc_2] != 0)
                {
                    _loc_5.push({skillType:param1[_loc_2]._skillData.skillType, giftFlag:param1[_loc_2]._skillData.giftFlag, level:Config._skillMap[int(param1[_loc_2]._skillData.baseId + "0")].reqLevel, skill:param1[_loc_2]});
                }
                _loc_2 = _loc_2 + 1;
            }
            if (_loc_4)
            {
                param1 = [0];
            }
            else
            {
                param1 = [];
            }
            _loc_5.sortOn(["giftFlag", "level", "skillType"], [Array.NUMERIC, Array.NUMERIC, Array.NUMERIC]);
            _loc_2 = 0;
            while (_loc_2 < _loc_5.length)
            {
                
                param1.push(_loc_5[_loc_2].skill);
                _loc_2 = _loc_2 + 1;
            }
            _loc_2 = 0;
            while (_loc_2 < param1.length)
            {
                
                if (param1[_loc_2] == 0)
                {
                    if (this._slotMap[0] == null)
                    {
                        this._slotArray[_loc_2] = new CloneSlot(_loc_2);
                        this._slotMap[0] = this._slotArray[_loc_2];
                        this._slotArray[_loc_2].bg = Config.findIconURL("s00000");
                        addChild(this._slotArray[_loc_2]);
                    }
                    else
                    {
                        this._slotArray[_loc_2] = this._slotMap[0];
                    }
                    _loc_3[0] = true;
                }
                else
                {
                    if (this._slotMap[param1[_loc_2]._skillData.baseId] == null)
                    {
                        this._slotArray[_loc_2] = new CloneSlot(_loc_2);
                        this._slotMap[param1[_loc_2]._skillData.baseId] = this._slotArray[_loc_2];
                        this._slotArray[_loc_2].skill = param1[_loc_2];
                        addChild(this._slotArray[_loc_2]);
                    }
                    else
                    {
                        this._slotArray[_loc_2] = this._slotMap[param1[_loc_2]._skillData.baseId];
                        if (param1[_loc_2].level > this._slotArray[_loc_2].skill.level)
                        {
                            this._slotArray[_loc_2].skill.level = param1[_loc_2].level;
                        }
                    }
                    _loc_3[param1[_loc_2]._skillData.baseId] = true;
                }
                this._slotArray[_loc_2].addEventListener("sglClick", this.handleClick);
                this._slotArray[_loc_2].addEventListener(MouseEvent.ROLL_OVER, this.handleRollOver);
                _loc_2 = _loc_2 + 1;
            }
            for (_loc_2 in this._slotMap)
            {
                
                if (!_loc_3[_loc_2])
                {
                    this._slotMap[_loc_2].removeEventListener("sglClick", this.handleClick);
                    this._slotMap[_loc_2].removeEventListener(MouseEvent.ROLL_OVER, this.handleRollOver);
                    this._slotMap[_loc_2].removeEventListener(MouseEvent.ROLL_OUT, this.handleRollOut);
                    removeChild(this._slotMap[_loc_2]);
                    delete this._slotMap[_loc_2];
                }
            }
            this._slotArray = [];
            _loc_6 = 0;
            for (_loc_2 in this._slotMap)
            {
                
                this._slotArray.push(this._slotMap[_loc_2]);
                this._slotArray[(this._slotArray.length - 1)].x = _loc_6;
                _loc_6 = _loc_6 + 36;
            }
            this.cacheAsBitmap = true;
            return;
        }// end function

        private function handleRollOver(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            event.currentTarget.removeEventListener(MouseEvent.ROLL_OUT, this.handleRollOut);
            event.currentTarget.addEventListener(MouseEvent.ROLL_OUT, this.handleRollOut);
            var _loc_2:* = CloneSlot(event.currentTarget);
            if (_loc_2.skill != null)
            {
                _loc_3 = new Point(_loc_2.x, _loc_2.y);
                _loc_3 = _loc_2.parent.localToGlobal(_loc_3);
                Holder.showInfo(_loc_2.skill.outputInfoSimple(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), true, 0, 220);
            }
            return;
        }// end function

        private function handleRollOut(event:MouseEvent) : void
        {
            event.currentTarget.removeEventListener(MouseEvent.ROLL_OUT, this.handleRollOut);
            Holder.closeInfo();
            return;
        }// end function

        private function handleClick(param1)
        {
            this._selectedItem = param1.currentTarget.skill;
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function open()
        {
            if (this.parent == null)
            {
                this._container.addChild(this);
                Config.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
                Config.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
            }
            return;
        }// end function

        public function close()
        {
            Config.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
            if (this.parent != null)
            {
                this.parent.removeChild(this);
                this.dispatchEvent(new Event(Event.CLOSE));
            }
            return;
        }// end function

        public function switchOpen()
        {
            Config.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
            if (this.parent != null)
            {
                this.parent.removeChild(this);
                this.dispatchEvent(new Event(Event.CLOSE));
            }
            else
            {
                this._container.addChild(this);
                Config.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
            }
            return;
        }// end function

        private function handleClickOutside(param1)
        {
            var _loc_2:* = Config.stage;
            var _loc_3:* = 0;
            while (_loc_3 < this._closeExcepts.length)
            {
                
                if (this._closeExcepts[_loc_3].hitTestPoint(_loc_2.mouseX, _loc_2.mouseY, true))
                {
                    return;
                }
                _loc_3++;
            }
            if (!hitTestPoint(_loc_2.mouseX, _loc_2.mouseY, true))
            {
                this.close();
            }
            return;
        }// end function

    }
}
