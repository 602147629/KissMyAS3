package lovefox.util
{
    import flash.filters.*;

    public class HueColorMatrixFilter extends Object
    {
        private var matrix:Array;
        private var _h:Number = 0;

        public function HueColorMatrixFilter()
        {
            this.Identity();
            return;
        }// end function

        private function Identity() : void
        {
            this.matrix = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
            return;
        }// end function

        public function reset() : void
        {
            this.Identity();
            return;
        }// end function

        public function set Saturation(param1:Number) : void
        {
            param1 = param1 > 1 ? (1) : (param1 < 0 ? (0) : (param1));
            var _loc_2:* = [0.213, 0.715, 0.072, 0.213, 0.715, 0.072, 0.213, 0.715, 0.072];
            var _loc_3:* = [0.787, -0.715, -0.072, -0.212, 0.285, -0.072, -0.213, -0.715, 0.928];
            var _loc_4:* = this.add(_loc_2, this.multiply(param1, _loc_3));
            this.concat([_loc_4[0], _loc_4[1], _loc_4[2], 0, 0, _loc_4[3], _loc_4[4], _loc_4[5], 0, 0, _loc_4[6], _loc_4[7], _loc_4[8], 0, 0, 0, 0, 0, 1, 0]);
            return;
        }// end function

        public function set Hue(param1:Number) : void
        {
            this._h = param1;
            param1 = this._h * 0.0174533;
            var _loc_2:* = [0.213, 0.715, 0.072, 0.213, 0.715, 0.072, 0.213, 0.715, 0.072];
            var _loc_3:* = [0.787, -0.715, -0.072, -0.212, 0.285, -0.072, -0.213, -0.715, 0.928];
            var _loc_4:* = [-0.213, -0.715, 0.928, 0.143, 0.14, -0.283, -0.787, 0.715, 0.072];
            var _loc_5:* = this.add(_loc_2, this.add(this.multiply(Math.cos(param1), _loc_3), this.multiply(Math.sin(param1), _loc_4)));
            this.concat([_loc_5[0], _loc_5[1], _loc_5[2], 0, 0, _loc_5[3], _loc_5[4], _loc_5[5], 0, 0, _loc_5[6], _loc_5[7], _loc_5[8], 0, 0, 0, 0, 0, 1, 0]);
            return;
        }// end function

        public function get Hue() : Number
        {
            return this._h;
        }// end function

        private function add(param1:Array, param2:Array) : Array
        {
            var _loc_3:* = [];
            var _loc_4:* = 0;
            while (_loc_4 < param1.length)
            {
                
                _loc_3.push(param1[_loc_4] + param2[_loc_4]);
                _loc_4 = _loc_4 + 1;
            }
            return _loc_3;
        }// end function

        private function multiply(param1:Number, param2:Array) : Array
        {
            var _loc_4:* = NaN;
            var _loc_3:* = [];
            for each (_loc_4 in param2)
            {
                
                if (_loc_4 == 0)
                {
                    _loc_3.push(0);
                    continue;
                }
                _loc_3.push(param1 * _loc_4);
            }
            return _loc_3;
        }// end function

        private function concat(param1:Array) : void
        {
            var _loc_2:* = [];
            var _loc_3:* = this.matrix;
            _loc_2[0] = _loc_3[0] * param1[0] + _loc_3[1] * param1[5] + _loc_3[2] * param1[10];
            _loc_2[1] = _loc_3[0] * param1[1] + _loc_3[1] * param1[6] + _loc_3[2] * param1[11];
            _loc_2[2] = _loc_3[0] * param1[2] + _loc_3[1] * param1[7] + _loc_3[2] * param1[12];
            _loc_2[3] = 0;
            _loc_2[4] = 0;
            _loc_2[5] = _loc_3[5] * param1[0] + _loc_3[6] * param1[5] + _loc_3[7] * param1[10];
            _loc_2[6] = _loc_3[5] * param1[1] + _loc_3[6] * param1[6] + _loc_3[7] * param1[11];
            _loc_2[7] = _loc_3[5] * param1[2] + _loc_3[6] * param1[7] + _loc_3[7] * param1[12];
            _loc_2[8] = 0;
            _loc_2[9] = 0;
            _loc_2[10] = _loc_3[10] * param1[0] + _loc_3[11] * param1[5] + _loc_3[12] * param1[10];
            _loc_2[11] = _loc_3[10] * param1[1] + _loc_3[11] * param1[6] + _loc_3[12] * param1[11];
            _loc_2[12] = _loc_3[10] * param1[2] + _loc_3[11] * param1[7] + _loc_3[12] * param1[12];
            _loc_2[13] = 0;
            _loc_2[14] = 0;
            _loc_2[15] = 0;
            _loc_2[16] = 0;
            _loc_2[17] = 0;
            _loc_2[18] = 1;
            _loc_2[19] = 0;
            this.matrix = _loc_2;
            return;
        }// end function

        public function get Filter() : ColorMatrixFilter
        {
            return new ColorMatrixFilter(this.matrix);
        }// end function

        public static function getHue(param1:Number)
        {
            var _loc_2:* = new HueColorMatrixFilter;
            _loc_2.Hue = param1;
            return _loc_2.Filter;
        }// end function

    }
}
