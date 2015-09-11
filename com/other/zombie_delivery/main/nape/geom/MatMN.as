package nape.geom
{
    import flash.*;
    import zpp_nape.geom.*;

    final public class MatMN extends Object
    {
        public var zpp_inner:ZPP_MatMN;

        public function MatMN(param1:int = 0, param2:int = 0) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            if (param1 > 0)
            {
            }
            if (param2 <= 0)
            {
                throw "Error: MatMN::dimensions cannot be < 1";
            }
            zpp_inner = new ZPP_MatMN(param1, param2);
            zpp_inner.outer = this;
            return;
        }// end function

        public function x(param1:int, param2:int) : Number
        {
            if (param1 >= 0)
            {
            }
            if (param2 >= 0)
            {
            }
            if (param1 < zpp_inner.m)
            {
            }
            if (param2 >= zpp_inner.n)
            {
                throw "Error: MatMN indices out of range";
            }
            return zpp_inner.x[param1 * zpp_inner.n + param2];
        }// end function

        public function transpose() : MatMN
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = NaN;
            var _loc_1:* = new MatMN(zpp_inner.n, zpp_inner.m);
            var _loc_2:* = 0;
            var _loc_3:* = zpp_inner.m;
            while (_loc_2 < _loc_3)
            {
                
                _loc_2++;
                _loc_4 = _loc_2;
                _loc_5 = 0;
                _loc_6 = zpp_inner.n;
                while (_loc_5 < _loc_6)
                {
                    
                    _loc_5++;
                    _loc_7 = _loc_5;
                    if (_loc_4 >= 0)
                    {
                    }
                    if (_loc_7 >= 0)
                    {
                    }
                    if (_loc_4 < zpp_inner.m)
                    {
                    }
                    if (_loc_7 >= zpp_inner.n)
                    {
                        throw "Error: MatMN indices out of range";
                    }
                    _loc_8 = zpp_inner.x[_loc_4 * zpp_inner.n + _loc_7];
                    if (_loc_7 >= 0)
                    {
                    }
                    if (_loc_4 >= 0)
                    {
                    }
                    if (_loc_7 < _loc_1.zpp_inner.m)
                    {
                    }
                    if (_loc_4 >= _loc_1.zpp_inner.n)
                    {
                        throw "Error: MatMN indices out of range";
                    }
                    _loc_1.zpp_inner.x[_loc_7 * _loc_1.zpp_inner.n + _loc_4] = _loc_8;
                }
            }
            return _loc_1;
        }// end function

        public function toString() : String
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_1:* = "{ ";
            var _loc_2:* = true;
            var _loc_3:* = 0;
            var _loc_4:* = zpp_inner.m;
            while (_loc_3 < _loc_4)
            {
                
                _loc_3++;
                _loc_5 = _loc_3;
                if (!_loc_2)
                {
                    _loc_1 = _loc_1 + "; ";
                }
                _loc_2 = false;
                _loc_6 = 0;
                _loc_7 = zpp_inner.n;
                while (_loc_6 < _loc_7)
                {
                    
                    _loc_6++;
                    _loc_8 = _loc_6;
                    if (_loc_5 >= 0)
                    {
                    }
                    if (_loc_8 >= 0)
                    {
                    }
                    if (_loc_5 < zpp_inner.m)
                    {
                    }
                    if (_loc_8 >= zpp_inner.n)
                    {
                        throw "Error: MatMN indices out of range";
                    }
                    _loc_1 = _loc_1 + (zpp_inner.x[_loc_5 * zpp_inner.n + _loc_8] + " ");
                }
            }
            _loc_1 = _loc_1 + "}";
            return _loc_1;
        }// end function

        public function setx(param1:int, param2:int, param3:Number) : Number
        {
            if (param1 >= 0)
            {
            }
            if (param2 >= 0)
            {
            }
            if (param1 < zpp_inner.m)
            {
            }
            if (param2 >= zpp_inner.n)
            {
                throw "Error: MatMN indices out of range";
            }
            var _loc_4:* = param3;
            zpp_inner.x[param1 * zpp_inner.n + param2] = param3;
            return _loc_4;
        }// end function

        public function mul(param1:MatMN) : MatMN
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_2:* = param1;
            if (zpp_inner.n != _loc_2.zpp_inner.m)
            {
                throw "Error: Matrix dimensions aren\'t compatible";
            }
            var _loc_3:* = new MatMN(zpp_inner.m, _loc_2.zpp_inner.n);
            var _loc_4:* = 0;
            var _loc_5:* = zpp_inner.m;
            while (_loc_4 < _loc_5)
            {
                
                _loc_4++;
                _loc_6 = _loc_4;
                _loc_7 = 0;
                _loc_8 = _loc_2.zpp_inner.n;
                while (_loc_7 < _loc_8)
                {
                    
                    _loc_7++;
                    _loc_9 = _loc_7;
                    _loc_10 = 0;
                    _loc_11 = 0;
                    _loc_12 = zpp_inner.n;
                    while (_loc_11 < _loc_12)
                    {
                        
                        _loc_11++;
                        _loc_13 = _loc_11;
                        if (_loc_6 >= 0)
                        {
                        }
                        if (_loc_13 >= 0)
                        {
                        }
                        if (_loc_6 < zpp_inner.m)
                        {
                        }
                        if (_loc_13 >= zpp_inner.n)
                        {
                            throw "Error: MatMN indices out of range";
                        }
                        if (_loc_13 >= 0)
                        {
                        }
                        if (_loc_9 >= 0)
                        {
                        }
                        if (_loc_13 < _loc_2.zpp_inner.m)
                        {
                        }
                        if (_loc_9 >= _loc_2.zpp_inner.n)
                        {
                            throw "Error: MatMN indices out of range";
                        }
                        _loc_10 = _loc_10 + zpp_inner.x[_loc_6 * zpp_inner.n + _loc_13] * _loc_2.zpp_inner.x[_loc_13 * _loc_2.zpp_inner.n + _loc_9];
                    }
                    if (_loc_6 >= 0)
                    {
                    }
                    if (_loc_9 >= 0)
                    {
                    }
                    if (_loc_6 < _loc_3.zpp_inner.m)
                    {
                    }
                    if (_loc_9 >= _loc_3.zpp_inner.n)
                    {
                        throw "Error: MatMN indices out of range";
                    }
                    _loc_3.zpp_inner.x[_loc_6 * _loc_3.zpp_inner.n + _loc_9] = _loc_10;
                }
            }
            return _loc_3;
        }// end function

        public function get_rows() : int
        {
            return zpp_inner.m;
        }// end function

        public function get_cols() : int
        {
            return zpp_inner.n;
        }// end function

    }
}
