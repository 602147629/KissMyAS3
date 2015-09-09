package lovefox.gameUI
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import lovefox.component.*;

    public class MessageTips extends MovieClip
    {
        private var tomovearr:Array;
        private var messagearr:Array;
        private var repalyarr:Array;
        private var ismoveing:Boolean = false;
        private var timepoint:uint = 0;
        private var timegap:uint = 300;
        private var messagelimit:uint = 5;

        public function MessageTips()
        {
            this.tomovearr = new Array();
            this.messagearr = new Array();
            this.repalyarr = new Array();
            this.addEventListener(Event.ENTER_FRAME, this.removetips);
            return;
        }// end function

        public function addmessage(param1:String, param2:uint = 0, param3:Object = null) : void
        {
            var _loc_4:* = new Object();
            new Object().str = param1;
            _loc_4.type = param2;
            _loc_4.obj = param3;
            this.tomovearr.push(_loc_4);
            if (this.tomovearr.length > 10)
            {
                this.tomovearr.length = 5;
            }
            this.tomovetips();
            return;
        }// end function

        private function addeffects(param1:LabelUI, param2:uint) : void
        {
            if (param2 == 0)
            {
                param1.textColor = 13382400;
            }
            else if (param2 == 1)
            {
                param1.textColor = 357138;
            }
            else if (param2 == 2)
            {
                param1.textColor = 9969926;
            }
            var _loc_3:* = new DropShadowFilter(1, 45, 3342336, 0.3, 1, 1, 10, 1, false, false);
            var _loc_4:* = new Array();
            new Array().push(_loc_3);
            param1.filters = _loc_4;
            return;
        }// end function

        private function tomovetips() : void
        {
            var _loc_1:* = false;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            if (!this.ismoveing)
            {
                if (this.tomovearr.length > 0)
                {
                    _loc_1 = false;
                    _loc_2 = new Object();
                    this.messagearr.push(_loc_2);
                    _loc_3 = new Sprite();
                    this.addChild(_loc_3);
                    _loc_4 = new Sprite();
                    _loc_3.addChild(_loc_4);
                    _loc_4.y = 2;
                    _loc_5 = new LabelUI();
                    _loc_5.text = this.tomovearr[0].str;
                    this.addeffects(_loc_5, this.tomovearr[0].type);
                    _loc_3.addChild(_loc_5);
                    _loc_3.x = Config.ui._width - _loc_5.width - 35 - 250;
                    this.messagearr[(this.messagearr.length - 1)].type = this.tomovearr[0].type;
                    this.messagearr[(this.messagearr.length - 1)].meassagepanel = _loc_3;
                    this.messagearr[(this.messagearr.length - 1)].message = _loc_5;
                    _loc_3.y = Config.ui._height - 90;
                    if (this.tomovearr[0].obj != null)
                    {
                        _loc_4.graphics.beginFill(16777215, 1);
                        _loc_4.graphics.drawRoundRect(0, 0, _loc_5.width, 16, 2);
                        _loc_4.graphics.endFill();
                        _loc_4.alpha = 0.1;
                        _loc_3.addEventListener(MouseEvent.CLICK, this.create(this.eventfuc, this.tomovearr[0].obj, _loc_4));
                        _loc_3.addEventListener(MouseEvent.ROLL_OVER, this.create(this.changealpha, _loc_4, 0.2));
                        _loc_3.addEventListener(MouseEvent.ROLL_OUT, this.create(this.changealpha, _loc_4, 0.1));
                        _loc_3.mouseEnabled = true;
                        _loc_3.buttonMode = true;
                        this.messagearr[(this.messagearr.length - 1)].mesobj = this.tomovearr[0].obj;
                    }
                    this.tomovearr.splice(0, 1);
                    TweenLite.to(_loc_3, 0.5, {x:Config.ui._width - _loc_5.width - 35, y:_loc_3.y}, 0, this.moveend);
                    this.ismoveing = true;
                    _loc_6 = 0;
                    while (_loc_6 < (this.messagearr.length - 1))
                    {
                        
                        TweenLite.to(this.messagearr[_loc_6].meassagepanel, 0.5, {x:this.messagearr[_loc_6].meassagepanel.x, y:Config.ui._height - 90 - ((this.messagearr.length - 1) - _loc_6) * 20});
                        _loc_6 = _loc_6 + 1;
                    }
                }
            }
            return;
        }// end function

        private function removetips(event:Event) : void
        {
            var _loc_2:* = 0;
            if (this.messagearr.length > 0)
            {
                if (!this.ismoveing)
                {
                    if (this.timepoint >= this.timegap)
                    {
                        this.resetxy();
                    }
                }
                var _loc_3:* = this;
                var _loc_4:* = this.timepoint + 1;
                _loc_3.timepoint = _loc_4;
                _loc_2 = this.repalyarr.length - 1;
                while (_loc_2 >= 0)
                {
                    
                    if (this.repalyarr[_loc_2].time >= 0)
                    {
                        var _loc_3:* = this.repalyarr[_loc_2];
                        var _loc_4:* = this.repalyarr[_loc_2].time - 1;
                        _loc_3.time = _loc_4;
                    }
                    else
                    {
                        this.addeffects(this.repalyarr[_loc_2].label, this.repalyarr[_loc_2].type);
                        this.repalyarr.splice(_loc_2, 1);
                    }
                    _loc_2 = _loc_2 - 1;
                }
                if (this.repalyarr.length > 0)
                {
                    this.textre();
                }
            }
            return;
        }// end function

        private function moveend() : void
        {
            if (this.messagearr.length > this.messagelimit)
            {
                this.resetxy();
            }
            this.ismoveing = false;
            this.tomovetips();
            return;
        }// end function

        public function resetxy() : void
        {
            var _loc_2:* = null;
            this.removeChild(this.messagearr[0].meassagepanel);
            if (this.messagearr[0].mesobj != null)
            {
                _loc_2 = new CommonEvent(CommonEvent.MESSAGE_CANCEL);
                _loc_2.sendobj = this.messagearr[0].mesobj;
                this.dispatchEvent(_loc_2);
            }
            this.messagearr.splice(0, 1);
            this.timepoint = 0;
            var _loc_1:* = 0;
            while (_loc_1 < this.messagearr.length)
            {
                
                TweenLite.to(this.messagearr[_loc_1].meassagepanel, 0.5, {x:this.messagearr[_loc_1].meassagepanel.x, y:Config.ui._height - 90 - ((this.messagearr.length - 1) - _loc_1) * 20});
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function eventfuc(event:Event, param2:Object, param3:Sprite) : void
        {
            param3.graphics.clear();
            event.currentTarget.mouseEnabled = false;
            event.currentTarget.buttonMode = false;
            var _loc_4:* = new CommonEvent(CommonEvent.MESSAGE_FUC);
            new CommonEvent(CommonEvent.MESSAGE_FUC).sendobj = param2;
            this.dispatchEvent(_loc_4);
            param2 = null;
            return;
        }// end function

        private function create(param1:Function, ... args) : Function
        {
            args = new activation;
            var F:Boolean;
            var f:* = param1;
            var arg:* = args;
            F;
            var _f:* = function (param1) : void
            {
                var _loc_2:* = arg;
                if (!F)
                {
                    F = true;
                    _loc_2.unshift(param1);
                }
                f.apply(null, _loc_2);
                return;
            }// end function
            ;
            return ;
        }// end function

        private function changealpha(event:MouseEvent, param2:Sprite, param3:Number) : void
        {
            param2.alpha = param3;
            return;
        }// end function

        private function showreplaytext(param1:LabelUI) : void
        {
            var _loc_2:* = new Object();
            _loc_2.label = param1;
            _loc_2.time = 150;
            this.repalyarr.push(_loc_2);
            return;
        }// end function

        private function textre() : void
        {
            var _loc_1:* = [6684672, 6684672, 6684672, 6684672, 6684672, 6684672, 16737792, 16737792, 16737792, 16737792, 16737792, 16737792];
            var _loc_2:* = 0;
            while (_loc_2 < this.repalyarr.length)
            {
                
                this.repalyarr[_loc_2].label.textColor = _loc_1[this.repalyarr[_loc_2].time % 12];
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function resize(param1, param2) : void
        {
            var _loc_3:* = 0;
            if (this.messagearr.length > 0)
            {
                _loc_3 = this.messagearr.length - 1;
                while (_loc_3 >= 0)
                {
                    
                    this.messagearr[_loc_3].meassagepanel.x = param1 - this.messagearr[_loc_3].meassagepanel.width - 35;
                    this.messagearr[_loc_3].meassagepanel.y = param2 - 90 - ((this.messagearr.length - 1) - _loc_3) * 20;
                    _loc_3 = _loc_3 - 1;
                }
            }
            return;
        }// end function

    }
}
