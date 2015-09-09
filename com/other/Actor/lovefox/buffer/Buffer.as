package lovefox.buffer
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class Buffer extends EventDispatcher
    {
        private var _loadedNumber:uint = 0;
        private var _totalNumber:uint = 0;
        private var _subPicArr:Object;
        private var _subSoundArr:Object;
        private var _allPicArr:Object;
        private var _allSoundArr:Object;
        private var _itemArr:Object;
        private var _monsterArr:Object;
        private var _charactorArr:Object;
        private var _effectArr:Object;
        private var _flyPropArr:Object;
        private var _skillArr:Object;
        private var index:uint = 0;
        private var count:uint = 0;
        private var done:Boolean = false;
        private var _initObj:Object;
        private var _extraBitmap:Array;

        public function Buffer()
        {
            this._subPicArr = [];
            this._subSoundArr = [];
            return;
        }// end function

        public function buffInit(param1, param2:Array = null)
        {
            var _loc_3:* = new URLStream();
            _loc_3.endian = Endian.LITTLE_ENDIAN;
            _loc_3.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            _loc_3.addEventListener(Event.COMPLETE, this.onComplete);
            if (Config.verObj[param1] == null)
            {
                _loc_3.load(new URLRequest(Config.sourceURL + param1 + "?ver=" + Config.ver));
            }
            else
            {
                _loc_3.load(new URLRequest(Config.sourceURL + param1 + "?ver=" + Config.verObj[param1]));
            }
            this._extraBitmap = param2;
            return;
        }// end function

        private function onProgress(event:ProgressEvent) : void
        {
            dispatchEvent(new ProgressEvent("progress", false, false, event.bytesLoaded / 2, event.bytesTotal));
            return;
        }// end function

        private function onComplete(event:Event) : void
        {
            var _loc_3:* = undefined;
            event.target.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
            event.target.removeEventListener(Event.COMPLETE, this.onComplete);
            var _loc_2:* = new ByteArray();
            event.target.readBytes(_loc_2, 0, event.target.bytesAvailable);
            _loc_2.uncompress();
            this._initObj = _loc_2.readObject();
            for (_loc_3 in this._initObj)
            {
                
                if (_loc_3 != "picSet" && _loc_3 != "pics")
                {
                    Config[_loc_3] = this._initObj[_loc_3];
                }
            }
            Config.dataVer = this._initObj.date;
            this.afterLoad();
            return;
        }// end function

        private function afterLoad()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_4:* = undefined;
            this._totalNumber = 0;
            if (this._initObj.picSet != null)
            {
                _loc_4 = new PicZip();
                _loc_4.addEventListener(Event.COMPLETE, this.handleUnzipComplete);
                _loc_4.unzip(this._initObj.picSet);
                var _loc_5:* = this;
                var _loc_6:* = this._totalNumber + 1;
                _loc_5._totalNumber = _loc_6;
            }
            this._loadedNumber = 0;
            this._allPicArr = [];
            this._allSoundArr = [];
            if (this._initObj.picSet != null)
            {
                _loc_1 = findSoundInXML(Config._xmlMap["ui.xml"]);
                this.findAndPush(_loc_1, this._allSoundArr);
            }
            var _loc_3:* = 0;
            if (this._initObj.pics != null)
            {
                for (_loc_2 in this._initObj.pics)
                {
                    
                    _loc_3 = _loc_3 + 1;
                    this._allPicArr.push(_loc_2);
                }
            }
            if (this._extraBitmap != null)
            {
                for (_loc_2 in this._extraBitmap)
                {
                    
                    _loc_3 = _loc_3 + 1;
                    this._allPicArr.push(this._extraBitmap[_loc_2]);
                }
            }
            BitmapLoader.setByteArray(this._initObj.pics);
            this._totalNumber = this._totalNumber + (_loc_3 + this._allSoundArr.length);
            if (this._totalNumber == 0)
            {
                dispatchEvent(new Event("complete"));
            }
            else
            {
                this.bufferPic(this._allPicArr);
                this.bufferSound(this._allSoundArr);
            }
            return;
        }// end function

        private function handleUnzipComplete(param1)
        {
            var _loc_2:* = this;
            var _loc_3:* = this._loadedNumber + 1;
            _loc_2._loadedNumber = _loc_3;
            dispatchEvent(new ProgressEvent("progress", false, false, this._totalNumber / 2 + this._loadedNumber / 2, this._totalNumber));
            if (this._loadedNumber == this._totalNumber)
            {
                param1.target.removeEventListener(ProgressEvent.PROGRESS, this.soundLoadProgress);
                param1.target.removeEventListener(ProgressEvent.PROGRESS, this.picLoadProgress);
                dispatchEvent(new Event("complete"));
            }
            return;
        }// end function

        private function findAndPush(param1, param2)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_5 = false;
                _loc_4 = 0;
                while (_loc_4 < param2.length)
                {
                    
                    if (param2[_loc_4] == param1[_loc_3])
                    {
                        _loc_5 = true;
                        break;
                    }
                    _loc_4 = _loc_4 + 1;
                }
                if (!_loc_5)
                {
                    param2.push(param1[_loc_3]);
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        private function findXMLInXML(param1:XML)
        {
            var _loc_6:* = undefined;
            var _loc_9:* = undefined;
            var _loc_2:* = String(param1.folder);
            var _loc_3:* = [];
            var _loc_4:* = param1.toString();
            var _loc_5:* = param1.toString().indexOf("<id>");
            var _loc_7:* = {};
            var _loc_8:* = "";
            while (_loc_5 != -1)
            {
                
                _loc_6 = _loc_4.indexOf("</id>");
                _loc_8 = _loc_4.substring(_loc_5 + 4, _loc_6);
                if (_loc_7[_loc_8] == null)
                {
                    _loc_7[_loc_8] = true;
                    _loc_3.push({url:_loc_2 + _loc_8 + ".xml", id:Number(_loc_8)});
                }
                _loc_4 = _loc_4.substring(_loc_6 + 5);
                _loc_5 = _loc_4.indexOf("<id>");
            }
            return _loc_3;
        }// end function

        private function bufferPic(param1)
        {
            var _loc_2:* = BitmapLoader.newBitmapLoader();
            _loc_2.addEventListener(ProgressEvent.PROGRESS, this.picLoadProgress);
            _loc_2.load(param1);
            return;
        }// end function

        private function bufferSound(param1)
        {
            var _loc_2:* = new SoundLoader();
            _loc_2.addEventListener(ProgressEvent.PROGRESS, this.soundLoadProgress);
            _loc_2.load(param1);
            return;
        }// end function

        private function soundLoadProgress(event:ProgressEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._loadedNumber + 1;
            _loc_2._loadedNumber = _loc_3;
            dispatchEvent(new ProgressEvent("progress", false, false, this._totalNumber / 2 + this._loadedNumber / 2, this._totalNumber));
            if (this._loadedNumber == this._totalNumber)
            {
                event.target.removeEventListener(ProgressEvent.PROGRESS, this.soundLoadProgress);
                event.target.removeEventListener(ProgressEvent.PROGRESS, this.picLoadProgress);
                dispatchEvent(new Event("complete"));
            }
            return;
        }// end function

        private function soundLoadComplete(event:Event) : void
        {
            return;
        }// end function

        private function picLoadProgress(event:ProgressEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._loadedNumber + 1;
            _loc_2._loadedNumber = _loc_3;
            dispatchEvent(new ProgressEvent("progress", false, false, this._totalNumber / 2 + this._loadedNumber / 2, this._totalNumber));
            if (this._loadedNumber == this._totalNumber)
            {
                event.target.removeEventListener(ProgressEvent.PROGRESS, this.soundLoadProgress);
                event.target.removeEventListener(ProgressEvent.PROGRESS, this.picLoadProgress);
                dispatchEvent(new Event("complete"));
            }
            return;
        }// end function

        private function picLoadComplete(event:Event) : void
        {
            return;
        }// end function

        public static function findPicInXML(param1)
        {
            var _loc_5:* = undefined;
            var _loc_8:* = undefined;
            var _loc_2:* = [];
            var _loc_3:* = param1.toString();
            var _loc_4:* = _loc_3.indexOf("<dir>");
            var _loc_6:* = {};
            var _loc_7:* = "";
            while (_loc_4 != -1)
            {
                
                _loc_5 = _loc_3.indexOf("</dir>", _loc_4 + 5);
                _loc_7 = _loc_3.substring(_loc_4 + 5, _loc_5);
                if (_loc_6[_loc_7] == null)
                {
                    _loc_6[_loc_7] = true;
                    _loc_2.push(_loc_7);
                }
                _loc_4 = _loc_3.indexOf("<dir>", _loc_5 + 6);
            }
            return _loc_2;
        }// end function

        private static function findSoundInXML(param1)
        {
            var _loc_5:* = undefined;
            var _loc_8:* = undefined;
            var _loc_2:* = [];
            var _loc_3:* = param1.toString();
            var _loc_4:* = _loc_3.indexOf("<sound>");
            var _loc_6:* = {};
            var _loc_7:* = "";
            while (_loc_4 != -1)
            {
                
                _loc_5 = _loc_3.indexOf("</sound>");
                _loc_7 = _loc_3.substring(_loc_4 + 7, _loc_5);
                if (_loc_6[_loc_7] == null)
                {
                    _loc_6[_loc_7] = true;
                    _loc_2 = _loc_2.concat(_loc_7.split("|"));
                }
                _loc_3 = _loc_3.substring(_loc_5 + 6);
                _loc_4 = _loc_3.indexOf("<sound>");
            }
            return _loc_2;
        }// end function

    }
}
