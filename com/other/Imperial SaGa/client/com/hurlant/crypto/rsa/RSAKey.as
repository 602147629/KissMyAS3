package com.hurlant.crypto.rsa
{
    import com.hurlant.crypto.prng.*;
    import com.hurlant.math.*;
    import com.hurlant.util.*;
    import flash.utils.*;

    public class RSAKey extends Object
    {
        public var dmp1:BigInteger;
        protected var canDecrypt:Boolean;
        public var d:BigInteger;
        public var e:int;
        public var dmq1:BigInteger;
        public var n:BigInteger;
        public var p:BigInteger;
        public var q:BigInteger;
        protected var canEncrypt:Boolean;
        public var coeff:BigInteger;

        public function RSAKey(param1:BigInteger, param2:int, param3:BigInteger = null, param4:BigInteger = null, param5:BigInteger = null, param6:BigInteger = null, param7:BigInteger = null, param8:BigInteger = null)
        {
            this.n = param1;
            this.e = param2;
            this.d = param3;
            this.p = param4;
            this.q = param5;
            this.dmp1 = param6;
            this.dmq1 = param7;
            this.coeff = param8;
            canEncrypt = n != null && e != 0;
            canDecrypt = canEncrypt && d != null;
            return;
        }// end function

        public function verify(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void
        {
            _decrypt(doPublic, param1, param2, param3, param4, 1);
            return;
        }// end function

        public function dump() : String
        {
            var _loc_1:* = null;
            _loc_1 = "N=" + n.toString(16) + "\n" + "E=" + e.toString(16) + "\n";
            if (canDecrypt)
            {
                _loc_1 = _loc_1 + ("D=" + d.toString(16) + "\n");
                if (p != null && q != null)
                {
                    _loc_1 = _loc_1 + ("P=" + p.toString(16) + "\n");
                    _loc_1 = _loc_1 + ("Q=" + q.toString(16) + "\n");
                    _loc_1 = _loc_1 + ("DMP1=" + dmp1.toString(16) + "\n");
                    _loc_1 = _loc_1 + ("DMQ1=" + dmq1.toString(16) + "\n");
                    _loc_1 = _loc_1 + ("IQMP=" + coeff.toString(16) + "\n");
                }
            }
            return _loc_1;
        }// end function

        protected function doPrivate2(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (p == null && q == null)
            {
                return param1.modPow(d, n);
            }
            _loc_2 = param1.mod(p).modPow(dmp1, p);
            _loc_3 = param1.mod(q).modPow(dmq1, q);
            while (_loc_2.compareTo(_loc_3) < 0)
            {
                
                _loc_2 = _loc_2.add(p);
            }
            _loc_4 = _loc_2.subtract(_loc_3).multiply(coeff).mod(p).multiply(q).add(_loc_3);
            return _loc_4;
        }// end function

        public function decrypt(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void
        {
            _decrypt(doPrivate2, param1, param2, param3, param4, 2);
            return;
        }// end function

        private function _decrypt(param1:Function, param2:ByteArray, param3:ByteArray, param4:uint, param5:Function, param6:int) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            if (param5 == null)
            {
                param5 = pkcs1unpad;
            }
            if (param2.position >= param2.length)
            {
                param2.position = 0;
            }
            _loc_7 = getBlockSize();
            _loc_8 = param2.position + param4;
            while (param2.position < _loc_8)
            {
                
                _loc_9 = new BigInteger(param2, param4);
                _loc_10 = this.param1(_loc_9);
                _loc_11 = this.param5(_loc_10, _loc_7);
                param3.writeBytes(_loc_11);
            }
            return;
        }// end function

        protected function doPublic(param1:BigInteger) : BigInteger
        {
            return param1.modPowInt(e, n);
        }// end function

        public function dispose() : void
        {
            e = 0;
            n.dispose();
            n = null;
            Memory.gc();
            return;
        }// end function

        private function _encrypt(param1:Function, param2:ByteArray, param3:ByteArray, param4:uint, param5:Function, param6:int) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (param5 == null)
            {
                param5 = pkcs1pad;
            }
            if (param2.position >= param2.length)
            {
                param2.position = 0;
            }
            _loc_7 = getBlockSize();
            _loc_8 = param2.position + param4;
            while (param2.position < _loc_8)
            {
                
                _loc_9 = new BigInteger(this.param5(param2, _loc_8, _loc_7, param6), _loc_7);
                _loc_10 = this.param1(_loc_9);
                _loc_10.toArray(param3);
            }
            return;
        }// end function

        private function rawpad(param1:ByteArray, param2:int, param3:uint) : ByteArray
        {
            return param1;
        }// end function

        public function encrypt(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void
        {
            _encrypt(doPublic, param1, param2, param3, param4, 2);
            return;
        }// end function

        private function pkcs1pad(param1:ByteArray, param2:int, param3:uint, param4:uint = 2) : ByteArray
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            _loc_5 = new ByteArray();
            _loc_6 = param1.position;
            param2 = Math.min(param2, param1.length, _loc_6 + param3 - 11);
            param1.position = param2;
            _loc_7 = param2 - 1;
            while (_loc_7 >= _loc_6 && --param3 > 11)
            {
                
                _loc_5[--param3] = param1[_loc_7--];
            }
            _loc_5[--_loc_3] = 0;
            _loc_8 = new Random();
            while (_loc_3 > 2)
            {
                
                _loc_9 = 0;
                while (_loc_9 == 0)
                {
                    
                    _loc_9 = param4 == 2 ? (_loc_8.nextByte()) : (255);
                }
                _loc_3 = --_loc_3 - 1;
                var _loc_11:* = --_loc_3 - 1;
                _loc_5[--_loc_3 - 1] = _loc_9;
            }
            _loc_5[--_loc_3] = param4;
            _loc_3 = --_loc_3 - 1;
            var _loc_12:* = --_loc_3 - 1;
            _loc_5[--_loc_3 - 1] = 0;
            return _loc_5;
        }// end function

        private function pkcs1unpad(param1:BigInteger, param2:uint, param3:uint = 2) : ByteArray
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            _loc_4 = param1.toByteArray();
            _loc_5 = new ByteArray();
            _loc_6 = 0;
            while (_loc_6 < _loc_4.length && _loc_4[_loc_6] == 0)
            {
                
                _loc_6++;
            }
            if (_loc_4.length - _loc_6 != (param2 - 1) || _loc_4[_loc_6] > 2)
            {
                trace("PKCS#1 unpad: i=" + _loc_6 + ", expected b[i]==[0,1,2], got b[i]=" + _loc_4[_loc_6].toString(16));
                return null;
            }
            _loc_6++;
            while (_loc_4[_loc_6] != 0)
            {
                
                if (++_loc_6 >= _loc_4.length)
                {
                    trace("PKCS#1 unpad: i=" + ++_loc_6 + ", b[i-1]!=0 (=" + _loc_4[(_loc_6 - 1)].toString(16) + ")");
                    return null;
                }
            }
            while (++_loc_6 < _loc_4.length)
            {
                
                _loc_5.writeByte(_loc_4[_loc_6]);
            }
            _loc_5.position = 0;
            return _loc_5;
        }// end function

        public function getBlockSize() : uint
        {
            return (n.bitLength() + 7) / 8;
        }// end function

        public function toString() : String
        {
            return "rsa";
        }// end function

        public function sign(param1:ByteArray, param2:ByteArray, param3:uint, param4:Function = null) : void
        {
            _encrypt(doPrivate2, param1, param2, param3, param4, 1);
            return;
        }// end function

        protected function doPrivate(param1:BigInteger) : BigInteger
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (p == null || q == null)
            {
                return param1.modPow(d, n);
            }
            _loc_2 = param1.mod(p).modPow(dmp1, p);
            _loc_3 = param1.mod(q).modPow(dmq1, q);
            while (_loc_2.compareTo(_loc_3) < 0)
            {
                
                _loc_2 = _loc_2.add(p);
            }
            return _loc_2.subtract(_loc_3).multiply(coeff).mod(p).multiply(q).add(_loc_3);
        }// end function

        static function bigRandom(param1:int, param2:Random) : BigInteger
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1 < 2)
            {
                return BigInteger.nbv(1);
            }
            _loc_3 = new ByteArray();
            param2.nextBytes(_loc_3, param1 >> 3);
            _loc_3.position = 0;
            _loc_4 = new BigInteger(_loc_3);
            _loc_4.primify(param1, 1);
            return _loc_4;
        }// end function

        public static function parsePublicKey(param1:String, param2:String) : RSAKey
        {
            return new RSAKey(new BigInteger(param1, 16), parseInt(param2, 16));
        }// end function

        public static function generate(param1:uint, param2:String) : RSAKey
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            _loc_3 = new Random();
            _loc_4 = param1 >> 1;
            _loc_5 = new RSAKey(null, 0, null);
            _loc_5.e = parseInt(param2, 16);
            _loc_6 = new BigInteger(param2, 16);
            while (true)
            {
                
                while (true)
                {
                    
                    _loc_5.p = bigRandom(param1 - _loc_4, _loc_3);
                    if (_loc_5.p.subtract(BigInteger.ONE).gcd(_loc_6).compareTo(BigInteger.ONE) == 0 && _loc_5.p.isProbablePrime(10))
                    {
                        break;
                    }
                }
                while (true)
                {
                    
                    _loc_5.q = bigRandom(_loc_4, _loc_3);
                    if (_loc_5.q.subtract(BigInteger.ONE).gcd(_loc_6).compareTo(BigInteger.ONE) == 0 && _loc_5.q.isProbablePrime(10))
                    {
                        break;
                    }
                }
                if (_loc_5.p.compareTo(_loc_5.q) <= 0)
                {
                    _loc_10 = _loc_5.p;
                    _loc_5.p = _loc_5.q;
                    _loc_5.q = _loc_10;
                }
                _loc_7 = _loc_5.p.subtract(BigInteger.ONE);
                _loc_8 = _loc_5.q.subtract(BigInteger.ONE);
                _loc_9 = _loc_7.multiply(_loc_8);
                if (_loc_9.gcd(_loc_6).compareTo(BigInteger.ONE) == 0)
                {
                    _loc_5.n = _loc_5.p.multiply(_loc_5.q);
                    _loc_5.d = _loc_6.modInverse(_loc_9);
                    _loc_5.dmp1 = _loc_5.d.mod(_loc_7);
                    _loc_5.dmq1 = _loc_5.d.mod(_loc_8);
                    _loc_5.coeff = _loc_5.q.modInverse(_loc_5.p);
                    break;
                }
            }
            return _loc_5;
        }// end function

        public static function parsePrivateKey(param1:String, param2:String, param3:String, param4:String = null, param5:String = null, param6:String = null, param7:String = null, param8:String = null) : RSAKey
        {
            if (param4 == null)
            {
                return new RSAKey(new BigInteger(param1, 16), parseInt(param2, 16), new BigInteger(param3, 16));
            }
            return new RSAKey(new BigInteger(param1, 16), parseInt(param2, 16), new BigInteger(param3, 16), new BigInteger(param4, 16), new BigInteger(param5, 16), new BigInteger(param6, 16), new BigInteger(param7), new BigInteger(param8));
        }// end function

    }
}
