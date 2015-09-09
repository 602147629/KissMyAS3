package lovefox.component
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class MousePointer extends Sprite
    {
        private var mshape:Sprite;
        private var mBmp:Bitmap;
        public var _cursorStack:Object;
        private var shapename:String = "";
        private var mousestate:String = "";
        private var mouseshapeobj:Object;
        private var _mouseTipTf:TextField;

        public function MousePointer()
        {
            var _loc_1:* = undefined;
            var _loc_3:* = undefined;
            this._cursorStack = {};
            Config.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
            Config.stage.addEventListener(Event.MOUSE_LEAVE, this.handleMouseLeave);
            var _loc_2:* = Config.findUI("cursor");
            for (_loc_1 in _loc_2.children())
            {
                
                this._cursorStack[_loc_2.children()[_loc_1].name()] = {bmpd:BitmapLoader.pick(String(_loc_2.children()[_loc_1].dir)), x:Number(_loc_2.children()[_loc_1].x), y:Number(_loc_2.children()[_loc_1].y)};
            }
            this.mshape = new Sprite();
            this.mBmp = new Bitmap();
            this.mshape.addChild(this.mBmp);
            this.mshape.mouseEnabled = false;
            this.mshape.mouseChildren = false;
            _loc_3 = new DropShadowFilter(4, 45, 0, 0.5);
            this.mshape.filters = [_loc_3];
            this._mouseTipTf = Config.getSimpleTextField();
            this._mouseTipTf.x = 16;
            this._mouseTipTf.textColor = 16777215;
            return;
        }// end function

        public function set mouseTip(param1)
        {
            if (param1 == null || param1 == "")
            {
                if (this._mouseTipTf.parent == this.mshape)
                {
                    this.mshape.removeChild(this._mouseTipTf);
                }
            }
            else
            {
                this._mouseTipTf.text = param1;
                if (this._mouseTipTf.parent != this.mshape)
                {
                    this.mshape.addChild(this._mouseTipTf);
                }
            }
            return;
        }// end function

        public function MouseShape(param1:String) : void
        {
            var _loc_2:* = undefined;
            if (param1 != "")
            {
                if (this.shapename != param1)
                {
                    this.shapename = param1;
                    Mouse.hide();
                    _loc_2 = this._cursorStack[this.shapename];
                    this.mBmp.bitmapData = _loc_2.bmpd;
                    this.mBmp.x = _loc_2.x;
                    this.mBmp.y = _loc_2.y;
                    this.mshape.x = Config.stage.mouseX;
                    this.mshape.y = Config.stage.mouseY;
                    Config.stage.addChild(this.mshape);
                }
            }
            else if (this.mousestate != "")
            {
                this.MouseShape(this.mousestate);
            }
            else
            {
                this.shapename = "";
                if (this.mshape.parent != null)
                {
                    this.mshape.parent.removeChild(this.mshape);
                }
                Mouse.show();
            }
            return;
        }// end function

        public function getMouseShape() : String
        {
            return this.shapename;
        }// end function

        public function setMouseState(param1:String, param2:Boolean = false) : void
        {
            if (param2)
            {
                this.mousestate = param1;
            }
            this.MouseShape(param1);
            return;
        }// end function

        public function getMouseState() : String
        {
            return this.mousestate;
        }// end function

        private function handleMouseLeave(param1)
        {
            this.mshape.visible = false;
            return;
        }// end function

        private function mouseMoveHandler(event:MouseEvent) : void
        {
            this.mshape.visible = true;
            this.mshape.x = event.stageX;
            this.mshape.y = event.stageY;
            event.updateAfterEvent();
            return;
        }// end function

    }
}
