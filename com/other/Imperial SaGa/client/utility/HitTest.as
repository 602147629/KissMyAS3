package utility
{
    import flash.display.*;

    public class HitTest extends Object
    {

        public function HitTest()
        {
            return;
        }// end function

        public static function isObstructHitTest(param1:DisplayObject, param2:int, param3:int) : Boolean
        {
            var obj:* = param1;
            var cursorX:* = param2;
            var cursorY:* = param3;
            var childHitTest:* = function (param1:DisplayObjectContainer, param2:int, param3:Boolean) : Boolean
            {
                var _loc_5:* = null;
                var _loc_6:* = null;
                var _loc_7:* = null;
                var _loc_4:* = param2;
                while (_loc_4 < param1.numChildren)
                {
                    
                    _loc_5 = param1.getChildAt(_loc_4);
                    if (_loc_5 is MovieClip)
                    {
                        _loc_6 = _loc_5 as MovieClip;
                        if (_loc_6.visible && _loc_6.mouseChildren && _loc_6.alpha > 0 && childHitTest(_loc_6, 0, false))
                        {
                            return true;
                        }
                    }
                    else if (_loc_5 is Shape)
                    {
                        _loc_7 = _loc_5 as Shape;
                        if (_loc_7.visible && _loc_7.alpha > 0 && _loc_7.hitTestPoint(cursorX, cursorY))
                        {
                            return true;
                        }
                    }
                    _loc_4++;
                }
                if (param3 && param1.parent)
                {
                    return childHitTest(param1.parent, (param1.parent.getChildIndex(param1) + 1), true);
                }
                return false;
            }// end function
            ;
            if (!obj.hitTestPoint(cursorX, cursorY))
            {
                return false;
            }
            if (!obj.parent)
            {
                return true;
            }
            return !HitTest.childHitTest(obj.parent, (obj.parent.getChildIndex(obj) + 1), true);
        }// end function

    }
}
