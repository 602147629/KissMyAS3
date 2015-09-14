package status
{

    public class PlayerDetailStatusResult extends Object
    {
        private var _bUpdate:Boolean;
        private var _bGotoTradingPost:Boolean;
        private var _bGrowsReset:Boolean;

        public function PlayerDetailStatusResult()
        {
            this.reset();
            return;
        }// end function

        public function get bUpdate() : Boolean
        {
            return this._bUpdate;
        }// end function

        public function set bUpdate(param1:Boolean) : void
        {
            this._bUpdate = param1;
            return;
        }// end function

        public function get bGotoTradingPost() : Boolean
        {
            return this._bGotoTradingPost;
        }// end function

        public function set bGotoTradingPost(param1:Boolean) : void
        {
            this._bGotoTradingPost = param1;
            return;
        }// end function

        public function get bGrowsReset() : Boolean
        {
            return this._bGrowsReset;
        }// end function

        public function set bGrowsReset(param1:Boolean) : void
        {
            this._bGrowsReset = param1;
            return;
        }// end function

        public function clone() : PlayerDetailStatusResult
        {
            var _loc_1:* = new PlayerDetailStatusResult();
            _loc_1._bUpdate = this._bUpdate;
            _loc_1._bGotoTradingPost = this._bGotoTradingPost;
            _loc_1._bGrowsReset = this._bGrowsReset;
            return _loc_1;
        }// end function

        public function reset() : void
        {
            this._bUpdate = false;
            this._bGotoTradingPost = false;
            this._bGrowsReset = false;
            return;
        }// end function

        public function marj(param1:PlayerDetailStatusResult) : void
        {
            if (param1._bUpdate)
            {
                this._bUpdate = true;
            }
            if (param1._bGotoTradingPost)
            {
                this._bGotoTradingPost = true;
            }
            if (param1._bGrowsReset)
            {
                this._bGrowsReset = true;
            }
            return;
        }// end function

    }
}
