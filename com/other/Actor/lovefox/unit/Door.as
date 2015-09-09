package lovefox.unit
{

    public class Door extends Unit
    {
        private var _poolPushed:Boolean = false;
        private var _opening:Boolean = true;
        public static var _objectPool:Array = [];

        public function Door(param1, param2, param3, param4, param5)
        {
            super({model:param1}, param2, param3, param4, param5);
            this._walkBlock = false;
            return;
        }// end function

        override public function destroy()
        {
            this.opening = true;
            return;
        }// end function

        public function get opening()
        {
            return this._opening;
        }// end function

        override function subDisplay(param1 = null)
        {
            super.subDisplay(param1);
            this.opening = this.opening;
            return;
        }// end function

        override public function reDraw()
        {
            super.reDraw();
            if (_img != null)
            {
                _img.shadow = false;
            }
            return;
        }// end function

        private function openOver(param1 = null)
        {
            this.changeStateTo("opened");
            return;
        }// end function

        private function closeOver(param1 = null)
        {
            this.changeStateTo("closed");
            return;
        }// end function

        public function set opening(param1)
        {
            if (this._opening == param1)
            {
                this._opening = param1;
                if (this._opening)
                {
                    this._opening = true;
                    if (_currTile != null)
                    {
                        _currTile._parentTile.block = 2;
                    }
                    this.changeStateTo("opened");
                }
                else
                {
                    this._opening = false;
                    if (_currTile != null)
                    {
                        _currTile._parentTile.block = 0;
                    }
                    this.changeStateTo("closed");
                }
            }
            else
            {
                this._opening = param1;
                if (this._opening)
                {
                    this._opening = true;
                    if (_currTile != null)
                    {
                        _currTile._parentTile.block = 2;
                    }
                    this.changeStateTo("open", this.openOver);
                }
                else
                {
                    this._opening = false;
                    if (_currTile != null)
                    {
                        _currTile._parentTile.block = 0;
                    }
                    this.changeStateTo("close", this.closeOver);
                }
            }
            return;
        }// end function

        public static function newDoor(param1, param2, param3, param4, param5)
        {
            var _loc_6:* = new Door(param1, param2, param3, param4, param5);
            return new Door(param1, param2, param3, param4, param5);
        }// end function

    }
}
