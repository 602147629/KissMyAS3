package utility
{

    public class ColorARGB extends Object
    {
        private var _r:int;
        private var _g:int;
        private var _b:int;
        private var _a:int;

        public function ColorARGB()
        {
            return;
        }// end function

        public function get r() : int
        {
            return this._r;
        }// end function

        public function set r(param1:int) : void
        {
            this._r = param1;
            return;
        }// end function

        public function get g() : int
        {
            return this._g;
        }// end function

        public function set g(param1:int) : void
        {
            this._g = param1;
            return;
        }// end function

        public function get b() : int
        {
            return this._b;
        }// end function

        public function set b(param1:int) : void
        {
            this._b = param1;
            return;
        }// end function

        public function get a() : int
        {
            return this._a;
        }// end function

        public function set a(param1:int) : void
        {
            this._a = param1;
            return;
        }// end function

        public function setRGB(param1:int, param2:int, param3:int) : void
        {
            this._r = param1;
            this._g = param2;
            this._b = param3;
            return;
        }// end function

        public function ARGBtoHex(param1:int, param2:int, param3:int, param4:int) : void
        {
            this._a = param1;
            this._r = param2;
            this._g = param3;
            this._b = param4;
            return;
        }// end function

        public function getRGB() : uint
        {
            return this._r << 16 | this._g << 8 | this._b;
        }// end function

        public function getARGB() : uint
        {
            return this._a << 24 | this._r << 16 | this._g << 8 | this._b;
        }// end function

        public static function RGBtoHex(param1:int, param2:int, param3:int) : uint
        {
            return param1 << 16 | param2 << 8 | param3;
        }// end function

        public static function ARGBtoHex(param1:int, param2:int, param3:int, param4:int) : uint
        {
            return param1 << 24 | param2 << 16 | param3 << 8 | param4;
        }// end function

    }
}
