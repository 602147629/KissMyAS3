package lovefox.unit
{

    public class Follower extends Unit
    {
        private var _poolPushed:Boolean = false;
        private var _pushPoolTimer:Object;
        private var _master:Unit;
        private var _thinkTimer:Object;
        private var _attacking:Boolean = false;
        public static var _objectPool:Array = [];

        public function Follower(param1:int, param2, param3, param4, param5)
        {
            var _loc_6:* = {model:param1};
            super(_loc_6, param2, param3, param4, param5);
            _selectable = false;
            _walkBlock = false;
            return;
        }// end function

        override public function destroy()
        {
            super.destroy();
            this.setMaster(null);
            this.stopLoop(this.move);
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

        override function changeClip()
        {
            super.changeClip();
            _selectable = false;
            _walkBlock = false;
            return;
        }// end function

        override protected function imgComplete()
        {
            super.imgComplete();
            return;
        }// end function

        public function playAttack()
        {
            this._attacking = true;
            this.startLoop(this.move);
            if (_img != null)
            {
                _img.changeStateTo("attack", this.attackOver);
            }
            return;
        }// end function

        private function attackOver(param1)
        {
            this._attacking = false;
            this.startLoop(this.move);
            if (_moveFlag)
            {
                param1.changeStateTo("move");
            }
            else
            {
                param1.changeStateTo("idle");
            }
            return;
        }// end function

        public function setMaster(param1:Unit)
        {
            if (this._master != null)
            {
                this._master.removeEventListener("move", this.handleMasterPass);
            }
            this._master = param1;
            if (this._master != null)
            {
                this._master.addEventListener("move", this.handleMasterPass);
            }
            return;
        }// end function

        private function handleMasterPass(param1)
        {
            this.startLoop(this.move);
            if (_img != null && !this._attacking)
            {
                _img.changeStateTo("move");
            }
            return;
        }// end function

        private function move(param1)
        {
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_2:* = 5;
            if (this._attacking)
            {
                _loc_5 = this._master._x + Math.cos(this._master._angle) * 24;
                _loc_6 = this._master._y + Math.sin(this._master._angle) * 24;
                _loc_2 = 2;
            }
            else
            {
                _loc_5 = this._master._x + Math.cos(this._master._angle) * -24;
                _loc_6 = this._master._y + Math.sin(this._master._angle) * -24;
            }
            var _loc_3:* = Math.sqrt(Math.pow(_loc_5 - _x, 2) + Math.pow(_loc_6 - _y, 2));
            var _loc_4:* = 1;
            if (_loc_3 < _loc_4)
            {
                _x = _loc_5;
                _y = _loc_6;
                _moveFlag = false;
                this.stopLoop(this.move);
                if (_img != null && !this._attacking)
                {
                    _img.changeStateTo("idle");
                }
            }
            else
            {
                _loc_7 = Math.atan2(_loc_6 - _y, _loc_5 - _x);
                _x = _x + (_loc_5 - _x) / _loc_2;
                _y = _y + (_loc_6 - _y) / _loc_2;
                directTo(_loc_7);
                _moveFlag = true;
            }
            if (_img != null)
            {
                if (-this._master._imgY != _img.zoff)
                {
                    if (Math.abs(-this._master._imgY - _img.zoff) < 1)
                    {
                        _img.zoff = -this._master._imgY;
                    }
                    else
                    {
                        _img.zoff = (-this._master._imgY - _img.zoff) / 5 + _img.zoff;
                    }
                }
            }
            draw();
            if (_map != null)
            {
                _loc_8 = _map.mapToTile({_x:_x, _y:_y});
                if (_loc_8 != _currTile)
                {
                    _currTile = _loc_8;
                    _currTile.addUnit(this);
                    swapDepthTile();
                }
            }
            return;
        }// end function

        public static function newFollower(param1:int, param2, param3, param4, param5)
        {
            var _loc_6:* = null;
            if (_objectPool.length == 0)
            {
                _loc_6 = new Follower(param1, param2, param3, param4, param5);
            }
            else
            {
                _loc_6 = _objectPool.shift();
                _loc_6.id = param5;
                _loc_6._x = param2;
                _loc_6._y = param3;
                _loc_6._data = {model:param1};
                _loc_6.changeClip();
            }
            return _loc_6;
        }// end function

    }
}
