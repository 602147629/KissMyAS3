package org.gif.encoder
{
    import flash.utils.*;

    public class NeuQuant extends Object
    {
        private var alphadec:int;
        private var thepicture:ByteArray;
        private var lengthcount:int;
        private var samplefac:int;
        private var network:Array;
        protected var netindex:Array;
        private var bias:Array;
        private var freq:Array;
        private var radpower:Array;
        private static var netsize:int = 256;
        private static var prime1:int = 499;
        private static var prime2:int = 491;
        private static var prime3:int = 487;
        private static var prime4:int = 503;
        private static var minpicturebytes:int = 3 * prime4;
        private static var maxnetpos:int = netsize - 1;
        private static var netbiasshift:int = 4;
        private static var ncycles:int = 100;
        private static var intbiasshift:int = 16;
        private static var intbias:int = 1 << intbiasshift;
        private static var gammashift:int = 10;
        private static var gamma:int = 1 << gammashift;
        private static var betashift:int = 10;
        private static var beta:int = intbias >> betashift;
        private static var betagamma:int = intbias << gammashift - betashift;
        private static var initrad:int = netsize >> 3;
        private static var radiusbiasshift:int = 6;
        private static var radiusbias:int = 1 << radiusbiasshift;
        private static var initradius:int = initrad * radiusbias;
        private static var radiusdec:int = 30;
        private static var alphabiasshift:int = 10;
        private static var initalpha:int = 1 << alphabiasshift;
        private static var radbiasshift:int = 8;
        private static var radbias:int = 1 << radbiasshift;
        private static var alpharadbshift:int = alphabiasshift + radbiasshift;
        private static var alpharadbias:int = 1 << alpharadbshift;

        public function NeuQuant(param1:ByteArray, param2:int, param3:int)
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            this.netindex = new Array();
            this.bias = new Array();
            this.freq = new Array();
            this.radpower = new Array();
            this.thepicture = param1;
            this.lengthcount = param2;
            this.samplefac = param3;
            this.network = new Array(netsize);
            _loc_4 = 0;
            while (_loc_4 < netsize)
            {
                
                this.network[_loc_4] = new Array(4);
                _loc_5 = this.network[_loc_4];
                var _loc_6:* = (_loc_4 << netbiasshift + 8) / netsize;
                _loc_5[2] = (_loc_4 << netbiasshift + 8) / netsize;
                _loc_5[1] = _loc_6;
                _loc_5[0] = _loc_6;
                this.freq[_loc_4] = intbias / netsize;
                this.bias[_loc_4] = 0;
                _loc_4++;
            }
            return;
        }// end function

        private function colorMap() : ByteArray
        {
            var _loc_6:* = 0;
            var _loc_1:* = new ByteArray();
            var _loc_2:* = new Array(netsize);
            var _loc_3:* = 0;
            while (_loc_3 < netsize)
            {
                
                _loc_2[this.network[_loc_3][3]] = _loc_3;
                _loc_3++;
            }
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < netsize)
            {
                
                _loc_6 = _loc_2[_loc_5];
                _loc_1[++_loc_4] = this.network[_loc_6][0];
                _loc_1[++_loc_4] = this.network[_loc_6][1];
                _loc_1[++_loc_4] = this.network[_loc_6][2];
                _loc_5++;
            }
            return _loc_1;
        }// end function

        private function inxbuild() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            _loc_7 = 0;
            _loc_8 = 0;
            _loc_1 = 0;
            while (_loc_1 < netsize)
            {
                
                _loc_5 = this.network[_loc_1];
                _loc_3 = _loc_1;
                _loc_4 = _loc_5[1];
                _loc_2 = _loc_1 + 1;
                while (_loc_2 < netsize)
                {
                    
                    _loc_6 = this.network[_loc_2];
                    if (_loc_6[1] < _loc_4)
                    {
                        _loc_3 = _loc_2;
                        _loc_4 = _loc_6[1];
                    }
                    _loc_2++;
                }
                _loc_6 = this.network[_loc_3];
                if (_loc_1 != _loc_3)
                {
                    _loc_2 = _loc_6[0];
                    _loc_6[0] = _loc_5[0];
                    _loc_5[0] = _loc_2;
                    _loc_2 = _loc_6[1];
                    _loc_6[1] = _loc_5[1];
                    _loc_5[1] = _loc_2;
                    _loc_2 = _loc_6[2];
                    _loc_6[2] = _loc_5[2];
                    _loc_5[2] = _loc_2;
                    _loc_2 = _loc_6[3];
                    _loc_6[3] = _loc_5[3];
                    _loc_5[3] = _loc_2;
                }
                if (_loc_4 != _loc_7)
                {
                    this.netindex[_loc_7] = _loc_8 + _loc_1 >> 1;
                    _loc_2 = _loc_7 + 1;
                    while (_loc_2 < _loc_4)
                    {
                        
                        this.netindex[_loc_2] = _loc_1;
                        _loc_2++;
                    }
                    _loc_7 = _loc_4;
                    _loc_8 = _loc_1;
                }
                _loc_1++;
            }
            this.netindex[_loc_7] = _loc_8 + maxnetpos >> 1;
            _loc_2 = _loc_7 + 1;
            while (_loc_2 < 256)
            {
                
                this.netindex[_loc_2] = maxnetpos;
                _loc_2++;
            }
            return;
        }// end function

        private function learn() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            if (this.lengthcount < minpicturebytes)
            {
                this.samplefac = 1;
            }
            this.alphadec = 30 + (this.samplefac - 1) / 3;
            _loc_12 = this.thepicture;
            _loc_13 = 0;
            _loc_14 = this.lengthcount;
            _loc_11 = this.lengthcount / (3 * this.samplefac);
            _loc_10 = _loc_11 / ncycles;
            _loc_8 = initalpha;
            _loc_6 = initradius;
            _loc_7 = _loc_6 >> radiusbiasshift;
            if (_loc_7 <= 1)
            {
                _loc_7 = 0;
            }
            _loc_1 = 0;
            while (_loc_1 < _loc_7)
            {
                
                this.radpower[_loc_1] = _loc_8 * ((_loc_7 * _loc_7 - _loc_1 * _loc_1) * radbias / (_loc_7 * _loc_7));
                _loc_1++;
            }
            if (this.lengthcount < minpicturebytes)
            {
                _loc_9 = 3;
            }
            else if (this.lengthcount % prime1 != 0)
            {
                _loc_9 = 3 * prime1;
            }
            else if (this.lengthcount % prime2 != 0)
            {
                _loc_9 = 3 * prime2;
            }
            else if (this.lengthcount % prime3 != 0)
            {
                _loc_9 = 3 * prime3;
            }
            else
            {
                _loc_9 = 3 * prime4;
            }
            _loc_1 = 0;
            while (_loc_1 < _loc_11)
            {
                
                _loc_3 = (_loc_12[_loc_13 + 0] & 255) << netbiasshift;
                _loc_4 = (_loc_12[(_loc_13 + 1)] & 255) << netbiasshift;
                _loc_5 = (_loc_12[_loc_13 + 2] & 255) << netbiasshift;
                _loc_2 = this.contest(_loc_3, _loc_4, _loc_5);
                this.altersingle(_loc_8, _loc_2, _loc_3, _loc_4, _loc_5);
                if (_loc_7 != 0)
                {
                    this.alterneigh(_loc_7, _loc_2, _loc_3, _loc_4, _loc_5);
                }
                _loc_13 = _loc_13 + _loc_9;
                if (_loc_13 >= _loc_14)
                {
                    _loc_13 = _loc_13 - this.lengthcount;
                }
                _loc_1++;
                if (_loc_10 == 0)
                {
                    _loc_10 = 1;
                }
                if (_loc_1 % _loc_10 == 0)
                {
                    _loc_8 = _loc_8 - _loc_8 / this.alphadec;
                    _loc_6 = _loc_6 - _loc_6 / radiusdec;
                    _loc_7 = _loc_6 >> radiusbiasshift;
                    if (_loc_7 <= 1)
                    {
                        _loc_7 = 0;
                    }
                    _loc_2 = 0;
                    while (_loc_2 < _loc_7)
                    {
                        
                        this.radpower[_loc_2] = _loc_8 * ((_loc_7 * _loc_7 - _loc_2 * _loc_2) * radbias / (_loc_7 * _loc_7));
                        _loc_2++;
                    }
                }
            }
            return;
        }// end function

        public function map(param1:int, param2:int, param3:int) : int
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            _loc_8 = 1000;
            _loc_10 = -1;
            _loc_4 = this.netindex[param2];
            _loc_5 = _loc_4 - 1;
            while (_loc_4 < netsize || _loc_5 >= 0)
            {
                
                if (_loc_4 < netsize)
                {
                    _loc_9 = this.network[_loc_4];
                    _loc_6 = _loc_9[1] - param2;
                    if (_loc_6 >= _loc_8)
                    {
                        _loc_4 = netsize;
                    }
                    else
                    {
                        _loc_4++;
                        if (_loc_6 < 0)
                        {
                            _loc_6 = -_loc_6;
                        }
                        _loc_7 = _loc_9[0] - param1;
                        if (_loc_7 < 0)
                        {
                            _loc_7 = -_loc_7;
                        }
                        _loc_6 = _loc_6 + _loc_7;
                        if (_loc_6 < _loc_8)
                        {
                            _loc_7 = _loc_9[2] - param3;
                            if (_loc_7 < 0)
                            {
                                _loc_7 = -_loc_7;
                            }
                            _loc_6 = _loc_6 + _loc_7;
                            if (_loc_6 < _loc_8)
                            {
                                _loc_8 = _loc_6;
                                _loc_10 = _loc_9[3];
                            }
                        }
                    }
                }
                if (_loc_5 >= 0)
                {
                    _loc_9 = this.network[_loc_5];
                    _loc_6 = param2 - _loc_9[1];
                    if (_loc_6 >= _loc_8)
                    {
                        _loc_5 = -1;
                        continue;
                    }
                    _loc_5 = _loc_5 - 1;
                    if (_loc_6 < 0)
                    {
                        _loc_6 = -_loc_6;
                    }
                    _loc_7 = _loc_9[0] - param1;
                    if (_loc_7 < 0)
                    {
                        _loc_7 = -_loc_7;
                    }
                    _loc_6 = _loc_6 + _loc_7;
                    if (_loc_6 < _loc_8)
                    {
                        _loc_7 = _loc_9[2] - param3;
                        if (_loc_7 < 0)
                        {
                            _loc_7 = -_loc_7;
                        }
                        _loc_6 = _loc_6 + _loc_7;
                        if (_loc_6 < _loc_8)
                        {
                            _loc_8 = _loc_6;
                            _loc_10 = _loc_9[3];
                        }
                    }
                }
            }
            return _loc_10;
        }// end function

        public function process() : ByteArray
        {
            this.learn();
            this.unbiasnet();
            this.inxbuild();
            return this.colorMap();
        }// end function

        private function unbiasnet() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            _loc_1 = 0;
            while (_loc_1 < netsize)
            {
                
                this.network[_loc_1][0] = this.network[_loc_1][0] >> netbiasshift;
                this.network[_loc_1][1] = this.network[_loc_1][1] >> netbiasshift;
                this.network[_loc_1][2] = this.network[_loc_1][2] >> netbiasshift;
                this.network[_loc_1][3] = _loc_1;
                _loc_1++;
            }
            return;
        }// end function

        private function alterneigh(param1:int, param2:int, param3:int, param4:int, param5:int) : void
        {
            var j:int;
            var k:int;
            var lo:int;
            var hi:int;
            var a:int;
            var m:int;
            var p:Array;
            var rad:* = param1;
            var i:* = param2;
            var b:* = param3;
            var g:* = param4;
            var r:* = param5;
            lo = i - rad;
            if (lo < -1)
            {
                lo;
            }
            hi = i + rad;
            if (hi > netsize)
            {
                hi = netsize;
            }
            j = (i + 1);
            k = (i - 1);
            m;
            do
            {
                
                m = (m + 1);
                a = this.radpower[m];
                if (j < hi)
                {
                    j = (j + 1);
                    p = this.network[j];
                    try
                    {
                        p[0] = p[0] - a * (p[0] - b) / alpharadbias;
                        p[1] = p[1] - a * (p[1] - g) / alpharadbias;
                        p[2] = p[2] - a * (p[2] - r) / alpharadbias;
                    }
                    catch (e:Error)
                    {
                    }
                }
                if (k > lo)
                {
                    k = (k - 1);
                    p = this.network[k];
                    try
                    {
                        p[0] = p[0] - a * (p[0] - b) / alpharadbias;
                        p[1] = p[1] - a * (p[1] - g) / alpharadbias;
                        p[2] = p[2] - a * (p[2] - r) / alpharadbias;
                    }
                    catch (e:Error)
                    {
                    }
                }
            }while (j < hi || k > lo)
            return;
        }// end function

        private function altersingle(param1:int, param2:int, param3:int, param4:int, param5:int) : void
        {
            var _loc_6:* = this.network[param2];
            this.network[param2][0] = _loc_6[0] - param1 * (_loc_6[0] - param3) / initalpha;
            _loc_6[1] = _loc_6[1] - param1 * (_loc_6[1] - param4) / initalpha;
            _loc_6[2] = _loc_6[2] - param1 * (_loc_6[2] - param5) / initalpha;
            return;
        }// end function

        private function contest(param1:int, param2:int, param3:int) : int
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            _loc_11 = ~(1 << 31);
            _loc_12 = _loc_11;
            _loc_9 = -1;
            _loc_10 = _loc_9;
            _loc_4 = 0;
            while (_loc_4 < netsize)
            {
                
                _loc_13 = this.network[_loc_4];
                _loc_5 = _loc_13[0] - param1;
                if (_loc_5 < 0)
                {
                    _loc_5 = -_loc_5;
                }
                _loc_6 = _loc_13[1] - param2;
                if (_loc_6 < 0)
                {
                    _loc_6 = -_loc_6;
                }
                _loc_5 = _loc_5 + _loc_6;
                _loc_6 = _loc_13[2] - param3;
                if (_loc_6 < 0)
                {
                    _loc_6 = -_loc_6;
                }
                _loc_5 = _loc_5 + _loc_6;
                if (_loc_5 < _loc_11)
                {
                    _loc_11 = _loc_5;
                    _loc_9 = _loc_4;
                }
                _loc_7 = _loc_5 - (this.bias[_loc_4] >> intbiasshift - netbiasshift);
                if (_loc_7 < _loc_12)
                {
                    _loc_12 = _loc_7;
                    _loc_10 = _loc_4;
                }
                _loc_8 = this.freq[_loc_4] >> betashift;
                this.freq[_loc_4] = this.freq[_loc_4] - _loc_8;
                this.bias[_loc_4] = this.bias[_loc_4] + (_loc_8 << gammashift);
                _loc_4++;
            }
            this.freq[_loc_9] = this.freq[_loc_9] + beta;
            this.bias[_loc_9] = this.bias[_loc_9] - betagamma;
            return _loc_10;
        }// end function

    }
}
