package lovefox.unit
{
    import lovefox.socket.*;

    public class Gather extends Unit
    {
        private var _poolPushed:Boolean = false;
        private var _pushPoolTimer:Object;
        private var _canGather:Boolean = true;
        public static var _objectPool:Array = [];

        public function Gather(param1, param2, param3, param4, param5)
        {
            super(param1, param2, param3, param4, param5);
            _walkBlock = false;
            return;
        }// end function

        public function set canGather(param1)
        {
            this._canGather = param1;
            var _loc_2:* = _data.effectID;
            if (_loc_2 > 0)
            {
                if (this._canGather)
                {
                    removeHalo(_loc_2);
                }
                else
                {
                    addHalo(_loc_2);
                }
            }
            return;
        }// end function

        public function get canGather()
        {
            return this._canGather;
        }// end function

        override public function addBorder()
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            super.addBorder();
            if (_data.id == 7014)
            {
                if (Config.player.warTeam == 1)
                {
                    say(Config.language("Gather", 1));
                }
                else
                {
                    say(Config.language("Gather", 2));
                }
            }
            else if (_data.id == 7015)
            {
                if (Config.player.warTeam == 1)
                {
                    say(Config.language("Gather", 2));
                }
                else
                {
                    say(Config.language("Gather", 1));
                }
            }
            else if (_data.id == 7013)
            {
                say(Config.language("Gather", 3));
            }
            else if (_data.id == 1128)
            {
                _loc_1 = new DataSet();
                _loc_1.addHead(CONST_ENUM.C2G_GATHER_COUNTDOWN);
                _loc_1.add32(this.id);
                ClientSocket.send(_loc_1);
                _loc_2 = _data.name + "\n成熟剩余时间 " + Config.ui._taskpanel.strtimer;
                say(_loc_2);
            }
            else
            {
                say(_data.name);
            }
            return;
        }// end function

        override public function removeBorder()
        {
            say("");
            super.removeBorder();
            return;
        }// end function

        public function sendgather(param1:int) : void
        {
            var _loc_2:* = null;
            if (_data.id == 7014 && Config.player.warTeam == 1 || _data.id == 7015 && Config.player.warTeam == 2)
            {
                Config.message(Config.language("Gather", 4));
                return;
            }
            if (this.canGather)
            {
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2G_GATHER);
                _loc_2.add32(param1);
                ClientSocket.send(_loc_2);
            }
            else
            {
                Config.message(_data.name + Config.language("Gather", 5));
            }
            return;
        }// end function

        override public function destroy()
        {
            if (_data.die == 1)
            {
                UnitEffect.smash(this);
            }
            super.destroy();
            clearTimeout(this._pushPoolTimer);
            if (!this._poolPushed)
            {
                this._poolPushed = true;
                this._pushPoolTimer = setTimeout(this.pushPool, 1000);
            }
            this.canGather = true;
            return;
        }// end function

        private function pushPool()
        {
            clearTimeout(this._pushPoolTimer);
            _objectPool.push(this);
            return;
        }// end function

        public static function newGather(param1, param2, param3, param4, param5)
        {
            var _loc_6:* = null;
            if (_objectPool.length == 0)
            {
                return new Gather(param1, param2, param3, param4, param5);
            }
            _loc_6 = _objectPool.shift();
            _loc_6._poolPushed = false;
            _loc_6._data = param1;
            _loc_6._x = param2;
            _loc_6._y = param3;
            _loc_6._type = param4;
            _loc_6._id = param5;
            if (_unitStack[_loc_6._type] == null)
            {
                _unitStack[_loc_6._type] = {};
            }
            _unitStack[_loc_6._type][_loc_6._id] = _loc_6;
            _loc_6._enterframeListenerArray = [];
            var _loc_8:* = _allCount + 1;
            _allCount = _loc_8;
            return _loc_6;
        }// end function

    }
}
