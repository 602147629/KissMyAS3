package org.gif.encoder
{
    import flash.utils.*;

    public class LZWEncoder extends Object
    {
        private var imgW:int;
        private var imgH:int;
        private var pixAry:ByteArray;
        private var initCodeSize:int;
        private var remaining:int;
        private var curPixel:int;
        private var n_bits:int;
        private var maxbits:int;
        private var maxcode:int;
        private var maxmaxcode:int;
        private var htab:Array;
        private var codetab:Array;
        private var hsize:int;
        private var free_ent:int = 0;
        private var clear_flg:Boolean = false;
        private var g_init_bits:int;
        private var ClearCode:int;
        private var EOFCode:int;
        private var cur_accum:int = 0;
        private var cur_bits:int = 0;
        private var masks:Array;
        private var a_count:int;
        private var accum:ByteArray;
        private static var EOF:int = -1;
        private static var BITS:int = 12;
        private static var HSIZE:int = 5003;

        public function LZWEncoder(param1:int, param2:int, param3:ByteArray, param4:int)
        {
            this.maxbits = BITS;
            this.maxmaxcode = 1 << BITS;
            this.htab = new Array();
            this.codetab = new Array();
            this.hsize = HSIZE;
            this.masks = [0, 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 2047, 4095, 8191, 16383, 32767, 65535];
            this.accum = new ByteArray();
            this.imgW = param1;
            this.imgH = param2;
            this.pixAry = param3;
            this.initCodeSize = Math.max(2, param4);
            return;
        }// end function

        private function char_out(param1:Number, param2:ByteArray) : void
        {
            var _loc_4:* = this;
            _loc_4.a_count = this.a_count + 1;
            var _loc_3:* = this.a_count + 1;
            this.accum[_loc_3] = param1;
            if (this.a_count >= 254)
            {
                this.flush_char(param2);
            }
            return;
        }// end function

        private function cl_block(param1:ByteArray) : void
        {
            this.cl_hash(this.hsize);
            this.free_ent = this.ClearCode + 2;
            this.clear_flg = true;
            this.output(this.ClearCode, param1);
            return;
        }// end function

        private function cl_hash(param1:int) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < param1)
            {
                
                this.htab[_loc_2] = -1;
                _loc_2++;
            }
            return;
        }// end function

        public function compress(param1:int, param2:ByteArray) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            this.g_init_bits = param1;
            this.clear_flg = false;
            this.n_bits = this.g_init_bits;
            this.maxcode = this.MAXCODE(this.n_bits);
            this.ClearCode = 1 << (param1 - 1);
            this.EOFCode = this.ClearCode + 1;
            this.free_ent = this.ClearCode + 2;
            this.a_count = 0;
            _loc_6 = this.nextPixel();
            _loc_9 = 0;
            _loc_3 = this.hsize;
            while (_loc_3 < 65536)
            {
                
                _loc_9++;
                _loc_3 = _loc_3 * 2;
            }
            _loc_9 = 8 - _loc_9;
            _loc_8 = this.hsize;
            this.cl_hash(_loc_8);
            this.output(this.ClearCode, param2);
            do
            {
                
                _loc_3 = (_loc_5 << this.maxbits) + _loc_6;
                _loc_4 = _loc_5 << _loc_9 ^ _loc_6;
                if (this.htab[_loc_4] == _loc_3)
                {
                    _loc_6 = this.codetab[_loc_4];
                    ;
                }
                else if (this.htab[_loc_4] >= 0)
                {
                    _loc_7 = _loc_8 - _loc_4;
                    if (_loc_4 == 0)
                    {
                        _loc_7 = 1;
                    }
                    do
                    {
                        
                        var _loc_10:* = _loc_4 - _loc_7;
                        _loc_4 = _loc_4 - _loc_7;
                        if (_loc_10 < 0)
                        {
                            _loc_4 = _loc_4 + _loc_8;
                        }
                        if (this.htab[_loc_4] == _loc_3)
                        {
                            _loc_6 = this.codetab[_loc_4];
                            break;
                        }
                    }while (this.htab[_loc_4] >= 0)
                }
                this.output(_loc_6, param2);
                _loc_6 = _loc_5;
                if (this.free_ent < this.maxmaxcode)
                {
                    var _loc_10:* = this;
                    _loc_10.free_ent = this.free_ent + 1;
                    this.codetab[_loc_4] = this.free_ent + 1;
                    this.htab[_loc_4] = _loc_3;
                }
                else
                {
                    this.cl_block(param2);
                }
                var _loc_10:* = this.nextPixel();
                _loc_5 = this.nextPixel();
            }while (_loc_10 != EOF)
            this.output(_loc_6, param2);
            this.output(this.EOFCode, param2);
            return;
        }// end function

        public function encode(param1:ByteArray) : void
        {
            param1.writeByte(this.initCodeSize);
            this.remaining = this.imgW * this.imgH;
            this.curPixel = 0;
            this.compress((this.initCodeSize + 1), param1);
            param1.writeByte(0);
            return;
        }// end function

        private function flush_char(param1:ByteArray) : void
        {
            if (this.a_count > 0)
            {
                param1.writeByte(this.a_count);
                param1.writeBytes(this.accum, 0, this.a_count);
                this.a_count = 0;
            }
            return;
        }// end function

        private function MAXCODE(param1:int) : int
        {
            return (1 << param1) - 1;
        }// end function

        private function nextPixel() : int
        {
            if (this.remaining == 0)
            {
                return EOF;
            }
            var _loc_2:* = this;
            var _loc_3:* = this.remaining - 1;
            _loc_2.remaining = _loc_3;
            var _loc_2:* = this;
            _loc_2.curPixel = this.curPixel + 1;
            var _loc_1:* = this.pixAry[this.curPixel++];
            return _loc_1 & 255;
        }// end function

        private function output(param1:int, param2:ByteArray) : void
        {
            this.cur_accum = this.cur_accum & this.masks[this.cur_bits];
            if (this.cur_bits > 0)
            {
                this.cur_accum = this.cur_accum | param1 << this.cur_bits;
            }
            else
            {
                this.cur_accum = param1;
            }
            this.cur_bits = this.cur_bits + this.n_bits;
            while (this.cur_bits >= 8)
            {
                
                this.char_out(this.cur_accum & 255, param2);
                this.cur_accum = this.cur_accum >> 8;
                this.cur_bits = this.cur_bits - 8;
            }
            if (this.free_ent > this.maxcode || this.clear_flg)
            {
                if (this.clear_flg)
                {
                    var _loc_3:* = this.g_init_bits;
                    this.n_bits = this.g_init_bits;
                    this.maxcode = this.MAXCODE(_loc_3);
                    this.clear_flg = false;
                }
                else
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this.n_bits + 1;
                    _loc_3.n_bits = _loc_4;
                    if (this.n_bits == this.maxbits)
                    {
                        this.maxcode = this.maxmaxcode;
                    }
                    else
                    {
                        this.maxcode = this.MAXCODE(this.n_bits);
                    }
                }
            }
            if (param1 == this.EOFCode)
            {
                while (this.cur_bits > 0)
                {
                    
                    this.char_out(this.cur_accum & 255, param2);
                    this.cur_accum = this.cur_accum >> 8;
                    this.cur_bits = this.cur_bits - 8;
                }
                this.flush_char(param2);
            }
            return;
        }// end function

    }
}
