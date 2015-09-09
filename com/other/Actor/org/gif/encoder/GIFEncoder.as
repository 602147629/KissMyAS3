package org.gif.encoder
{
    import flash.display.*;
    import flash.utils.*;

    public class GIFEncoder extends Object
    {
        private var width:int;
        private var height:int;
        private var transparent:Object = null;
        private var transIndex:int;
        private var repeat:int = -1;
        private var delay:int = 0;
        private var started:Boolean = false;
        private var out:ByteArray;
        private var image:Bitmap;
        private var pixels:ByteArray;
        private var indexedPixels:ByteArray;
        private var colorDepth:int;
        private var colorTab:ByteArray;
        private var usedEntry:Array;
        private var palSize:int = 7;
        private var dispose:int = -1;
        private var closeStream:Boolean = false;
        private var firstFrame:Boolean = true;
        private var sizeSet:Boolean = false;
        private var sample:int = 10;

        public function GIFEncoder()
        {
            this.usedEntry = new Array();
            return;
        }// end function

        public function setDelay(param1:int) : void
        {
            this.delay = Math.round(param1 / 10);
            return;
        }// end function

        public function setDispose(param1:int) : void
        {
            if (param1 >= 0)
            {
                this.dispose = param1;
            }
            return;
        }// end function

        public function setRepeat(param1:int) : void
        {
            if (param1 >= 0)
            {
                this.repeat = param1;
            }
            return;
        }// end function

        public function setTransparent(param1:Number) : void
        {
            this.transparent = param1;
            return;
        }// end function

        public function addFrame(param1:BitmapData) : Boolean
        {
            var im:* = param1;
            if (im == null || !this.started || this.out == null)
            {
                throw new Error("Please call start method before calling addFrame");
            }
            var ok:Boolean;
            try
            {
                this.image = new Bitmap(im);
                if (!this.sizeSet)
                {
                    this.setSize(this.image.width, this.image.height);
                }
                this.getImagePixels();
                this.analyzePixels();
                if (this.firstFrame)
                {
                    this.writeLSD();
                    this.writePalette();
                    if (this.repeat >= 0)
                    {
                        this.writeNetscapeExt();
                    }
                }
                this.writeGraphicCtrlExt();
                this.writeImageDesc();
                if (!this.firstFrame)
                {
                    this.writePalette();
                }
                this.writePixels();
                this.firstFrame = false;
            }
            catch (e:Error)
            {
                ok;
            }
            return ok;
        }// end function

        public function finish() : Boolean
        {
            if (!this.started)
            {
                return false;
            }
            var ok:Boolean;
            this.started = false;
            try
            {
                this.out.writeByte(59);
            }
            catch (e:Error)
            {
                ok;
            }
            return ok;
        }// end function

        private function reset() : void
        {
            this.transIndex = 0;
            this.image = null;
            this.pixels = null;
            this.indexedPixels = null;
            this.colorTab = null;
            this.closeStream = false;
            this.firstFrame = true;
            return;
        }// end function

        public function setFrameRate(param1:Number) : void
        {
            if (param1 != 15)
            {
                this.delay = Math.round(100 / param1);
            }
            return;
        }// end function

        public function setQuality(param1:int) : void
        {
            if (param1 < 1)
            {
                param1 = 1;
            }
            this.sample = param1;
            return;
        }// end function

        private function setSize(param1:int, param2:int) : void
        {
            if (this.started && !this.firstFrame)
            {
                return;
            }
            this.width = param1;
            this.height = param2;
            if (this.width < 1)
            {
                this.width = 320;
            }
            if (this.height < 1)
            {
                this.height = 240;
            }
            this.sizeSet = true;
            return;
        }// end function

        public function start() : Boolean
        {
            this.reset();
            var ok:Boolean;
            this.closeStream = false;
            this.out = new ByteArray();
            try
            {
                this.out.writeUTFBytes("GIF89a");
            }
            catch (e:Error)
            {
                ok;
            }
            var _loc_2:* = ok;
            this.started = ok;
            return _loc_2;
        }// end function

        private function analyzePixels() : void
        {
            var _loc_6:* = 0;
            var _loc_1:* = this.pixels.length;
            var _loc_2:* = _loc_1 / 3;
            this.indexedPixels = new ByteArray();
            var _loc_3:* = new NeuQuant(this.pixels, _loc_1, this.sample);
            this.colorTab = _loc_3.process();
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_2)
            {
                
                _loc_6 = _loc_3.map(this.pixels[_loc_4++] & 255, this.pixels[_loc_4++] & 255, this.pixels[_loc_4++] & 255);
                this.usedEntry[_loc_6] = true;
                this.indexedPixels[_loc_5] = _loc_6;
                _loc_5++;
            }
            this.pixels = null;
            this.colorDepth = 8;
            this.palSize = 7;
            if (this.transparent != null)
            {
                this.transIndex = this.findClosest(this.transparent);
            }
            return;
        }// end function

        private function findClosest(param1:Number) : int
        {
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            if (this.colorTab == null)
            {
                return -1;
            }
            var _loc_2:* = (param1 & 16711680) >> 16;
            var _loc_3:* = (param1 & 65280) >> 8;
            var _loc_4:* = param1 & 255;
            var _loc_5:* = 0;
            var _loc_6:* = 256 * 256 * 256;
            var _loc_7:* = this.colorTab.length;
            var _loc_8:* = 0;
            while (_loc_8 < _loc_7)
            {
                
                _loc_9 = _loc_2 - (this.colorTab[_loc_8++] & 255);
                _loc_10 = _loc_3 - (this.colorTab[_loc_8++] & 255);
                _loc_11 = _loc_4 - (this.colorTab[_loc_8] & 255);
                _loc_12 = _loc_9 * _loc_9 + _loc_10 * _loc_10 + _loc_11 * _loc_11;
                _loc_13 = _loc_8 / 3;
                if (this.usedEntry[_loc_13] && _loc_12 < _loc_6)
                {
                    _loc_6 = _loc_12;
                    _loc_5 = _loc_13;
                }
                _loc_8++;
            }
            return _loc_5;
        }// end function

        private function getImagePixels() : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_1:* = this.image.width;
            var _loc_2:* = this.image.height;
            this.pixels = new ByteArray();
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = 0;
                while (_loc_5 < _loc_1)
                {
                    
                    _loc_6 = this.image.bitmapData.getPixel(_loc_5, _loc_4);
                    this.pixels[_loc_3] = (_loc_6 & 16711680) >> 16;
                    _loc_3++;
                    this.pixels[_loc_3] = (_loc_6 & 65280) >> 8;
                    _loc_3++;
                    this.pixels[_loc_3] = _loc_6 & 255;
                    _loc_3++;
                    _loc_5++;
                }
                _loc_4++;
            }
            return;
        }// end function

        private function writeGraphicCtrlExt() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            this.out.writeByte(33);
            this.out.writeByte(249);
            this.out.writeByte(4);
            if (this.transparent == null)
            {
                _loc_1 = 0;
                _loc_2 = 0;
            }
            else
            {
                _loc_1 = 1;
                _loc_2 = 2;
            }
            if (this.dispose >= 0)
            {
                _loc_2 = this.dispose & 7;
            }
            _loc_2 = _loc_2 << 2;
            this.out.writeByte(0 | _loc_2 | 0 | _loc_1);
            this.WriteShort(this.delay);
            this.out.writeByte(this.transIndex);
            this.out.writeByte(0);
            return;
        }// end function

        private function writeImageDesc() : void
        {
            this.out.writeByte(44);
            this.WriteShort(0);
            this.WriteShort(0);
            this.WriteShort(this.width);
            this.WriteShort(this.height);
            if (this.firstFrame)
            {
                this.out.writeByte(0);
            }
            else
            {
                this.out.writeByte(128 | 0 | 0 | 0 | this.palSize);
            }
            return;
        }// end function

        private function writeLSD() : void
        {
            this.WriteShort(this.width);
            this.WriteShort(this.height);
            this.out.writeByte(128 | 112 | 0 | this.palSize);
            this.out.writeByte(0);
            this.out.writeByte(0);
            return;
        }// end function

        private function writeNetscapeExt() : void
        {
            this.out.writeByte(33);
            this.out.writeByte(255);
            this.out.writeByte(11);
            this.out.writeUTFBytes("NETSCAPE" + "2.0");
            this.out.writeByte(3);
            this.out.writeByte(1);
            this.WriteShort(this.repeat);
            this.out.writeByte(0);
            return;
        }// end function

        private function writePalette() : void
        {
            this.out.writeBytes(this.colorTab, 0, this.colorTab.length);
            var _loc_1:* = 3 * 256 - this.colorTab.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this.out.writeByte(0);
                _loc_2++;
            }
            return;
        }// end function

        private function WriteShort(param1:int) : void
        {
            this.out.writeByte(param1 & 255);
            this.out.writeByte(param1 >> 8 & 255);
            return;
        }// end function

        private function writePixels() : void
        {
            var _loc_1:* = new LZWEncoder(this.width, this.height, this.indexedPixels, this.colorDepth);
            _loc_1.encode(this.out);
            return;
        }// end function

        public function get stream() : ByteArray
        {
            return this.out;
        }// end function

    }
}
