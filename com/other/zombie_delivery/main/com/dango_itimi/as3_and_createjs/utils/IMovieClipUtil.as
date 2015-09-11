package com.dango_itimi.as3_and_createjs.utils
{
    import flash.display.*;

    public interface IMovieClipUtil
    {

        public function IMovieClipUtil() : void;

        function setPosition(param1:MovieClip) : void;

        function prevFrame() : void;

        function nextFrame() : void;

        function loopFrame() : void;

        function isLastFrame() : Boolean;

        function isCurrentLabel(param1:String) : Boolean;

        function gotoLastFrame() : void;

        function gotoFirstFrame() : void;

        function gotoAndStop(param1:int) : void;

        function getTotalFrames() : int;

        function getCurrentFrameBaseCreateJS() : int;

        function getCurrentFrame() : int;

        function contains(param1:String) : Boolean;

    }
}
