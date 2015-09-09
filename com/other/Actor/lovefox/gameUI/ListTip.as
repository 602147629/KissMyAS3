package lovefox.gameUI
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class ListTip extends Sprite
    {
        private var tiptimer:Timer;
        public var _dealalert1:int;
        private var _tipicon:Sprite;
        private static var _listarr:Array;
        private static var _timenum:int = 30;
        public static var ui:ListTip;

        public function ListTip()
        {
            _listarr = new Array();
            ui = this;
            this.addEventListener(MouseEvent.CLICK, this.alerttip);
            this.tiptimer = new Timer(1000);
            this.tiptimer.addEventListener(TimerEvent.TIMER, this.showtime);
            return;
        }// end function

        public function setsize(param1:Number, param2:int) : void
        {
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        private function showtime(event:Event) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = int((_listarr.length - 1));
            while (_loc_3 >= 0)
            {
                
                var _loc_4:* = _listarr[_loc_3];
                var _loc_5:* = _listarr[_loc_3].timenum - 1;
                _loc_4.timenum = _loc_5;
                if (_listarr[_loc_3].timenum <= 0)
                {
                    ui.dobackfuc(_listarr[_loc_3]);
                    _listarr.splice(_loc_3, 1);
                    if (_loc_3 == 0)
                    {
                        _loc_2 = true;
                    }
                }
                _loc_3 = _loc_3 - 1;
            }
            if (_loc_2)
            {
                this.showtip();
            }
            if (_listarr.length == 0)
            {
                this.tiptimer.stop();
            }
            return;
        }// end function

        private function showtip() : void
        {
            var _loc_1:* = undefined;
            this.removeallchild(this);
            if (_listarr.length > 0)
            {
                _loc_1 = this.geticon(_listarr[0].type);
                this.addChild(_loc_1);
            }
            return;
        }// end function

        private function geticon(param1:int) : Sprite
        {
            var _loc_3:* = null;
            var _loc_2:* = new Sprite();
            _loc_2.graphics.lineStyle(1, 3355443, 0.5);
            _loc_2.graphics.beginFill(0, 0.6);
            _loc_2.graphics.drawRoundRect(0, 0, 32, 32, 5);
            _loc_2.graphics.endFill();
            switch(param1)
            {
                case 1:
                {
                    _loc_3 = Config.language("ListTip", 1);
                    break;
                }
                case 2:
                {
                    _loc_3 = Config.language("ListTip", 2);
                    break;
                }
                case 3:
                {
                    _loc_3 = Config.language("ListTip", 3);
                    break;
                }
                case 4:
                {
                    _loc_3 = Config.language("ListTip", 4);
                    break;
                }
                case 5:
                {
                    _loc_3 = Config.language("ListTip", 5);
                    break;
                }
                case 6:
                {
                    _loc_3 = Config.language("ListTip", 6);
                    break;
                }
                case 7:
                {
                    _loc_3 = Config.language("ListTip", 7);
                    break;
                }
                case 8:
                {
                    _loc_3 = Config.language("ListTip", 8);
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_4:* = Config.getSimpleTextField();
            Config.getSimpleTextField().text = _loc_3;
            _loc_4.x = (32 - _loc_4.width) / 2;
            _loc_4.y = (32 - _loc_4.height) / 2;
            _loc_4.textColor = 16777215;
            _loc_2.addChild(_loc_4);
            return _loc_2;
        }// end function

        private function removeallchild(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        private function alerttip(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            if (_listarr.length > 0)
            {
                if (_listarr[0].clickfunc != null)
                {
                    _listarr[0].clickfunc(_listarr[0]);
                }
                switch(_listarr[0].type)
                {
                    case 1:
                    case 3:
                    case 5:
                    case 8:
                    {
                        this._dealalert1 = AlertUI.alert(_listarr[0].title, _listarr[0].msg, _listarr[0].btns, _listarr[0].funcs, _listarr[0].d, false, true, false, null, false, _listarr[0].onReon, _listarr[0].onReplace);
                        break;
                    }
                    case 2:
                    {
                        AlertUI.alert(_listarr[0].title, _listarr[0].msg, _listarr[0].btns, _listarr[0].funcs, _listarr[0].d, false, true, false, _listarr[0].child);
                        break;
                    }
                    case 4:
                    {
                        Config.ui._mailpanel.openMail(_listarr[0].status);
                        break;
                    }
                    case 6:
                    {
                        Config.ui._recomPanel.open();
                        Config.ui._recomPanel.initsecpage(null, 1);
                        break;
                    }
                    case 7:
                    {
                        _loc_2 = 0;
                        if (_listarr[0].hasOwnProperty("d"))
                        {
                            if (_listarr[0].d.hasOwnProperty("position"))
                            {
                                _loc_2 = _listarr[0].d.position;
                            }
                        }
                        Config.ui._activePanel.setPosition(_loc_2);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            _listarr.splice(0, 1);
            this.showtip();
            return;
        }// end function

        private function dobackfuc(param1:Object) : void
        {
            var tb:* = param1;
            if (tb.hasOwnProperty("backfuc"))
            {
                try
                {
                    tb.backfuc(tb.d);
                }
                catch (e:Error)
                {
                    trace("调用失败");
                }
            }
            return;
        }// end function

        public static function addList(param1:Object) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < _listarr.length)
            {
                
                if (_listarr[_loc_2].type == param1.type && _listarr[_loc_2].fname == param1.fname)
                {
                    _listarr.splice(_loc_2, 1);
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            if (!param1.hasOwnProperty("timenum"))
            {
                param1.timenum = _timenum;
            }
            _listarr.splice(0, 0, param1);
            if (_listarr.length > 5)
            {
                ui.dobackfuc(_listarr[5]);
                _listarr.length = 5;
            }
            if (_listarr.length == 1)
            {
                ui.tiptimer.start();
            }
            ui.showtip();
            return;
        }// end function

        public static function removeList(param1:int, param2:String) : void
        {
            var _loc_3:* = 0;
            while (_loc_3 < _listarr.length)
            {
                
                if (_listarr[_loc_3].type == param1 && _listarr[_loc_3].fname == param2)
                {
                    _listarr.splice(_loc_3, 1);
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            ui.showtip();
            return;
        }// end function

    }
}
