package window
{

    public class WindowStyle extends Object
    {
        private var _leftMargin:Number;
        private var _topMargin:Number;
        private var _rightMargin:Number;
        private var _bottomMargin:Number;
        private var _rowNum:int;

        public function WindowStyle()
        {
            this._leftMargin = 0;
            this._topMargin = 0;
            this._rightMargin = 0;
            this._bottomMargin = 0;
            this._rowNum = 1;
            return;
        }// end function

        public function clone() : WindowStyle
        {
            var _loc_1:* = new WindowStyle();
            _loc_1.leftMargin = this._leftMargin;
            _loc_1.topMargin = this._topMargin;
            _loc_1.rightMargin = this._rightMargin;
            _loc_1.bottomMargin = this._bottomMargin;
            return _loc_1;
        }// end function

        public function set leftMargin(param1:Number) : void
        {
            this._leftMargin = param1;
            return;
        }// end function

        public function get leftMargin() : Number
        {
            return this._leftMargin;
        }// end function

        public function set topMargin(param1:Number) : void
        {
            this._topMargin = param1;
            return;
        }// end function

        public function get topMargin() : Number
        {
            return this._topMargin;
        }// end function

        public function set rightMargin(param1:Number) : void
        {
            this._rightMargin = param1;
            return;
        }// end function

        public function get rightMargin() : Number
        {
            return this._rightMargin;
        }// end function

        public function set bottomMargin(param1:Number) : void
        {
            this._bottomMargin = param1;
            return;
        }// end function

        public function get bottomMargin() : Number
        {
            return this._bottomMargin;
        }// end function

        public function get rowNum() : int
        {
            return this._rowNum;
        }// end function

        public function set rowNum(param1:int) : void
        {
            this._rowNum = param1;
            return;
        }// end function

    }
}
