package sound
{
    import develop.*;
    import flash.media.*;

    public class SoundFadeoutDelete extends Object
    {
        private var _soundChannel:SoundChannel;
        private var _fadeVolume:Number;
        private var _soundListData:SoundListData;

        public function SoundFadeoutDelete(param1:SoundChannel, param2:SoundListData, param3:Number)
        {
            this._soundChannel = param1;
            this._soundListData = param2;
            this._fadeVolume = param3;
            return;
        }// end function

        public function release() : void
        {
            this._soundChannel.stop();
            this._soundChannel = null;
            this._soundListData = null;
            return;
        }// end function

        public function isEnd() : Boolean
        {
            var _loc_1:* = this._soundChannel.soundTransform;
            return _loc_1.volume <= 0;
        }// end function

        public function subFadeout(param1:Number, param2:Number) : void
        {
            var _loc_3:* = this._soundChannel.soundTransform;
            var _loc_4:* = _loc_3.volume;
            this._fadeVolume = this._fadeVolume - param1;
            if (this._fadeVolume < 0)
            {
                this._fadeVolume = 0;
            }
            _loc_3.volume = this._fadeVolume * param2 * this._soundListData.voluem;
            this._soundChannel.soundTransform = _loc_3;
            return;
        }// end function

        public function setFadeout(param1:Number, param2:Number) : void
        {
            var _loc_3:* = this._soundChannel.soundTransform;
            var _loc_4:* = _loc_3.volume;
            this._fadeVolume = param1;
            DebugLog.print("Del FadeVolume:" + this._fadeVolume + " vol:" + this._soundChannel.soundTransform.volume);
            _loc_3.volume = this._fadeVolume * param2 * this._soundListData.voluem;
            this._soundChannel.soundTransform = _loc_3;
            return;
        }// end function

    }
}
