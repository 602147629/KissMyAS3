package lovefox.util.compiler
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class PNGDecoder extends Object
    {
        private static const IHDR:uint = 1229472850;
        private static const PLTE:uint = 1347179589;
        private static const IDAT:uint = 1229209940;
        private static const IEND:uint = 1229278788;
        private static var imgWidth:uint = 0;
        private static var imgHeight:uint = 0;
        private static var bitDepth:uint = 0;
        private static var colourType:uint = 0;
        private static var compressionMethod:uint = 0;
        private static var filterMethod:uint = 0;
        private static var interlaceMethod:uint = 0;
        private static var chunks:Array;
        private static var input:ByteArray;
        private static var output:ByteArray;

        public function PNGDecoder()
        {
            return;
        }// end function

        public static function decode(param1:ByteArray) : BitmapData
        {
            var _loc_5:* = null;
            chunks = new Array();
            input = new ByteArray();
            output = new ByteArray();
            input = param1;
            input.position = 0;
            if (!readSignature())
            {
                throw new Error("wrong signature");
            }
            getChunks();
            var _loc_2:* = 0;
            while (_loc_2 < chunks.length)
            {
                
                switch(chunks[_loc_2].type)
                {
                    case IHDR:
                    {
                        processIHDR(_loc_2);
                        break;
                    }
                    case IDAT:
                    {
                        processIDAT(_loc_2);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_2++;
            }
            var _loc_3:* = new BitmapData(imgWidth, imgHeight);
            var _loc_4:* = new BitmapData(imgWidth, imgHeight, true, 16777215);
            if (output.length > 0 && imgWidth * imgHeight * 4 == output.length)
            {
                output.position = 0;
                _loc_3.setPixels(new Rectangle(0, 0, imgWidth, imgHeight), output);
                _loc_5 = new Matrix();
                _loc_5.scale(-1, -1);
                _loc_5.translate(imgWidth, imgHeight);
                _loc_4.draw(_loc_3, _loc_5);
            }
            return _loc_4;
        }// end function

        private static function processIHDR(param1:uint) : void
        {
            input.position = chunks[param1].position;
            imgWidth = input.readUnsignedInt();
            imgHeight = input.readUnsignedInt();
            bitDepth = input.readUnsignedByte();
            colourType = input.readUnsignedByte();
            compressionMethod = input.readUnsignedByte();
            filterMethod = input.readUnsignedByte();
            interlaceMethod = input.readUnsignedByte();
            return;
        }// end function

        private static function processIDAT(param1:uint) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_2:* = new ByteArray();
            var _loc_3:* = imgWidth * 4;
            _loc_2.writeBytes(input, chunks[param1].position, chunks[param1].length);
            _loc_2.uncompress();
            var _loc_4:* = _loc_2.length - 1;
            while (_loc_4 > 0)
            {
                
                if (_loc_4 % (_loc_3 + 1) != 0)
                {
                    _loc_5 = _loc_2[_loc_4];
                    _loc_6 = _loc_2[(_loc_4 - 1)];
                    _loc_7 = _loc_2[_loc_4 - 2];
                    _loc_8 = _loc_2[_loc_4 - 3];
                    output.writeByte(_loc_5);
                    output.writeByte(_loc_8);
                    output.writeByte(_loc_7);
                    output.writeByte(_loc_6);
                    _loc_4 = _loc_4 - 3;
                }
                _loc_4 = _loc_4 - 1;
            }
            return;
        }// end function

        private static function getChunks() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = input.length;
            while (input.position < _loc_4)
            {
                
                _loc_2 = input.readUnsignedInt();
                _loc_3 = input.readUnsignedInt();
                _loc_1 = input.position;
                input.position = input.position + _loc_2;
                input.position = input.position + 4;
                chunks.push({position:_loc_1, length:_loc_2, type:_loc_3});
            }
            return;
        }// end function

        private static function readSignature() : Boolean
        {
            return input.readUnsignedInt() == 2303741511 && input.readUnsignedInt() == 218765834;
        }// end function

        private static function fixType(param1:uint) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = param1.toString(16);
            while (_loc_3.length < 8)
            {
                
                _loc_3 = "0" + _loc_3;
            }
            _loc_2 = _loc_2 + String.fromCharCode(parseInt(_loc_3.substr(0, 2), 16));
            _loc_2 = _loc_2 + String.fromCharCode(parseInt(_loc_3.substr(2, 2), 16));
            _loc_2 = _loc_2 + String.fromCharCode(parseInt(_loc_3.substr(4, 2), 16));
            _loc_2 = _loc_2 + String.fromCharCode(parseInt(_loc_3.substr(6, 2), 16));
            return _loc_2;
        }// end function

    }
}
