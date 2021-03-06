﻿package status
{
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import input.*;
    import item.*;
    import message.*;
    import resource.*;

    public class ItemSimpleStatus extends Object
    {
        private var _mcBase:MovieClip;
        private var _btnArea:ButtonArea;
        private var _arrow:StatusArrow;

        public function ItemSimpleStatus(param1:DisplayObjectContainer, param2:Point = null)
        {
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", "ItemInfoBalloon");
            this._arrow = new StatusArrow(this._mcBase.ItemInfoBalloonMc.arrowNull, ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", "CharaStatusArrow");
            this._btnArea = new ButtonArea(this._mcBase);
            ButtonManager.getInstance().addButtonArea(this._btnArea);
            param1.addChild(this._mcBase);
            this._mcBase.visible = false;
            this._btnArea.setEnable(false);
            if (param2)
            {
                this.setPosition(param2);
            }
            return;
        }// end function

        public function release() : void
        {
            if (this._btnArea)
            {
                ButtonManager.getInstance().removeButtonArea(this._btnArea);
            }
            this._btnArea = null;
            if (this._arrow)
            {
                this._arrow.release();
            }
            this._arrow = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        public function show() : void
        {
            this._mcBase.visible = true;
            if (this._btnArea)
            {
                this._btnArea.setEnable(true);
            }
            return;
        }// end function

        public function hide() : void
        {
            this._mcBase.visible = false;
            if (this._btnArea)
            {
                this._btnArea.setEnable(false);
            }
            return;
        }// end function

        public function isShow() : Boolean
        {
            return this._mcBase.visible;
        }// end function

        public function setItemData(param1:int) : void
        {
            var _loc_2:* = ItemManager.getInstance().getItemInformation(param1);
            if (_loc_2)
            {
                this.setStatus(_loc_2.name, _loc_2.explanation);
            }
            else
            {
                this.setStatus("", "");
            }
            return;
        }// end function

        public function setPaymentItemData(param1:int) : void
        {
            var _loc_2:* = ItemManager.getInstance().getPaymentItemInformation(param1);
            if (_loc_2)
            {
                this.setStatus(_loc_2.name, _loc_2.description);
            }
            else
            {
                this.setStatus("", "");
            }
            return;
        }// end function

        public function setStatus(param1:String, param2:String) : void
        {
            var _loc_3:* = this._mcBase.ItemInfoBalloonMc.ItemInfoBalloon;
            TextControl.setText(_loc_3.NameMc.textDt, param1 ? (param1) : (""));
            TextControl.setText(_loc_3.InfoMc.textDt, param2 ? (param2) : (""));
            return;
        }// end function

        public function setParent(param1:DisplayObjectContainer) : void
        {
            if (this._mcBase.parent != param1)
            {
                if (this._mcBase.parent)
                {
                    this._mcBase.parent.removeChild(this._mcBase);
                }
                if (param1)
                {
                    param1.addChild(this._mcBase);
                }
            }
            return;
        }// end function

        public function setPosition(param1:Point) : void
        {
            if (this._mcBase)
            {
                this._mcBase.x = param1.x;
                this._mcBase.y = param1.y;
            }
            return;
        }// end function

        public function setArrowTargetPosition(param1:Point) : void
        {
            this._arrow.setArrowTargetPosition(param1);
            return;
        }// end function

        public function isHitTest() : Boolean
        {
            if (!this._mcBase.visible)
            {
                return false;
            }
            var _loc_1:* = InputManager.getInstance().corsor;
            return this._mcBase.hitTestPoint(_loc_1.x, _loc_1.y);
        }// end function

        public static function loadResource() : void
        {
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            return;
        }// end function

    }
}
