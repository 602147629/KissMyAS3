package com.dango_itimi.as3.utils
{
    import com.dango_itimi.as3_and_createjs.utils.*;
    import flash.*;
    import flash.display.*;

    public class MovieClipUtil extends Object implements IMovieClipUtil
    {
        public var mc:MovieClip;

        public function MovieClipUtil(param1:MovieClip = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            mc = param1;
            return;
        }// end function

        public function setPosition(param1:MovieClip) : void
        {
            mc.x = param1.x;
            mc.y = param1.y;
            return;
        }// end function

        public function prevFrame() : void
        {
            mc.prevFrame();
            return;
        }// end function

        public function nextFrame() : void
        {
            mc.nextFrame();
            return;
        }// end function

        public function loopFrame() : void
        {
            if (mc.currentFrame < mc.totalFrames)
            {
                nextFrame();
            }
            else
            {
                gotoFirstFrame();
            }
            return;
        }// end function

        public function isLastFrame() : Boolean
        {
            return mc.currentFrame == mc.totalFrames;
        }// end function

        public function isCurrentLabel(param1:String) : Boolean
        {
            return mc.currentLabel == param1;
        }// end function

        public function gotoLastFrame() : void
        {
            mc.gotoAndStop(mc.totalFrames);
            return;
        }// end function

        public function gotoFirstFrame() : void
        {
            mc.gotoAndStop(1);
            return;
        }// end function

        public function gotoAndStop(param1:int) : void
        {
            mc.gotoAndStop(param1);
            return;
        }// end function

        public function getTotalFrames() : int
        {
            return mc.totalFrames;
        }// end function

        public function getCurrentFrameBaseCreateJS() : int
        {
            return (mc.currentFrame - 1);
        }// end function

        public function getCurrentFrame() : int
        {
            return mc.currentFrame;
        }// end function

        public function contains(param1:String) : Boolean
        {
            return mc.getChildByName(param1) != null;
        }// end function

    }
}
